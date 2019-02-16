#!/bin/bash 
#####################################################################
#Project		:	RetroPie_BGM_Player
#Version		:	1.0.0
#Git			:	https://github.com/Naprosnia/RetroPie_BGM_Player
#####################################################################
#Script Name	:	bgm_setfade.sh
#Date			:	20190216	(YYYYMMDD)
#Description	:	BGM Player fade effect menu.
#Usage			:	Should be called from bgm_control.sh.
#Author       	:	Luis Torres aka Naprosnia
#####################################################################
#Credits		:	crcerror : https://github.com/crcerror
#####################################################################

BGM=$HOME"/RetroPie-BGM-Player"
BGMCONTROL=$BGM"/bgm_control"
BGMSETTINGS=$BGM"/bgm_settings.cfg"

infobox=
infobox="${infobox}___________________________________________________________________________\n\n"
infobox="${infobox}RetroPie BGM Player Fade Effect\n\n"
infobox="${infobox}Fade effect is highly experimental.\n\n"
infobox="${infobox}If you encounter any error or malfunction related to audio volume, or even if this option does not work for you, disable it.\n"
infobox="${infobox}If you use other audio channels other than PCM (default), this option will certainly not work.\n"
infobox="${infobox}\n"
infobox="${infobox}Any issue with this effect, please report to https://github.com/Naprosnia/RetroPie_BGM_Player/.\n"
infobox="${infobox}\n\n"
infobox="${infobox}A special thanks to crcerror / cyperghost, for developing the base script for the fade effect. https://github.com/crcerror\n"
infobox="${infobox}\n"
infobox="${infobox}___________________________________________________________________________\n\n"

dialog --backtitle "RetroPie BGM Player" --title "BGM Fade Effect Alert" --msgbox "${infobox}" 23 80


function main_menu() {
    local choice

    while true; do
	
		source $BGMSETTINGS >/dev/null 2>&1
		[ $bgm_fade -eq 0 ] && status=( "disabled" "Enable" 1 )  || status=( "enabled" "Disable" 0 )
		
        choice=$(dialog --backtitle "RetroPie BGM Player" --title "BGM Fade Effect Setting" \
            --ok-label "Select" --cancel-label "Back" --no-tags \
            --menu "BGM Player Fade Effect is ${status[0]}" 25 75 20 \
            1 "${status[1]} Fade Effect" \
            2>&1 > /dev/tty)

        opt=$?
		[ $opt -eq 1 ] && exit
		
		bash $BGM/bgm_system.sh -setsetting bgm_fade ${status[2]}
		
    done
}

main_menu