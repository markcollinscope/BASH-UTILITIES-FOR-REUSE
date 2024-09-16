
. utils_core.shi 
echo INCLUDE
errecho INCLUDE
. ./uo.shi

errecho START
USAGE=usage
eval $(bopt --rem 'global z opt' -z:--zopt "$@");
echo z: $z;
errecho zopt: $zopt;
errifopt "$@";

_testopt()
{
	eval $(binopt "-a|--aaa" _A false true "$@")
	eval $(boolopt --rem 'hello world, you all ok?' -b:--bbb _B "$@")
	eval $(boolopt  -c:--ccc _C "$@")
	errecho H1
	eval $(valopt --rem 'val o pt .....' -v:--val val "$@")
	errecho H2
	errecho "$@" 
}

run()
{
	local CMD="$@"
	errecho CMD: $CMD
	$CMD
	errecho DONE
}

_A=hello
errecho 1A: $_A
run _testopt 1  2 3 4 5
errecho A: $_A
errecho X: hello
errecho 

errecho 2A: $_A
run _testopt a b  --aaa c d e f g
errecho A: $_A
errecho X: true
errecho 

errecho 3A: $_A
run _testopt -a z y xxx wwwwwww --aaa vvvvvvvvvvvvvvvvvvv -aa uuuuuuuuuuuuuuuuuu t -a
errecho A: $_A
errecho X: true
errecho 

errecho 3B1: $_B
run _testopt -a z y xxx -b wwwwwww --aaa vvvvvvvvvvvvvvvvvvv -aa uuuuuuuuuuuuuuuuuu t -a
errecho B: $_B
errecho X: true
errecho 

_B=anypresetvalue
errecho 3B2: $_B
run _testopt -a z y xxx --bbb wwwwwww --aaa vvvvvvvvvvvvvvvvvvv -aa uuuuuuuuuuuuuuuuuu t -a
errecho B: $_B
errecho X: true
errecho 

errecho 3C: $_C
run _testopt 1 2  --ccc 3 4 5
errecho C: $_C
errecho X: true
errecho 

errecho 4VAL: $val;
run _testopt  1 --val 991 2 3 -a -b --aaa --ccc -c 4 5
errecho val: $val
errecho X: 991
errecho 

errecho 5VAL: $val;
run _testopt  1 -v 999000 2 3 -a -b --aaa --ccc -c 4 5
errecho val: $val
errecho X: 999000
errecho 
