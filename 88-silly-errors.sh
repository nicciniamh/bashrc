#!/bin/bash
(return 0 2>/dev/null) || { echo "This script should not be run directly, use source instead" >&2 ; exit 1; }
if type command_not_found_handle 2>/dev/null  | grep -q 'a function' ; then
    rename_function command_not_found_handle old_command_not_found_handle
else
    function old_command_not_found_handle() { false; }
    export -f old_command_not_found_handle
fi
function __cnf_sereload() { 
    # Load the silly error message templates into an array. 
    IFS=$'\r\n' GLOBIGNORE='*' command eval  '__silly_errors=($(cat $HOME/.bash.rc.d/sass.txt))'
    IFS=$'\r\n' GLOBIGNORE='*' command eval  '__silly_obsret=($(cat $HOME/.bash.rc.d/retorts.txt))'
}
export -f __cnf_sereload
__cnf_sereload
if [[ -f badwords.txt ]] ; then
    IFS=$'\r\n ' GLOBIGNORE='*' command eval  '__cnf_obs=($(cat $HOME/.bash.rc.d/badwords.txt))'
else
    declare -a __cnf_obs=("fuck" "shit" "cunt" "piss" "motherfucker" "tits" "bitch" "penis")
fi
function __cnf_runfunction () {
	[[ -d  "$1" ]] && { cd "$1"; return; }
	[[ -L  "$1" ]] && [[ -d "$(readlink "$1")" ]] && { cd "$1"; return;}

    if [[ ! -z "$MACOS_NAME" ]] ; then
        bfile="/usr/local/Homebrew/Library/Taps/homebrew/homebrew-core/Formula/${1}.rb"
        if [[ -f $bfile ]] ; then
            dsc=$(grep '^  desc'  $bfile | sed 's/^  desc //g')
            if [[ ! -z "$dsc" ]] ; then
                echo "Did you mean, \"$1\": $dsc?"
                echo "You may install it with brew install $1"
                return 1
            fi
        fi
    fi
    RANDOM=$$$(date +%s)
    if [[ " ${__cnf_obs[@]} " =~ " ${1} " ]]; then
        echo "$1?? ${__silly_obsret[$RANDOM % ${#__silly_obsret[@]} ]}" >&2
        return 1
    fi
    emsg=${__silly_errors[$RANDOM % ${#__silly_errors[@]} ]}
    echo -e "${emsg//"@"/"$1"}">&2
    return 1
}
function command_not_found_handle() {
    if [[ $- == *i* ]] ; then
        __cnf_runfunction "$1"
    else
        old_command_not_found_handle "$1"
    fi
    false
}
function badwords() {
    local cnt=${#__cnf_obs[@]}
    ((cnt-=1))
    local i=0
    for i in ${!__cnf_obs[@]} ; do
        echo -n ${__cnf_obs[i]}
        if ((i < cnt)) ; then
            echo -n ", "
        fi
    done
    echo
}
export -f badwords
export -f command_not_found_handle
