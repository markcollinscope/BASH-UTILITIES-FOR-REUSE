. utils.shi

USAGE=$(cat <<USG

$0 [-n] show a bash function definition
-n - show fn name only

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
