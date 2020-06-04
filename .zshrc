#!/bin/bash
#################################################
# Zsh specific rc stuff go here (bash shebang to keep shellcheck happy)
# 1. You might want to add to .myshrc and not here
#################################################

# if not running interactively, don't do anything
[[ $- != *i* ]] && return

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
