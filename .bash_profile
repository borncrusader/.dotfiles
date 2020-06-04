#!/bin/sh
#################################################
# Some general rules
# 1. Only add bash specific quirks here
#################################################

# shellcheck disable=SC1090
[ -f "$HOME/.profile" ] && . "$HOME/.profile"

# source the bashrc for login shells too
_source_if_exists "$HOME/.bashrc"

# Finally set the prompt variable
export PS1='\[\e[0;32m\][\u@\h \W]\$\[\e[0m\] '
