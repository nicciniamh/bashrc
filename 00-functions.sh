(return 0 2>/dev/null) || { echo "This script should not be run directly, use source instead" >&2 ; exit 1; }
copy_function() { test -n "$(declare -f $1)" && eval "${_/$1/$2}"; };
rename_function() { copy_function "$@" && unset -f "$1"; }

unset chomppath
## Chomppath gives a visual representation of a long path as .../path/to/dir
## for display purposes.
function chomppath() {
	local f=0
	local pin="$1"
	IFS=/ read -r -a __p <<< "${pin}"
	__p=("${__p[@]:1}")
	while [[ ${#__p[@]} -gt 3 ]] ; do
		f=1
		__p=("${__p[@]:1}")
	done
	local p=".."
	local c=""
	if [[ f -ne 0 ]] ; then
		for c in ${__p[@]} ; do
			p=${p}/${c}
		done
		echo "$p"
	else
		echo "$1"
	fi
	unset __p
}
export -f chomppath
