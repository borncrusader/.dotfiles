#!/bin/bash

set -euo pipefail

# Some useful references
# 1. https://openfolder.sh/macos-migrations-with-brewfile

update() {
    echo "updating system specific Brewfile"

    # --all to
    # --force for overwriting file
    brew bundle dump --all --force --file=Brewfile-$(hostname)

    "$@"
}

consolidate() {
    echo "consolidating Brewfile"

    # start from scratch; this is version controlled anyway
    rm -f Brewfile

    # do first mas ones to prefer the app store version
    cat Brewfile-* | grep -e "^mas" | sort | uniq >> Brewfile
    echo "" >> Brewfile

    cat Brewfile-* | grep -e "^tap" | sort | uniq >> Brewfile
    echo "" >> Brewfile

    cat Brewfile-* | grep -e "^cask" | sort | uniq >> Brewfile
    echo "" >> Brewfile

    cat Brewfile-* | grep -e "^brew" | sort | uniq >> Brewfile

    "$@"
}

install() {
    echo "installing from Brewfile"

    brew bundle

    "$@"
}

if [[ $(uname) != "Darwin" ]]; then
    echo "not on a Mac, skipping brew commands"
    exit 0
fi

if [[ $(dirname "$0") != "." ]]; then
    echo "not in the same directory as this script; changing directory"
    cd "$(dirname "$0")"
fi

if [[ "$#" -eq 0 ]]; then
    echo "no arguments provided; defaulting to update and consolidate"
    update consolidate
else
    "$@"
fi

