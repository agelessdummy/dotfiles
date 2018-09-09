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
zpm load trapd00r/zsh-syntax-highlighting-filetypes
zpm load zsh-users/zsh-syntax-highlighting
#zpm load MikeDacre/careful_rm
zpm load arzzen/calc.plugin.zsh
zpm load desyncr/auto-ls
zpm load sindresorhus/pretty-time-zsh 
zpm load skx/sysadmin-util
zpm load nviennot/zsh-vim-plugin
zpm load MichaelAquilina/zsh-you-should-use
#zpm load srijanshetty/zsh-pandoc-completion
zpm load dracula/zsh
zpm load bhilburn/powerlevel9k
# source ~/.local/share/zpm/plugins/powerlevel9k/powerlevel9k.zsh-theme
source ~/.local/share/zpm/bhilburn---powerlevel9k/powerlevel9k.zsh-theme
POWERLEVEL9K_MODE='nerdfont-complete'
zpm load zsh-users/zsh-completions
zpm load nachoparker/tab_list_files_zsh_widget
