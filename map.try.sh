#!/bin/bash

# TEST - WORKS!

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

ee()
{
    echo $* >&2;
}

mapfn()
{
    local flag=$1
    shift
    local -n mapfnref=$1;

    echo "Debug: flag = <$flag>"
    echo "Debug: mapfnref = ${mapfnref[@]}"  # Display the contents of the referenced array

    # if test "$flag" == "--len"; then ### QUOTES MAKE NO DIFFERENCE!
    # == - double equals vs = single equals on test x = y - seems to make no difference either!
    if test $flag = --len; then
        ee is len
        mapfnlen mapfnref;
        return;
    fi
    if test $flag == --keys; then
       ee is keys
       mapfnkeys mapfnref;
       return;
    fi
    ee fuck off
}

declare -g -A mp;
mp[hello]=world;
mp[wife]=strife

echo keys only:
mapfn --keys mp;
echo

echo len only:
mapfn --len mp
echo

# OUTPUT - OK!

# keys only:
# Debug: flag = <--keys>
# Debug: mapfnref = strife world
# is keys
# wife hello

# len only:
# Debug: flag = <--len>
# Debug: mapfnref = strife world
# is len
# 2




exit;
