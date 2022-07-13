#!/bin/bash
(return 0 2>/dev/null) || { echo "This script should not be run directly, use source instead" >&2 ; exit 1; }
if [[  $TERM_PROGRAM == "iTerm.app" ]] ; then
	if [[  ~/.iterm2_shell_integration.bash ]] ; then
		source ~/.iterm2_shell_integration.bash
		export iterm2_prompt_mark="$(iterm2_prompt_mark)"
	fi
	function iterm2_print_user_vars() {
		iterm2_set_user_var fortune "$(/usr/local/bin/fortune -sn 30)"
		true
	}
	export -f iterm2_print_user_vars
	iterm2_print_user_vars
fi
