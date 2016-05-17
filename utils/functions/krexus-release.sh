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


# Version: 2.0
# dependencies: PushUpload, basketmd5, plus all their dependencies
# Usage: release [afh/basket] [DEVICE_NAME]

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

   # Create the device array
   devices=()
   for combo in "${vendorsetups[@]}"; do
       device=$(echo $combo | sed 's/.*_\(.*\)-.*/\1/')
       if [[ "$device" = "$2" ]] ; then
           devices=$2
           break
       else
           devices+=($device)
       fi
   done

   # Don't build the devices here
   if [[ $# -lt 2 ]] ; then
       notbuilt=("grouper" "flounder")
       for del in "${notbuilt[@]}"; do
           devices=(${devices[@]/$del})
       done
   fi

   # Notify of specific device release
   if [[ $# -eq 2 ]] ; then
       echo "${green}You are releasing a $2 build!${reset}"
   else
       echo "${green}You are releasing builds for: ${devices[@]}!${reset}"
   fi

   # Start building
   for device in "${devices[@]}"; do
       lunch krexus_$device-$variant && make deviceclean && mka otapackage && pushupload $1
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
   for device in "${devices[@]}"; do
       upload_message=${device}_upload
       # wait and re-source the log file if the variable is unset*
       while [ -z "${!upload_message}" ]; do
           sleep 10;
           source $(gettop)/upload-status.log
       done
       [ "${!upload_message}" = "success" ]
       st=$(( $? + st ))
   done

   # Notify about the result
   if [ $st -eq 0 ]; then
       echo "${green}All uploads were successful, we are notifying the pushbullet channel now...${reset}"
       pushbullet channel
   else
       echo "${red}Something went bad with the uploads, you should re-try manually${reset}"
   fi
}
