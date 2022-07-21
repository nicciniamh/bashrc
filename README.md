# Nicci's Nifty Bash Startup
![](https://raw.githubusercontent.com/nicciniamh/bashrc/main/media/iterm-screenshot.jpg)


Plug-in based bash startup. Each file is named with a number prefix and a name. These files
are sourced in order of their numeric prefix. Code with OS dependencies should be checked and
only executed on the proper environment. 

### Features
* OS Detection
* Directory aliases for cd command,
* Reactive prompt setup
* Snappy responses to invalid commands (and obscenities too)
* More

## Scripts defined in .bash.rc.d

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
* **retorts.txt**         *retorts for "bad" words*
* **sass.txt**            *silly error messages*

## Script Setup and Enabling
Scripts must be executable and named as above. If you want to ignore a script, you can remove execute permissions on it. For example, if you don't want the prompt set the way I have it, you can run ```chmod -x 11-setprompt.sh```

## OS Detection Inside startup scripts
On startup, 05-vars.sh checks and sets OS specific variables. The global shell variable, RCOSTYPE is set to "linux" or "macos" appropriately. 

For example:

```bash
	if [[ "$RCOSTYPE" == "linux" ]]; then
	   # do linux specific stuff here
	fi
```
	
Another way to distinghish the OS type is using uname. For example:

```bash
	if [[ $(uname) == "Darin" ]] ; then
		# Do some macOS stuff
	elif [[ $(uname) == "Linux" ]] ; then
		# Do some linux stuff
	else
		# Do other processing or error handling
	fi
```

The advantage to using RCOSTYOE is that, since it's an exported variable, no additional program needs to be invoked to get the OS type, so it's slightly faster. 

For a complete list of exported variables, please see [Global Variables Exported](#Global-Variables-Exported)

## Installation

Place .bash.rc.d in your home folder. 

in *[homedir]/.bashrc* end the script with the following line: 

    source ~/.bash.rd.c/rc.loader.sh

**Note**: The XX-script.sh files, they must be set to executable for any those scripts to be called by *rc.loader.sh*.

The optional *.aliases* and *.aliases.options* files should be in your home folder, but will be silently ignored if not present. 

## Global Variables Exported
| Variable              |Usage|
|-----------------------|---|
| DISTRIB_CODENAME      |For Linux Systems the Distribution Codename like "focal"|
| DISTRIB_DESCRIPTION   |Long description of Linux Distribution   |
| DISTRIB_ID            |Vendor Name of Distribution   |
| DISTRIB_RELEASE       |Vender Release ID (e.g., 20.04) of Distributio  |
| HOST_ADDRESS          |Space separated IP Addresses |
| MACOS_FRIENDLY        |Friendly name of macOS, e.g., Catalina   |
| MACOS_NAME            |Name of macOS, e.g, "Mac OS X"   |
| MACOS_PRODUCT         |Long name of macOS   |
| MACOS_VERSION         |Numeric verion of macOS |
| PROMPT_DIRTRIM        |Limits the lengh of paths in prompt |
| RCOSTYPE              |Name of OS, e.g, linux or macos   |
| TERMINAL_TITLE_STRING |The string that is sent to the terminal app for its title, part of 11-setprompt.sh |

Other files:

- [README.cdalias.md](https://github.com/nicciniamh/bashrc/blob/main/README.cdalias.md) - information on the cdalias script and usage
- [README.silly.md](https://github.com/nicciniamh/bashrc/blob/main/README.silly.md) - information on the error handling in 88-silly-errors.sh