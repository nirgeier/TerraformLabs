#!/bin/bash

# Create array with file names
FOLDERS=()

### IFS -
# The special shell variable `IFS`` determines how Bash 
#   recognizes word boundaries while splitting a sequence 
#   of character strings.
# The default value of IFS is a three-character string 
#    comprising a space, tab, and newline

# Get the file list and break if with IFS
# The space after the `IFS= ` is important 
while IFS=read -r -d $'\0';
do
    # Add the folder name
    FOLDERS+=("$REPLY")
    # Search for the desired folders
done < <(find ../Labs -name "01.*" -print0)

# Debug: print out the folders list
#echo ${FOLDERS[@]}

for item in "${#FOLDERS[@]}"; do
   echo "$item"; 
done | tac