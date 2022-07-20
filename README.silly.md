# Snappy responses for bad commands or words
When *88-silly-errors.sh* is enabled, processing for bad commands and bad words is done by using a random, preset response described below.

## Silly Error Message Format

Silly error messages are stored in the file "sass.txt", in whichever 
directory the rest of the bash startup scripts are run from. 

Each silly error message is on it's own line. 

Multiple lines for one response cannot be used. 

An emedded "at-symbol" @ is replaced with the command that was attempted. 

Escape sequences are translated by the shell. 
E.g., "\033[1m" will set bold text. \007 will sound the bell. 

On MacOS with homebrew installed potential candidates for the failed command
may be found and suggested.

## Badwords and responses
Words defined (one per line) in *.bash.rc.d/badwords.txt*, when used as a command, will result in a random line from *.bash.rc.d/retorts.txt*
