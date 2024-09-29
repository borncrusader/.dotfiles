# Setup fzf
# ---------
if [[ ! "$PATH" == *${FZF_PATH}/bin* ]]; then
  export PATH="$PATH:${FZF_PATH}/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && [[ -f "${FZF_PATH}/shell/completion.zsh" ]] && source "${FZF_PATH}/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------
[[ -f "${FZF_PATH}/shell/key-bindings.zsh" ]] && source "${FZF_PATH}/shell/key-bindings.zsh"
