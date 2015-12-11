#!/bin/bash

#     Copyright (C) 2015 KreAch3R
#
#     Licensed under the Apache License, Version 2.0 (the "License");
#     you may not use this file except in compliance with the License.
#     You may obtain a copy of the License at
#
#          http://www.apache.org/licenses/LICENSE-2.0
#
#     Unless required by applicable law or agreed to in writing, software
#     distributed under the License is distributed on an "AS IS" BASIS,
#     WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#     See the License for the specific language governing permissions and
#     limitations under the License.

# Version: 0.21
# dependencies: git
# Info: Enhanced cd command for git repos
# Notice: For better looking results, color the header output of git status: "git config color.status.header green"

function cdb() {
	if [[ $# -eq 0 ]]; then
		echo "cdb: ERROR, no directory specified"
	else
	    # Check root directory (works for HOME "~")
	    if [ "$(echo $1 | cut -d "/" -f2)" ]; then
		rootdir=$(echo $1 | cut -d "/" -f2);
	    fi
	    if [ "$(echo $1 | cut -d "/" -f1)" ]; then
		rootdir=$(echo $1 | cut -d "/" -f1);
	    fi
	    #Check if the specified directory is a child of the source directory (where you would normally be when you use the cdb() command)
 	    rootdirfound=$( ls -a | grep $rootdir )
	    if [ "$rootdirfound" ]; then
		#Check if the folder is a git repo
		gitfound=$( ls -a ./$1 | grep .git )
		\cd $1
		if [ "$gitfound" ]; then
		    git status # "status" gives out more information AND the current branch
		fi
	    else
		\cd $1
	    fi
	fi
}

