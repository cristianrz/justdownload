#!/bin/sh

set -eu

# build README.md
{
	cat header.md
	echo '| App | Method | Comments |'
	echo '| --- | --- | --- |'
	awk -F';' '{ print "| " $1 " | [" $2 "](" $3 ") | " $4 " | " }' apps.csv
	echo
} >./README.md

# build docs/
mkdir -p docs/
rm docs/*.md
cp README.md docs/index.md
awk -F';' '
	{
		gsub(/ /, "-", $1)
		$1 = tolower($1);
		file = "docs/" $1 ".md"
		print "[" $2 "](" $3 ")" > file
	}
' apps.csv
