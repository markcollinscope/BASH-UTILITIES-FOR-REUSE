# BASH-UTILS - VERSION 0.1 - SUBJECT TO FURTHER REVIEW - COMMENTS WELCOMED
A set of over 40 bash utility functions to make writing complex well structured Bash Scripts easier.

Broadly speaking the utilities provide functionality to simplify writing bash functions (check arguments, etc), under take debugging or verbose output (when -v flag passed into a script), get or override user input (-f type flag), check or ensure files and directories exist, do useful stuff with git directories, create map data structures (multi-d), and a whole load of other useful miscellaneous stuff.

## Using the utilities
To use any of the utilities it must  be 'included' within your script. 
To do this put:

```
. filename.shi  
# note the 'dot' (.)
```

and set your PATH variable:


```
export PATH="/path/to/utilities/directory:$PATH"
```

The easiest way top use the utilities is to include utils.shi:

```

source utils.shi # source is alternate to 'dot'.
```
or you can include the sub-utility file itself, e.g.

```

. utils_vb.shi  # will include whatever it needs to work correctly.
```

NB: *including* a bash include file is merely a textual inclusion mechanism. There is no formal 'importing' etc. as you might find in full programming languages. 

## The Source

### The files and associated notes:

Filename         | Notes
-----------------|--------------
utils.shi        | Main include file. Including this file includes all the files listed below.
utils_core.shi   | functions for: script exit and status, bash function argument checking, setting text output colo[u]r on command line, echoing to standard error, and a default Usage function.
utils_vb.shi     | Verbose output functionality. The functions here will, if a '-v' is passed as the first argument to a script, output (echo) additional information - e.g. for debug or for additional explanation (see vbecho). Provides for output of bash function names as well (see vbfnecho). No '-v' flag, no output. 
utils_fd.shi     | Functions to *check* (exit on error) or *ensure* (create if not present) if directories and files that a scripts expects to be there actually is. See function names (create, ensure). Also functions to create temp files, search for files, or write output to files.
utils_uio.shi        | Warn (continue yes/no?)  style. Or hit any key to continue. Passing -f as first arg to a script using this include will turn the warnings off ('force' option). 
utils_git.shi    | functions to determine - am I in a git dir? Does this git dir need a commit? etc. Used for git related scripts (unsurprisingly).
utils_msc.shi    | other functinos. randomString and xgrep can be quite useful.
utils_map.shi    | multi dimensional (hash)map data structure. can use with caution (for now).
NB: utils_globals.shi| This is a set of bash variables that are useful in scripts - globally assigned values for backup directories, git directories, etc.  Defaults are provided but if set externally and exported these values can be overridden. Some functions *will* expect the values to be set.

### File naming

* *.shi* (**sh**ell **i**nclude) is used as a suffix for all utility files.

### Code conventions

* *tabstops* - the code uses tabs to indent. The tabstop during development is set to 4, though you should be able to vary this at the beginning of lines at least (but perhaps not once text has started).

* *test -z xxx vs. [[ -z xxx ]]* - the code currently uses the 'test' form of condition for 'if' statements, etc. e.g. 'test -z "$X"' - is $X an empty string. If enough people complain I could be tempted to convert this.

## Comments and Contributions Welcome
Please do contribute:
* email:markcollinscope@gmail.com, or message here.
* branch etc. to contribute something new and make a pull request.