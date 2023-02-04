#!/bin/bash

. utils.shi

SEP='|'

noeval() 
{
	echo "$@"
}

newboolopt() 
{
	local __FLAGS="$1"
	local __VAR="$2"
	shift 2;
	local __ARGS="$@"

	errecho "FLAGS: $__FLAGS"
	errecho "VAR: $__VAR"
	errecho "ARGS: $__ARGS"

	local _EVAL=
	local _SEMICOLON=
	for i in $(splitValue $__FLAGS); do
		errecho "Processing: <$i>"
		CMD="eval $(boolopt $i $__VAR $__ARGS)"
		errecho "CMD: $(noeval $CMD)"

		_EVAL=$(concat -c $_SEMICOLON "$_EVAL" "$CMD");
		errecho _EVAL: $_EVAL
		_SEMICOLON=';'	
	done
	echo $_EVAL;
}

tstSplitOpt()
{
	errecho "TESTING: $1";

	local RESULT=

	RETURN=$(newboolopt '--bb|--cc' RESULT "$@");

	echo "RETURN-VALUE: $(noeval $RETURN)"
	eval $RETURN;

	errecho RESULT: $RESULT;
	if $RESULT; then echo YAYYY; else echo NAHHHHHH; fi
}

main()
{
	vbvar IFS
	VAL="a|b|c|d";
	vbvar VAL
	RES=$(splitValue $VAL);
	vbvar RES
	resetIFS
	vbvar IFS

	echo $(count $RES)
	echo $RES

	tstSplitOpt --bb;
	echo RESULT: $RESULT
	tstSplitOpt --cc;
	echo RESULT: $RESULT
	tstSplitOpt --dd;
	echo RESULT: $RESULT

	exitok;
}

main "$@"
