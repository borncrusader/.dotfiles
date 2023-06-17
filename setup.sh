#!/bin/sh

# bail out on first error
set -e

create_link()
{
	# usage: create_link original link
    if [ -L "$2" ]; then
        echo "link already exists"
        return
    fi

	if [ -e "$2" ]; then
		echo "backing up $2 as $2.back"
		mv "$2" "$2.back"
	fi

	echo "creating link $2 -> $1"
	ln -s "$1" "$2"
}

## common
create_link .dotfiles/.vim/ ~/.vim
create_link .dotfiles/bin/ ~/bin
create_link .dotfiles/.config/nvim/ ~/.config/nvim

create_link .dotfiles/.zprofile ~/.zprofile
create_link .dotfiles/.zshrc ~/.zshrc
create_link .dotfiles/.bash_profile ~/.bash_profile
create_link .dotfiles/.bashrc ~/.bashrc
create_link .dotfiles/.myshrc ~/.myshrc
create_link .dotfiles/.profile ~/.profile
create_link .dotfiles/.screenrc ~/.screenrc
create_link .dotfiles/.tmux.conf ~/.tmux.conf
create_link .dotfiles/.vimrc ~/.vimrc
create_link .dotfiles/.psqlrc ~/.psqlrc
create_link .dotfiles/zsh-vim-mode ~/.zsh-vim-mode
create_link .dotfiles/.fzf.zsh ~/.fzf.zsh
create_link .dotfiles/.fzf.bash ~/.fzf.bash

## Linux specific
if [ "$(uname)" = 'Linux' ]; then
	create_link .dotfiles/.config/i3 ~/.config/i3
	create_link .dotfiles/.xinitrc ~/.xinitrc
	create_link .dotfiles/.xmodmap ~/.xmodmap
	create_link .dotfiles/.gtkrc-2.0 ~/.gtkrc-2.0
    create_link .dotfiles/.i3status.conf ~/.i3status.conf
    create_link .dotfiles/.Xresources ~/.Xresources
fi

## Mac specific
if [ "$(uname)" = 'Darwin' ]; then
    #create_link .dotfiles/.slate ~/.slate
    create_link .dotfiles/.hammersoon ~/.hammerspoon
    #create_link .dotfiles/alfred ~/alfred

    # solve for key repeat issues in macs
    defaults write -g ApplePressAndHoldEnabled -bool false

    # smooth scrolling
    defaults write -g CGFontRenderingFontSmoothingDisabled -bool NO
    defaults -currentHost write -globalDomain AppleFontSmoothing -int 2

    # alacritty
    # git clone https://github.com/alacritty/alacritty.git
    # cd alacritty
    # sudo tic -xe alacritty,alacritty-direct extra/alacritty.info
    # cd .. && rm -rf alacritty
fi