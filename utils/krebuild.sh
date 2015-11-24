#!/bin/bash

#A KreAch3R Script

#Variables
green=`tput setaf 2`
reset=`tput sgr0`

#sourcing envsetup
source build/envsetup.sh

# cd --> cdb alias
alias cd='cdb'

function release() {
   readarray -t vendorsetups < vendor/krexus/vendorsetup.sh
   for command in "${vendorsetups[@]}"; do
        setup=$( echo $command | cut -d ' ' -f 2 )
        lunch $setup && mka otapackage && pushupload basket
   done
   pushbullet channel
}
