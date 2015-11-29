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

# Version: 0.1
# dependencies: git
# Info: Enhanced cd command for git repos

function cdb() {
	if [[ $# -eq 0 ]]; then
		echo "cdb: ERROR, no directory specified"
	else
		gitfound=$( ls -a ./$1 | grep .git )
		cd $1
		if [ "$gitfound" ]; then
			# echo "Success, git found"
			git status # "status" gives out more information AND the current branch
		fi
	fi
}

