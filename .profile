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
export EDITOR='nvim'
export TERM='xterm-256color'
export GOPATH_DEFAULT="$HOME/go"
export GOPATH="$GOPATH_DEFAULT"
export GOBIN="$GOPATH/bin"
export NVM_DIR="$HOME/.nvm"
export SSH_AUTH_SOCK="$HOME/.ssh/.auth_socket"
export OBSIDIAN="$HOME/syncthing/obsidian"
export CODE="$HOME/code"
export LANG="en_US.UTF-8"

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
    [ -d "$1" ] && [[ "$PATH" != *"$1"* ]] && PATH="$1":$PATH
}

_add_to_cdpath() {
    [ -d "$1" ] && [[ "$CDPATH" != *"$1"* ]] && CDPATH="$1":$CDPATH
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
_add_to_path "/usr/local/opt/gnu-sed/libexec/gnubin"
_add_to_path "$HOME/bin/mac"
_add_to_path "/usr/local/sbin"
_add_to_path "$HOME/.yarn/bin"
_add_to_path "$HOME/.config/yarn/global/node_modules/.bin"

# asdf
_source_if_exists "/usr/local/opt/asdf/asdf.sh"

# broot
_source_if_exists "$HOME/Library/Preferences/org.dystroy.broot/launcher/bash/br"

# package-not-found details
_source_if_exists "/usr/share/doc/pkgfile/command-not-found.zsh"

# nix
_source_if_exists "$HOME/.nix-profile/etc/profile.d/nix.sh"

# emacs
_add_to_path "/Applications/Emacs.app/Contents/MacOS"

# flutter
_add_to_path "$HOME/code/flutter/bin"

# rust
_source_if_exists "$HOME/.cargo/env"

# homebrew
if [ "$OS" = "MAC" ]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi

_add_to_path "$HOME/Library/Python/3.8/bin"

_add_to_path "$HOME/adb-fastboot/platform-tools"

_add_to_path "$HOME/.local/bin"

# pnpm
if [ "$OS" = "MAC" ]; then
    export PNPM_HOME="/Users/ska/Library/pnpm"
    _add_to_path "$PNPM_HOME"
fi

# start_cuda
if [ -d "/opt/cuda" ]; then
    export CUDA_PATH=/opt/cuda

    _add_to_path "$CUDA_PATH/bin"
    _add_to_path "$CUDA_PATH/nsight_compute"
    _add_to_path "$CUDA_PATH/nsight_systems/bin"

    # This line used to not be required but it somehow is with cuda 12.3.
    # We reported this as a bug to NVIDIA. For now, this seems like a viable
    # workaround.
    export NVCC_PREPEND_FLAGS='-ccbin /opt/cuda/bin'
fi
# end_cuda

# antigravity
_add_to_path "$HOME/.antigravity/antigravity/bin"

# bun completions
_source_if_exists "$HOME/.bun/_bun"

# bun
if [ -d "$HOME/.bun" ]; then
    export BUN_INSTALL="$HOME/.bun"

    _add_to_path "$BUN_INSTALL/bin"
fi

# work related profile (should be last)
_source_if_exists "$HOME/.myshprofile_work"

_sp=${_sp}_P
