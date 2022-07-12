#!/usr/bin/env bash
(return 0 2>/dev/null) || { echo "This script should not be run directly, use source instead" >&2 ; exit 1; }
[[ -z "$SHLVL" ]] && [[ $SHLVL -gt 1 ]] && return
## Change to the rc directory but return where we started when done. 
#DEBUG=dbg
__cpwd=$(pwd)
rcdotd="$HOME/.bash.rc.d"
cd $rcdotd
function atexit() {
	trap - EXIT
	[[ "${DEBUG}" ]] &&  read -p "Press ENTER to continue..."
}
trap atexit EXIT
[[ "${DEBUG}" ]] && set -x
for f in [0-9]*.sh ; do
	file="${rcdotd}/${f}"
	[[   "${DEBUG}" ]] && echo "${file}"
	[[ -x $file ]] && source $file
done
cd "$__cpwd">/dev/null
unset __cpwd
