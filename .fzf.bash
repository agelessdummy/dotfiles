# Setup fzf
# ---------
if [[ ! "$PATH" == */home/mendez/.fzf/bin* ]]; then
  export PATH="$PATH:/home/mendez/.fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/home/mendez/.fzf/shell/completion.bash" 2> /dev/null

# Key bindings
# ------------
source "/home/mendez/.fzf/shell/key-bindings.bash"

