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

    ee "Debug: flag = $flag"
    ee "Debug: mapfnref = ${mapfnref[@]}"  # Display the contents of the referenced array
	sleep 1

    if test $flag = --name; then
        ee name
        mapfnname mapfnref;
        ee 'as $1: ' $(mapfnname $1)
    elif test $flag = --len; then
        ee option-len
        mapfnlen mapfnref;
    elif test $flag = --keys; then
       ee keys
       mapfnkeys mapfnref;
    elif test $flag = --vals; then
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
echo
echo name is: $(mapfnname mp)
echo
echo len is: $(mapfnlen mp);
echo
echo keys are: $(mapfnkeys mp);

declare -g values=$(mapfnvals mp)
echo
echo values are: $values;
echo
echo "values (i) are: $(mapfnvalsi mp)"
echo

# whereas this lot dont! Any of them!
echo
echo "NOW VIA *** FLAGS ***"
echo
echo name is: $(mapfn --name mp)
echo
echo len is: $(mapfn --len mp);
echo
echo keys are: $(mapfn --keys mp);
echo
values=$(mapfn --vals mp)
echo values are: $values;
echo
echo "values (i) are: $(mapfnvalsi mp)"
exit;
