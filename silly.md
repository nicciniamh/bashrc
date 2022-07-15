# Silly Error Message Format

Silly error messages are stored in the file "sass.txt", in whichever 
directory the rest of the bash startup scripts are run from. 

Each silly error message is on it's own line. 

Multiple lines cannot be used. 

An emedded "at-symbol" @ is replaced with the command that was attempted. 

Escape sequences are translated by the shell. 
E.g., "\033[1m" will set bold text. \007 will sound the bell. 

On MacOS with homebrew installed potential candidates for the failed command
may be found and suggested.

