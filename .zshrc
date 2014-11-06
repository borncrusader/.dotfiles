# if not running interactively, don't do anything
[[ $- != *i* ]] && return

# Lines configured by zsh-newuser-install
export HISTFILE=~/.histfile
export HISTSIZE=25000
export SAVEHIST=10000
export HISTIGNORE="&:ls:[bf]g:exit:reset:clear:cd:cd ..:cd.."

setopt histignoredups
setopt histignorespace
setopt appendhistory
setopt autocd
setopt extendedglob
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

autoload -U colors && colors
prompt="%{$fg[green]%}%m:%3~%# %{$reset_color%}"

# source package-not-found details
[[ -f /usr/share/doc/pkgfile/command-not-found.zsh ]] && source /usr/share/doc/pkgfile/command-not-found.zsh

# finally source the common shell rc
[[ -f ~/.myshrc ]] && source ~/.myshrc
