#!/bin/bash
set -e

#Create the zip packages with *.image *changes and *.sourcers files 

PHARO_VERSION=$1
PROJECT_FOLDER=$PROJECT_NAME$PHARO_VERSION

createPackage() {
BITS=$1
FILE_NAME=Pharo${PHARO_VERSION:0:1}.${PHARO_VERSION:1:1}-${BITS}bit-$PROJECT_NAME	
echo "Creating pack $FILE_NAME.zip"
cd tmp/$PROJECT_FOLDER/pharo$PHARO_VERSION-$BITS
mv Pharo.image $FILE_NAME.image
mv Pharo.changes $FILE_NAME.changes
# Creating the zip file
zip -qry ../../../result/$FILE_NAME.zip *.image *.changes *.sources
cd ../../../
}

# Create a package of 32 bits image if is setted in conf file
if [ $ARCH_32 = true ]; then
createPackage 32
fi

# Create a package of 64 bits image if is setted in conf file
if [ $ARCH_64 = true ]; then
createPackage 64
fi