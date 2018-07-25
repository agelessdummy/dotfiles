if [[ -f ~/.zpm/zpm.zsh ]]; then
	source ~/.zpm/zpm.zsh
else
	git clone --recursive https://github.com/horosgrisa/zpm ~/.zpm
	source ~/.zpm/zpm.zsh
fi

#---
# Pluggins
zpm load zsh-users/zsh-completions
zpm load Updating ninrod/pass-zsh-completion
zpm load Updating srijanshetty/zsh-pandoc-completion
#zpm load horosgrisa/zsh-dropbox 
#zpm load d12frosted/cabal.plugin.zsh
zpm load ehamberg/zsh-cabal-completion
zpm load nviennot/zsh-vim-plugin
zpm load gko/ssh-connect
zpm load KasperChristensen/mylocation
zpm load wfxr/forgit
#zpm load zsh-users/zsh-syntax-highlighting
zpm load zdharma/fast-syntax-highlighting
#zpm load MikeDacre/careful_rm
zpm load arzzen/calc.plugin.zsh
zpm load desyncr/auto-ls
zpm load sindresorhus/pretty-time-zsh 
zpm load skx/sysadmin-util
zpm load nviennot/zsh-vim-plugin
zpm load MichaelAquilina/zsh-you-should-use
#zpm load srijanshetty/zsh-pandoc-completion
zpm load dracula/zsh
