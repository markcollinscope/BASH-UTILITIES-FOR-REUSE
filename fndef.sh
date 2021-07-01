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

	RES=$(set | sed -n "/^[[:alnum:]]*$PARTFN.*\s()/,/^}/p")
	if $NAMEONLY; then 
		RES=$(cat <<< $RES | grep '()') 
	fi
	cat <<< $RES	
}
# set | grep ".*$1.* ()" | awk '{ print $1; }'

main $*
