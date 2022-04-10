#/bin/bash

. utils.shi

if ! test "$(pwd)" = "$(gitroot)"; then
	errecho 'not in git root directory for utils'
	exiterr;
fi

LITERAL='```'

cat << END
# BASH-UTILS - VERSION 0.9.0 - UNDER FINAL REVIEW - PRODUCTION RELEASE - CAN BE USED.
A set of around 100 bash utility functions to make writing complex well structured Bash Scripts easier.

nb: There may be typos in this documentation. It is still under review. Please let the author know of any.

Broadly speaking the utilities provide functionality to simplify 
* run time checking bash functions - argument checking for functions, etc, 
* assist undertaking of debugging (verbose output when -v or --vb flag passed into a script - flag configurable), 
* get or override user input (-f type flag), 
* create cross-script or same-script (as defined by context) 'persistent' bash variables that hide implementation details.
* check or ensure files and directories exist, 
* do useful stuff with git directories, move stuff around, commit stuff from scripts, branch from scripts, etc.
* automatically process command line flags (e.g. script -x -y -z 200 arg1 arg2) as either boolean flags or values to be set) - and automatically add usage documentation if you use the default Usage() function (provided automatically),
* enable the creation of map data structures (multi-d), 

and a whole load of other useful stuff.

## Using the utilities

To use any of the utilities they must  be 'included' within your script. 

To do this - having cloned this repo:
* copy the contents of the SRC directory to a place on your PATH.
* put the following at the top of your script(s).

$LITERAL
# this is optional - and shows the redefinition of a default 
# value ('--vb') within utilities, see later documentation.
export UTS_VERBOSEFLAG='-v' 

. utils.shi  
# note the 'dot' (.)
$LITERAL

nb: bash functions 'return' values in one of two ways - either by echo-return (echoing a value) - in which case the calling script
must use something like the following to pick up the return:
$LITERAL
VALUE=\$(function) 
$LITERAL

Alternatively they may 'return' values is using a 'return' statement explicity - return 0 or non-0.
$LITERAL
0 - will be evaluated as True in bash conditional statements
Non-0 - will be evaluated as False in bash conditional statements. So:

boolf() { return 1; }
if boolf; then ... else ... fi 
$LITERAL

would execute the 'else' part of the bash 'if' expression.
END

cat << END
## The Source

### Summary of Functionality

Filename            | Notes
--------------------|--------------
utils_core.shi      | $CORE_SUMMARY
utils_vb.shi        | $VB_SUMMARY
utils_opts.shi 		| $OPTS_SUMMARY
utils_git.shi 		| $GIT_SUMMARY
utils_pvar.shi      | $PVAR_SUMMARY
utils_fd.shi 	    | $FD_SUMMARY
utils_map.shi 		| $MAP_SUMMARY
utils_msc.shi 		| $MSC_SUMMARY
utils_uio.shi       | $UIO_SUMMARY
_					| _
utils.shi            | put '. utils.shi' at the top of your script to includes all utils files listed above.
utils_globals.shi   | This is a set of bash variables that are useful in scripts - globally assigned values for backup directories, git directories, etc.  Defaults are provided but if set externally and exported these values can be overridden. Some functions *will* expect the values to be set. It is possible to override any value without editing the file - environment takes precedence.
END

cat << END
## Per File - Detailed Description of Functions.
END

# Utils file list:
_UTILS="utils_core.shi utils_fd.shi utils_git.shi utils_map.shi utils_msc.shi utils_opts.shi utils_pvar.shi utils_uio.shi utils_vb.shi"

for i in $_UTILS; do
	echo "### $i"
	echo '```'
	ffn "[^].*" -s -m "$i" | grep -v "^_"
	echo ' '
	echo '```'
done

cat << END
### File naming

* *.shi (shell include) is used as a suffix for all utility files.

### Code conventions

* *tabstops* - the code uses tabs to indent. The tabstop during development is set to 4, though you should be able to vary this at the beginning of lines at least (but perhaps not once text has started).

* *test -z xxx vs. [[ -z xxx ]]* - the code currently uses the 'test' form of condition for 'if' statements, etc. e.g. 'test -z "$X"' - is $X an empty string. If enough people complain I could be tempted to convert this - but is it worth it?

## HELPER SCRIPTS and related notes

This README.md file was generated from a bash script (see README.sh) using some HELPER functions (see HELPER related sub-directory), 
mainly to extract functions and their documentation from the utils_xxx.shi files.

The HELPER scripts provided are:
END

TMPF=$(tmpFile)
rm -rf $TMPF

HELPERS="ffn.sh fndef.sh"
cd HELPER*;

for i in $HELPERS; do
	echo >> $TMPF
	echo "### $(basename $i)";
	echo $LITERAL >> $TMPF
	2>&1 $i "--hh" >> $TMPF
	echo >> $TMPF
	echo $LITERAL >> $TMPF
	echo >> $TMPF
done 

cat $TMPF

cat << END
## Comments and Contributions Welcome

Feedback or Contributions welcome:
* email:markcollinscope+bashutils@gmail.com, or message here.
* branch etc. to contribute something new and make a pull request.
* be patient - do let me know if you're doing something in advance, please.

END
