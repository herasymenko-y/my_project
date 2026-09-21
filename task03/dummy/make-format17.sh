#!/bin/bash

echo "Script usage guide: Run the script only by specifying your project directory. Ensure that your project contains a non-empty .clang-format file."

if [ -z "$1" ] || [ ! -d "$1" ]; then
echo "The directory does not exist"
exit 1;
fi 

if [ ! -f "$1/.clang-format" ]; then
echo "The .clang-format file not found"
exit 1;
fi

DIR=$1
FILES=$(find "$DIR" -type f \( -name "*.c" -o -name "*.h" \))

if [ -z "$FILES" ];then
echo "The $DIR is empty"
exit 1;
fi 

echo "CLANG-FORMAT 17 VERSION"
clang-format-17 -i $FILES 
if [ $? -eq 0 ]; then
echo "The project has been formatted"
else 
echo "Error : The project is not formatted"
fi 
