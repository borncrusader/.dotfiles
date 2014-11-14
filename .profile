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
fi

# session and os specific
