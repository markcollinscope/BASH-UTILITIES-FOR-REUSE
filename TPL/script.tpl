#!/bin/bash

. utils.shi
set -e

Usage()
{
	USAGE=$(cat <<ENDUSAGE
		Usage: $(basename $0) <[-o|--opts] ...> <args ...>
		- REMOVE THIS LINE - USED TO CLEANUP UNUNSED SCRIPTS THAT USE THIS TPL - SEARCH PATTERN: "UNUSEDSCRIPTXXX"

		$(getOptUsageDocco)
		# REMOVE getOptUsage IF NOT USING --rem with AUTO-ARGS.
ENDUSAGE
	)

	USAGE=$(cat<<<$USAGE | sed 's/^\t\t//g')	# remove two leading tabs...
	1>&2 cat<<<$USAGE
	exiterr;
}

cleanup() { echo "It's a trap!"; }; trap cleanup SIGINT; ### ctl-c. See docco for other options.
doFn() { echo "DO-SUMMIT: $*"; }

main()
{
	errecho "START: $*"

	eval $(binopt --rem "binary options" -b BVAR hello world "$@"); echo BVAR: $BVAR
	eval $(boolopt -c BOOLVAR "$@"); echo BOOLVAR: $BOOLVAR;
	eval $(valopt --rem "mainvar options - ok asshole?" -m MAINVAR "$@"); echo MAINVAR: $MAINVAR
	eval $(valopt --rem "another value options just for fun" -x XVAR "$@"); echo XVAR $XVAR;

	errecho $0: $*

	doFn $*

	Usage

	exitok;
}

main "$@"

