#!/bin/bash

# Set Debug mode
set -x

# The source folder
SOURCE_FOLDER=${1:-/Users/nirg/repositories/TerraformLabs/Labs/03-Getting-Started-Helm-Chart}

# The output file
OUTPUT_FILE=${2:-${SOURCE_FOLDER}/main.tf}

# Clear the target file
touch ${OUTPUT_FILE}
echo '' > ${OUTPUT_FILE}

# Read the files in the sampels folder
for file in ${SOURCE_FOLDER}/tf-files/*
do
    # filter out directories, list only files
    if [[ -f $file ]]; 
    then 
        cat $file >> ${OUTPUT_FILE}
    # close the if loop
    fi
    # Close the do command    
done