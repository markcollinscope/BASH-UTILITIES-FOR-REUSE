#!/bin/bash

. utils.shi

USAGE=$(cat << UTXT

Usage: $(basename $0) [-f] <args>
da da da
o dum dum dum
o dum dum dum

UTXT
);

Usage()
{
	OPTIONS="$(getOptUsage)"
	>&2 cat<<<$USAGE
	>&2 cat<<<$OPTIONS
	exiterr 1
}

cleanup() { echo "It's a trap!"; }; trap cleanup SIGINT;
doFn() { echo "DO-SUMMIT: $*"; }

main()
{
	# eg use of opts.
	eval $(boolopt -c BOOLVAR "$@"); echo BOOLVAR: $BOOLVAR;
	eval $(valopt --rem "mainvar options - ok asshole?" -m MAINVAR "$@"); echo MAINVAR: $MAINVAR
	# ...

	exitok;
}

main "$@"

