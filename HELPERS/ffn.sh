#!/bin/bash

######
USAGE=$(cat <<END_USAGE

Usage: $(basename $0) [-options] <part-fn-name>

Search <$UTS_SCRIPTDIR> and sub-dirs for all 'script includes (*$UTS_BASHINCLUDE, etc)' to find bash fns matching the partial name given.
<part-fn-name> is a grep style pattern. Do *not* put '()' at the end - this is done automatically.
Matches functions of the form:
---
afunctionname() - start of line, alphanumeric name, () at the end, no spaces.
---
END_USAGE
)
######

. utils.shi

Usage()
{
	OPTIONS="$(getOptUsage)"
	>&2 cat<<<$USAGE
	>&2 cat<<<$OPTIONS
	exiterr 1
}

# option variables.
ANYFUNCTION=false;
EXACTMATCH=false;
SHORTFORMAT=false;
LONGFORMAT=false;
PRINTFILENAMEONLY=false;
FILEPATTERN=""


FNEND='()'

eval $(boolopt --rem "match any function (do not give a function name)" -a ANYFUNCTION "$@")
eval $(boolopt --rem "search for an exact match only" -x EXACTMATCH "$@")
eval $(boolopt --rem "print matching file name only" -n PRINTFILENAMEONLY "$@")
eval $(valopt  --rem "specify files (by glob pattern) to match (ls style - e.g. *.sh)" -m FILEPATTERN "$@")
eval $(boolopt --rem "use shorter output format (prints fn upto first blank line)" -s SHORTFORMAT "$@")
eval $(boolopt --rem "use longer detailed output format" -l LONGFORMAT "$@")
eval $(boolopt --rem "use bash native (set) output format" -d USEBASHNATIVE "$@")
errifopt "$@";

searchForMatch()
{
	if $ANYFUNCTION; then
		PARTFNNAME="";
	else
		setvar PARTFNNAME "$1"; shift;
	fi

	local FILEPATTERN=

	for i in "$@"; do
		FILEPATTERN="*$i $FILEPATTERN"
	done

	local FUNCT="^[[:alnum:]]*$PARTFNNAME[[:alnum:]]*$FNEND";
	local MATCHES=$(xfindfilesgrep "$FUNCT" $FILEPATTERN)
	local COUNT=$(count $MATCHES)

	vbecho "MATCHES: <$MATCHES>"

	if $EXACTMATCH; then
		FUNCT="^$PARTFNNAME$FNEND"
	fi
	
	if $USEBASHNATIVE && (( COUNT > 0 )); then
		fndef $PARTFNNAME;
		return 0;
	fi

	vbvar MATCHES
	vbvar COUNT 
	vbvar FILEPATTERN
	vbvar FUNCT

	for match in $MATCHES; do
		vbvar match

		if $LONGFORMAT; then
			vbfnecho 'Long Option Chosen'
			printbetween $FUNCT '^}$' $match;

		elif $SHORTFORMAT; then
			vbfnecho "Short Option Chosen ($FUNCT, $match)"
			printbetween $FUNCT '^{' $match | sed 's/^{//g';

		elif $PRINTFILENAMEONLY; then
			vbfnecho 'Name Only Option Chosen'
			echo $match; 
		else
			vbfnecho 'No Option Chosen'
			xgrep $FUNCT $match;
		fi
	done
	return 0;
}

main()
{
	cd $UTS_SCRIPTDIR
	vbecho "Starting search in <$(pwd)>"
	FILEPATTERN=${FILEPATTERN:-"$UTS_BASHINCLUDE"}

	if $ANYFUNCTION; then
		searchForMatch "$FILEPATTERN"
	else
		if (( $# != 1 )); then Usage; fi
		setvar PARTFN "$1"
		searchForMatch "$PARTFN" "$FILEPATTERN"
	fi
}

main "$@"
