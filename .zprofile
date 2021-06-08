#!/bin/sh
#################################################
# Some general rules
# 1. Only add bash specific quirks here
# 2. $HOME/.zshrc is sourced for login shells too
# 3. Make sure _sp is updated appropriately
#################################################

_sp=${_sp}_z

# shellcheck disable=SC1090
[ -f "$HOME/.profile" ] && . "$HOME/.profile"

# Lines configured by zsh-newuser-install
export HISTFILE=~/.histfile
export HISTSIZE=25000
export SAVEHIST=10000
export HISTIGNORE="&:ls:[bf]g:exit:reset:clear:cd:cd ..:cd.."

setopt histignoredups
setopt histignorespace
setopt incappendhistory
setopt sharehistory
setopt autocd
setopt extendedglob
bindkey -e
# End of lines configured by zsh-newuser-install

# The following lines were added by compinstall
zstyle :compinstall filename "$HOME/.zshrc"

autoload -Uz compinit
compinit
# End of lines added by compinstall

autoload -U colors && colors

# some keyboard shortcuts
# helpful way to determine what a key press's code is on the prompt
# press ctrl-v and then type your key combination
bindkey ';10D' beginning-of-line
bindkey ';10C' end-of-line
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word
bindkey ';5D' backward-word
bindkey ';5C' forward-word
bindkey '^[[3~' delete-char
# TODO: doesn't work yet
#bindkey '^[[1;3C' forward-kill-word
bindkey '^[[1;3D' backward-kill-word

_sp=${_sp}_Z
