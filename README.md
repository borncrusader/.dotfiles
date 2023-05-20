# About
A collection of all my dotfiles and my common scripts

# BASH v ZSH File Sourcing
login-shell
bash: /etc/profile, ~/.bash_profile
zsh: /etc/zsh/zprofile (sources /etc/profile internally), ~/.zprofile, /etc/zsh/zlogin, ~/.zlogin

interactive-shell
bash: ~/.bashrc
zsh: /etc/zsh/zshrc, ~/.zshrc

Additionally zsh sources /etc/zsh/zlogout and ~/.zlogout at logout, and /etc/zsh/zshenv, ~/.zshenv at first.

# Where to place aliases/exports
Typically environment variables are shared across all shells, so best to have them in the *profile file.
Aliases are local to a shell, so best to have them in the *rc file.

# FZF
TBD
