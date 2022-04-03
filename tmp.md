# BASH-UTILS - VERSION 0.9.0 - CURRENTLY UNDER REVIEW - BUT USABLE
There may be typos in this documentation. It is still under review.

A set of over 40 bash utility functions to make writing complex well structured Bash Scripts easier.

Broadly speaking the utilities provide functionality to simplify 
* run time checking bash functions - argument checking for functions, etc, 
* under take debugging or verbose output (when --vb flag passed into a script), 
* get or override user input (-f type flag), 
* check or ensure files and directories exist, 
* do useful stuff with git directories, 
* create map data structures (multi-d), 

and a whole load of other useful miscellaneous stuff.

## Using the utilities
To use any of the utilities they must  be 'included' within your script. 
To do this put:

```
. utils.shi  
# note the 'dot' (.)
```
Filename            | Notes
--------------------|--------------
utils_core.shi      | Core utility functions for bash. These functions are used across other utility functions extensively. Many are more for convenience or readibility than for extensive functionality, e.g. 'script' - print the basename of the currently running script...
utils_vb.shi        | Functions mainly used in debugging - that print values, etc. when a 'verbose' flag is set to on. Note that the functionality automatically parses (then removes) "--vb", if it is the *first* argument to a script, to set verbose on.
utils_opts.shi 		| Utility functions to enable the automatic parsing of command line option flags (-x, --doit, etc) and their subsequent removal from the command line argument to make processing easier. Options can appear in any position. Use of an optional --rem 'description ...' when specifying command line flag auto processing results in the 'description ...' being added to the Usage description in the containing script (without any further effort). 
utils_git.shi 		| Utitlites to assist in the automation of git related activities. In particular allows detection of the 'current' git repo. e.g. get currrent git root dir, is this a git repo? what's the current branch called ... etc.
utils_pvar.shi      | Provides services to enable bash scripts to store 'persistent' variables. Persisent meaning the variable retain their value across different calls to the same, or another, script.
utils_fd.shi 	    | Utilities for file and directory management. Find directories and files, check they exist, find directories not in the 'excluded' list (UTS_EXCLUDE - defined in egrep format). Functions with 'x' as first char exclude results based on the UTS_EXCLUDE value.
utils_map.shi 		| Utilities to provide multi-dimentional hash-map style functionality to bash, enabling the addition or extraction of values from a named MAP given any number of keys (one key per dimension).
utils_msc.shi 		| Provides misc servces for thing like: padded output; stripping whitespaces; counting arguments; checking a scripts software dependencies & tarring up directories.
utils_uio.shi       | Functions that request user input ("warning: do you want to..., hit any key to...") before continuing. 
Putting "--ff" as the first arguments to a script call 'forces' the functions to skip user input (e.g. like rm -f does).
_					| _
utils.sh            | put '. utils.sh' at the top of your script to includes all utils files listed above.
utils_globals.shi   | This is a set of bash variables that are useful in scripts - globally assigned values for backup directories, git directories, etc.  Defaults are provided but if set externally and exported these values can be overridden. Some functions *will* expect the values to be set. It is possible to override any value without editing the file - environment takes precedence.
## Functions Descriptions By File

### File naming

* *.shi (shell include) is used as a suffix for all utility files.

### Code conventions

* *tabstops* - the code uses tabs to indent. The tabstop during development is set to 4, though you should be able to vary this at the beginning of lines at least (but perhaps not once text has started).

* *test -z xxx vs. [[ -z xxx ]]* - the code currently uses the 'test' form of condition for 'if' statements, etc. e.g. 'test -z ""' - is  an empty string. If enough people complain I could be tempted to convert this - but is it worth it?

## Comments and Contributions Welcome
Contributions welcome:
* email:markcollinscope+bashutils@gmail.com, or message here.
* branch etc. to contribute something new and make a pull request.
* be patient - do let me know if you're doing something in advance, please.

## Other notes:
This README.md file was generated from a bash script (see README.sh) using some HELPERS functions (see directory), 
mainly to extract functions and their documentation from the utils_xxx.shi files.

The HELPER scripts provided are:
SCRIPT:
HELPER_SCRIPTS LICENSE README.md README.sh SRC tmp.md
SYNOPSIS:
README.sh: line 96: HELPERS/*: No such file or directory

