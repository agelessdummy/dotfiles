"--- WebSites
" https://shapeshed.com/vim-templates/
" https://www.tecmint.com/create-custom-header-template-for-shell-scripts-in-vim
"-------------

if has("autocmd")
  augroup templates
    autocmd BufNewFile *.sh 0r condfig/templates/sh.temp
    autocmd BufNewFile *.sh 0r condfig/templates/tex.temp
    autocmd BufNewFile *.sh 0r condfig/templates/md.temp
  augroup END
endif
