## https://dzone.com/articles/increasing-shell-productivity-with-zsh-aliases
## blank aliases

typeset -a baliases

baliases=()

balias() {

alias $@

args="$@"

args=${args%%\=*}

baliases+=(${args##* })

}

# ignored aliases

typeset -a ialiases

ialiases=()

ialias() {

alias $@

args="$@"

args=${args%%\=*}

ialiases+=(${args##* })

}

# functionality

expand-alias-space() {

[[ $LBUFFER =~ "\<(${(j:|:)baliases})\$" ]]; insertBlank=$?

if [[ ! $LBUFFER =~ "\<(${(j:|:)ialiases})\$" ]]; then

zle _expand_alias

fi

zle self-insert

if [[ "$insertBlank" = "0" ]]; then

zle backward-delete-char

fi

}

zle -N expand-alias-space

bindkey " " expand-alias-space

bindkey -M isearch " " magic-space

# command aliases

alias jj='java -jar'

alias mcp='mvn clean package'

# blank aliases, without trailing whitespace

balias clh='curl localhost:'



# "ignored" aliases, not expanded

ialias l='exa -al'

ialias curl='curl --silent --show-error'



# global aliases

alias -g L='| less'

alias -g G='| grep'

ialias -g grep='grep --color=auto --exclude-dir={.bzr,CVS,.git,.hg,.svn}'

#### MY OWN ALIAS'S
# Debian and Ubuntu Systems
alias update="sudo apt-get update && sudo apt-get -y upgrade && sudo apt-get autoremove && sudo apt-get autoclean"
alias apt-get="sudo apt-get"
alias dpkg="sudo dpkg"
alias store="dpkg --get-selections > ~/.dotfiles/backups/packages.list"
alias restore="dpkg --get-selections < ~/.dotfiles/backups/packages.list && sudo apt-get -y update && sudo apt-get dselect-upgrade"
alias restore="apt-get install -y $(cat  ~/.dotfiles/backups/package.list | awk '{print $1}')"
alias fonts="fc-cache -fv"


## https://raw.githubusercontent.com/xero/dotfiles/master/zsh/.zsh/aliases.zsh 
alias ls="ls -hF --color=auto"
alias mkdir="mkdir -p"
alias cp="cp -r"
alias scp="scp -r"
alias xsel="xsel -b"
alias fuck='sudo $(fc -ln -1)'
alias ag="ag --color --color-line-number '0;35' --color-match '46;30' --color-path '4;36'"
alias tree='tree -CAFa -I "CVS|*.*.package|.svn|.git|.hg|node_modules|bower_components" --dirsfirst'
# colorized cat
function c() {
  for file in "$@"
  do
    pygmentize -O style=sourcerer -f console256 -g "$file" 
  done
}
# colorized less
function l() {
  pygmentize -O style=sourcerer -f console256 -g $1 | less -r 
}
# read markdown files like manpages
function md() {
    pandoc -s -f markdown -t man "$*" | man -l -
}
# nullpointer url shortener
function short() {
  curl -F"shorten=$*" https://0x0.st
}
