#!/bin/bash

#A KreAch3R Script

#Variables
green=`tput setaf 2`
red=`tput setaf 1`
yellow=`tput setaf 3`
reset=`tput sgr0`

#sourcing envsetup
source build/envsetup.sh

# cd --> cdb alias
alias cd='cdb'

echo "${green}Welcome to Krexus! ${reset}"
