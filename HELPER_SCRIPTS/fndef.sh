#/bin/bash

. utils.shi

USAGE=$(cat <<USG
$(script) [-n] <part-fn-name>
Show bash function definition(s) - using native bash 'set' format (full listing)
Match any function that contains <part-fn-name> within it.
USG
)

processHelp
errifopts "$@"

main()
{
	setvar PARTFN $1
	RES=$(set | sed -n "/^[[:alnum:]]*$PARTFN[[:alnum:]]* ()/,/^}/p")

	#
	# if $NAMEONLY; then 
		# RES=$(cat <<< $RES | grep "^[[:alnum:]]*$PARTFN[[:alnum:]]* ()")
	# fi

	cat <<< $RES	
}

main "$@"
