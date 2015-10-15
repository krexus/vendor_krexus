#!/bin/bash

#A KreAch3R Script

#Variables
pushbullet=$(gettop)/vendor/krexus/utils/pushbullet.sh

function loadvariables() {
#Check the $OUT directory for .zip files and grab the latest
otalocation=$(find $OUT -maxdepth 1 -type f -name "*.zip" | xargs ls -t | head -n1)
#Strip the directory from the file name
otapackage=$(basename $otalocation)
}

function pushbullet() {
    loadvariables
    printf "Notifying Pushbullet devices..."
    . $pushbullet push all note "OTA available!" "$otapackage created successfully."
    }

function zippy-upload() {
    loadvariables
    printf "Uploading to Zippyshare..."
    echo
    exec 5>&1
    local upload_url=$(plowup zippyshare --max-rate 90k $otalocation | tee >(cat - >&5))
    printf "Notifying Pushbullet devices..."
    . $pushbullet push all link "Upload complete: $otapackage" $upload_url
    }

function afh-upload() {
    loadvariables
    printf "Uploading to Android File host (FTP)..."
    echo
    ncftpput -f ~/.afh-credentials.cfg / $otalocation
    printf "Notifying Pushbullet devices..."
    . $pushbullet push all link "Upload complete: $otapackage" "www.androidfilehost.com"
    }

function pushupload() {
#Quoting the variable because it may be empty
    if [ "$1" == afh  ]
    then
    pushbullet && afh-upload
    else
    pushbullet && zippy-upload
    fi
    }
