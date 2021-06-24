#!/bin/bash
# REMOVE THIS LINE - IT IS USED TO CLEANUP UNUNSED SCRIPTS - PATTERN MATCH UNUSEDSCRIPTXXX

#
USAGE=$(cat <<ENDUSAGE
Usage: $(basename $0) <args ...> - description...
-x	option x...
-y 	option y... etc.
ENDUSAGE
)
#

. utils.shi

cleanup() # Only if you really need it.
{
    # add cleanup code.
}
trap cleanup SIGINT # trap ctrl-c, call cleanup.


doit() 
{
	# ... do something!
}

main()
{
	local ARGS=

	while ! test -z "$1"; do
		case $1 in
			-o|--output) # 2 arg option, for example.
				OUTPUTFILE=$2; shift 2 ;;
			-a) # one arg options.
				FLAG="A"; shift ;;
			*)  
				ARGS="$ARGS "$1 # keep "non option" args for later use.
				shift;
				;;
		esac;
	done

	doit $ARGS # process real arguments and do something.
	exitok;
}

main $*;
