
. utils.shi

_testopt()
{
	eval $(binopt "-a|--aaa" _A false true "$@")
	eval $(boolopt --rem 'hello world, you all ok?' -b _B "$@")
	eval $(boolopt  -c:--ccc _C "$@")
	errecho "$@" 
}

_A=hello
errecho 1A: $_A
_testopt 1  2 3 4 5
errecho A: $_A

errecho 2A: $_A
_testopt a b  --aaa c d e f g 
errecho A: $_A

errecho 3A: $_A
_testopt -a z y xxx wwwwwww --aaa vvvvvvvvvvvvvvvvvvv -aa uuuuuuuuuuuuuuuuuu t -a
errecho A: $_A

errecho 3B: $_B
_testopt -a z y xxx -b wwwwwww --aaa vvvvvvvvvvvvvvvvvvv -aa uuuuuuuuuuuuuuuuuu t -a
errecho B: $_B

errecho 3C: $_C
_testopt 1 2  3 4 5
errecho C: $_C
