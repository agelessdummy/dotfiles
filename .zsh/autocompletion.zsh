fpath=("$HOME/.zsh/functions"
    "$HOME/.zsh/completions"
    "${fpath[@]}"
    )

autoload $(ls $HOME/.zsh/functions)

autoload -Uz compinit && compinit

zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=2 eval "$(dircolors -b)"
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

# https://superuser.com/questions/160750/can-zsh-do-2-stage-completion
zstyle ':completion:*' insert-unambiguous true
zstyle ':completion:*' menu select=1 interactive

#---
#https://wiki.archlinux.org/index.php/Zsh
# Persistent rehash
zstyle ':completion:*' rehash true

# help
autoload -Uz run-help
#unalias run-help
alias help=run-help
autoload -Uz run-help-git
autoload -Uz run-help-ip
autoload -Uz run-help-openssl
autoload -Uz run-help-p4
autoload -Uz run-help-sudo
autoload -Uz run-help-svk
autoload -Uz run-help-svn

setopt COMPLETE_ALIASES
#---
# vim deoplete-zsh
zmodload zsh/zpty

#---
# https://www.dustri.org/b/my-zsh-configuration.html
watch=all                       # watch all logins
logcheck=30                     # every 30 seconds
WATCHFMT="%n from %M has %a tty%l at %T %W"

#--
# https://wiki.gentoo.org/wiki/Zsh/Guide
zstyle ':completion:*:descriptions' format '%U%B%d%b%u'
zstyle ':completion:*:warnings' format '%BSorry, no matches for: %d%b' 
#setopt correctall

zstyle ':completion::complete:*' use-cache 1


#---
setopt INC_APPEND_HISTORY SHARE_HISTORY
setopt APPEND_HISTORY
setopt MENUCOMPLETE
setopt ALL_EXPORT

# Set/unset  shell options
setopt   -o sharehistory
setopt   completealiases
setopt   notify globdots correct pushdtohome cdablevars autolist
setopt   correctall autocd recexact longlistjobs
setopt   autoresume histignoredups pushdsilent
setopt   autopushd pushdminus extendedglob rcquotes mailwarning
unsetopt bgnice autoparamslash
