# if not running interactively, don't do anything
[[ $- != *i* ]] && return

s()
{
	source ~/.bashrc
}

# finally source the common shell rc
[[ -f ~/.myshrc ]] && source ~/.myshrc
