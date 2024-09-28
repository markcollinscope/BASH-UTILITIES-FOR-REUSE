. utils.shi
. uts.msc.shi

. uts.unit.shi


fn.join()
{
	arg.count.assert 2 2;
	local fn=$(arg $1)
	local subfn=$(arg $2)

	local joinchar=".";
	concat $fn $joinchar $subfn;
}

opt.bool()
{
	boolopt "$@";
}

function opt.err()
{
	let const_opt='opt bool --err err_opt "$@"'
	echo $const_opt;
}

function fn.exists()
{
	test $(type -t $1) = function
}

function fn.redefine() # just docco for now.
{
	if arg.null $1

	local fnname=$(arg $1)
}

if tst.active; then
	fn.redefine uts.abort;
	uts.abort() # 'override this'
	{

	}

	function test.fn.exists()
	{
		local fnname='nonexistantfn'
		fn.exists $fnnamme
		assertSame $? 1;

		local otherfn='fn.exists';
		fn.exists $otherfn;
		assertSame $? 0;
	}
fi


function fn()
{
	local subfn=$1;
	local fn=$(concat 'fn' '.' $subfn);
	
	if fn.exists $fn; then
		shift;
		$fn "$@";
	else
		uts.abort "No such function: <fn $subfn>"; # tbd - test mode?
	fi
}

if tst.active; then
	fn._hello()
	{
		echo hello;
	}

	function fn.shtest()
	{
		local result=$(fn _hello);
		assertSame $result hello
	}
fi

