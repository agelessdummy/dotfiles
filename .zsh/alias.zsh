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
alias fonts="fc-cache -fv"
#alias dd="dd status=progress count=100 "
#alias dd="progress_bar dd "
alias dd="dd status=progress"
alias sha1sum="sha1sum -c"
alias sha256sum="sha256sum -c SHA256SUMS 2>&1 | grep OK"


## https://raw.githubusercontent.com/xero/dotfiles/master/zsh/.zsh/aliases.zsh 
alias ls="ls -hF --color=auto"
alias mkdir="mkdir -p"
#alias cp="cp -r"
#alias scp="scp -r"
alias xsel="xsel -b"
alias fuck='sudo $(fc -ln -1)'
alias ag="ag --color --color-line-number '0;35' --color-match '46;30' --color-path '4;36'"
alias tree='tree -CAFa -I "CVS|*.*.package|.svn|.git|.hg|node_modules|bower_components" --dirsfirst'
alias fstab="sudo vim /etc/fstab"
alias grub="sudo vim /etc/default/grub"
alias grubup="sudo update-grub"
alias c='clear'

alias zshrc="source ~/.zshrc"

#16: Add safety nets
# do not delete / or prompt if deleting more than 3 files at a time #
alias rm='rm -I --preserve-root'
# confirmation #
alias mv='mv -i'
alias cp='cp -i'
alias ln='ln -i'
# Parenting changing perms on / #
alias chown='chown --preserve-root'
alias chmod='chmod --preserve-root'
alias chgrp='chgrp --preserve-root'

#19: Tune sudo and su
alias root='sudo -i'
alias su='sudo -i'

# reboot / halt / poweroff
alias reboot='sudo /sbin/reboot'
alias poweroff='sudo /sbin/poweroff'
alias halt='sudo /sbin/halt'
alias shutdown='sudo /sbin/shutdown'
alias sysoff='shutdown -p now'

#21: Control web servers
# also pass it via sudo so whoever is admin can reload it without calling you #
alias nginxreload='sudo /usr/local/nginx/sbin/nginx -s reload'
alias nginxtest='sudo /usr/local/nginx/sbin/nginx -t'
alias lightyload='sudo /etc/init.d/lighttpd reload'
alias lightytest='sudo /usr/sbin/lighttpd -f /etc/lighttpd/lighttpd.conf -t'
alias httpdreload='sudo /usr/sbin/apachectl -k graceful'
alias httpdtest='sudo /usr/sbin/apachectl -t && /usr/sbin/apachectl -t -D DUMP_VHOSTS'

#25: Get system memory, cpu usage, and gpu memory info quickly
## pass options to free ##
alias meminfo='free -m -l -t'
## get top process eating memory
alias psmem='ps auxf | sort -nr -k 4'
alias psmem10='ps auxf | sort -nr -k 4 | head -10'
## get top process eating cpu ##
alias pscpu='ps auxf | sort -nr -k 3'
alias pscpu10='ps auxf | sort -nr -k 3 | head -10'
## Get server cpu info ##
alias cpuinfo='lscpu'
## older system use /proc/cpuinfo ##
##alias cpuinfo='less /proc/cpuinfo' ##
## get GPU ram on desktop / laptop##
alias gpumeminfo='grep -i --color memory /var/log/Xorg.0.log'

# resume wget by default
alias wget="wget -c"

#  Control cd command behavior
## get rid of command not found ##
#alias cd='cd && ls'
alias cd..='cd ..'
alias ..='cd ..'
alias ...='cd ../../../'
alias ....='cd ../../../../'
alias .....='cd ../../../../'
alias .4='cd ../../../../'
alias .5='cd ../../../../..'

alias wtf='dmesg'
alias rtfm='man'

#Create a new set of commands
alias path='echo -e ${PATH//:/\\n}'
alias now='date +"%T"'
alias nowtime=now
alias nowdate='date +"%d-%m-%Y"'

#11: Control output of networking tool called ping
alias ping='ping -c 5'
# Do not wait interval 1 second, go fast #
alias fastping='ping -c 100 -s.2'


## https://unix.stackexchange.com/questions/252166/how-to-configure-zshrc-for-specfic-os
case `uname` in
  Darwin)
    # commands for OS X go here
    alias ql='qlmanage -p 2>/dev/null' # OS X Quick Look
    alias oo='open .' # open current directory in OS X Finder
    alias today='calendar -A 0 -f /usr/share/calendar/calendar.mark | sort'
    alias mailsize='du -hs ~/Library/mail'
    alias smart='diskutil info disk0 | grep SMART' # display SMART status of hard drive
    # Hall of the Mountain King
    alias cello='say -v cellos "di di di di di di di di di di di di di di di di di di di di di di di di di di"'
    # alias to show all Mac App store apps
    alias apps='mdfind "kMDItemAppStoreHasReceipt=1"'
    # reset Address Book permissions in Mountain Lion (and later presumably)
    alias resetaddressbook='tccutil reset AddressBook'
    # refresh brew by upgrading all outdated casks
    alias freshbrew='brew outdated | while read cask; do brew upgrade $cask; done'
    alias newbrew='brew install'
    # rebuild Launch Services to remove duplicate entries on Open With menu
    alias rebuildopenwith='/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.fram ework/Support/lsregister -kill -r -domain local -domain system -domain user'
    alias eog='open -a Preview'
    alias -s {png,jpg,bmp,PNG,JPG,BMP}=eog
  ;;
  Linux)
    # commands for Linux go here
    ## shortcut  for iptables and pass it via sudo#
    alias ipt='sudo /sbin/iptables'
    # display all rules #
    alias iptlist='sudo /sbin/iptables -L -n -v --line-numbers'
    alias iptlistin='sudo /sbin/iptables -L INPUT -n -v --line-numbers'
    alias iptlistout='sudo /sbin/iptables -L OUTPUT -n -v --line-numbers'
    alias iptlistfw='sudo /sbin/iptables -L FORWARD -n -v --line-numbers'
    alias firewall=iptlist
    # Debian and Ubuntu stuff
    #alias update="sudo apt-get update && sudo apt-get -y upgrade && sudo apt-get autoremove && sudo apt-get autoclean"
    alias dupdate="sudo apt-get update && sudo apt-get -y upgrade && sudo apt autoremove"
    alias apt-get="sudo apt-get"
    alias dpkg="sudo dpkg"
    #alias store="dpkg --get-selections > ~/.dotfiles/backups/packages.list"
    #alias restore="dpkg --get-selections < ~/.dotfiles/backups/packages.list && sudo apt-get -y update && sudo apt-get dselect-upgrade"
    #alias restore="apt-get install -y $(cat  ~/.dotfiles/backups/package.list | awk '{print $1}')"
# arch linux specipid
    alias pacup="sudo pacman -Syu" 
    alias aup="yaourt -Syu --aur" 
  ;;
  FreeBSD)
    # commands for FreeBSD go here
    alias doas='doas '
    alias make='make config-recursive install clean'
    alias fupdate='freebsd-update fetch-install'
    alias portsnap='portsnap fetch extract'
  ;;
esac

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

alias wiki='vim $HOME/Documents/Dropbox/Wiki/index.md'
