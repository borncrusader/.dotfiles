# Setup fzf
# ---------
if [[ ! "$PATH" == */Users/ska/.fzf/bin* ]]; then
  PATH="${PATH:+${PATH}:}/Users/ska/.fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/Users/ska/.fzf/shell/completion.bash" 2> /dev/null

# Key bindings
# ------------
source "/Users/ska/.fzf/shell/key-bindings.bash"
