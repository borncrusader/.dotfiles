system=`uname`

# system specific settings
if [[ $system == 'Darwin' ]]; then
	# proper colors on Mac
	export CLICOLOR=1                                                                                     |~
	export LSCOLORS=ExFxBxDxCxegedabagacad                                                                |~

	alias ls="ls -GFh"
elif [[ $system == 'Linux' ]]; then
	alias ls='ls --color'
fi

# alises go here
alias cd..='cd ..'
alias dush='du -sh'
alias vi='vim -X'
alias pore='vi -X -c "cf grep_op" -c "copen"'
alias makit='make 2>&1 | tee grep_op'
alias rdesk='rdesktop -g 1366x730'
alias leaky='valgrind --leak-check=full --track-origins=yes'
alias chkconn='ping 8.8.8.8'

alias cdnc='cd ~/Dropbox/turn'
alias cdad='cd ~/Dropbox/turn/admin'
alias cdt='cd ~/Dropbox/turn/thesis'
alias cdl='cd ~/Dropbox/monk/lua'

# exports
export PATH=$PATH:/opt/local/bin:/opt/local/sbin:$HOME/bin
export PS1='\w\$ '
export EDITOR='vim'
export HISTCONTROL=erasedups
export HISTIGNORE="&:ls:[bf]g:exit"
export MONK="~/Dropbox/monk"
export TERM='xterm'

# aliases
alias gochief="ssh -Y sananthakrishnan@chief-sh101"
alias goarch="ssh -Y sananthakrishnan@arch-sananth"
alias goeos="ssh -Y sananth5@remote.eos.ncsu.edu"
alias goarch="ssh -Y sananth5@arc.csc.ncsu.edu"

echo '~/.zprofile sourced'
