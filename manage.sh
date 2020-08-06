#!/bin/sh

cleanup() {
    git submodule foreach git checkout -- .
    git submodule foreach git restore --staged .
    git submodule foreach git clean -f
}

latest() {
    git submodule foreach git checkout master
    git submodule foreach git pull
}

add() {
    grep 'path = ' .gitmodules | awk -F " = " '{ print $2 }' | xargs git add
}

febreze() {
    cleanup && latest && add && echo "✨ So refreshing! ✨"
}

eval "$1"
