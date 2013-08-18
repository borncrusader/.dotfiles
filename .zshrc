#echo 'zshrc begin'
# if not running interactively, don't do anything
[[ $- != *i* ]] && return

# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt appendhistory autocd extendedglob
bindkey -e
# End of lines configured by zsh-newuser-install

# The following lines were added by compinstall
zstyle :compinstall filename "$HOME/.zshrc"

autoload -Uz compinit
compinit
# End of lines added by compinstall

s()
{
	source ~/.zshrc
}

# set the prompt to {hostname}{directory}{prompt}
autoload -U colors && colors
prompt="%{$fg[green]%}%m:%3~%# %{$reset_color%}"

# source package-not-found details
[[ -f /usr/share/doc/pkgfile/command-not-found.zsh ]] && source /usr/share/doc/pkgfile/command-not-found.zsh

# finally source the common shell rc
[[ -f ~/.myshrc ]] && source ~/.myshrc

#echo 'zshrc end'
