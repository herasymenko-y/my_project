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
		read -p "Input name of branch:" INPUT_BRANCH 
		
		echo "USER_NAME=\"$INPUT_NAME\"" > .git_myconfig
		echo "USER_EMAIL=\"$INPUT_EMAIL\"" >> .git_myconfig
		echo "USER_BRANCH=\"$INPUT_BRANCH\"" >> .git_myconfig
		source .git_myconfig
			else 
			echo "Error: script don't working without .git_myconfig"
			exit 1;
	fi 
fi 
# Обробка параметрів та їх кількість

case "$#" in
0) 
echo "Script usage guide: 1. The script must be run with one or two parameters (the first is the directory name, the second is the remote repository URL). 2. The script uses a .git_myconfig file containing the username, user email, and branch name. Make sure to create this file."
;;
1) 
echo "Working with directory: $1"
   	if [ -d "$1" ]; then 
   	echo "This directory is already exist"
     		if [ ! -z "$(ls -A "$1")" ]; then 
     		echo "This directory contains files or repository"
     		exit 1;
    			else 
     			cd "$1"
     			git init 
     			git config --local user.name "$USER_NAME"
     			git config --local user.email "$USER_EMAIL"
     			git config --local init.defaultBranch "$USER_BRANCH"
     			echo "# $1" > README.md
    		fi 
   			else 
   			mkdir "$1"
   			cd "$1"
   			git init 
   			git config --local user.name "$USER_NAME"
   			git config --local user.email "$USER_EMAIL"
   			git config --local init.defaultBranch "$USER_BRANCH"
   			echo "# $1" > README.md
  		fi
;;
2) 
  	if [ ! -d "$1" ]; then 
   	mkdir "$1"
   	cd "$1"
   	git init 
   	git config --local user.name "$USER_NAME"
   	git config --local user.email "$USER_EMAIL"
   	git config --local init.defaultBranch "$USER_BRANCH"
   	echo "# $1" > README.md
   	git remote add origin "$2"
     		elif [ -z "$(ls -A "$1")" ]; then
     		cd "$1"
     		git init 
     		git config --local user.name "$USER_NAME"
     		git config --local user.email "$USER_EMAIL"
     		git config --local init.defaultBranch "$USER_BRANCH"
     		echo "# $1" > README.md
     		git remote add origin "$2"
       			elif [ -d "$1/.git" ]; then
       			cd "$1"
       			git remote add origin "$2"
     				else 
     				echo "Error: existing files are not a repository"
     				exit 1; 
     	fi
;;
*) 
echo "Error: an unexpected number of parameters was passed"
exit 1;
;; 
esac

