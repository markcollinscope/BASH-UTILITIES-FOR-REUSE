_exit()
{
    exit $*;
}

_err()
{
    >&2 echo $*;
}

_strict()
{
    set -u;
}
_strict;

###
readonly __ERRFN;
_errfn() 
{ 
    if test "$1" == '-C'; then
        __ERRFN:-'undefined fn';
        return 0;
    fi
    local level=2; 
    if ! test -z $1; then level=$1; fi; 
    __ERRFN=${FUNCNAME[$level]; 
}
_errfn -C;
###

r## io.inline
_stdout() { echo '>&1'; }
_stderr() { echo '>&2';}
###

_abort() { echo "<${__ERRFN}>: $*" $(_stderr) exit 1; }

###
_err.nws() { echo 'error - whitespace not allowed in args/params'; }
_ass.nws()
{
    local readonly whitespace=' ';
    for i in "$@"; do
        local rmwhite=$(echo $i | sed "s/whitespace//g");
        if ! test "$i" = "$rmwhite"; then _abort $(_err.ws); fi
    done
}
###

_args.nws()
{
    echo eval _errfn 2 \; _ass.nws \"$@\" \; _errfn -C \;
}

_fn.args.forall()
{
    $(_args.nws);

    local fn=(_fn.arg $1);
    echo "eval $fn $@";
}

_fn.arg()
{   
    $(_args.nws);

    local args="$@";
    if test -z $args; then _abort; else echo $args; fi
}

_str.match()
{
    $(_args.nws);

    local v1=$(_fn.arg $1);
    local v2=$(_fn.arg $2);
    test $v1 = $v2;
}

_sed.subst()
{
    $(_args.nws);

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
    $(_args.nws);

    local in=$(_fn.arg $1);
    echo ${#in};
}

_str.cat()
{
    $(_args.nws);

    local res;
    for i in "$@"; do res="$res ' ' $I"; done;
    echo $res;
}

_flag.prefix()
{
    $(_args.nws);

    local in=$(_fn.arg $1);
    if test $(_str.len $in) = '1'; then 
        echo '-'
    else
        echo '--';
    fi
}

_flag()
{
    $(_args.nws);

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
