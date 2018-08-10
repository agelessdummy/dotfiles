let g:lightline = {
\ 'mode_map': { 'c': 'NORMAL' },
\ 'colorscheme': 'iceberg',
\ 'active': {
\   'left': [ [ 'mode', 'paste' ],
\             [ 'readonly', 'filename', 'modified', 'Tomotoe', ] ],
\   'right': [ [ 'lineinfo', 'wordcount', ],
\              [ 'filetype',  'linter_warnings', 'linter_errors', 'linter_ok' ] ]
\ },
\   'tabline': {
\     'left': [ [ 'tabs', 'buffers'] ],
\     'right': [ [ 'folder','close' ] ]
\   },
\   'tab': {
\     'active': [ 'tabnum' ],
\     'inactive': [ 'tabnum' ]
\   },
\   'component_expand': {
\    'linter_warnings': 'LightlineLinterWarnings',
\    'linter_errors': 'LightlineLinterErrors',
\    'linter_ok': 'LightlineLinterOK',
\    'buffers': 'lightline#bufferline#buffers'
\   },
\ 'component_type': {
\    'readonly': 'error',
\    'linter_warnings': 'warning',
\    'linter_error': 'error',
\    'buffers': 'tabsel'
\ },
\   'component': {
\     'lineinfo': '%l/%L',
\   },
\ 'component_function': {
\   'Tomotoe': 'PomodoroStatus',
\   'readonly': 'LightlineReadonly',
\   'filename': 'LightlineFilename',
\   'fileformat': 'LightlineFileformat',
\   'filetype': 'LightlineFiletype',
\   'wordcount': 'WordCount',
\   'mode': 'MyMode',
\ },
\ }
let g:lightline.separator = {
\   'left': '', 'right': ''
\ }
let g:lightline.subseparator = {
\   'left': '', 'right': '' 
\ }
"---
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
"----
function! LightlineFilename()
    " Get the full path of the current file.
    let filepath =  expand('%:p')
    let modified = &modified ? ' +' : ''
    " If the filename is empty, then display nothing as appropriate.
    if empty(filepath)
        return '[No Name]' . modified
    endif
    " Find the correct expansion depending on whether Vim has autochdir.
    let mod = (exists('+acd') && &acd) ? ':~' : ':~:.'
    " Apply the above expansion to the expanded file path and split by the separator.
    let shortened_filepath = fnamemodify(filepath, mod)
    if len(shortened_filepath) < 45
        return shortened_filepath.modified
    endif
    " Ensure that we have the correct slash for the OS.
    let dirsep = has('win32') && ! &shellslash ? '\\' : '/'
    " Check if the filepath was shortened above.
    let was_shortened = filepath != shortened_filepath
    " Split the filepath.
    let filepath_parts = split(shortened_filepath, dirsep)
    " Take the first character from each part of the path (except the tidle and filename).
    let initial_position = was_shortened ? 0 : 1
    let excluded_parts = filepath_parts[initial_position:-2]
    let shortened_paths = map(excluded_parts, 'v:val[0]')
    " Recombine the shortened paths with the tilde and filename.
    let combined_parts = shortened_paths + [filepath_parts[-1]]
    let combined_parts = (was_shortened ? [] : [filepath_parts[0]]) + combined_parts
    " Recombine into a single string.
    let finalpath = join(combined_parts, dirsep)
    return finalpath . modified
endfunction
"---
function! LightlineFileformat()
    return winwidth(0) > 70 ? &fileformat : ''
endfunction
"---
function! LightlineFiletype()
    return winwidth(0) > 70 ? (&filetype !=# '' ? &filetype : 'no ft') : ''
endfunction
"---
function! LightlineFilename()
  let filename = expand('%:t') !=# '' ? expand('%:t') : '[No Name]'
  let modified = &modified ? ' +' : ''
  return filename . modified
endfunction
"----
function! LightlineReadonly()
  return &readonly && &filetype !~# '\v(help|vimfiler|unite)' ? 'RO' : ''
endfunction
"---
function! LightlineLinterWarnings() abort
    let l:counts = ale#statusline#Count(bufnr(''))
    let l:all_errors = l:counts.error + l:counts.style_error
    let l:all_non_errors = l:count.total - l:all_errors
    return l:counts.total == 0 ? '': printf('%d ', all_non_errors)
endfunction
"---
function! LightlineLinterErrors() abort
    let l:counts = ale#statusline#Count(bufnr(''))
    let l:all_errors = l:counts.error + l:counts.style_error
    let l:all_non_errors = l:counts.total - l:all_errors
    return l:counts.total == 0 ? '' : printf('%d ', all_errors)
endfunction
"---
function! LightlineLinterOK() abort
        let l:counts = ale#statusline#Count(bufnr(''))
    let l:all_errors = l:counts.error + l:counts.style_error
    let l:all_non_errors = l:counts.total - l:all_errors
    return l:counts.total == 0 ? '' : ''
endfunction
"---
"use lightline but not in goyo
autocmd User ALELint call s:MaybeUpdateLightline()
function! s:MaybeUpdateLightline()
    if exists('#lightline')
        call lightline#update()
    end
endfunction
"---
function! MyMode()
  return winwidth('.') > 60 ? lightline#mode() : ''
endfunction
"---
let g:unite_force_overwrite_statusline = 0
let g:vimfiler_force_overwrite_statusline = 0
let g:lightline#bufferline#enable_devicons = 1

let g:lightline#ale#indicator_checking = "\uf110"
let g:lightline#ale#indicator_warnings = "\uf071"
let g:lightline#ale#indicator_errors = "\uf05e"
let g:lightline#ale#indicator_ok = "\uf00c"

" lightline-buffer ui settings
" replace these symbols with ascii characters if your environment does not support unicode
let g:lightline_buffer_logo = ' '
let g:lightline_buffer_readonly_icon = ''
let g:lightline_buffer_modified_icon = '✭'
let g:lightline_buffer_git_icon = ' '
let g:lightline_buffer_ellipsis_icon = '..'
let g:lightline_buffer_expand_left_icon = '◀ '
let g:lightline_buffer_expand_right_icon = ' ▶'
let g:lightline_buffer_active_buffer_left_icon = ''
let g:lightline_buffer_active_buffer_right_icon = ''
let g:lightline_buffer_separator_icon = '  '
" enable devicons, only support utf-8
" require <https://github.com/ryanoasis/vim-devicons>
let g:lightline_buffer_enable_devicons = 1
" lightline-buffer function settings
let g:lightline_buffer_show_bufnr = 1
" :help filename-modifiers
let g:lightline_buffer_fname_mod = ':t'
" hide buffer list
let g:lightline_buffer_excludes = ['vimfiler']
" max file name length
let g:lightline_buffer_maxflen = 30
" max file extension length
let g:lightline_buffer_maxfextlen = 3
" min file name length
let g:lightline_buffer_minflen = 16
" min file extension length
let g:lightline_buffer_minfextlen = 3
" reserve length for other component (e.g. info, close)
let g:lightline_buffer_reservelen = 20

set showtabline=2  " Show tabline
set guioptions-=e  " Don't use GUI tabline
