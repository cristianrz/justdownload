#!/bin/sh

set -eu

# build README.md
{
	cat header.md
	echo '| App | Method | Comments |'
	echo '| --- | --- | --- |'
	gawk --lint=fatal  -F';' '{
		if ( NF < 4 ) $4 = ""
		if ( $3 != "#" && $3 != "" ) {
			print "| " $1 " | [" $2 "](" $3 ") | " $4 " | "
		} else {
			print "| " $1 " | " $2 " | " $4 " | " 
		}
	}' apps.csv
	echo
} >./README.md

# build docs/
mkdir -p docs/
rm docs/*.md
cp README.md docs/index.md
gawk --lint=fatal  -F';' '
	{
		gsub(/ /, "-", $1)
		$1 = tolower($1);
		file = "docs/" $1 ".md"
		print "# " $1 "\n[" $2 "](" $3 ")" > file
		close(file)
	}
' apps.csv
