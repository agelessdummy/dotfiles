" https://shapeshed.com/vim-statuslines/
" https://stackoverflow.com/questions/114431/fast-word-count-function-in-vim
" http://vimdoc.sourceforge.net/htmldoc/options.html#%27statusline%27
" https://superuser.com/questions/365320/how-to-show-the-current-column-in-the-statusbar-in-vim
" http://got-ravings.blogspot.com/2008/08/vim-pr0n-making-statuslines-that-own.html
" http://got-ravings.blogspot.com/search/label/statuslines
" https://github.com/scrooloose/vimfiles/blob/master/vimrc#L78
" https://github.com/blaenk/dots/blob/9843177fa6155e843eb9e84225f458cd0205c969/vim/vimrc.ln#L49-L64 
" https://www.blaenkdenum.com/posts/a-simpler-vim-statusline/ 
" https://gabri.me/blog/diy-vim-statusline/ 
" https://hackernoon.com/the-last-statusline-for-vim-a613048959b2
" http://www.nkantar.com/blog/my-vim-statusline
" `https://cromwell-intl.com/open-source/vim-word-count.html
"https://gist.github.com/cormacrelf/d0bee254f5630b0e93c3
"----------------------------------
" runtime! config/statLine/*.vim  " fuctions

"--- Functions
"Linter Status
function! LinterStatus() abort
   let l:counts = ale#statusline#Count(bufnr(''))
   let l:all_errors = l:counts.error + l:counts.style_error
   let l:all_non_errors = l:counts.total - l:all_errors
   return l:counts.total == 0 ? '' : printf(
   \ 'W:%d E:%d',
   \ l:all_non_errors,
   \ l:all_errors
   \)
endfunction

"File Size
function! FileSize() abort
    let l:bytes = getfsize(expand('%p'))
    if (l:bytes >= 1024)
        let l:kbytes = l:bytes / 1025
    endif
    if (exists('kbytes') && l:kbytes >= 1000)
        let l:mbytes = l:kbytes / 1000
    endif
 
    if l:bytes <= 0
        return '0'
    endif
  
    if (exists('mbytes'))
        return l:mbytes . 'MB '
    elseif (exists('kbytes'))
        return l:kbytes . 'KB '
    else
        return l:bytes . 'B '
    endif
endfunction
"Read Only
function! ReadOnly() abort
  if &readonly || !&modifiable
    return ''
  else
    return ''
endfunction

" Paste
function! PasteForStatusline()
    let paste_status = &paste
    if paste_status == 1
        return " [paste] "
    else
        return ""
    endif
endfunction

"Word Count
"let g:word_count="<unknown>"
"function WordCount()
"	return g:word_count
"endfunction
"function UpdateWordCount()
"	let lnum = 1
"	let n = 0
"	while lnum <= line('$')
"		let n = n + len(split(getline(lnum)))
"		let lnum = lnum + 1
"	endwhile
"	let g:word_count = n
"endfunction
"" Update the count when cursor is idle in command or insert mode.
"" Update when idle for 1000 msec (default is 4000 msec).
"set updatetime=1000
"augroup WordCounter
"	au! CursorHold,CursorHoldI * call UpdateWordCount()
"augroup END

function! WordCount()
    let currentmode = mode()
    if !exists("g:lastmode_wc")
        let g:lastmode_wc = currentmode
    endif
    " if we modify file, open a new buffer, be in visual ever, or switch modes
    " since last run, we recompute.
    if &modified || !exists("b:wordcount") || currentmode =~? '\c.*v' || currentmode != g:lastmode_wc
        let g:lastmode_wc = currentmode
        let l:old_position = getpos('.')
        let l:old_status = v:statusmsg
        execute "silent normal g\<c-g>"
        if v:statusmsg == "--No lines in buffer--"
            let b:wordcount = 0
        else
            let s:split_wc = split(v:statusmsg)
            if index(s:split_wc, "Selected") < 0
                let b:wordcount = str2nr(s:split_wc[11])
            else
                let b:wordcount = str2nr(s:split_wc[5])
            endif
            let v:statusmsg = l:old_status
        endif
        call setpos('.', l:old_position)
        return b:wordcount
    else
        return b:wordcount
    endif
endfunction

"Weather
"fuction! Weather()

"Ale Linters
function! LinterStatus() abort
    let l:counts = ale#statusline#Count(bufnr(''))

    let l:all_errors = l:counts.error + l:counts.style_error
    let l:all_non_errors = l:counts.total - l:all_errors

    return l:counts.total == 0 ? 'OK' : printf(
    \   '%dW %dE',
    \   all_non_errors,
    \   all_errors
    \)
endfunction

set statusline=%{LinterStatus()}

"--- Lines
" statusline
" cf the default statusline: %<%f\ %h%m%r%=%-14.(%l,%c%V%)\ %P
" format markers:
"   %< truncation point
"   %n buffer number
"   %f relative path to file
"   %m modified flag [+] (modified), [-] (unmodifiable) or nothing
"   %r readonly flag [RO]
"   %y filetype [ruby]
"   %= split point for left and right justification
"   %-35. width specification
"   %l current line number
"   %L number of lines in buffer
"   %c current column number
"   %V current virtual column number (-n), if different from %c
"   %P percentage through buffer
"   %) end of width specification

"set statusline=
"set statusline+=%<\                       " cut at start
"set statusline+=%2*[%n%H%M%R%W]%*\        " flags and buf no
"set statusline+=%-40f\   " path
"set statusline+=%m  "
"" switching to right side
"set statusline+=%=
"" set statusline+=%l  " 
"" set statusline+=%L  "
"set statusline+=%=%1*%y%*%*\              " file type
"set statusline+=%10((LN{%l/%L},%c)%)\            " line and column
"set statusline+=%P                        " percentage of file
""set statusline+=%n   " buffer number

set statusline=
set statusline+=\ %*
set statusline+=\ ‹‹
set statusline+=\ %#ErrorMsg#%{PomodoroStatus()}%#StatusLine# 
set statusline+=\ %.20F
"set statusline+=\ %F           " full path name
"set statusline+=\ %t\                   " short file name
set statusline+=\ %{FileSize()}
set statusline+=\ %{ReadOnly()}
set statusline+=\ ››
set statusline+=\ %m

set statusline+=%=

"set statusline+=%{PasteForStatusline()}       " paste flag
"set statusline+=\[%{mode()}\]                 " current mode
"set statusline+=\ %y
set statusline+=\ %Y\                   " file type
set statusline+=%#keyword#\%{strftime(\"%l:%M:%S\ \%p,\ %a\ %b\ %d,\ %Y\")}
"set statusline+=\ %<%f%h%m%r%=%{strftime(\"%l:%M:%S\ \%p,\ %a\ %b\ %d,\ %Y\")}
set statusline+=\                             " blank space

set statusline+=\ %*
set statusline+=\ ‹‹

set statusline+=\ %#DiffAdd#%{(mode()=='n')?'\ \ NORMAL\ ':''}
set statusline+=\ %#DiffChange#%{(mode()=='i')?'\ \ INSERT\ ':''}
set statusline+=\ %#DiffDelete#%{(mode()=='r')?'\ \ RPLACE\ ':''}
set statusline+=\ %#Cursor#%{(mode()=='v')?'\ \ VISUAL\ ':''}
set statusline+=\ %10((%l/%L)%)\ LN,             " {current line/total lines} column
set statusline+=\ %{WordCount()}\ WC,
set statusline+=\ %n\ BUF           " buffer number
set statusline+=\ %#Visual#       " colour
set statusline+=\ %{&paste?'\ PASTE\ ':''}
set statusline+=\ %{&spell?'\ SPELL\ ':''}
set statusline+=\ %#CursorIM#     " colour
set statusline+=\ %#warningmsg#    " linters error flag
set statusline+=\ %{LinterStatus()}    " linters error flag
"set statusline+=\ %{FugitiveStatusline()}  " indicator with currect branch
set statusline+=%*                            " linters error flag
set statusline+=\ ››\ %*
