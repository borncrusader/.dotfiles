#!/bin/bash
#################################################
# Some general rules
# 1. Only add bash specific quirks here
# 2. Make sure _sp is updated appropriately
#################################################

_sp=${_sp}_b

# shellcheck disable=SC1090
[[ "$_sp" != *_p_* ]] && . "$HOME/.profile"

# source the bashrc for login shells too
# shellcheck disable=SC1090
[[ "$_sp" != *_br_* ]] && . "$HOME/.bashrc"

# Finally set the prompt variable
export PS1='\[\e[0;32m\][\u@\h \W]\$\[\e[0m\] '

_sp=${_sp}_B
if [ -e /Users/sananthakrishnan/.nix-profile/etc/profile.d/nix.sh ]; then . /Users/sananthakrishnan/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer
