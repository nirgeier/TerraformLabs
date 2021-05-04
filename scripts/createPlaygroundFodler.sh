#!/bin/bash
set -x

# Create the playground directory
PLAYGROUND_FOLDER=${PWD}/../../playground/$(basename $PWD)
mkdir -p $PLAYGROUND_FOLDER
cd $PLAYGROUND_FOLDER
