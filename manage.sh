#!/bin/sh

cleanup() {
    git submodule foreach git checkout -- .
    git submodule foreach git restore --staged .
}

latest() {
    cleanup
    git submodule foreach git checkout master
    git submodule foreach git pull
}

eval "$1"
