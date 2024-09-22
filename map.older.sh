#!/bin/bash

mapfnname()
{
    local m=$1
    echo $m;
}

mapfnlen()
{
    local -n m=$1;
    echo "${#m[@]}";
}

mapfnkeys()
{
    local -n m=$1
    echo "${!m[@]}"
}

mapfnvals()
{
    local -n m=$1;
    echo "${m[@]}"
}

mapfnvalsi()
{
    local -n lm=$1;
    mapfnvals lm;
}

ee()
{
    echo $* >&2;
}

mapfn()
{
    local flag=$1
    shift
    local -n mapfnref=$1;
    
    if test $flag==--name; then
        ee name
        mapfnname mapfnref;
        ee 'as $1: ' $(mapfnname $1)
    elif test $flag==--len; then
        ee len
        mapfnlen mapfnref;
    elif test $flag==--keys; then
       ee keys
       mapfnkeys mapfnref;
    elif test $flag==--vals; then
       ee vals
       mapfnvals mapfnref;
    else
        ee 'fuck off'; exit; 
    fi
}

declare -g -A mp;
mp[hello]=world;
mp[wife]=strife

# how come - this lot work, including mapfnvalsi
echo name is: $(mapfnname mp)
echo len is: $(mapfnlen mp);
echo keys are: $(mapfnkeys mp);

declare -g values=$(mapfnvals mp)
echo values are: $values;
echo "values (i) are: $(mapfnvalsi mp)"

# whereas this lot dont! Any of them!
echo
echo "NOW VIA *** FLAGS ***"
echo name is: $(mapfn --name mp)
echo len is: $(mapfn --len mp);
echo keys are: $(mapfn --keys mp);
values=$(mapfn --vals mp)
echo values are: $values;
# echo "values (i) are: $(mapfnvalsi mp)"
exit;
