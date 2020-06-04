#!/bin/sh
#################################################
# Some general rules
# 1. Add only exports and PATHs to this file
# 2. Don't run commands like brew here
#################################################

#################################################
# Determine OS
#################################################
if [ "$(uname)" = "Darwin" ]; then
    export OS="MAC"
elif [ "$(uname)" = "Linux" ]; then
    export OS="LINUX"
else
    echo "ALARM! New system found! uname: $(uname) and whoami: $(whoami)"
fi

#################################################
# Common exports
#################################################
export EDITOR='vim'
export TERM='xterm-256color'
export SYSDUMP="$HOME/sysdump"
export GOPATH="$HOME/go"
export NVM_DIR="$HOME/.nvm"

#################################################
# OS Specific exports
#################################################
if [ "$OS" = "MAC" ]; then
	# proper colors on mac
	export CLICOLOR=1
    export LSCOLORS=exfxcxdxbxegedabagacad

    # For GPG signing, else throws an inappropriate ioctl error
    GPG_TTY=$(tty)
    export GPG_TTY

    export CODE=/Volumes/code
else
    export CODE=$HOME/code
fi

#################################################
# SSH/GPG Agent Handling
#################################################
start_ssh_agent()
{
    if [[ `ps -ef | grep ssh-agent | wc -l` -gt 1 ]]; then
        echo "ssh-agent already running"
        return
    fi

    if [[ -z $SSH_AUTH_SOCK ]]; then
        export SSH_AUTH_SOCK=~/.ssh/.auth_socket
    fi

    # if socket is available create the new auth session
    if [[ ! -S $SSH_AUTH_SOCK ]]; then
        echo "starting ssh-agent"
        `ssh-agent -a $SSH_AUTH_SOCK` > /dev/null 2>&1

        # Add all default keys to ssh auth
        ssh-add 2> /dev/null
    fi
}

# http://robinwinslow.co.uk/2012/07/20/tmux-and-ssh-auto-login-with-ssh-agent-finally/
#if [ -z "$TMUX" ] && [ ! -z "$SSH_TTY" ]; then
#    # we're not in a tmux session and logged in via SSH
#
#    #start_ssh_agent
#fi

# do this for all shells
#if [ -z "$SSH_AUTH_SOCK" ]; then
#    export SSH_AUTH_SOCK=~/.ssh/.auth_socket
#fi

#if [ -z "$(pgrep gpg-agent)" ]; then
#    eval "$(gpg-agent --daemon --pinentry-program /usr/local/bin/pinentry)"
#fi
#################################################
# Some helpful functions
#################################################
_add_to_path() {
    [ -d "$1" ] && PATH="$1":$PATH
}

_source_if_exists() {
    # shellcheck disable=SC1090
    [ -f "$1" ] && . "$1"
}

#################################################
# Path Manipulation
#################################################
_add_to_path "$HOME/bin"
_add_to_path "$GOPATH/bin"
_add_to_path "$HOME/.cargo/bin"
_add_to_path "/usr/local/opt/node@8/bin"
_add_to_path "/usr/local/opt/gnu-sed/libexec/gnubin"
_add_to_path "$HOME/.poetry/bin"
_add_to_path "$HOME/bin/mac"

# asdf
_source_if_exists "/usr/local/opt/asdf/asdf.sh"

# broot
_source_if_exists "/Users/sananthakrishnan/Library/Preferences/org.dystroy.broot/launcher/bash/br"

# package-not-found details
_source_if_exists "/usr/share/doc/pkgfile/command-not-found.zsh"
