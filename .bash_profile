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

# START - Managed by chef cookbook stripe_cpe_bin
alias tc='/usr/local/stripe/bin/test_cookbook'
alias cz='/usr/local/stripe/bin/chef-zero'
alias cookit='tc && cz'
# STOP - Managed by chef cookbook stripe_cpe_bin
