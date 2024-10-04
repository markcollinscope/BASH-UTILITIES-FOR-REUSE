#/bin/bash

uts.

uts.const()
{
    local name=$1;
    local val=$2;

    if test -z $val; then val=$name; fi

    local tpl="
        $name() { echo "$val"; }
    ";
    eval $tpl;
}

uts.flag()
{
    local flag=$1;

    if test $flag == '--flag'; then
        # strip - or -- from this, if needed.
        # add - or -- onto this.
        echo result;
    elif test $flag == '--var'; then
        # add - or -- to this, if needed.
        # strip - or -- from this.
        echo result;
    else
        local name=$1;
        local useflag=${2:-name};
        useflag=(uts.flag --flag $useflag);

        uts.const $name $useflag;
    fi
}

uts.enum()
{
    local name=$1;
    shift;
    local vals="$@";

    local tpl="
		enum.$name()
		{
		    local flag=$1;
		
		    if test $flag == '--legal'
		        local val=$2;             # must have.
		        for i in $(enum.$name);
		            if test $i == $val; then
		                return 0;
		            fi
		        done
                return 1;
		    else
		        echo "$@";
		    fi
		}
    "

    eval $tpl;
}

uts.const Apple;
uts.const Banana;
uts.const Kiwi;

uts.enum Fruit $(Apple) $(Banana) $(Kiwi);

avalue=$(orange);

if ! Fruit --legal; then echo 'error in assignment'; fi

