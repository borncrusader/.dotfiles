#!/bin/bash

set -euo pipefail

DRY_RUN=false
VERBOSE=false

for arg in "$@"; do
    case "$arg" in
        --dry-run|-n) DRY_RUN=true ;;
        --verbose|-v) VERBOSE=true ;;
        --help|-h)
            echo "Usage: install.sh [options]"
            echo ""
            echo "Options:"
            echo "  -n, --dry-run   show what would be done without making changes"
            echo "  -v, --verbose   show skipped steps and commands as they run"
            echo "  -h, --help      show this help"
            exit 0
            ;;
    esac
done

_run() {
    # usage: _run "description" cmd args...
    local desc="$1"; shift
    if $DRY_RUN; then
        echo "[dry-run] $desc"
    else
        if $VERBOSE; then echo "+ $desc"; fi
        "$@"
    fi
}

_write() {
    # usage: _write <file> <<'EOF' ... EOF
    if $DRY_RUN; then
        echo "[dry-run] write $1"
    else
        cat > "$1"
    fi
}

_mkdir() {
    # usage: _mkdir <directory>
    if ! [[ -d "$1" ]]; then
        _run "create directory $1" mkdir -p "$1"
    fi
}

_create_link() {
    # usage: _create_link original link
    if ! [[ -d $(dirname "$2") ]]; then
        _mkdir "$(dirname "$2")"
    fi

    if [[ -L "$2" ]]; then
        if $VERBOSE; then echo "$2: link already exists"; fi
        return
    fi

    if [[ -e "$2" ]]; then
        _run "back up $2" mv "$2" "$2.back"
    fi

    _run "link $2 -> $1" ln -s "$1" "$2"
}

_run_with_prompt() {
    # usage: _run_with_prompt "description" cmd args...
    local desc="$1"; shift
    if $DRY_RUN; then
        echo "[dry-run] (prompted) $desc"
        return 0
    fi
    read -rp "$desc [y/N] " confirm
    if [[ "$confirm" =~ ^[Yy]$ ]]; then
        if $VERBOSE; then echo "+ $desc"; fi
        "$@"
    fi
}

if ! $DRY_RUN; then
    case "${SHELL:-}" in
        */bash|*/zsh) ;;
        *)
            read -rp "Current shell (${SHELL:-unknown}) is not bash or zsh — shell configs may not apply. Proceed? [y/N] " _confirm
            case "$_confirm" in
                [Yy]) ;;
                *) echo "Aborted."; exit 1 ;;
            esac
            unset _confirm
            ;;
    esac
fi

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

if [[ "$(uname)" = 'Linux' ]]; then
    _create_link "$HOME/.config/ghostty/config-linux" "$HOME/.config/ghostty/config-platform-specific"

    _create_link "$HOME/.dotfiles/.config/i3/" "$HOME/.config/i3"
    _create_link "$HOME/.dotfiles/.xinitrc" "$HOME/.xinitrc"
    _create_link "$HOME/.dotfiles/.xmodmap" "$HOME/.xmodmap"
    _create_link "$HOME/.dotfiles/.gtkrc-2.0" "$HOME/.gtkrc-2.0"
    _create_link "$HOME/.dotfiles/.i3status.conf" "$HOME/.i3status.conf"
    _create_link "$HOME/.dotfiles/.i3blocks.conf" "$HOME/.i3blocks.conf"
    _create_link "$HOME/.dotfiles/.Xresources" "$HOME/.Xresources"

    _create_link "$HOME/.dotfiles/.config/waybar/" "$HOME/.config/waybar"
    _create_link "$HOME/.dotfiles/.config/hypr/" "$HOME/.config/hypr"
elif [[ "$(uname)" = 'Darwin' ]]; then
    _create_link "$HOME/.config/ghostty/config-macos" "$HOME/.config/ghostty/config-platform-specific"

    _create_link "$HOME/.dotfiles/.hammerspoon/" "$HOME/.hammerspoon"

    _create_link "$HOME/.dotfiles/alfred/" "$HOME/alfred"

    _run "replace caps-lock with ctrl" \
        hidutil property --set '{"UserKeyMapping":[{"HIDKeyboardModifierMappingSrc":0x700000039,"HIDKeyboardModifierMappingDst":0x7000000E0}]}'

    _run "move Cmd+Space to Opt+Space for Spotlight" \
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

    _run "set screenshot location to ~/Pictures/Screenshots" \
        defaults write com.apple.screencapture location -string "$HOME/Pictures/Screenshots/"
    _run "disable press-and-hold for faster key repeat" \
        defaults write -g ApplePressAndHoldEnabled -bool false
    _run "enable font smoothing" \
        defaults write -g CGFontRenderingFontSmoothingDisabled -bool NO
    _run "set font smoothing level" \
        defaults -currentHost write -globalDomain AppleFontSmoothing -int 2
    _run "set dock autohide speed to instant" \
        defaults write com.apple.dock autohide-time-modifier -int 0
    _run "set dock autohide delay to zero" \
        defaults write com.apple.dock autohide-delay -int 0
    _run "restart Dock to apply changes" \
        killall Dock

    if [[ ! -f "/opt/homebrew/bin/brew" ]]; then
        _run "install homebrew" \
            /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        _run "brew install tmux nvim ripgrep" \
            /opt/homebrew/bin/brew install tmux nvim ripgrep
        _run "brew install --cask keepingyouawake" \
            /opt/homebrew/bin/brew install --cask keepingyouawake
    fi

    _run_with_prompt "set timezone to America/Los_Angeles" \
        sudo systemsetup -settimezone "America/Los_Angeles"

    _run_with_prompt "run software update" \
        sudo softwareupdate -i -a --agree-to-license

    _run "activate macOS settings" \
        /System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u
fi

if [[ ! -f "$HOME/.gitconfig" ]]; then
    _write "$HOME/.gitconfig" <<'EOF'
[include]
	path = ~/.dotfiles/.gitconfig

# Uncomment and adjust path to use a work-specific git config:
# [includeIf "gitdir:~/work/"]
# 	path = ~/.gitconfig-work
EOF
fi

if [[ ! -f "$HOME/.ssh/id_ed25519" ]]; then
    _run "create ed25519 SSH key" \
        ssh-keygen -o -a 256 -t ed25519 -C "$(hostname)-$(date +'%d-%m-%Y')"
fi
