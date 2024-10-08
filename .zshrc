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

if [ -f $HOME/.dotfiles/antigen.zsh ]; then
    source $HOME/.dotfiles/antigen.zsh

    antigen use oh-my-zsh

    antigen bundle git
    antigen bundle sudo
    antigen bundle zsh-autosuggestions
    antigen bundle command-not-found
    antigen bundle zsh-users/zsh-autosuggestions
    antigen bundle zsh-users/zsh-syntax-highlighting
    antigen bundle zsh-users/zsh-history-substring-search
    antigen bundle unixorn/fzf-zsh-plugin@main

    antigen theme cypher

    antigen apply
fi

# this is not part of zsh-users; hence using source
if [ -f $HOME/.zsh-vim-mode/zsh-vim-mode.plugin.zsh ]; then
    source "$HOME/.zsh-vim-mode/zsh-vim-mode.plugin.zsh"

    #MODE_INDICATOR_VIINS='%F{15}<%F{8}INSERT<%f'
    MODE_INDICATOR_VICMD='%F{10}<%F{2}NORMAL>%f'
    MODE_INDICATOR_REPLACE='%F{9}<%F{1}REPLACE>%f'
    MODE_INDICATOR_SEARCH='%F{13}<%F{5}SEARCH>%f'
    MODE_INDICATOR_VISUAL='%F{12}<%F{4}VISUAL>%f'
    MODE_INDICATOR_VLINE='%F{12}<%F{4}V-LINE>%f'
fi

# prompt shenanigans
setopt PROMPT_SUBST

# shellcheck disable=SC2034,1087,2154
BASE_PROMPT="%m %{${fg_bold[red]}%}:: %{${fg[green]}%}%3~%(0?. . %{${fg[red]}%}%? )%{${fg[blue]}%}»%{${reset_color}%}"
PROMPT="${BASE_PROMPT} "

# always best to set noclobber
set -o noclobber

# source fzf
_source_if_exists "$HOME/.fzf.zsh"

# finally source the common shell rc
_source_if_exists "$HOME/.dotfiles/.myshrc"

# TODO(srinath): clean this up
if [ -d "$HOME/miniconda3" ]; then
    # >>> conda initialize >>>
    # !! Contents within this block are managed by 'conda init' !!
    __conda_setup="$('$HOME/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
    if [ $? -eq 0 ]; then
        eval "$__conda_setup"
    else
        if [ -f "$HOME/miniconda3/etc/profile.d/conda.sh" ]; then
            . "$HOME/miniconda3/etc/profile.d/conda.sh"
        else
            export PATH="$HOME/miniconda3/bin:$PATH"
        fi
    fi
    unset __conda_setup
    # <<< conda initialize <<<
fi

# better cd handling
setopt AUTO_PUSHD                  # pushes the old directory onto the stack
setopt PUSHD_MINUS                 # exchange the meanings of '+' and '-'
setopt CDABLE_VARS                 # expand the expression (allows 'cd -2/tmp')
#autoload -U compinit && compinit   # load + start completion
zstyle ':completion:*:directory-stack' list-colors '=(#b) #([0-9]#)*( *)==95=38;5;12'

_sp=${_sp}_ZR

# pnpm
export PNPM_HOME="/Users/ska/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end
