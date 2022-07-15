#!/usr/bin/env bash
(return 0 2>/dev/null) || { echo "This script should not be run directly, use source instead" >&2 ; exit 1; }
source ~/.aliases
