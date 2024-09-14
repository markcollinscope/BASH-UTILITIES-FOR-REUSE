. utils.shi

_testopt()
{
	eval $(binopt "-a|--aaa" _A false true "$@")
	errecho "$@" 
}

_A=hello
errecho A: $_A
_testopt 1  2 3 4 5
errecho A: $_A
