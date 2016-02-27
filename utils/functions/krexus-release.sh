#!/bin/bash

#     Copyright (C) 2016 KreAch3R, Krexus
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


# Version: 1.5
# dependencies: PushUpload, basketmd5, plus all their dependencies
# Usage: release [afh/basket]

function release() {
   # Check for upload service
   if [[ $# -eq 0 ]] ; then
       echo "${yellow}Please specify the upload service!${reset}"
       return 0
   fi

   # Update Dropbox Public changelog
   export DROPBOX_CHANGELOG=true

   # Setting upload success/failure value
   st=0

   # Start building every device
   for combo in "${vendorsetups[@]}"; do
       # We don't build grouper for now
       if [ "$combo" != "krexus_grouper-user" ]; then
           lunch $combo && make deviceclean && mka otapackage && pushupload $1
       fi
   done

   # wait for the nfctp log to be updated
   sleep 20;
   # TO-DO: Find better way to do this, drop double code
   # Wait for the last upload to finish
   while [[ $(tac ~/.ncftp/spool/log | grep -m 1 .) != *done* ]]; do
   # Bigger sleep value because we want the pushupload equivalent code to run first
       sleep 20;
   done;
   # sleep some more so that the upload-status.log file is updated
   sleep 20;

   # Source the status file
   source $(gettop)/upload-status.log
   for combo in "${vendorsetups[@]}"; do
       device=$(echo $combo | sed 's/.*_\(.*\)-.*/\1/')
       # We don't build grouper for now
       if [ "$device" != "grouper" ]; then
          upload_message=${device}_upload
	  # wait and re-source the log file if the variable is unset*
	  while [ -z "${!upload_message}" ]; do
	      sleep 10;
	      source $(gettop)/upload-status.log
	  done
	  [ "${!upload_message}" = "success" ]
	  st=$(( $? + st ))
       fi
   done

   # Notify about the result
   if [ $st -eq 0 ]; then
       echo "${green}All uploads were successful, we are notifying the pushbullet channel now...${reset}"
       pushbullet channel
   else
       echo "${red}Something went bad with the uploads, you should re-try manually${reset}"
   fi
}
