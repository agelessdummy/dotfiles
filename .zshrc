# xero <x@xero.nu>
# http://code.xero.nu/dotfiles
# http://git.io/.files

# load configs
for config (~/.zsh/*.zsh) source $config

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

#---
#fpath=(~/.zsh/functions $fpath)
#fpath=(~/.zsh/functions "${fpath[@]}")
