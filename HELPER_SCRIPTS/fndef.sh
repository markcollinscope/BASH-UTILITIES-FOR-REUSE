#/bin/bash

. utils.shi

USAGE=$(cat <<USG
$(script) [-n] <part-fn-name>
Show bash function definition(s) - using native bash 'set' format.
Match any function that contains <part-fn-name> within it.
-n - show the fn name only
USG
)

main()
{
	NAMEONLY=false
	if test "$1" = "-n"; then NAMEONLY=true; shift; fi
	checkNotEmptyString "Missing function name" $1

	setvar PARTFN $1

	RES=$(set | sed -n "/^[[:alnum:]]*$PARTFN[[:alnum:]]* ()/,/^}/p")
	if $NAMEONLY; then 
		RES=$(cat <<< $RES | grep "^[[:alnum:]]*$PARTFN[[:alnum:]]* ()")
	fi
	cat <<< $RES	
}

main "$@"
