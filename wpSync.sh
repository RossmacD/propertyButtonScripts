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

# Menu Functions

function prodToStaging(){
	echo "Prod to staging selected"
	cd /var/www/html
	wp db export ~/wpTemp/production.sql
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
