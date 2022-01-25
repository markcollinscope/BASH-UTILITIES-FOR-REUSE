. utils.shi

# Utils file list:
UTILS="utils_core.shi utils_fd.shi utils_git.shi utils_globals.shi utils_map.shi utils_msc.shi utils_opts.shi utils_pvar.shi utils.shi utils_uio.shi utils_vb.shi"

cat << END
# BASH-UTILS - VERSION 0.2 - SUBJECT TO FURTHER REVIEW - COMMENTS WELCOMED
A set of over 40 bash utility functions to make writing complex well structured Bash Scripts easier.

Broadly speaking the utilities provide functionality to simplify writing bash functions (check arguments, etc), under take debugging or verbose output (when -v flag passed into a script), get or override user input (-f type flag), check or ensure files and directories exist, do useful stuff with git directories, create map data structures (multi-d), and a whole load of other useful miscellaneous stuff.

## Using the utilities
To use any of the utilities it must  be 'included' within your script. 
To do this put:

```
. utils.shi  
# note the 'dot' (.)
```
and set your PATH variable:


```
export PATH="/path/to/utilities/directory:$PATH"
```

The easiest way to use the utilities is to include utils.shi:

```

source utils.shi # source is alternate to 'dot'.
```
or you can include the sub-utility file itself, e.g.

```

. utils_vb.shi  # will include whatever it needs to work correctly.
```

NB: *including* a bash include file is merely a textual inclusion mechanism. There is no formal 'importing' etc. as you might find in full programming languages. 
END

## The Source

### The files and associated notes:
cat << END
Filename            | Notes
--------------------|--------------
utils_core.shi      | $CORE_SUMMARY
utils_vb.shi        | $VB_SUMMARY
utils_opts.shi 		| $OPTS_SUMMARY
utils_git.shi 		| $GIT_SUMMARY
utils_pvar.shi      ! $PVAR_SUMMARY
utils_fd.shi 	    | $FB_SUMMARY
utils_map.shi 		| $MAP_SUMMARY
utils_msc.shi 		| $MSC_SUMMARY
utils_uio.shi       | $UIO_SUMMARY
--------------------|-------------
utils.sh            | put '. utils.sh' at the top of your script to includes all utils files listed above.

nb: utils_globals.shi| This is a set of bash variables that are useful in scripts - globally assigned values for backup directories, git directories, etc.  Defaults are provided but if set externally and exported these values can be overridden. Some functions *will* expect the values to be set.
END


cat << END
## Functions Descriptions By File
END

for i in utils_vb.shi; do  # $UTILS; do
	echo "### $i"
	echo '```'
	ffn -s -m "$i"  ".*" | grep -v "^_" | sed 's/#//g' | sed 's/^ //g'
	echo ' '
	echo '```'
done

cat << END

### File naming

* *.shi* (**sh**ell **i**nclude) is used as a suffix for all utility files.

### Code conventions

* *tabstops* - the code uses tabs to indent. The tabstop during development is set to 4, though you should be able to vary this at the beginning of lines at least (but perhaps not once text has started).

* *test -z xxx vs. [[ -z xxx ]]* - the code currently uses the 'test' form of condition for 'if' statements, etc. e.g. 'test -z "$X"' - is $X an empty string. If enough people complain I could be tempted to convert this - but is it worth it?

## Comments and Contributions Welcome
Please do contribute:
* email:markcollinscope+bashutils@gmail.com, or message here.
* branch etc. to contribute something new and make a pull request.
* be patient - do let me know if you're doing something in advance, please.
END

