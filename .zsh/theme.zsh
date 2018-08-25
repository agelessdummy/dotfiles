ZSH_THEME="dracula"
#ZSH_THEME="powerlevel9k"

export TERM=xterm-256color

# https://dev.to/lloydstubber/my-wsl-setup-for-development 
#Change ls colours
LS_COLORS="ow=01;36;40" && export LS_COLORS

#make cd use the ls colours
zstyle ':completion:*' list-colors "${(@s.:.)LS_COLORS}"
autoload -Uz compinit
compinit
