# Setup fzf
# ---------
if [[ ! "$PATH" == *${FZF_PATH}/bin* ]]; then
  PATH="${PATH:+${PATH}:}${FZF_PATH}/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && [[ -f "${FZF_PATH}/shell/completion.bash" ]] && source "${FZF_PATH}/shell/completion.bash" 2> /dev/null

# Key bindings
# ------------
[[ -f "${FZF_PATH}/shell/key-bindings.bash" ]] && source "${FZF_PATH}/shell/key-bindings.bash"
