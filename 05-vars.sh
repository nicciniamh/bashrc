#!/usr/bin/env bash
(return 0 2>/dev/null) || { echo "This script should not be run directly, use source instead" >&2 ; exit 1; }

function __getAppleIfAddrs() {
	networksetup -listallhardwareports | grep Device | grep -v serial| awk '{print $2}'|\
		while read if ;
			do ipconfig getifaddr $if
	done
}
if [[ "$(uname)" == "Darwin" ]] ; then
	export RCOSTYPE="macos"
	export HOST_ADDRESS="$(__getAppleIfAddrs | tr '\n' ' ')"
	export MACOS_FRIENDLY="$(awk '/SOFTWARE LICENSE AGREEMENT FOR macOS/' '/System/Library/CoreServices/Setup Assistant.app/Contents/Resources/en.lproj/OSXSoftwareLicense.rtf' | awk -F 'macOS ' '{print $NF}' | awk '{print substr($0, 0, length($0)-1)}')"
	export MACOS_VERSION="$(sw_vers -productVersion)"
	export MACOS_NAME="$(sw_vers -productName)"
	export MACOS_PRODUCT="${MACOS_NAME} ${MACOS_FRIENDLY}"
fi
if [[ $(uname) == "Linux" ]] ; then
	export RCOSTYPE="linux"
	if [[ -f /etc/lsb-release ]]; then
		source /etc/lsb-release
		export DISTRIB_ID DISTRIB_RELEASE DISTRIB_CODENAME DISTRIB_DESCRIPTION
	fi
	export HOST_ADDRESS=$(hostname -I|awk '{print $1}')
fi
