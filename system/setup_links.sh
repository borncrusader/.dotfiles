#!/bin/sh

if [[ `uname` == 'Linux' ]]; then
	ln -s .dotfiles/.config/awesome ~/.config/awesome
fi

ln -s .dotfiles/.vim ~/.vim
ln -s .dotfiles/bin ~/bin

ln -s .dotfiles/.bash_profile ~/.bash_profile
ln -s .dotfiles/.bashrc ~/.bashrc

if [[ `uname` == 'Linux' ]]; then
	ln -s .dotfiles/.gtkrc-2.0 ~/.gtkrc-2.0
	ln -s .dotfiles/.gtkrc.mine ~/.gtkrc.mine
fi

ln -s .dotfiles/.myshrc ~/.myshrc
ln -s .dotfiles/.profile ~/.profile
ln -s .dotfiles/.screenrc ~/.screenrc
ln -s .dotfiles/.tmux.conf ~/.tmux.conf
ln -s .dotfiles/.vimrc ~/.vimrc

if [[ `uname` == 'Linux' ]]; then
	ln -s .dotfiles/.xinitrc ~/.xinitrc
	ln -s .dotfiles/.xmodmap ~/.xmodmap
fi

ln -s .dotfiles/.zprofile ~/.zprofile
ln -s .dotfiles/.zshrc ~/.zshrc
