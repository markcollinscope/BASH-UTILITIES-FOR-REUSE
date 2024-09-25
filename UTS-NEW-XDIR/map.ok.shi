#!/bin/bash

# THIS STUFF SEEMS TO WORK!

map.len()
{
    local -n m=$1;
    echo "${#m[@]}";
}

map.keys()
{
    local -n m=$1
    echo "${!m[@]}"
}

map.vals()
{
    local -n m=$1;
    echo "${m[@]}";
}

ee()
{
    local debug=false;
    if $debug; then 
      echo $* >&2;
    fi
}

map()
{
    local flag=$1
    shift
    local -n mapref=$1;

    if test $flag = "--len"; then
        map.len mapref;
        return;
    fi

    if test $flag == "--keys"; then
       map.keys mapref;
       return;
    fi

    if test $flag == "--vals"; then
       map.vals mapref;
       return;
    fi

    echo "error - no directive given" >&2;
    exit 1;
}

declare -g -A mp;
mp[hello]=world;
mp[wife]=strife
mp[today]=tues

echo keys:
map --keys mp;
echo expected: today, wife, hello
echo

echo vals:
map --vals mp;
echo expected: world, strife, tues
echo

echo len:
map --len mp
echo expected: 3
echo

