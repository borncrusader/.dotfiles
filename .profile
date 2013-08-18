# os specific settings
if [[ `uname` == 'Darwin' ]]; then
	# proper colors on Mac
	export CLICOLOR=1
	export LSCOLORS=ExFxBxDxCxegedabagacad
fi

# exports
export PATH=$PATH:/opt/local/bin:/opt/local/sbin:$HOME/bin
export EDITOR='vim'
export HISTCONTROL=erasedups
export HISTIGNORE="&:ls:[bf]g:exit"
export MONK="~/Dropbox/monk"
export TERM='xterm'
