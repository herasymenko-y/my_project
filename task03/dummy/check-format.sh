#!/bin/bash

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

echo "==== CLANG-FORMAT 17 VERSION ===="
clang-format-17 --dry-run --Werror $FILES > /dev/null 2>&1
if [ $? -eq 0 ]; then
echo "clang-format-17: The project formatting is correct"
else 
echo "clang-format-17: Formatting errors found"
fi 

echo "==== CLANG-FORMAT 22 VERSION ===="
clang-format-22 --dry-run --Werror $FILES > /dev/null 2>&1
if [ $? -eq 0 ]; then
echo "clang-format-22: The project formatting is correct"
else 
echo "clang-format-22: Formatting errors found"
fi 
