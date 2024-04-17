#!/bin/sh

set -eu

# build README.md
{
	cat header.md
	echo '| App | Method | Comments |'
	echo '| --- | --- | --- |'
	awk -F';' '{ print "| " $1 " | [" $2 "](" $3 ") | " $4 " | " }' apps.csv
	echo
} > README.md

# build apps/
rm apps/*
awk -F';' '
	{
		gsub(/ /, "-", $1)
		$1 = tolower($1);
		file = "apps/" $1 ".md"
		print "[" $2 "](" $3 ")" > file
	}
' apps.csv

