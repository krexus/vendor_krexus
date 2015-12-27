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


# Version: 1.0
# dependencies: PushUpload, basketmd5, plus all their dependencies

function release() {
   # Update Dropbox Public changelog
   export DROPBOX_CHANGELOG=true

   st=0
   # Start building every device
   for combo in "${vendorsetups[@]}"; do
		# We don't build grouper for now
   		if [ "$combo" != "krexus_grouper-user" ]; then
        	lunch $combo && make deviceclean && mka otapackage && pushupload basket
        fi
   done
   # wait for the nfctp log to be updated
   sleep 20;
   # TO-DO: Find better way to do this, drop double code
   # Wait for the last upload to finish
   while [[ $(tac ~/.ncftp/spool/log | grep -m 1 .) != *done* ]]; do
   # Bigger sleep value because we want the pushupload equivalent code to run first and update the upload-status.log file
	  sleep 20;
   done;
   # Source the status file
   source $(gettop)/upload-status.log
   for combo in "${vendorsetups[@]}"; do
   		device=$(echo $combo | sed 's/.*_\(.*\)-.*/\1/')
   		# We don't build grouper for now
   		if [ "$device" != "grouper" ]; then
	   		upload_message=${device}_upload
	   		[ "${!upload_message}" = "success" ]
	   		st=$(( $? + st ))
	   	fi
   done
   if [ $st -eq 0 ]; then
     echo "${green}All uploads were successful, we are notifying the pushbullet channel now...${reset}"
     pushbullet channel
   else
   	 echo "${red}Something went bad with the uploads, you should re-try manually${reset}"
   fi
}
