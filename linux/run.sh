#!/bin/bash

update() {
    echo "updating list of packages"

    pacman -Q > "pacman-installed-packages-$(hostname)"
}

install() {
    echo "installing from Brewfile"

    cat pacman-installed-packages-* | awk '{ print $2 }' | xargs pacman -S
}

if [[ $(uname) != "Linux" ]] || ! grep "Arch Linux" /etc/lsb-release; then
    echo "not on an Arch box, skipping pacman commands"
    exit 0
fi

if [[ $(dirname "$0") != "." ]]; then
    echo "not in the same directory as this script; changing directory"
    cd "$(dirname "$0")" || exit
fi

if [[ "$#" -eq 0 ]]; then
    echo "no arguments provided; defaulting to update and consolidate"

    update
else
    "$@"
fi

