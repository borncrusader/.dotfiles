#!/bin/bash

f="cscope.files"

if [ ! -z $1 ]; then
	if [ $1 == '-h' ]; then
		echo "usage: $0 {temp-file}"
		echo "  default temp-file is $f"
		exit
	fi

	f=$1
fi

echo "generating list of files to $f"
if [ `uname` == "Darwin" ]; then
	find -E . -type f -regex '.*/.*\.([ch](pp|xx)?|cc|C|java)' > $f
elif [ `uname` == "Linux" ]; then
	find . -regextype posix-extended -type f -regex '.*/.*\.([ch](pp|xx)?|cc|C|java)' > $f
fi

echo "generating cscope database"
if [ -e $f ]; then
	cscope -bqi $f
fi
