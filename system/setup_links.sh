#!/bin/sh

# TODO: cmd line arg based sym-linking

create_link()
{
	# usage: create_link original link
	if [[ -e $2 ]]; then
		echo "backing up $2 as $2.back"
		mv "$2" "$2.back"
	fi

	echo "creating link $2 -> $1"
	ln -s "$1" "$2"
}

## common
create_link .dotfiles/.vim/ ~/.vim
create_link .dotfiles/bin/ ~/bin
create_link .dotfiles/.zprofile ~/.zprofile
create_link .dotfiles/.zshrc ~/.zshrc
create_link .dotfiles/.bash_profile ~/.bash_profile
create_link .dotfiles/.bashrc ~/.bashrc
create_link .dotfiles/.myshrc ~/.myshrc
create_link .dotfiles/.profile ~/.profile
create_link .dotfiles/.screenrc ~/.screenrc
create_link .dotfiles/.tmux.conf ~/.tmux.conf
create_link .dotfiles/.vimrc ~/.vimrc

## Linux specific
if [[ `uname` == 'Linux' ]]; then
	#create_link .dotfiles/.config/awesome/ ~/.config/awesome
	create_link .dotfiles/.config/i3 ~/.config/i3
	create_link .dotfiles/.config/lilyterm ~/.config/lilyterm
	create_link .dotfiles/.xinitrc ~/.xinitrc
	create_link .dotfiles/.xmodmap ~/.xmodmap
	create_link .dotfiles/.gtkrc-2.0 ~/.gtkrc-2.0
    create_link .dotfiles/.i3status.conf ~/.i3status.conf
fi

## Mac specific
if [[ `uname` == 'Darwin' ]]; then
	create_link .dotfiles/.slate ~/.slate
fi
