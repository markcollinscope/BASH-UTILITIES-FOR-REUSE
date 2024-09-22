#!/bin/bash

# TEST CASE WORKS --len only.

ee() { echo $* >&2; }

mapfnlen()
{
    local -n m=$1;
    echo "${#m[@]}";
}

mapfn() # for test.
{
    local flag=$1
    local -n mapfnref=$2;

    echo "Debug: flag = $flag"
    echo "Debug: mapfnref = ${mapfnref[@]}"  # Display the contents of the referenced array

    # if test "$flag"="--len"; then         # works as well.
    if test $flag=--len; then               # still works.
        ee "flag:--len."
        mapfnlen mapfnref
    else
        ee error on flag
    fi;
}

declare -g -A mp;
mp[hello]=world;
mp[wife]=strife

echo len only:
mapfn --len mp;

# outputs: - coorectly!
# len only:
# Debug: flag = --len
# Debug: mapfnref = strife world
# option is len.
# 2


exit;
