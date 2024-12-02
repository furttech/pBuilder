# Project Title
 
Builder Script for C Projects

## Description

Written in Bash

Intended for C programmer looking to quickly initialize a project file structure. Quickly create empty file and folder structure needed to compile C project. Options for directory, name, git and make file generation.

## Getting Started

### Dependencies

* Linux(bash) Only
* Intended for C/C++
* Targeted to only run in users Home Directory

### Installing

Simply clone the repo
copy to project base directory
change permissions

```
git clone https://github.com/furttech/[repo_name]

cp ./project_builder.sh [project directory location]/pBuilder.sh

chmod 755 ./pBuilder.sh
```

## Run The Script

Options are not required and will default to preset

```
./project_builder.sh

./project_builder.sh -v -d -n=sample
```

## Help

Help Command

```
./project_builder.sh -h

./project_builder.sh --help
```

## Author(s)

[Haxosourass.rex](@furttech)

## Version History

* 0.1_BETA
	* early BETA release
	* POC : simple c project init script
	* initial test release

## License

This project is licensed under the MIT License - refrence LICENSE.md for details

## Acknowledgements


