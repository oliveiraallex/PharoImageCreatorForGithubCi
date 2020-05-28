#!/bin/bash
set -e

#Download the Pharo image and VM according the configuration file

PHARO_VERSION=$1
PROJECT_FOLDER=$PROJECT_NAME$PHARO_VERSION

# Set and going to temporary folder of pharo version
mkdir -p result
mkdir -p tmp/$PROJECT_FOLDER
cd tmp/$PROJECT_FOLDER

# Download the Pharo VM and images 32/64 for the current platform
# We use this VM to prepare the images we are going to pack

# Preparing the Pharo 32 if is setted in conf file
if [ $ARCH_32 = true ]; then
PHARO32_VM=get.pharo.org/vm$PHARO_VERSION
PHARO32_IMAGE=get.pharo.org/$PHARO_VERSION
mkdir -p pharo$PHARO_VERSION-32 && cd pharo$PHARO_VERSION-32
wget -O - $PHARO32_VM | bash
wget -O - $PHARO32_IMAGE | bash
cd ..
fi

# Preparing the Pharo 64 if is setted in conf file
if [ $ARCH_64 = true ]; then
PHARO64_VM=get.pharo.org/64/vm$PHARO_VERSION
PHARO64_IMAGE=get.pharo.org/64/$PHARO_VERSION
mkdir -p pharo$PHARO_VERSION-64 && cd pharo$PHARO_VERSION-64
wget -O - $PHARO64_VM | bash
wget -O - $PHARO64_IMAGE | bash
cd ..
fi