#/bin/bash

const()
{
    local name=$1;
    local val=$2;

    if test -z $val; then val=$name; fi

    local tpl="
        $name() { echo "$val"; }
    ";
    eval $tpl;
}

enum.fruit()
{
    local flag=$1;

    if test $flag == '--valid'; then
        local val=$2;             # must have.
        for i in $(enum.fruit);
            if test $i == $val; then
                return 0;
            fi
        done
    else
        echo apples oranges pears;
    fi
}

enum()
{
    local name=$1;
    shift;
    local vals="$@";

    local tpl="
		enum.$name()
		{
		    local flag=$1;
		
		    if test $flag == '--includes' '--holds'
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

const apple;
const orange;
const pair;

enum fruit $(apple) $(orange) $(pair)

avalue=$(orange);

if ! enum.fruit --includse $avalue; then echo 'error in assignment'; fi
