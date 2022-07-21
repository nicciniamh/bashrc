## cdalias - directory aliasing for the cd builtin.

cdalias is a set of functions which creates directory aliases 
for the  bash cd builtin.

Aliases are stored in the 
file pointed to by *$CDALIASDICTFILE* or *$HOME.cdaliases* if not set. The format of this file is simple:

	 alias definition # Comment
 
 Comments may also be placed at the beginning of the 
 line and those lines, as well as blank lines, are 
 ignored entirely.

## Usage
	cd [-aoprh|-reload|-list dir

### Options added to the cd command:
		-a alias definition or -a alias:definition
			   store new alias definition and exit  
		-o     cd will act like popd, although directory aliases are then irrelevant
		-p     cd will act like pushd
		-r alias removes the alias.
		-h 	   Will display the internal help for cd, then help on these options and exit
		-list  list the directory aliases and exit
		-reload Reload aliases from dictionary file

### Built-in aliases
If there is no alias file or no definitions, the prebuilt aliases are:

	 	...  Change to the parent of the parent, or ../..
 		.... Change to the parent of the parent of the parent, or ../../..

## Limitations
  Alias names must not contain leading dashes or any slashes or, 
  generally special characters. For aliase names with spaces use
  the second syntax of:
  
  	alias name:/some/long/path
 
  Other restrictions such as slashes, dashes and special characters
  apply. 
 
## Exported variables and functions
cdalias needs these variables and functions to work. 

- _CDALIAS_HELP - used with the -h option to cd
- _cdalias_dictfile - consistent representation of the alias file being used
- _cdalias_dictionary - internal dictionary of aliases
- _cdalias_writealiases - write out alias file
- _cdalias_readaliases - read in alias file
- cdalias - the cdalias function

### *wrapping up*
As part of .bash.rc.d, the cdalias script will alias cd=cdalias.


