# Dotfiles

A collection of dotfiles and scripts for macOS and Linux, managed via symlinks.

## Installation

```bash
git clone --recurse-submodules https://github.com/borncrusader/dotfiles ~/.dotfiles
cd ~/.dotfiles
./install.sh
```

The install script creates symlinks from `~/.dotfiles` to your home directory, backing up any existing files to `*.back`.

## Repository Structure

```
.dotfiles/
├── .config/           # App configs (nvim, alacritty, i3, hypr, waybar)
├── .vim/              # Vim configuration
├── bin/               # Custom scripts (symlinked to ~/bin)
├── homebrew/          # Brewfile management for multiple machines
├── linux/             # Linux-specific configs (i3blocks-contrib submodule)
├── zsh/               # Oh-My-Zsh (submodule)
├── zsh-vim-mode/      # Zsh vim keybinding plugin (submodule)
├── install.sh         # Main installation script
└── *.conf, .*rc       # Shell and tool configs
```

## Shell Configuration

### File Purposes

| File | Purpose |
|------|---------|
| `.profile` | Environment variables and PATH setup (shell-agnostic) |
| `.myshrc` | Aliases, functions, SSH/GPG agents (shell-agnostic) |
| `.zprofile` | Zsh login shell: sources `.profile`, history settings |
| `.zshrc` | Zsh interactive: antigen plugins, vim-mode, sources `.myshrc` |
| `.bash_profile` | Bash login shell |
| `.bashrc` | Bash interactive shell |

### Zsh Sourcing Flow

For an interactive login zsh session, files are sourced in this order:

```
┌─────────────────────────────────────────────────────────────────┐
│  .zprofile (login shell)                                        │
│    └── .profile (environment vars, PATH)                        │
│                                                                 │
│  .zshrc (interactive shell)                                     │
│    ├── antigen plugins (oh-my-zsh, git, autosuggestions, etc.) │
│    ├── zsh-vim-mode                                             │
│    ├── .fzf.zsh                                                 │
│    ├── .myshrc (aliases, functions)                             │
│    │     └── .myshrc_work (if exists)                           │
│    └── conda (if miniconda3 exists)                             │
└─────────────────────────────────────────────────────────────────┘
```

### The `_sp` Debug Variable

The `_sp` variable tracks the shell sourcing path for debugging. Each file appends markers:

| Marker | File | Position |
|--------|------|----------|
| `_p` / `_P` | `.profile` | start / end |
| `_z` / `_Z` | `.zprofile` | start / end |
| `_zr` / `_ZR` | `.zshrc` | start / end |
| `_mr` / `_MR` | `.myshrc` | start / end |

Run `shdbg` to see the sourcing path. A typical zsh login session shows:
```
$ shdbg
_z_p_P_Z_zr_mr_MR_ZR
```

This helps diagnose issues like files being sourced multiple times or in unexpected order.

### Key Functions

| Function | Description |
|----------|-------------|
| `shdbg` | Print the `_sp` sourcing path |
| `howdy` | Re-source `.zshrc` |
| `mkcd <dir>` | Create directory and cd into it |
| `ws [work]` | Switch GOPATH between default and work |
| `inspect_cert` | Inspect SSL certificates (file or remote) |
| `refresh` | Linux package management (pacman/yay) |

## Bash v Zsh File Sourcing (Reference)

**login-shell**
- bash: `/etc/profile`, `~/.bash_profile`
- zsh: `/etc/zsh/zprofile` (sources `/etc/profile` internally), `~/.zprofile`, `/etc/zsh/zlogin`, `~/.zlogin`

**interactive-shell**
- bash: `~/.bashrc`
- zsh: `/etc/zsh/zshrc`, `~/.zshrc`

Additionally zsh sources `/etc/zsh/zlogout` and `~/.zlogout` at logout, and `/etc/zsh/zshenv`, `~/.zshenv` at first.

### Where to Place Aliases/Exports

- **Environment variables** are shared across all shells → put in `*profile` files
- **Aliases** are local to a shell → put in `*rc` files

## FZF Integration

FZF (fuzzy finder) is integrated via the `fzf-zsh-plugin` antigen bundle. Config files:
- `.fzf.zsh` - Zsh-specific FZF setup
- `.fzf.bash` - Bash-specific FZF setup

Common keybindings:
- `Ctrl+T` - Fuzzy find files
- `Ctrl+R` - Fuzzy search command history
- `Alt+C` - Fuzzy cd into directories

---

# TODO

- populate gitconfig
- have a sample .netrc file
- if using systemd-resolved:
  ```
  ln -sf ../run/systemd/resolve/stub-resolv.conf /etc/resolv.conf
  ```
- /etc/sddm.conf.d/autologin.conf

# Linux

nvidia, nvidia_modeset, nvidia_uvm, nvidia_drm in MODULES=() in /etc/mkinitcpio.conf

# macOS

- Display -> Reduce Motion
- Desktop & Dock -> Mission Control (turn off automatically rearrange ...)
