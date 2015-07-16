#!/bin/bash

#A KreAch3R Script

#Variables
green=`tput setaf 2`
reset=`tput sgr0`

#sourcing envsetup
source build/envsetup.sh

#inform on Changelog
echo "${green}Changelog is enabled (by default)${reset}"

#enable Prebuilt Chromium
#export USE_PREBUILT_CHROMIUM=1
#echo "${green}Prebuilt Chromium will be used${reset}"
