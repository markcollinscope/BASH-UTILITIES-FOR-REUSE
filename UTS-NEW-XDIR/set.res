# demons
declare -g -a arr=('one two three' four five 'six seven');

count() { echo $#; }
count "$@"
echo expected-result: 0

set -- "${arr[@]}";
count "$@"
echo expected-result: 4

e() { echo "${arr[@]}"; }

count $(e);
echo expected-result: 7

set -- $(e)
count "$@"
echo expected-result: 

