#!/bin/bash

declare TARGET_BASE_DIR="home"
declare DEFAULT_PROJECT_ROOT="default_project"
declare DEFAULT_PROJECT_NAME="pBuilder_skeleton"
verbose_flag=0
git_flag=0
make_flag=0
project_directory=${DEFAULT_PROJECT_ROOT}
project_name=${DEFAULT_PROJECT_NAME}

# Display Script Usage
usage() {
	echo "Usage ${0} [OPTIONS]"	
	echo "Options:"
	echo "-h, --help 	Display help message"
	echo "-v, --verbose	Enable Verbose Mode "
	echo "-d  --basedir	Project Directory Name"
	echo "-n  --name	Project Name"
	echo "-g  --git-enabled	Initialize git Repo Skeleton"
	echo "-m  --make	Initialise make file"
}

argument_validation() {

	[[ ("${1}" == *=* && -n ${1#*=}) || ( ! -z "${2}" && "${2}" != -* ) ]];
}

parse_option_arg() {

	echo "${2:-${1#*= }}" 
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
			-d* | --basedir*)
	   			if ! argument_validation ${@}; then
					echo "Directory Not Specified" >&2		
					usage
					fatal
				fi
			
				project_directory=$(parse_option_arg ${@})
				
				## BETA DEBUG DELETE DEBUG
				printf "DEBUG :: PDIR :: %s \n" ${project_directory}

				shift
				;;
	  		-n* | --name*)
				if ! argument_validation ${@}; then
					echo "Name Not Specified" >&2 
					usage
					fatal
				fi
	
				project_name=$(parse_option_arg ${@})
		
				## BETA DEBUG DELETE DEBUG
				printf "DEBUG :: PNAME :: %s \n" ${project_name}

				shift
				;;
			*)
	   			printf "Invalid Option: %s \n" ${1}
				
				usage
				exit 1
				;;
	  	esac
	  	shift
	done
}

# Fatal Error Exit Rotine
fatal() {
	# TO STD ERR
	echo "${0} : Fatal Error:" "${@}" >&2
	exit 1
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

	if [[ ${project_directory} != ${DEFAULT_PROJECT_ROOT} ]]
	then
		printf "Project Root : %s \n" ${project_directory}
	else	
		printf "Creating Default ROOT Dir : %s \n" ${DEFAULT_PROJECT_ROOT}
	fi
	
	if [[ ${project_name} != ${DEFAULT_PROJECT_NAME} ]]
	then
		printf "Project Name: %s \n" ${project_name}
	else	
		printf "Creating Default Project : %s \n" ${DEFAULT_PROJECT_NAME}
	fi


	if [[ ${git_flag} == 1 ]]; then echo "Git Enabled"; else echo "Git Disabled"; fi
	
	if [[ ${make_flag} == 1 ]]; then echo "'make' File Enabled"; else echo "'make' Disabled"; fi
fi
