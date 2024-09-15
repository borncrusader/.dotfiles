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

# TODO
- populate gitconfig
- have a sample .netrc file
- if using systemd-resolved
```
ln -sf ../run/systemd/resolve/stub-resolv.conf /etc/resolv.conf
```

/etc/sddm.conf.d/autologin.conf

# Linux
nvidia, nvidia_modeset, nvidia_uvm, nvidia_drm in MODULES=() in /etc/mkinitcpio.conf

# Macos
Display -> Reduce Motion
Desktop & Dock -> Mission Control (turn off automatically rearrange ...)
