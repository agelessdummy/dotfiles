augroup vimrc_autocmd "{
" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

autocmd FileType java setlocal noexpandtab
autocmd FileType java setlocal list
autocmd FileType java setlocal listchars=tab:+\ ,eol:-
autocmd FileType java setlocal formatprg=par\ -w80\ -T4
autocmd FileType php setlocal expandtab
autocmd FileType php setlocal list
autocmd FileType php setlocal listchars=tab:+\ ,eol:-
autocmd FileType php setlocal formatprg=par\ -w80\ -T4
autocmd FileType ruby setlocal tabstop=2
autocmd FileType ruby setlocal shiftwidth=2
autocmd FileType ruby setlocal softtabstop=2
autocmd FileType ruby setlocal commentstring=#\ %s
autocmd FileType python setlocal commentstring=#\ %s
autocmd BufEnter *.cls setlocal filetype=java
autocmd BufEnter *.zsh-theme setlocal filetype=zsh
autocmd BufEnter Makefile setlocal noexpandtab
autocmd BufEnter *.sh setlocal tabstop=2
autocmd BufEnter *.sh setlocal shiftwidth=2
autocmd BufEnter *.sh setlocal softtabstop=2
autocmd BufEnter *i3/config setlocal filetype=i3

  " Except... on Markdown. That's good stuff.
autocmd FileType markdown setlocal wrap
autocmd FileType html setlocal wrap

"au! BufNewFile,BufFilePre,BufRead *.md set filetype=markdown.pandoc
"autocmd! BufNewFile,BufFilePRe,BufRead *.{markdown,mdown,mkd,mkdn,mmd,md} setlocal filetype=markdown.pandoc
autocmd! BufNewFile,BufFilePRe,BufRead *.{markdown,mdown,mkd,mkdn,mmd,md} setf markdown.pandoc
autocmd FileType markdown TableModeEnable
"autocmd FileType markdown WritegoodEnable

" typewriter and GOYO
" Change the cursor from block to i-beam in INSERT mode
let &t_SI = "\e[5 q"
let &t_EI = "\e[1 q"
augroup myCmds
  au!
  autocmd VimEnter * silent !echo -ne "\e[1 q"
augroup END

" VimTex Buffer variable
autocmd FileType tex let b:vimtex_main = 'main.tex'

"--- Functions
" Remove trailing whitespaces and ^M chars
"function! StripTrailingWhitespace()
"  " Preparation: save last search, and cursor position.
"  let _s=@/
"  let l = line(".")
"  let c = col(".")
"  " do the business:
"  %s/\s\+$//e
"  " clean up: restore previous search history, and cursor position
"  let @/=_s
"  call cursor(l, c)
"endfunction
"autocmd FileType c,cpp,java,md,tex,go,php,javascript,javascript.jsx,coffee,jade,stylus,css,puppet,python,rust,twig,xml,yml,perl,sql autocmd BufWritePre <buffer> call StripTrailingWhitespace()

"au FileType tex,mmd,md,markdown,html,text $HOME/.config/nvim/config/words/abbrev.vim 
"au FileType tex,mmd,md,markdown,html,txt ~/.config/nvim/config/words/abbrev.vim 

" AutoSave
"autocmd TextChanged,TextChangedI <buffer> silent write
"autocmd CursorHold,TextChanged,TextChangedI <buffer> silent write
"au FocusLost * silent! wa

"https://www.linux.com/learn/vim-tips-folding-fun
"au BufWinLeave * mkview
"au BufWinEnter * silent loadview

" use TAB for everythihng (deoplete)
"autocmd FileType javascript let g:SuperTabDefaultCompletionType = "<c-x><c-o>"
autocmd FileType * let g:SuperTabDefaultCompletionType = "<c-x><c-o>"
let g:UltiSnipsExpandTrigger="<C-j>"
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"

"--- Writєr's Write, all of the time
" https://josh.blog/2017/04/writing-mode-vim
" http://vim.wikia.com/wiki/Word_wrap_without_line_breaks
func! Wp()
    setlocal formatoptions=1 
    setlocal noexpandtab 
    set complete+=s
    "set formatprg=par
    setlocal wrap 
    setlocal linebreak 
    set nolist " list disables linebreaks
    set textwidth=0
    set wrapmargin=0
    " If you want to keep your existing 'textwidth',no Vim automatically reformat when typing on existing lines:
    "set formatoptions-=t
    " If you want Vim to adjust textwidth automatically most of the time but you have a few long lines that you don't want to change:
    set formatoptions+=l
    autocmd! User PomodoroStart WritingNow
    "autocmd! User GoyoEnter Limelight
    "autocmd! User GoyoLeave Limelight!
    "autocmd! User goyo.vim echom 'Goyo is now loaded!'
endfu
com! Prose call Wp()
"---

"--- let's make some textmode art!
"function! AsciiMode()
"  e ++enc=cp850
"  set nu!
"  set virtualedit=all
"  "set colorcolumn=80
"endfunction
"com! Ascii call AsciiMode()
"---

augroup END "}
