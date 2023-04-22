#!/bin/bash

# Get the folders list
FOLDERS=()

# Break the folder list so we can loop on the list
# We must leav the space after the IFS
while IFS= read -r -d $'\0';
do
    # Add the folder name
    FOLDERS+=("$REPLY")
    # Search for the desired folders
done < <(find ../Labs -name "01.*" -print0)

# Sort the folders in reverse order
# IFS=$'\n' FOLDERS=($(sort -r <<<"${FOLDERS[*]}"))
# unset IFS

echo $FOLDERS[@]

# # The first index to rename
# FIRST_INDEX=4

# # Get the length of the array and add one for the renaming
# LAST_INDEX=$((${#FOLDERS[@]}))

# # loop over the sequence and change the folder names
# # "%02g" - To pad with 2 digits
# for i in `seq -f"%02g" -w $FIRST_INDEX $LAST_INDEX`
# do 
#       echo $i
#  done
