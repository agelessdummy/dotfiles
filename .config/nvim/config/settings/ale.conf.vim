" change the signs
let g:ale_sign_error = '✖'
let g:ale_sign_warning = '⚠'

"For airline integrstion
"let g:airline#extensions#ale#error_symbol = '✖:'
"let g:airline#extensions#ale#warning_symbol = '⚠:'

" change the colors
"highlight clear ALEErrorSign
"highlight clear ALEWarningSign

let g:ale_fixers = {}
let g:ale_fixers['markdown'] = ['prettier']
let g:ale_fixers['latex'] = ['prettier']
let g:ale_fixers['javascript'] = ['prettier']
let g:ale_fixers['css'] = ['prettier']


let g:ale_linters = {
   \ 'zsh': ['shell'],
   \ 'bash': ['shell'],
   \ 'sh': [ 'language_server' ],
   \ 'latex': ['alex', 'vale'],
   \ 'markdown': [ 'alex', 'vale' ],
   \ 'reStucturedText': [ 'vale' ],
   \ 'Text^': [ 'vale' ],
   \ 'vim': ['vint'],
   \ 'cs':['syntax', 'semantic', 'issues'],
   \ 'python': ['pylint'],
   \ 'java': ['javac']
   \}

let g:ale_linter_aliases = {
    \ 'zsh': 'sh',
    \ 'bash': 'sh',
    \}


let g:ale_set_highlights = 1 " Set this in your vimrc file to disabling highlighting
let g:ale_list_window_size = 5  " Show 5 lines of errors (default: 10)
let g:ale_fix_on_save = 1   " Set this variable to 1 to fix files when you save them.
let g:ale_completion_enabled = 1    " Enable completion where available.
let g:ale_linters_explicit = 1  " Only run linters named in ale_linters settings.
" How can I keep the sign gutter open?
"let g:ale_sign_column_always = 1

"--- format for echo message
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'

"--- linters when file is saved
" Write this in your vimrc file
let g:ale_lint_on_text_changed = 'never'
" You can disable this option too
" if you don't want linters to run on opening a file
let g:ale_lint_on_enter = 0
"let g:ale_lint_on_enter = 1


let g:ale_javascript_prettier_options = '--single-quote --trailing-comma es5'
