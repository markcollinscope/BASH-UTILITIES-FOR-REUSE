#!/bin/bash

. utils.shi

USAGE=$(cat << UTXT

Usage: $(basename $0) [-f] <args>
da da da
o dum dum dum
o dum dum dum

UTXT
);

cleanup() { echo "It's a trap!"; }; trap cleanup SIGINT;
doFn() { echo "DO-SUMMIT: $*"; }

main()
{
	# eg use of opts.
	eval $(boolopt -c BOOLVAR "$@"); echo BOOLVAR: $BOOLVAR;
	eval $(valopt --rem "mainvar options - this is the docco - ok?" -m MAINVAR "$@"); echo MAINVAR: $MAINVAR
	# ...

	exitok;
}

main "$@"

