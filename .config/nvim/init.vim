" https://www.gregjs.com/vim/2016/do-yourself-a-favor-and-modularize-your-vimrc-init-vim/

"runtime config/plugings.vim	" vim-plug
runtime config/general.vim	" the vim/neovim config
runtime! config/settings/*.conf.vim	" plugin config
runtime config/keys.vim	" custon key-bindings
runtime config/color.vim	" color config
"runtime config/writers.vim	" writers config
runtime config/autocmd.vim	" autocmd config
runtime config/line.vim	" statusline config
runtime config/vimawesome.vim
"runtime config/templates.vim  " templates files
"runtime! config/templates/*.temp    " templates
