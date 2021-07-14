#!/bin/bash

. utils.shi
set -u
set -e

USAGE=$(cat <<ENDUSAGE
	Usage: $(basename $0)
	* Print all uts_ vars - recursive descent search used.
	* nb: works from *Current* directory downwards.
ENDUSAGE
)


main()
{
	xgrep -r -h UTS_ | sed 's/.*\(UTS_[[:alnum:]]*\).*/\1/' | sort | uniq
}

main $*
