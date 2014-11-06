# if not running interactively, don't do anything
[[ $- != *i* ]] && return

# history control
export HISTCONTROL=erasedups
# & is a special pattern that suppresses duplicate entries
export HISTIGNORE=" *:&:ls:[bf]g:exit"

s()
{
	source ~/.bashrc
}

# finally source the common shell rc
[[ -f ~/.myshrc ]] && source ~/.myshrc
