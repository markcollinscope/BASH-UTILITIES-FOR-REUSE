# BASH-UTILS
A set of over 40 bash utility functions to make writing complex well structured Bash Scripts easier.

Broadly speaking the utilities provide functionality to simplify writing bash functions (check arguments, etc), under take debugging or verbose output (when -v flag passed into a script), get or override user input (-f type flag), check or ensure files and directories exist, do useful stuff with git directories, create map data structures (multi-d), and a whole load of other useful miscellaneous stuff.

## Using the utilities
To use any of the utilities it must  be 'included' within your script. 
To do this put:

```
. filename.shi  # note the 'dot' (.)
```
and set your PATH variable:
```
export PATH="/path/to/utilities/directory:$PATH" #

at the top of your file, where filename is taken from the files available in the repository. The easist way top use the utilities is to include utils.shi:
```
source utils.shi # source is alternate to 'dot'.
```
or you can include the sub-utility file itself, e.g.
```

. utils_vb.shi  # will include whatever it needs to work correctly.
```
## The Source
### File naming
* *.shi* (shell include) is used as a suffix for all utility files.
### Code conventions
* *tabstops* - the code uses tabs to indent. The tabstop during development is set to 4, though you should be able to vary this at the beginning of lines at least.
* *test -z xxx vs. [[ -z xxx ]]* - the code currently uses the 'test' form of condition for 'if' statements, etc. e.g. 'test -z "$X"' - is $X an empty string. If enough people complain I could be tempted to convert this.

