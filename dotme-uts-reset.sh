# for debug on utils_...

echo $BASH_SOURCE

UTILS_CORE=
UTILS_VB=
UTILS_GIT=
UTILS_UIO=
UTILS_FD=
UTILS_MSC=
UTILS_MAP=

DEBUGUTILS=true
echo DEBUGUTILS=$DEBUGUTILS

echo  "Setup Utils Include? Ctrl-c to Exit"
read x
. utils.shi
