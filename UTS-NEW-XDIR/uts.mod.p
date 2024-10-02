puid()
{
    echo $$;
}

privar() # types, eg. list? arr?
{
    local varname=$1;
    local sep='_privar_';
    local privarname=$(uts.cat $varname $sep $(puid));

    if test is function $varname - exit;

    local tpl="
        $varname()
        {
            echo $privarname;
        }
    "
    eval $tpl;
    echo $privarname;
}

declare -g $(privar egvar)=initvalue;
declare -g --Arr $(privar refvarlist);

refvar() # new variable 'created' - global, bit like new fn.
{
    local varname=$1;
    local refvarname=$(uts.cat $varname $sep $(puid));
    echo $refvarname;
}

const name;
const doc;
const fns;

enum modprops $(name) $(doc) $(fns);
mod()
{
    local name=$1;
}

# init, set, get. possibly... add?
