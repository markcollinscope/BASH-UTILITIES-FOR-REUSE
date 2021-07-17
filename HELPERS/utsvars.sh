#!/bin/bash

. utils.shi
set -u
set -e

USAGE=$(cat <<ENDUSAGE

Usage: $(basename $0)
=====
o print all UTS_ vars - recursive descent search used.
o nb: works from *current* directory downwards.

ENDUSAGE
)

main()
{
	xgrep -r -h UTS_ | sed 's/.*\(UTS_[[:alnum:]]*\).*/\1/' | sort | uniq
}

main $*
