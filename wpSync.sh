#!/bin/bash

##
# Color  Variables
##
green='\e[32m'
blue='\e[34m'
clear='\e[0m'

##
# Color Functions
##

ColorGreen(){
	echo -ne $green$1$clear
}
ColorBlue(){
	echo -ne $blue$1$clear
}

# Variables
prodPath=/var/www/html
prodUrl=https://test.webspace.ie
stagePath=/var/www/html
stageUrl=https://test.webspace.ie/

#Menu Functions
function prodToStaging(){
	echo "Prod to staging selected"
	echo "Copying Database from ${prodPath}"
	cd $prodPath
	wp db export ~/wpTemp/production.sql
	echo "Importing Database Into ${stagePath}"
	cd $stagePath
	wp db import ~/wpTemp/production.sql
	echo "Replacing ${prodUrl} with ${stageUrl}"
	wp search-replace $prodUrl $stageUrl
	cd ~/scripts
	exit
}

function stagingToProd(){
	echo "Staginf to prod selected"
	exit
}


menu(){
echo -ne "
My First Menu
$(ColorGreen '1)') Sync: Prod to Staging
$(ColorGreen '2)') Sync: Staging to Prod
$(ColorGreen '0)') Exit
$(ColorBlue 'Choose an option:') "
        read a
        case $a in
	        1) prodToStaging ; menu ;;
	        2) stagingToProd ; menu;;
		0) exit 0 ;;
		*) echo -e $red"Wrong option."$clear; WrongCommand;;
        esac
}

# Call the menu function
menu
