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
export SYSDUMP="$HOME/sysdump"
export GOPATH_DEFAULT="$HOME/go"
export GOPATH="$GOPATH_DEFAULT"
export GOBIN="$GOPATH/bin"
export NVM_DIR="$HOME/.nvm"
export SSH_AUTH_SOCK="$HOME/.ssh/.auth_socket"

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

    export CODE=/Volumes/code
else
    export CODE=$HOME/code
fi

#################################################
# Some helpful functions
#################################################
_add_to_path() {
    [ -d "$1" ] && PATH="$1":$PATH
}

_source_if_exists() {
    # shellcheck disable=SC1090
    [ -f "$1" ] && . "$1"
}

#################################################
# Path Manipulation
#################################################
_add_to_path "$HOME/bin"
_add_to_path "$GOPATH/bin"
_add_to_path "$HOME/.cargo/bin"
_add_to_path "/usr/local/opt/node@8/bin"
_add_to_path "/usr/local/opt/gnu-sed/libexec/gnubin"
_add_to_path "$HOME/.poetry/bin"
_add_to_path "$HOME/bin/mac"


# asdf
_source_if_exists "/usr/local/opt/asdf/asdf.sh"

# broot
_source_if_exists "/Users/sananthakrishnan/Library/Preferences/org.dystroy.broot/launcher/bash/br"

# package-not-found details
_source_if_exists "/usr/share/doc/pkgfile/command-not-found.zsh"

# nix
_source_if_exists "/Users/sananthakrishnan/.nix-profile/etc/profile.d/nix.sh"

_add_to_path "/Users/sananthakrishnan/.gem/ruby/2.6.0/bin"

_sp=${_sp}_P
