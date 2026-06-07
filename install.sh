#!/bin/bash

_mkdir() {
    ! [[ -d "$1" ]] && echo "creating directory: $1" && mkdir -p "$1"
}

_create_link()
{
    # usage: _create_link original link
    if ! [[ -d $(dirname "$2") ]]; then
	_mkdir "$2"
    fi

    if [[ -L "$2" ]]; then
        echo "$2: link already exists"
        return
    fi

    if [[ -e "$2" ]]; then
	echo "$2: backing up as $2.back"
	mv "$2" "$2.back"
    fi

    echo "$2: creating link -> $1"
    ln -s "$1" "$2"
}

prompt() {
    read -rp "$1 [y/N] " confirm

    if [[ "$confirm" =~ ^[Yy]$ ]]; then
	return 0
    else 
	return 1
    fi
}

## common
_create_link "$HOME/.dotfiles/bin/" "$HOME/bin"
_create_link "$HOME/.dotfiles/.config/nvim/" "$HOME/.config/nvim"
_create_link "$HOME/.dotfiles/.config/ghostty/" "$HOME/.config/ghostty"

_create_link "$HOME/.dotfiles/.zprofile" "$HOME/.zprofile"
_create_link "$HOME/.dotfiles/.zshrc" "$HOME/.zshrc"
_create_link "$HOME/.dotfiles/.bash_profile" "$HOME/.bash_profile"
_create_link "$HOME/.dotfiles/.bashrc" "$HOME/.bashrc"
_create_link "$HOME/.dotfiles/.myshrc" "$HOME/.myshrc"
_create_link "$HOME/.dotfiles/.profile" "$HOME/.profile"
_create_link "$HOME/.dotfiles/.tmux.conf" "$HOME/.tmux.conf"
_create_link "$HOME/.dotfiles/.vimrc" "$HOME/.vimrc"
_create_link "$HOME/.dotfiles/.psqlrc" "$HOME/.psqlrc"
_create_link "$HOME/.dotfiles/zsh-vim-mode" "$HOME/.zsh-vim-mode"
_create_link "$HOME/.dotfiles/.fzf.zsh" "$HOME/.fzf.zsh"
_create_link "$HOME/.dotfiles/.fzf.bash" "$HOME/.fzf.bash"

_create_link "$HOME/.dotfiles/.claude/commands/" "$HOME/.claude/commands"

# Linux specific
if [[ "$(uname)" = 'Linux' ]]; then
    _create_link "$HOME/.dotfiles/.config/i3/" "$HOME/.config/i3"
    _create_link "$HOME/.dotfiles/.xinitrc" "$HOME/.xinitrc"
    _create_link "$HOME/.dotfiles/.xmodmap" "$HOME/.xmodmap"
    _create_link "$HOME/.dotfiles/.gtkrc-2.0" "$HOME/.gtkrc-2.0"
    _create_link "$HOME/.dotfiles/.i3status.conf" "$HOME/.i3status.conf"
    _create_link "$HOME/.dotfiles/.i3blocks.conf" "$HOME/.i3blocks.conf"
    _create_link "$HOME/.dotfiles/.Xresources" "$HOME/.Xresources"

    # wayland
    _create_link "$HOME/.dotfiles/.config/waybar/" "$HOME/.config/waybar"
    _create_link "$HOME/.dotfiles/.config/hypr/" "$HOME/.config/hypr"
fi

## Mac specific
if [[ "$(uname)" = 'Darwin' ]]; then
    _create_link "$HOME/.config/ghostty/config-macos" "$HOME/.config/ghostty/config-platform-specific"

    _create_link "$HOME/.dotfiles/.hammerspoon/" "$HOME/.hammerspoon"

    _create_link "$HOME/.dotfiles/alfred/" "$HOME/alfred"

    # replace caps-lock with ctrl
    echo "replacing caps-lock with ctrl"
    hidutil property --set '{"UserKeyMapping":[{"HIDKeyboardModifierMappingSrc":0x700000039,"HIDKeyboardModifierMappingDst":0x7000000E0}]}'

    # move spotlight to opt+space
    echo "move Cmd+Space to Opt+Space for Spotlight"
    defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 64 "
	<dict>
  	  <key>enabled</key><true/>
  	  <key>value</key><dict>
  	    <key>type</key><string>standard</string>
  	    <key>parameters</key>
  	    <array>
  	      <integer>32</integer>
  	      <integer>49</integer>
  	      <integer>524288</integer>
  	    </array>
  	  </dict>
  	</dict>
"

    # change the default directory for screenshots
    echo "change screenshot location to $HOME/Pictures/Screenshots"
    defaults write com.apple.screencapture location -string "$HOME/Pictures/Screenshots/"

    # disable accents on press and hold for faster key repeat
    echo "disable accents on press and hold for faster key repeat"
    defaults write -g ApplePressAndHoldEnabled -bool false

    # smooth scrolling
    echo "enable smooth scrolling"
    defaults write -g CGFontRenderingFontSmoothingDisabled -bool NO
    defaults -currentHost write -globalDomain AppleFontSmoothing -int 2

    # make the dock appear and disappear faster
    echo "make dock appear and disapper faster"
    defaults write com.apple.dock autohide-time-modifier -int 0
    defaults write com.apple.dock autohide-delay -int 0
    killall Dock

    # install homebrew and bare minimum stuff
    if [[ ! -f "/opt/homebrew/bin/brew" ]]; then
	echo "installing hombrew and basic applications"

	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

	# applications
	/opt/homebrew/bin/brew install tmux nvim ripgrep

	# casks
	/opt/homebrew/bin/brew install --cask keepingyouawake
    fi

    prompt "Set Timezone" && sudo systemsetup -settimezone "America/Los_Angeles"

    prompt "Do Software Update" && sudo softwareupdate -i -a --agree-to-license

    # have changes take effect
    echo "activating settings immediately"
    /System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u
fi

if [[ ! -f "$HOME/.ssh/id_ed25519" ]]; then
    echo "creating ssh key"

    ssh-keygen -o -a 256 -t ed25519 -C "$(hostname)-$(date +'%d-%m-%Y')"
fi
