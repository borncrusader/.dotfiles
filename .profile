# preliminary initiation
# there are two types - sessions and OS
# mac always is HOME
# linux can either be HOME or WORK
if [[ $(uname) == 'Darwin' ]]; then
    export SESSION='HOME'
    export OS='MAC'
elif [[ $(uname) == 'Linux' && $(whoami) == 'ska' ]]; then
    export SESSION='HOME'
    export OS='LINUX'
elif [[ $(uname) == 'Linux' ]]; then
    export SESSION='HOME'
    export OS='LINUX'
else
    echo "ALARM! New system found! $(uname) and $(whoami)"
fi

# common
export EDITOR='vim'
export TERM='xterm-256color'

# TODO: path is special! if it already has the information, don't re-add it
export PATH=$HOME/bin:$PATH

# session specific
if [[ $SESSION == 'HOME' ]]; then
    if [[ -d $HOME/Dropbox ]]; then
        export MONK="$HOME/Dropbox/monk"
        export SYSDUMP="$HOME/Dropbox/sysdump"
    fi
else
    export WRK=/local/ska
fi

# os specific
if [[ $OS == 'MAC' ]]; then
	# proper colors on Mac
	export CLICOLOR=1
    export LSCOLORS=exfxcxdxbxegedabagacad
    #export LSCOLORS=gxfxbEaEBxxEhEhBaDaCaD # from github

    export PATH=$HOME/bin/mac:$PATH

    export CODE=/Volumes/code
    export HACKER="/Volumes/code/hacker"
    export GOPATH=$HACKER/sandbox/go
    # XQuartz on Mavericks sometimes needs this!
    export DISPLAY=":0"
else
    export CODE=$HOME/code
fi

# session and os specific
function start_ssh_agent()
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
if [[ -z $TMUX && ! -z $SSH_TTY ]]; then
    # we're not in a tmux session and logged in via SSH

    start_ssh_agent
fi

# do this for all shells
if [[ -z $SSH_AUTH_SOCK ]]; then
    export SSH_AUTH_SOCK=~/.ssh/.auth_socket
fi
