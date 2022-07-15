# Nicci's Nifty Bash Startup
![](https://raw.githubusercontent.com/nicciniamh/bashrc/main/iterm-screenshot.jpg)


Plug-in based bash startup. Each file is named with a number prefix and a name. These files
are sourced in order of their numeric prefix. Code with OS dependencies should be checked and
only executed on the proper environment. 

### Features
* OS Detection
* Directory aliases for cd command,
* Reactive prompt setup
*  and more. 

## Scripts defined

* **00-functions.sh**     *Miscelaneous code for bash function management*
* **05-vars.sh**          *Set some variables*
* **09-histopt.sh**       *Set history options*
* **10-aliases.sh**       *Load aliases from ~/.aliases*
* **11-setprompt.sh**     *Set the terminal prompt*
* **12-cdalias.sh**       *Replace the "cd" command allowing for aliasing of paths (cd -h for info)*
* **88-silly-errors.sh**  *Silly error messages for commands not found*
* **90-iterm.sh**         *code specific to the macOS iTerm app*
* **95-banner.sh**			*Show a pretty banner*
* **99-paths.sh**         *Path fixups*
* **badwords.txt**        *words to trigger retorts*
* **banner.py**           *Print a banner on screen*
* **imgcat**				   *Called in 90-iterm to find imgcat*
* **rc.loader.sh**        *The script that loads this whole mess*
* **readme.md**           *This file*
* **readme.sh**           *Convert readme to straight text*
* **retorts.txt**         *retorts for "bad" words*
* **sass.txt**            *silly error messages*
* **silly.md**            *Brief text about the format for sass.txt*

## Script setup and enabling
Scripts must be executable and named as above. If you want to temporarily ignore a script, you can remove execute permissions on it. 

## OS Detection and inside startup scripts
On startup, 05-vars.sh checks and sets OS specific variables. The global shell variable, RCOSTYPE is set to "linux" or "macos" appropriately. 

For example:

	if [[ "$RCOSTYPE" == "linux" ]]; then
	   # do linux specific stuff here
	fi

*note that $(uname) can be used with Linux and Darwin appropriately, too. RCOSTYPE is marginally faster.*

## Installation
Place all these files in *[homedir]/.bash.rc.d* except *.aliases* and *.aliases.options*. 

The aliases are optional. If you already have a .aliases file, you may keep that or merge these with yours. In order for *10-aliases.sh* to work properly, this file must be in your home directory. 

in *[homedir]/.bashrc* end the script with the following line: 

    source ~/.bash.rd.c/rc.loader.sh

**Note**: The XX-script.sh files, they must be set to executable for any those scripts to be called by *rc.loader.sh*.