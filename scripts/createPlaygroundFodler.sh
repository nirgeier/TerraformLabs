#!/bin/bash

YELLOW='\033[0;33m'
RESET='\033[0m' # No Color

set -x

# Save the original folder
SRC_FOLDER=$PWD

# Create the playground directory for the specific demo
PLAYGROUND_FOLDER=$( dirname "${BASH_SOURCE[0]}" )/../playground/$(basename $PWD)

# Create the demo folder under the playground folder
mkdir -p $PLAYGROUND_FOLDER

# Switch to the demo folder
cd $PLAYGROUND_FOLDER

# Clean the folder from any prevoius content
rm -rf *

if [ -d "$SRC_FOLDER/src" ]; then
    # Copy the demo files
    cp $SRC_FOLDER/src/* .
fi

# Check the tf file
echo ${YELLOW}
cat *.tf 
echo ${RESET}

# Initialize terrafrom 
terraform init