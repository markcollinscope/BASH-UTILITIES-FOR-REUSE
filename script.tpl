#!/bin/bash

. utils.shi
set -u
set -e

#
setUsage()
{
	USAGE=$(cat <<ENDUSAGE
		Usage: $(basename $0)
		- Script Template - REMOVE THIS LINE - IT IS USED TO CLEANUP UNUNSED SCRIPTS - PATTERN MATCH "UNUSEDSCRIPTXXX"

		Options:
		$(getOptUsage)
		---
ENDUSAGE
	)
	# USAGE=$(cat<<<$USAGE | sed 's/^\t\t//g')
}

cleanup() { echo "It's a trap!"; }
trap cleanup SIGINT # ctl-c.

doit() { echo "DOIT: $@"; }

main()
{
	errecho $0: $*
	argExact 3 "$@"

	doit $*
	exitok;
}

eval $(binopt -b BVAR hello world $* -d "boolean options ok"); echo BVAR: $BVAR
eval $(valopt -d "mainvar options - ok asshole?" -m MAINVAR $*); echo MAINVAR: $MAINVAR

setUsage	
main $*
