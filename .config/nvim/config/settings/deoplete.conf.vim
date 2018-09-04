let g:deoplete#enable_at_startup = 1
let g:deoplete#auto_complete_start_length = 1

call deoplete#custom#source(
    \ 'dictionary', 'matchers', ['matcher_head'])
call deoplete#custom#source(
    \ 'dictionary', 'sorters', [''])
call deoplete#custom#source(
    \ 'dictionary','min_pattern_length', 4)

" play nice with multiple omnifunctions provided by third-party plugins
"let g:deoplete#omni#functions = {}

"let g:deoplete#sources = {}
"let g:deoplete#sources.gitcommit=['github']

"let g:deoplete#keyword_patterns = {}
"let g:deoplete#keyword_patterns.gitcommit = '.+'

"call deoplete#util#set_pattern(
"  \ g:deoplete#omni#input_patterns,
"  \ 'gitcommit', [g:deoplete#keyword_patterns.gitcommit])


" Don't forget to start deoplete let g:deoplete#enable_at_startup = 1 " Less spam let g:deoplete#auto_complete_start_length = 2 
" Use smartcase
let g:deoplete#enable_smart_case = 1

" Setup completion sources
let g:deoplete#sources = {}

"--- webcomplete 
" Use <C-X><C-U> in insert mode to get completions
"set completefunc=webcomplete#complete

" Use <C-X><C-O> in insert mode to get completions
set omnifunc=webcomplete#complete

"--- github
let g:deoplete#sources = {}
let g:deoplete#sources.gitcommit=['github']

let g:deoplete#keyword_patterns = {}
let g:deoplete#keyword_patterns.gitcommit = '.+'

"call deoplete#util#set_pattern(
"  \ g:deoplete#omni#input_patterns,
"  \ 'gitcommit', [g:deoplete#keyword_patterns.gitcommit])

"--- 


"---
"--- use TAB as the mapping
inoremap <silent><expr> <TAB>
    \ pumvisible() ?  "\<C-n>" :
    \ <SID>check_back_space() ? "\<TAB>" :
    \ deoplete#mappings#manual_complete()
function! s:check_back_space() abort "" {{{
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~ '\s'
endfunction "" }}}

"inoremap <silent><expr><CR> pumvisible() ? deoplete#mappings#close_popup()."\<Plug>(neosnippet_expand_or_jump)" : "\<CR>"
