#!/bin/sh
#################################################
# Some general rules
# 1. Add only exports and PATHs to this file
# 2. Don't run commands like brew here
# 3. Make sure _sp is updated appropriately
#################################################

_sp=${_sp}_p

#################################################
# Determine OS
#################################################
if [ "$(uname)" = "Darwin" ]; then
    export OS="MAC"
elif [ "$(uname)" = "Linux" ]; then
    export OS="LINUX"
else
    echo "ALARM! New system found! uname: $(uname) and whoami: $(whoami)"
fi

#################################################
# Common exports
#################################################
export EDITOR='vim'
export TERM='xterm-256color'
export GOPATH_DEFAULT="$HOME/go"
export GOPATH="$GOPATH_DEFAULT"
export GOBIN="$GOPATH/bin"
export NVM_DIR="$HOME/.nvm"
export SSH_AUTH_SOCK="$HOME/.ssh/.auth_socket"
export OBSIDIAN="$HOME/syncthing/obsidian"
export CODE="$HOME/code"

#################################################
# OS Specific exports
#################################################
if [ "$OS" = "MAC" ]; then
	# proper colors on mac
	export CLICOLOR=1
    export LSCOLORS=exfxcxdxbxegedabagacad

    # For GPG signing, else throws an inappropriate ioctl error
    GPG_TTY=$(tty)
    export GPG_TTY

    export MANPAGER="sh -c 'col -bx | bat -l man -p'"
fi

#################################################
# Some helpful functions
#################################################
_add_to_path() {
    [ -d "$1" ] && PATH="$1":$PATH
}

_add_to_cdpath() {
    [ -d "$1" ] && CDPATH="$1":$CDPATH
}

_source_if_exists() {
    # shellcheck disable=SC1090
    [ -f "$1" ] && . "$1"
}

_function_exists() {
    command -v "$1" > /dev/null
    return $?
}

#################################################
# Path Manipulation
#################################################
_add_to_path "$HOME/bin"
_add_to_path "$GOPATH/bin"
_add_to_path "/usr/local/opt/node@8/bin"
_add_to_path "/usr/local/opt/gnu-sed/libexec/gnubin"
_add_to_path "$HOME/.poetry/bin"
_add_to_path "$HOME/bin/mac"
_add_to_path "/usr/local/sbin"
_add_to_path "$HOME/.yarn/bin"
_add_to_path "$HOME/.config/yarn/global/node_modules/.bin"
_add_to_path "/usr/local/opt/terraform@0.12/bin"

# asdf
_source_if_exists "/usr/local/opt/asdf/asdf.sh"

# broot
_source_if_exists "$HOME/Library/Preferences/org.dystroy.broot/launcher/bash/br"

# package-not-found details
_source_if_exists "/usr/share/doc/pkgfile/command-not-found.zsh"

# nix
_source_if_exists "$HOME/.nix-profile/etc/profile.d/nix.sh"

# ruby
_add_to_path "$HOME/.gem/ruby/2.6.0/bin"

# emacs
_add_to_path "/Applications/Emacs.app/Contents/MacOS"

# flutter
_add_to_path "$HOME/code/flutter/bin"

# rust
_source_if_exists "$HOME/.cargo/env"

# work related profile (should be last)
_source_if_exists "$HOME/.myshprofile_work"

# homebrew
if [ "$OS" = "MAC" ]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi

_sp=${_sp}_P
