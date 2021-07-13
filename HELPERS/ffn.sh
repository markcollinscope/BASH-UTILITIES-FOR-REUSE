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

EXACTMATCH=false;
SHORTFORMAT=false;
LONGFORMAT=false;
PRINTFILENAMEONLY=false;
FNEND='()'

searchForMatch()
{
	setvar PARTFNNAME "$1"; shift;

	local FILEPATTERN=

	for i in "$@"; do
		FILEPATTERN="*$i $FILEPATTERN"
	done

	local FUNCT="^[[:alnum:]]*$PARTFNNAME.*$FNEND";
	local MATCHES=$(xfindfilesgrep "$FUNCT" $FILEPATTERN)
	local COUNT=$(count $MATCHES)

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
		if $LONGFORMAT; then
			printbetween $FUNCT '}' $match;

		elif $SHORTFORMAT; then
			printbetween $FUNCT '^$' $match;

		elif $PRINTFILENAMEONLY; then
			echo $match; 

		else
			xgrep $FUNCT $match;
		fi
	done
	return 0;

}

main()
{
	eval $(boolopt --rem "search for an exact match only" -x EXACTMATCH "$@")
	eval $(boolopt --rem "print matching file name only" -n PRINTFILENAMEONLY "$@")
	eval $(valopt  --rem "specify files (by glob pattern) to match (ls style - e.g. *.sh)" -m FILEPATTERN "$@")
	eval $(boolopt --rem "use shorter output format (prints fn upto first blank line)" -s SHORTFORMAT "$@")
	eval $(boolopt --rem "use longer detailed output format" -l LONGFORMAT "$@")
	eval $(boolopt --rem "use bash native (set) output format" -d USEBASHNATIVE "$@")
	errifopt "$@";

	if (( $# != 1 )); then Usage; fi
	setvar PARTFN "$1"

	cd $UTS_SCRIPTDIR
	FILEPATTERN=${FILEPATTERN:-"$UTS_BASHINCLUDE"}

	searchForMatch "$PARTFN" "$FILEPATTERN"
}

main "$@"
