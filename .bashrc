#!/bin/bash
#################################################
# Bash specific rc stuff go here
# 1. You might want to add to .myshrc and not here
# 2. Make sure _sp is updated appropriately
#################################################

_sp=${_sp}_br

# if not running interactively, don't do anything
[[ $- != *i* ]] && return

# this is required for certain envs where .profile is not sourced
# shellcheck disable=SC1090
[[ "$_sp" != *_p_* ]] && . "$HOME/.profile"

howdy()
{
    # shellcheck disable=SC1090
	source "$HOME/.bashrc"
}

# history control
export HISTCONTROL=erasedups
# & is a special pattern that suppresses duplicate entries
export HISTIGNORE="&:ls:[bf]g:exit:reset:clear:cd:cd ..:cd.."
shopt -s histappend

# finally source the common shell rc
_source_if_exists "$HOME/.dotfiles/.myshrc"

_sp=${_sp}_BR
