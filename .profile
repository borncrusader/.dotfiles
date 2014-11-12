# os specific settings
if [[ `uname` == 'Darwin' ]]; then
	# proper colors on Mac
	export CLICOLOR=1
    export LSCOLORS=gxfxbEaEBxxEhEhBaDaCaD

    export PATH=$HOME/bin/mac:/usr/local/opt/coreutils/libexec/gnubin:$PATH
elif [[ `uname` == 'Linux' ]]; then
fi

# exports
export CODE=/Volumes/code
export EDITOR='vim'
export HACKER="/Volumes/code/hacker"
export GOPATH=$HACKER/sandbox/go
export MONK="$HOME/Dropbox/monk"
# TODO: path is special! if it already has the information, don't re-add it
export PATH=$HOME/bin:$PATH
export SYSDUMP="$HOME/Dropbox/sysdump"
export TERM='xterm-256color'
