### https://unix.stackexchange.com/questions/14230/zsh-tab-completion-on-empty-line
## Here is complete implementation of tcsh's autolist in zsh, when you press tab on empty line

# list dir with TAB, when there are only spaces/no text before cursor,
# or complete words, that are before cursor only (like in tcsh)
tcsh_autolist() { if [[ -z ${LBUFFER// } ]]
    then BUFFER="ls " CURSOR=3 zle list-choices
    else zle expand-or-complete-prefix; fi }
zle -N tcsh_autolist
bindkey '^I' tcsh_autolist

# If you want to emulate tcsh more closely, also add this to your .zshrc:
unsetopt always_last_prompt       # print completion suggestions above prompt

