#!/bin/bash
set -e

#Read the configuration file
source ../imageConf.sh

#Download the Pharo image and VM according the configuration file
for I in "${PHARO[@]}"; do bash environmentCreate.sh "$I" ; done

# Install the project Pharo script in each image, according configuration file
for I in "${PHARO[@]}"; do bash projectInstall.sh "$I" ; done

#Create the zip packages with *.image *changes and *.sourcers files 
for I in "${PHARO[@]}"; do bash packagesCreate.sh "$I" ; done