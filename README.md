# PharoImageCreatorForGithubCi
This tool is the easiest way to create Pharo images with your project and release them on Github Releases page (continuous builds, each push). You can chose to create and release images of your project for Pharo 7/8/9 32/64

## Motivation
I would like to create images with some projects already installed ([Telepharo](https://github.com/pharo-ide/TelePharo) and [PharoThings](https://github.com/pharo-iot/PharoThings)), to make it easier to deploy them remotely. That way, I could just upload / download the image with the latest version of the project installed to my remote device, Raspberry, Cloud/VPS (virtual private server) like Amazon AWS, Microsoft Azure and run it quickly.

## How it works
This is a combination of 3 tools: [Travis CI](https://docs.travis-ci.com/user/tutorial), [uploadtool](https://github.com/probonopd/uploadtool) (thanks [probonopd](https://github.com/probonopd)) and this tool (PharoImageCreatorForGithubCi). I'm using my [uploadtool](https://github.com/oliveiraallex/uploadtool) fork to avoid breaking this integration in case of any future changes in the official repository. 

At each push in your repository, Travis will execute the scripts and a release of your project will be provided on the Release tab with zip files containing Pharo .image, .sources and .changes files, with your project already installed, like the image below. 

You can also run it on your local machine (Mac OSX, Linux) and view the .zip files in `result` folder.

You can see it working in [Telepharo](https://github.com/pharo-ide/TelePharo) and [PharoThings](https://github.com/pharo-iot/PharoThings) repositories. 

![image](https://user-images.githubusercontent.com/39618015/83521318-55a8a780-a4df-11ea-9f66-81cd8b05e74d.png)

## How to use it

1. You need to add a file `.imageConf.sh` in the root of your repository. This file has the configurations of images will be created, like wich Pharo version, architecture and the Pharo script of what to you want to install on them. This file needs to be like this:
```bash
#!/bin/bash
set -ev

# Give the name of your project (without spaces). The result files will look like this: Pharo8.0-64bit-MyProject.zip
export PROJECT_NAME='MyProject'

# Comment on the versions you don't want to release.
#PHARO[0]=70
PHARO[1]=80
PHARO[2]=90

# Set true or false for which architecture you want
export ARCH_32=false
export ARCH_64=true

# Put the Pharo script that will be executed when creating your Pharo images
export PHARO_SCRIPT="Iceberg enableMetacelloIntegration: false.
Metacello new
	baseline: 'MyProject';
	repository: 'github://MY_USER/MY_PROJECT';
	load: #(Client Server).	
Iceberg enableMetacelloIntegration: true.
Smalltalk saveSession."
```

2. You need to have a Travis integration on your repository. So you add something like this in your `.travis.yml` file:
```yml
- language: c
  addons:
    apt:
      packages: #installing packages to run Pharo 32 bit in 64 bit environment
      - git
      - libasound2:i386
      - libcairo2:i386
      - libz1:i386
      - libbz2-1.0:i386
      - libssl1.0.0:i386
      - libfreetype6:i386
  install:
    - git clone https://github.com/oliveiraallex/PharoImageCreatorForGithubCi.git
  script:
    -  bash PharoImageCreatorForGithubCi/imageCreate.sh
  after_success:
    - wget -c https://github.com/oliveiraallex/oliveiraallex/raw/master/upload.sh
    - bash upload.sh result/*
  branches:
    except:
    - /^(?i:continuous)$/
```

If you already have Pharo tests running on Travis, you can add an matrix to use different languages on travis:

```yml
matrix:
  include:
    - language: smalltalk
      sudo: false
      os: linux
      smalltalk: Pharo-6.1
    - language: smalltalk
      sudo: false
      os: linux
      smalltalk: Pharo-7.0
    - language: smalltalk
      sudo: false
      os: linux
      smalltalk: Pharo64-7.0
    - language: smalltalk
      sudo: false
      os: linux
      smalltalk: Pharo32-8.0
    - language: smalltalk
      sudo: false
      os: linux
      smalltalk: Pharo64-8.0

    - language: c
      addons:
        apt:
          packages:
          - git
          - libasound2:i386
          - libcairo2:i386
          - libz1:i386
          - libbz2-1.0:i386
          - libssl1.0.0:i386
          - libfreetype6:i386
      install:
        - git clone https://github.com/oliveiraallex/PharoImageCreatorForGithubCi.git
      script:
        -  bash PharoImageCreatorForGithubCi/imageCreate.sh
      after_success:
        - wget -c https://github.com/oliveiraallex/uploadtool/raw/master/upload.sh
        - bash upload.sh result/*
      branches:
        except:
        - /^(?i:continuous)$/
```
3. Now configure your Github token to upload the files, like described in [uploadtool](https://github.com/probonopd/uploadtool) and in the next commit you will be able to see your Pharo images to download in Releases page. 

You can also use the download link to always download the last version: https://github.com/MY_USER/MY_PROJECT/download/continuous/Pharo8.0-64bit-MyProject.zip

## Run it in your local machine (Mac OSX, Linux)
You can also run this script in your local machine and generate the images of your project in your hard drive. 

1. Clone this repository with `git clone https://github.com/oliveiraallex/PharoImageCreatorForGithubCi.git`

2. Go to the project folder and change the file `.imageConf.sh` according to your preferences. 

3. Run the script `./imageCreate.sh`