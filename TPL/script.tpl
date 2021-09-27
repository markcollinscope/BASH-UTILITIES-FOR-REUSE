#!/bin/bash

. utils.shi

USAGE=$(cat << UTXT

Usage: $(script) [-options] <args>
da da da
o dum dum dum
o dum dum dum

UTXT
);

doCleanUp() { echo "It's a trap!"; }; trap doCleanUp SIGINT;

main()
{
	# eg use of opts.
	# eval $(boolopt -c BOOLVAR "$@"); echo BOOLVAR: $BOOLVAR;
	# eval $(valopt --rem "mainvar options - this is the docco - ok?" -m MAINVAR "$@"); echo MAINVAR: $MAINVAR
	# ...
	# errifopt "$@"
	# chkargcount 1 2 "$@"
	...

	exitok;
}

main "$@"
