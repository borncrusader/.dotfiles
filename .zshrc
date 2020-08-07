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

# source ohmyzsh
#_source_if_exists "$HOME/.dotfiles/.ohmyzshrc"

if [ -f $HOME/.dotfiles/antigen.zsh ]; then
    source $HOME/.dotfiles/antigen.zsh

    antigen use oh-my-zsh

    antigen bundle git
    antigen bundle sudo
    antigen bundle ruby
    antigen bundle rails
    antigen bundle zsh-autosuggestions
    antigen bundle command-not-found
    antigen bundle zsh-users/zsh-autosuggestions
    antigen bundle zsh-users/zsh-syntax-highlighting
    antigen bundle zsh-users/zsh-history-substring-search

    antigen theme cypher

    antigen apply
fi

setopt PROMPT_SUBST
# shellcheck disable=SC2034,1087,2154
BASE_PROMPT="%m %{${fg_bold[red]}%}:: %{${fg[green]}%}%3~%(0?. . %{${fg[red]}%}%? )%{${fg[blue]}%}»%{${reset_color}%}"
PROMPT="${BASE_PROMPT} "

# finally source the common shell rc
_source_if_exists "$HOME/.dotfiles/.myshrc"

_sp=${_sp}_ZR
if [ -e /Users/sananthakrishnan/.nix-profile/etc/profile.d/nix.sh ]; then . /Users/sananthakrishnan/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer
