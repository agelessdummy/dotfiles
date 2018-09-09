""--- WebSites
" https://www.cyfyifanchen.com/neovim-true-color/
" https://github.com/NLKNguyen/papercolor-theme

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


colorscheme dracula
"colorscheme iceberg
"colorscheme challenger_deep
"let g:challenger_deep_termcolors = 256
"colorscheme typewriter


" PromptLine Theme
"let g:airline_theme = 'jellybeans'
let g:airline_theme = 'typewriter'
" papercolor
" jellybeans
" bubblegum
" molokai
" murmur
" wombat
" deus
" solarized
" let g: airline_solarized_bg=''    " dark or light

if has("gui_running")
        echo "yes, we have a GUI"
        set background=dark     "light
        "set antialias                                                                                               
        let g:Powerline_symbols = 'fancy'
        "set guicursor+=a:blinkon0   " disable cursor blink
        set guioptions-=e
        if has("gui_gtk2") || has("gui_gtk3")
        set guifont=Sauce\ Code\ Pro\ Nerd\ Font\ Complete\ 12
        if has("gui_mac")
        set guifont=Sauce\ Code\ Pro\ Nerd\ Font\ Complete: 12
        elseif has("x11")
	    " Also for GTK 1
	    set guifont=*-lucidatypewriter-medium-r-normal-*-*-180-*-*-m-*-*
        elseif has("gui_win32")
	    set guifont=Luxi_Mono:h12:cANSI
        endif
    else
        echo "Boring old console"
        set t_Co=256
        set background=dark " light
    endif
endif



