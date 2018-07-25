let g:grammarous#default_comments_only_filetypes = {
            \ '*' : 1, 'help' : 0, 'markdown' : 0,
            \ }
" How are rules added to the default rule set?
"let g:grammarous#enabled_rules = {'*' : ['PASSIVE_VOICE']}

" Some rules annoy me.
"let g:grammarous#disabled_rules = {
            \ '*' : ['WHITESPACE_RULE', 'EN_QUOTES'],
            \ 'help' : ['WHITESPACE_RULE', 'EN_QUOTES', 'SENTENCE_WHITESPACE', 'UPPERCASE_SENTENCE_START'],
            \ }

" How do I use this plugin with vim's spelllang?
let g:grammarous#use_vim_spelllang = 1  " Default 0, to enable 1.

" I want to use above <Plug> mappings only after checking.
let g:grammarous#hooks = {}
function! g:grammarous#hooks.on_check(errs) abort
    nmap <buffer><C-n> <Plug>(grammarous-move-to-next-error)
    nmap <buffer><C-p> <Plug>(grammarous-move-to-previous-error)
endfunction

function! g:grammarous#hooks.on_reset(errs) abort
    nunmap <buffer><C-n>
    nunmap <buffer><C-p>
endfunction

" I want to see the first error in an information window soon after :GrammarousCheck
"set g:grammarous#show_first_error = 0   " 0 = disable, 1 = enable

" I want to use a location list to jump among errors
let g:grammarous#use_location_list = 1  " 0 = disable, 1 = enable
