""--- WebSites
" https://www.cyfyifanchen.com/neovim-true-color/
" https://github.com/NLKNguyen/papercolor-theme

"set background=light
set background=dark

" For Neovim 0.1.3 and 0.1.4
let $NVIM_TUI_ENABLE_TRUE_COLOR=1
"let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1

" Or if you have Neovim >= 0.1.5
if (has("termguicolors"))
    set termguicolors
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"

    " Change cursor shape based on mode
    let &t_SI = "\<Esc>[6 q"
    let &t_SR = "\<Esc>[4 q"
    let &t_EI = "\<Esc>[2 q"
endif

"set guifont=Source\ Code\ Pro\ for\ Powerline\ 12
"set guifont=Source\ Code\ Pro\ for\ Powerline "make sure to escape the spaces in the name properly
"set antialias                                                                                               
let g:Powerline_symbols = 'fancy'
set guicursor+=a:blinkon0   " disable cursor blink

"colorscheme dracula

colorscheme iceberg

"colorscheme challenger_deep
"let g:challenger_deep_termcolors = 256

" PromptLine Theme
let g:airline_theme = 'jellybeans'
" papercolor
" jellybeans
" bubblegum
" molokai
" murmur
" wombat
" deus
" solarized
" let g: airline_solarized_bg=''    " dark or light


if !has('gui_running')
  set t_Co=256
endif

