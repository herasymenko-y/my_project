#!/bin/bash

# Перший блок з .git_myconfig та перевіркою безпеки

if [ -d ".git" ]; then 
echo " Error: the current folder is a repository "
exit 1
fi

if [ -f ".git_myconfig" ]; then
source .git_myconfig
echo "Configuration loaded for the user: $USER_NAME"
else 
read -p "Do you want to create .git_myconfig now? [y/n]:" var
if [ "$var" == "y" ]; then 
read -p "Input your name:" INPUT_NAME
read -p "Input your email:" INPUT_EMAIL
read -p "Input name of brunch:" INPUT_BRANCH 
echo "USER_NAME=\"$INPUT_NAME\"" > .git_myconfig
echo "USER_EMAIL=\"$INPUT_EMAIL\"" >> .git_myconfig
echo "USER_BRANCH=\"$INPUT_BRANCH\"" >> .git_myconfig
source .git_myconfig
else 
echo "Error: script don't working without .git_myconfig"
exit 1;
fi 
fi 



