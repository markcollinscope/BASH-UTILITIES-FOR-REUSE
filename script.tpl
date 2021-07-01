#!/bin/bash
# REMOVE THIS LINE - IT IS USED TO CLEANUP UNUNSED SCRIPTS - PATTERN MATCH UNUSEDSCRIPTXXX

. utils.shi

#
USAGE=$(cat <<ENDUSAGE
Usage: $(basename $0)

$(getOptUsage)
ENDUSAGE
)
#

cleanup() { echo "It's a trap!"; }
trap cleanup SIGINT # ctl-c.

doit() { echo "DOIT: $*"; }

main()
{
	eval $(boolopt -b BVAR $*); echo BVAR: $BVAR
	eval $(valopt -m MAINVAR $*); echo MAINVAR $MAINVAR
	# ...

	doit $*;
	exitok;
}

main $*;
Usage
