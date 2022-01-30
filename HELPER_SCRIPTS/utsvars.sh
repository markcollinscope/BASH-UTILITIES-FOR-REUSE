#!/bin/bash

. utils.shi
set -u
set -e

USAGE=$(cat <<ENDUSAGE
Usage: $(scripts)
o print all UTS_ vars - recursive descent search used.
o nb: works from *current* directory downwards.
o use to ensure non-duplication of existing UTS_ vars and to find errors
ENDUSAGE
)

main()
{
	xgrep -r -h UTS_ | sed 's/.*\(UTS_[[:alnum:]]*\).*/\1/' | sort | uniq
}

main $*
