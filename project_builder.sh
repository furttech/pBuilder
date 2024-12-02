#!/bin/bash

declare TARGET_BASE_DIR="home"

# Display Script Usage
usage() {
	echo "Usage $0 [OPTIONS]"	
	echo "Options:"
	echo "-h, --help 	Display help message"
	echo "-v, --verbose	Enable Verbose Mode "
	echo "-d  --dir		Project Directory"
	echo "-n  --name	Project Name"
	echo "-g  --git		Initialize git Repo Skeleton"
	echo "-m  --make	Initialise make file"
}



fatal() {
	# TO STD ERR
	echo "$0 : Fatal Error:" "$@" >&2
	exit 1
}

# split $PWD into paths array
paths=($(echo $PWD | tr "/" " "))

# check script is ran in users home directory 
if [ ${paths[0]} != $TARGET_BASE_DIR ]
then
	fatal Creating project outside User home 
fi

printf "" 


