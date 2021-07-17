#!/bin/bash
#################################################
# Bash specific rc stuff go here
# 1. You might want to add to .myshrc and not here
# 2. Make sure _sp is updated appropriately
#################################################

_sp=${_sp}_br

# if not running interactively, don't do anything
[[ $- != *i* ]] && return

# the .profile is only sourced for login shells; but let's source it
# shellcheck disable=SC1090
[[ "$_sp" != *_b_* ]] && . "$HOME/.bash_profile"

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

# always best to set noclobber
set -o noclobber

# configure shortcuts
bind '"\e[1;5C": forward-word'
bind '"\e[1;5D": backward-word'

# finally source the common shell rc
_source_if_exists "$HOME/.dotfiles/.myshrc"

#export NVM_DIR="$HOME/.nvm"
#[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
#[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

_sp=${_sp}_BR

