. utils.shi

# eval $(boolopt -n NAMEONLY $*) - TODO

USAGE=$(cat <<HERE
$0 [-n] show a bash function definition
-n - show fn name only
HERE
)


main()
{
	NAMEONLY=false
	setvar PARTFN $1

	RES=$(set | sed -n "/^[[:alnum:]]*$PARTFN[[:alnum:]]* ()/,/^}/p")
	if $NAMEONLY; then 
		RES=$(cat <<< $RES | grep "^[[:alnum:]]*$PARTFN[[:alnum:]]* ()")
	fi
	cat <<< $RES	
}

main $*
