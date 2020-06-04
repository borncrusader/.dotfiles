#!/bin/bash
#################################################
# Zsh specific rc stuff go here (bash shebang to keep shellcheck happy)
# 1. You might want to add to .myshrc and not here
# 2. Make sure _sp is updated appropriately
#################################################

_sp=${_sp}_zr

# if not running interactively, don't do anything
[[ $- != *i* ]] && return

# the .profile is only sourced for login shells; but let's source it
# shellcheck disable=SC1090
[[ "$_sp" != *_z_* ]] && . "$HOME/.zprofile"

howdy()
{
    # shellcheck disable=SC1090
    source "$HOME/.zshrc"
}

# shellcheck disable=SC2034,1087,2154
prompt="%{$fg[green]%}%m:%3~%# %{$reset_color%}"

# source ohmyzsh
_source_if_exists "$HOME/.dotfiles/.ohmyzshrc"

# finally source the common shell rc
_source_if_exists "$HOME/.dotfiles/.myshrc"

_sp=${_sp}_ZR
