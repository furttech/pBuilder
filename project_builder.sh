#!/bin/bash

# Reset IFS (Internal Field Seperator) to prevent word splitting attacks
IFS=$' \t\n'

declare TARGET_BASE_DIR="home"

verbose_flag=0
git_flag=0
make_flag=0

# Display Script Usage
usage() {
	echo " "
	echo "Usage ${0} [OPTIONS]"	
	echo " "
	echo "Options:"
	echo "-h, --help 	Display help message"
	echo "-v, --verbose	Enable Verbose Mode "
	echo "-g, --eit-enabled	Initialize git Repo Skeleton"
	echo " "
	echo "Example:"
	echo "	./script_name -v -g -m"
	echo " "
}

# Runs firstly set script behalvour base on user options 
options_handler() {
	while [ ${#} -gt 0 ]; do
	 	case ${1} in
	  		-h | --help)
	   			usage
	   			exit 0
	   			;;
	  		-v | --verbose)
	   			verbose_flag=1
	   			;;
			-g | --git-enabled)
				git_flag=1
				;;
			-m | --make)
				make_flag=1
				;;
			*)
				echo "Invalid Argument" ${1}
				usage
				fatal
				;;
			esac
			shift
	done
}

# Fatal Error Exit Rotine
fatal() {
	# Use subshell to limit command scope
	$(bash -c 'printf "%s : Fatal Error: %s" ${0} ${@}' >&2 )
	exit 1
}

project_setup() {

	# Request user input for Project Folder Name
	read -p "Enter Project Folder Name:" project_folder

	# Remove path traveral attempts
	pf_c=$(basename "${project_folder}")

	# Check User Input for unwanted charaters 
	if [[ "$pf_c" =~ ^[[:alnum:]_]+$ ]]; then
	
		if [[ ${verbose_flag} == 1 ]]; then
			printf "Generating Main Project Folder %s \n" ${pf_c}
		fi
		
	else	
		printf "Invalid Character String : Folder Name %s \n" ${pf_c}
		fatal 
	fi	


	# Request user input for Project File Name
	read -p "Enter Project File Name:" project_name
	
	# Remove path traversal breakout attempt
	pn_c=$(basename "${project_name}")
	
	# Check User Input for Invalid Character
	if [[ "${pn_c}" =~ ^[[:alnum:]_]+$ ]]; then
	
		if [[ ${verbose_flag} == 1 ]]; then
			printf "Initializing Main Project Files %s[.c/.h] \n" ${pn_c}
		fi	
	else
		printf "Invalid Character String : Project Name %s \n" ${pn_c}
		fatal 
	fi

	# Create Project Directory Structure	
	$(mkdir ${pf_c})
	$(mkdir "${pf_c}/include")
	$(mkdir "${pf_c}/lib")	
	$(mkdir "${pf_c}/src")
	$(mkdir "${pf_c}/src/obj")

	$(touch "${pf_c}/src/obj/${pn_c}.o")
	$(touch "${pf_c}/src/${pn_c}.c")
	$(touch "${pf_c}/src/makefile")
	$(touch "${pf_c}/include/${pn_c}.h")
}

# split $PWD into paths array
paths=($(echo ${PWD} | tr "/" " "))

# check script is ran in users home directory 
if [[ ${paths[0]} != ${TARGET_BASE_DIR} ]]
then
	fatal Creating project outside User home 
fi

## Call Options Handler
options_handler "${@}"

if [[ ${verbose_flag} == 1 ]]
then
	printf '
	          ____            _   _       _               
	         |  _ \          (_) | |     | |              
	  _ __   | |_) |  _   _   _  | |   __| |   ___   _ __ 
	 |  _ \  |  _ <  | | | | | | | |  / _  |  / _ \ |  __|
	 | |_) | | |_) | | |_| | | | | | | (_| | |  __/ | |   
	 | .__/  |____/   \__,_| |_| |_|  \__,_|  \___| |_|   
	 | |                                                  
	 |_|                                                  
	
	v0.1BETA
	responsible idiot - @furttech aka Haxosouras.rex

	Simply Start Coding C with pBuilder!

	\n'

	if [[ ${git_flag} == 1 ]]; then echo "Git Enabled"; else echo "Git Disabled"; fi
	
	if [[ ${make_flag} == 1 ]]; then echo "'make' File Enabled"; else echo "'make' Disabled"; fi

fi

## Setup Project
project_setup
