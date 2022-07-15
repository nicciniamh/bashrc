#!/bin/false
#
# This file should be sourced from .bashrc or .bash_login
#
# Set the prompt and prompt command to properly set the xterm title, and 
# color the prompt for specific systems. If $HOME/bin/setprompt.colors that 
# file is sourced and uses the same format as below
# If you're running as root, the background of user and path is always red. 
#
# escape sequences are escaped within bash as non-printing characters to
# prevent terminal weirdness with embedded ansi codes
(return 0 2>/dev/null) || { echo "This script should not be run directly, use source instead" >&2 ; exit 1; }
function __ansicolor() {
    ## This function creates escaped escape sequences for prompting
    if [[ $# == 3 ]] ; then
        local at=$1
        shift
    else
        local at=0
    fi
    echo "\[\e[${at};3${1};4${2}m\]"
}
function setTitle() {
	local wd=$(chomppath $(pwd))
    local ITS="$(whoami)@${HOSTNAME}:${wd}"
    echo -en '\033]0;'
    echo -n "$ITS"
    echo -en '\007'
    export TERMINAL_TITLE_STRING=${ITS}
}
function setPrompt() {
    local EXIT=$? ## Must be firstl line in function
    local happy="😀"
    local sad="😡"
    local ablack=0
    local ared=1
    local agreen=2
    local ayellow=3
    local ablue=4
    local apurple=5
    local acyan=6
    local awhite=7
    local anorm=0
    local abold=1
    local afaint=2
    local aunder=4
    local ablnk=5
    local RESET="\[\e[0m\]"
    if (($EXIT)) ; then
        local FACE="${sad}"
    else
        local FACE="${happy}"
    fi
    #FACE="${FACE} (${EXIT})"
    if (($EUID)) ; then
        local USER="$(__ansicolor $abold $awhite $apurple)"
    else
        local USER="$(__ansicolor $abold $ayellow $ared)"
    fi
    local HIST="$(__ansicolor $abold $ablack $acyan)"
    local HOST="$(__ansicolor $abold $awhite $agreen)"
    local CDIR="$(__ansicolor $awhite $ablue)"
    local PCH="▶"
    if hostname|egrep -q 'BigMac' ; then   ### If you don't want the hostname to show replace "BigMac" with your hostname
        local hpart=""
    else
        local hpart="${HOST} \h "
    fi
    export PS1="${FACE} ${HIST} \! ${hpart}${USER} \u ${CDIR} \w ${RESET}${PCH} "
    setTitle
}
export PROMPT_DIRTRIM=3
export PROMPT_COMMAND=setPrompt
