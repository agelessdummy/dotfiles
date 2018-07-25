#█▓▒░ preferred editor for local and remote sessions
export EDITOR=vim
export VISUAL=vim


alias v="vim"
alias vi="vim"
alias emacs="vim"


if type nvim > /dev/null 2>&1; then
  alias vim='nvim'
fi

alias  vup="vim +PlugInstall +UpdateRemotePlugins +qa"
