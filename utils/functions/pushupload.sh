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


# Version: 5
# dependencies:
# plowshare: https://github.com/mcrapet/plowshare
#            sudo apt-get install plowshare4
# pushbullet-bash: https://github.com/Red5d/pushbullet-bash
# ncftp: sudo apt-get install ncftp
# xmlstarlet: sudo apt-get install xmlstarlet
# Usage: pushbullet [channel]
#        pushupload [afh/basket] (zippy is default)

# Variables
pushbullet=$(gettop)/vendor/krexus/utils/pushbullet.sh
basketmd5=$(gettop)/vendor/krexus/utils/basketmd5.sh

function loadvariables() {
    # Check the $OUT directory for .zip files and grab the latest
    otalocation=$(find $OUT -maxdepth 1 -type f -name "*.zip" | xargs ls -t | head -n1)
    # Find the .md5 hash for the same file
    otamd5=$(cat $(echo $otalocation | sed -e 's/$/.md5sum/') | cut -f1 -d' ')
    # Strip the directory from the file name
    otapackage=$(basename $otalocation)
}

function prepare() {
    loadvariables
    echo "${yellow}Uploading to $printmessage ${reset}"
}

function pushbullet() {
    loadvariables
    if [ "$1" == channel ]; then
	$pushbullet push krexus link "OTAs available!" "$(date +"%d/%m/%y") builds are out! \n\nTap to download! \nChangelog: krexus.github.io/#changelog" "$link"
    else
	$pushbullet push all note "$TARGET_DEVICE: complete!" "$otapackage compiled successfully."
    fi
}

function pushupload() {
# Quoting the variable because it may be empty
    if [[ $# -eq 0 ]]; then
    	pushbullet && zippy-upload
    else
    	pushbullet && $1-upload
    fi
}

function ftp-upload() {
    prepare
    # send the ftp job for background uploading
    ncftpput -f ~/.$service-credentials.cfg -b $dir $otalocation
    # Run in background; check the upload
    {
    	# wait for the ncftp log to be updated
    	sleep 10
	    while [[ $(tac ~/.ncftp/spool/log | grep -m 1 .) != *done* ]]; do
	        sleep 10
	    done
	    if [ "$service" == basket ]; then
                # sleep some more, to give time to BasketBuild to update the site about the new uploaded build
                sleep 10
                # check parsemd5 output
                $basketmd5 $TARGET_DEVICE $otamd5 $otapackage
                ftp-upload-result
	    elif [ "$service" == afh ]; then
                ftp-upload-result
            fi
    } > backgroundcommands.log 2>&1 &
    disown
}

function ftp-upload-result() {
    if [ $? -eq 0 ]; then
        $pushbullet push all link "$TARGET_DEVICE: OTA available!" "$otapackage is uploaded successfully" "$link"
        if [ "$DROPBOX_CHANGELOG" = true ]; then
            echo "${TARGET_DEVICE}_upload=success" >> upload-status.log
            # Update the ota config file in Dropbox/Public folder
            xmlstarlet ed -L -u "/KrexusOTA/Stable/$TARGET_DEVICE/Filename" -v "$(echo $otapackage | cut -f1 -d'.')" ~/Dropbox/Public/krexus_ota.xml
            xmlstarlet ed -L -u "/KrexusOTA/Stable/$TARGET_DEVICE/RomUrl" -v "$link" ~/Dropbox/Public/krexus_ota.xml
        fi
    else
        $pushbullet push all note "Upload for $TARGET_DEVICE failed!" "Please re-try manually!"
        if [ "$DROPBOX_CHANGELOG" = true ]; then
            echo "${TARGET_DEVICE}_upload=failure" >> upload-status.log
        fi
    fi
}

function afh-upload() {
    printmessage="Android File host (FTP)..."
    link="https://www.androidfilehost.com/?w=devices&uid=23501681358558648"
    service="afh"
    dir="/"
    ftp-upload
}

function basket-upload() {
    printmessage="BasketBuild (FTP)..."
    link="https://basketbuild.com/devs/KreAch3R/Krexus"
    service="basket"
    dir="/Krexus/$TARGET_DEVICE"
    ftp-upload
}

function zippy-upload() {
    printmessage="Zippyshare..."
    prepare
    exec 5>&1
    local upload_url=$(plowup zippyshare --max-rate 90k $otalocation | tee >(cat - >&5))
    $pushbullet push all link "$TARGET_DEVICE: upload complete!" "packagename: $otapackage" $upload_url
}
