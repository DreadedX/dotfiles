#!/bin/bash
# Checking if url is specified
if [ -z "$1" ]; then echo "Please specify url."; exit; fi; 

# Making src directory and README.md
mkdir src
touch README.md
echo "#$(basename $PWD)" >> README.md

# Initializing git and making first commit
git init
git add .
git commit -m "Initial commit"

# Set origin and push the first commit
git remote add origin $1;
git push -u origin master;
