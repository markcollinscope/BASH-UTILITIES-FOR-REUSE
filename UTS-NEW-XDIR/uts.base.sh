# /bin/bash

# clone candidates.
# null errecho (fnecho ...) errifnull callFnIfExists exiterr -k exitok fnname no ne getarg isNum
# tmpFile evalerr isTerminalOutput setcol append (?) io.no io.ne io.none win.clear win.curpos

# LEVEL 0 FNS

# purely for uts debugging.
readonly __DEBUG=true;
_dbg()
{
    $__DEBUG && _io.err "${FUNCNAME[2]},${FUNCNAME[1]}: $@";
}

## basic sys stuff.
_sys.strict()
{
    set -u;
}
_sys.strict;

_sys.exit()
{
    local exitval=${1:-0};
    _dbg exiting
    exit $exitval;
    _dbg still here.
}

_sys.abort()
{
    echo "aborting...." >&2;
    kill 0;
}

### IO basics
_io.echo()
{
    echo "$@";
}

_io.err()
{
    local abort=false;
    if test "$1" = "--abort"; then
        abort=true;
        shift;
    fi
    echo "$@" >&2;
    $abort && _sys.abort;
}

### FN MANIPULATION/CREATION.
_fn.name()
{
    local level=${1:-'0'};
    _io.echo "${FUNCNAME[$level]}";
}

_fn.stack()
{
    local nlevels=${1:-6}
    local res="";
    for ((i=2;i<nlevels;i++)) do
        res=$res' '$(_fn.name i);
    done
    _io.echo $res;
}

_fn.caller()
{
    _fn.name 3;
}

declare -g __ARGS_ERRFN="";
_args.errfn()
{
    local flag=$1;
    
    if test $flag == '--isnull'; then 
        test -z $__ARGS_ERRFN;
        return;

    elif test $flag == '--clear'; then
        __ARGS_ERRFN=$2;
        return 0;
        
    elif test $flag == '--set' && _args.errfn --isnull; then
        __ARGS_ERRFN=$2;
        return 0;
    
    elif test $flag == '--set' && _args.errfn --isnull; then
        # do nothing.
        return 0;

    elif test $flag == '--get' && ! _args.errfn --isnull; then
        _io.echo $__ARGS_ERRFN;
        return 0;

    elif test $flag == '--get' && _args.errfn --isnull; then
        _io.err "$(fn.name): cannot get args when fn is not set";
        _sys.abort;
    fi
    
    _io.err "$(fn.name): unknown flag <$flag>";
    _sys.abort;
}
###

_args.ws()
{
    for i in "$@"; do 
        local in="$i";
        local out=$(_io.echo "$in" | sed 's/ //');
        if ! test "$in" == "$out"; then
            _io.err "Call Stack: "$(_fn.stack);
            _io.err "Error there is whitespace in a function call arg (value: <$in>) - this is explicitly not permitted.";
            _sys.abort;
        fi 
    done
    return 0;
}

_fn.arg()
{   
    local arg="$1";
    _fn.ws $arg
    
    if test -z "$arg"; then
        local caller=$(_fn.caller);
        _io.err "$caller: empty arg value";
        _sys.abort;
    fi

    _fn.ws "$1";
    _io.echo $1;
}

_fn.clone()
{
    local fromfn=$(_fn.arg $1);
    local tofn=$(_fn.arg $2);

    if ! test $(type -t $fromfn) = "function"; then
        _io.err.fn $(fn.name);
        _io.err "attemps to clone non function <$fromfn>";
        _sys.abort;
    fi
    
    local clonebody=$(declare -f $fromfn | grep -v $fromfn);
    
    local tpl="
        $tofn()
        $clonebody
    ";

    eval $tpl
}

# null arg, ws arg, abort msgs, ...

egfn()
{
    local a1=$(_fn.arg "$1");
    local a2=$(_fn.arg ${2-'default'});

    _io.echo $a1 $a2
}

egfn 'ws ws' hithere;