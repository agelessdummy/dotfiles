" https://texwiki.texjp.org/?vimtex
" https://www.gregorykapfhammer.com/writing/tool/vim/2017/06/26/Neovim-Remote-Latex/
"https://wikimatze.de/vimtex-the-perfect-tool-for-working-with-tex-and-vim/

let g:tex_flavor = 'xelatex' " latex, pdflatex, xelatex,
let g:tex_conceal = ''

if has("nvim")
  let g:vimtex_latexmk_progname = 'nvr'
endif

let g:vimtex_complete_recursive_bib = 1
let g:vimtex_complete_enabled = 1
let g:vimtex_quickfix_method = 'pplatex'
let g:vimtex_quickfix_mode = 0

let g:vimtex_enabled = 1
"let g:vimtex_view_general_viewer = 'open'
"let g:vimtex_view_general_options = '@line @pdf @tex'
let g:vimtex_latexmk_continuous = 1
let g:vimtex_latexmk_background = 1
let g:vimtex_latexmk_options = '-pdf'
let g:vimtex_latexmk_options = '-pdfdvi'
let g:vimtex_latexmk_options = '-pdfps'
let g:vimtex_view_general_options = '@line @pdf @tex'

let g:vimtex_view_method = 'okular'
