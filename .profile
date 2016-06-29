# preliminary initiation
if [[ $(uname) == 'Darwin' ]]; then
    export SESSION='HOME'
    export OS='MAC'
elif [[ $(uname) == 'Linux' ]]; then
    export SESSION='WORK'
    export OS='LINUX'
else
    echo "ALARM! New system found! $(uname)"
fi

# common
export EDITOR='vim'
# TODO: path is special! if it already has the information, don't re-add it
export PATH=$HOME/bin:$PATH
export TERM='xterm-256color'

# session specific
if [[ $SESSION == 'HOME' ]]; then
    export MONK="$HOME/Dropbox/monk"
    export SYSDUMP="$HOME/Dropbox/sysdump"
else
    export WRK=/work/sananthakrishnan
    export SVN_EDITOR=/u/qa/tools/svn-editor
    export SECTP=$WRK/sectp
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
fi

# session and os specific

# machine specific
if [[ $(hostname) == "chief-sh101.lab.nbttech.com" ]]; then
	export TMPDIR=/work/sananthakrishnan/tmp
fi

# http://robinwinslow.co.uk/2012/07/20/tmux-and-ssh-auto-login-with-ssh-agent-finally/
if [[ -z $TMUX && ! -z $SSH_TTY ]]; then
    # we're not in a tmux session and logged in via SSH

    # if ssh auth variable is missing
    if [[ -z $SSH_AUTH_SOCK ]]; then
        export SSH_AUTH_SOCK=~/.ssh/.auth_socket
    fi

    # if socket is available create the new auth session
    if [[ ! -S $SSH_AUTH_SOCK ]]; then
        `ssh-agent -a $SSH_AUTH_SOCK` > /dev/null 2>&1

        # Add all default keys to ssh auth
        ssh-add 2> /dev/null
    fi
fi
