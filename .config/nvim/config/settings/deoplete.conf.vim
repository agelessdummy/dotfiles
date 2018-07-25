let g:deoplete#enable_at_startup = 1

" play nice with multiple omnifunctions provided by third-party plugins
let g:deoplete#omni#functions = {}

let g:deoplete#sources = {}
let g:deoplete#sources.gitcommit=['github']

let g:deoplete#keyword_patterns = {}
let g:deoplete#keyword_patterns.gitcommit = '.+'

"call deoplete#util#set_pattern(
"  \ g:deoplete#omni#input_patterns,
"  \ 'gitcommit', [g:deoplete#keyword_patterns.gitcommit])
