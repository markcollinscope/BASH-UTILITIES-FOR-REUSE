# /bin/bash

# clone candidates.
# null errecho (fnecho ...) errifnull callFnIfExists exiterr -k exitok fnname no ne getarg isNum
# tmpFile evalerr isTerminalOutput setcol append (?) io.no io.ne io.none win.clear win.curpos

# LEVEL 0 FNS

# purely for uts debugging.
readonly __DEBUG=true;
_dbg()
{
    $__DEBUG && _io.err "${FUNCNAME[2]}: $@";
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
    exit $exitval;
}

_sys.abort()
{
    echo "aborting...." >&2;
    _sys.exit 1;
}

### IO basics
_io.echo()
{
    echo "$@";
}

_io.stdout() { echo '>&1'; }
_io.stderr() { echo '>&2';}

_io.err()
{
    local abort=false;
    if test "$1" = "--abort"; then
        abort=true;
        shift;
    fi
    $(_io.stderr) echo "$@";
    $abort && _sys.abort;
}

### FN MANIPULATION/CREATION.
_fn.name()
{
    local level=${1:-1};
    level=$((level + 1)));

    _io.echo "${FUNCNAME[$level]}";
}

_fn.caller()
{
    _fn.name 3;
}

_fn.ws()
{
    for i in "$@"; do 
        local in="$i";
        local out=$(_io.echo "$in" | sed 's/ //');
        if ! test "$in" == "$out"; then
            local caller=$(fn.name 2)
            _io.err "$caller: whitespace in args - no allowed";
            _sys.abort;
        fi 
    done
    return 0;
}

_fn.arg()
{   
    if test -z "$1"; then
        local caller=$(_fn.name 2);
        _io.err "$caller: empty arg value";
        _sys.abort;
    fi

    _fn.ws "$1";
    _io.echo $arg;
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

### ASSERTIONs for error checking.
# std msg.
__ass.err.nws() { echo 'error - whitespace not allowed in args/params'; }
_ass.nws()
{
    local readonly whitespace=' ';
    for i in "$@"; do
        local rmwhite=$(echo $i | sed "s/whitespace//g");
        if ! test "$i" = "$rmwhite"; then _sys.abort $(__ass.err.nws); fi
    done
}


_fn.null NB.FOR.INLINE

NB.FOR.INLINE
_ass.nws()
{
    echo eval "
        _io.err.fn 2 ; 
        \$(_ass.nws) \"$@\" ; 
        _io.err.fn -C ;
    ";
}

exit;

NB.FOR.INLINE
_fn.args.forall()
{
    $(_ass.nws);

    local fn=(_fn.arg $1);
    _echo "eval $fn $@";
}

_str.match()
{
    $(_ass.nws);

    local v1=$(_fn.arg $1);
    local v2=$(_fn.arg $2);
    test $v1 = $v2;
}

_sed.subst()
{
    $(_ass.nws);

    local sedexpr=$(_fn.arg $1);
    local in=$(_fn.arg $2);
    echo $in | sed "$sedexpr";
}

_str.subst()
{
    local str=$(_fn.arg $1);
    local exp=$(_fn.arg $2);

    local sedstr=$(_sed.subst $exp $str);
    echo $sedstr;
}

_str.len()
{
    $(_ass.nws);

    local in=$(_fn.arg $1);
    echo ${#in};
}

_str.cat()
{
    $(_ass.nws);

    local res;
    for i in "$@"; do res="$res ' ' $I"; done;
    echo $res;
}

_flag.prefix()
{
    $(_ass.nws);

    local in=$(_fn.arg $1);
    if test $(_str.len $in) = '1'; then 
        echo '-'
    else
        echo '--';
    fi
}

_flag()
{
    $(_ass.nws);

    local flag=$(_fn.arg $1);
    local in=$(_fn.arg $2);
    local rmdash=$(_str.subst $in 's/^-*//g');

    case "$flag" in

        --prefix)
            _flag.prefix $in;
            return;
        ;;

        --is)
            ! test $rmdash = $in;
            return;

        ;;

        --rmdash)
            echo $rmdash;
            return;
        ;;

        --withdash)
            echo $in$(_flag --prefix $in);
            return;
        ;;

    esac;
}
