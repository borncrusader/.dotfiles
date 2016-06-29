# all *profile work done here
[[ -f ~/.profile ]] && source ~/.profile

# source the bashrc for login shells too
[[ -f ~/.bashrc ]] && source ~/.bashrc

# Finally set the prompt variable
export PS1='\[\e[0;32m\][\u@\h \W]\$\[\e[0m\] '
