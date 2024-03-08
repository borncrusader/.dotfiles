#!/bin/sh

# bail out on first error
set -euo pipefail

create_link()
{
	# usage: create_link original link
    if [ -L "$2" ]; then
        echo "$2: link already exists"
        return
    fi

	if [ -e "$2" ]; then
		echo "$2: backing up as $2.back"
		mv "$2" "$2.back"
	fi

	echo "$2: creating link -> $1"
	ln -s "$1" "$2"
}

## common
create_link ~/.dotfiles/.vim/ ~/.vim
create_link ~/.dotfiles/bin/ ~/bin
create_link ~/.dotfiles/.config/nvim/ ~/.config/nvim
create_link ~/.dotfiles/.config/alacritty/ ~/.config/alacritty

create_link ~/.dotfiles/.zprofile ~/.zprofile
create_link ~/.dotfiles/.zshrc ~/.zshrc
create_link ~/.dotfiles/.bash_profile ~/.bash_profile
create_link ~/.dotfiles/.bashrc ~/.bashrc
create_link ~/.dotfiles/.myshrc ~/.myshrc
create_link ~/.dotfiles/.profile ~/.profile
create_link ~/.dotfiles/.tmux.conf ~/.tmux.conf
create_link ~/.dotfiles/.vimrc ~/.vimrc
create_link ~/.dotfiles/.psqlrc ~/.psqlrc
create_link ~/.dotfiles/zsh-vim-mode ~/.zsh-vim-mode
create_link ~/.dotfiles/.fzf.zsh ~/.fzf.zsh
create_link ~/.dotfiles/.fzf.bash ~/.fzf.bash

# Linux specific
if [ "$(uname)" = 'Linux' ]; then
    create_link ~/.dotfiles/.config/i3/ ~/.config/i3
    create_link ~/.dotfiles/.xinitrc ~/.xinitrc
    create_link ~/.dotfiles/.xmodmap ~/.xmodmap
    create_link ~/.dotfiles/.gtkrc-2.0 ~/.gtkrc-2.0
    create_link ~/.dotfiles/.i3status.conf ~/.i3status.conf
    create_link ~/.dotfiles/.Xresources ~/.Xresources
fi

## Mac specific
if [ "$(uname)" = 'Darwin' ]; then
    create_link .dotfiles/.hammersoon ~/.hammerspoon

    # change the default directory for screenshots
    defaults write com.apple.screencapture location -string "$HOME/Pictures/Screenshots/"

    # solve for key repeat issues in macs
    defaults write -g ApplePressAndHoldEnabled -bool false

    # smooth scrolling
    defaults write -g CGFontRenderingFontSmoothingDisabled -bool NO
    defaults -currentHost write -globalDomain AppleFontSmoothing -int 2

    # make the dock appear and disappear faster
    defaults write com.apple.dock autohide-time-modifier -int 0
    defaults write com.apple.dock autohide-delay -int 0
    killall Dock

    # install applications
    ./brew/run.sh install

    # set timezone
    sudo systemsetup -settimezone "America/Los_Angeles"

    # finally do an update and agree to the xcode license; will restart
    sudo softwareupdate -i -a --restart --agree-to-license
fi
