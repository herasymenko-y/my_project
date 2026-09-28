#!/bin/bash

if [ "$#" != 1 ]; then
echo "Error: Please provide exactly one .c file."
exit 1;
fi
FILE="$1"
BIN_FILE="${FILE%.*}"

aarch64-linux-gnu-gcc "$FILE" -o "$BIN_FILE"

echo -e "\n Running application: $BIN_FILE"
./"$BIN_FILE" info.txt


echo -e "\n Analyzing binary size (size) :"
size "$BIN_FILE"


echo -e "\n Checking dependencies (ldd):"
ldd "$BIN_FILE" 


echo -e "\n Reading ELF header (readelf):"
readelf -h "$BIN_FILE"


echo -e "\n Extracting text strings (strings):"
strings "$BIN_FILE" | head -n 5




