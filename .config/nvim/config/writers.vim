" https://josh.blog/2017/04/writing-mode-vim
abbr wp call Wp()
fun! Wp()
    setlocal formatoptions=1 
    setlocal noexpandtab 
    set complete+=s
    set formatprg=par
    setlocal wrap 
    setlocal linebreak 
    autocmd! User PomodoroStart WritingNow
    autocmd! User GoyoEnter Limelight
    autocmd! User GoyoLeave Limelight!
    autocmd! User goyo.vim echom 'Goyo is now loaded!'
endfu
