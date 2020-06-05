#!/bin/bash
set -e

#Check if it's running from localhost or in Travis CI
if [ -d PharoImageCreatorForGithubCi ]; then
    echo -e "\n \033[0;32m +++ Running PharoImageCreatorForGithubCi on Travis CI \033[0m \n"
    FOLDER="PharoImageCreatorForGithubCi/"
else 
    echo -e "\n \033[0;32m +++ Running PharoImageCreatorForGithubCi on localhost \033[0m \n"
fi

#Read the configuration file
source .imageConf.sh

#Download the Pharo image and VM according the configuration file
for I in "${PHARO[@]}"; do bash ${FOLDER}environmentCreate.sh "$I" ; done

# Install the project Pharo script in each image, according configuration file
for I in "${PHARO[@]}"; do bash ${FOLDER}projectInstall.sh "$I" ; done

#Create the zip packages with *.image *changes and *.sourcers files 
for I in "${PHARO[@]}"; do bash ${FOLDER}packagesCreate.sh "$I" ; done