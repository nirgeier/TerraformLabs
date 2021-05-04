#!/bin/bash

# Get the folders list
FOLDERS=()
while IFS=read -r -d $'\0'; do
    FOLDERS+=("$REPLY")
done < <(find ../Labs -name "01.*" -print0)

# Sort the folders in reverse order
IFS=$'\n' FOLDERS=($(sort -r <<<"${FOLDERS[*]}"))
unset IFS

# The first index to rename
FIRST_INDEX=4
# Get the length of the array and add one for the renaming
LAST_INDEX=$((${#FOLDERS[@]}))

# loop over the sequence and change the folder names
# "%02g" - To pad with 2 digits
for i in `seq -f"%02g" -w $LAST_INDEX $FIRST_INDEX `
do 
      echo $i
 done
