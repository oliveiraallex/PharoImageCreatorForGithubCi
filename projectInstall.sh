#!/bin/bash
set -e

# Install the project Pharo script in each image, according configuration file

PHARO_VERSION=$1
PROJECT_FOLDER=$PROJECT_NAME$PHARO_VERSION

installProject() {
BITS=$1
echo -e "\n \033[0;32m +++ Installing $PROJECT_NAME in Pharo ${PHARO_VERSION:0:1} $BITS bit \033[0m \n"
cd tmp/$PROJECT_FOLDER/pharo$PHARO_VERSION-$BITS
./pharo Pharo.image eval --save "$PHARO_SCRIPT"
cd ../../../
}

# Run Pharo scripts in 32 bits image if is setted in conf file
if [ $ARCH_32 = true ]; then
installProject 32
fi

# Run Pharo scripts in 64 bits image if is setted in conf file
if [ $ARCH_64 = true ]; then
installProject 64
fi