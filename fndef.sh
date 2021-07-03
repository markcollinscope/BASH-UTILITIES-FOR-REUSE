. utils.shi

USAGE=$(cat <<HERE
$0 [-n] show a bash function definition
-n - show fn name only
HERE
)

eval $(boolopt -n NAMEONLY $*)

main()
{
	setvar PARTFN $1

	RES=$(set | sed -n "/^[[:alnum:]]*$PARTFN[[:alnum:]]* ()/,/^}/p")
	if $NAMEONLY; then 
		RES=$(cat <<< $RES | grep "^[[:alnum:]]*$PARTFN[[:alnum:]]* ()")
	fi
	cat <<< $RES	
}

main $*
