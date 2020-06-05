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