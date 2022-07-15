#!/bin/bash
(return 0 2>/dev/null) || { echo "This script should not be run directly, use source instead" >&2 ; exit 1; }
if  shopt -q login_shell ; then
   clear
   [[ -x ~/.bash.rc.d/banner.py ]] && ~/.bash.rc.d/banner.py
fi
