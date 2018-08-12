" https://github.com/bigeagle/neovim-config/blob/master/init.vim
" https://robots.thoughtbot.com/vim-spell-checking
" http://ryrych.pl/2015/12/12/markdown-long-urls-that-play-nicely-with-80-character-line-length.html
" https://www.linuxquestions.org/questions/fedora-35/wanted-fedora%27s-default-bashrc-and-vimrc-files-834884/
" https://github.com/junegunn/vim-plug/wiki/tips#automatic-installation
" https://www.ukuug.org/events/linux2004/programme/paper-SMyers/Linux_2004_slides/vim_tips/
" https://defuse.ca/vimrc.htm
" http://learnvimscriptthehardway.stevelosh.com/chapters/06.html
" http://gabekoss.com/blog/2013/11/writing_with_vim/
" https://www.electricmonk.nl/log/2012/07/26/persistent-undo-history-in-vim/
" https://www.swamphogg.com/2015/vim-setup/
" http://www.naperwrimo.org/wiki/index.php?title=Vim_for_Writers
" https://coderwall.com/p/sdhfug/vim-swap-backup-and-undo-files
" https://linux-audit.com/using-encrypted-documents-with-vim
" http://spf13.com/post/perfect-vimrc-vim-config-file/
" http://www.slackorama.com/projects/vim/vimrc.html 
" https://github.com/Slackwise/dotfiles/blob/master/vim/vimrc
" http://vimcasts.org/episodes/accessing-the-system-clipboard-from-vi
" http://www.guckes.net/vim/setup.html 
" https://github.com/bigchirv/neovim-distribution
" http://hacktux.com/vim/spellcheck
" https://unix.stackexchange.com/questions/44616/why-is-vim-creating-files-with-dos-line-endings
" https://gist.github.com/napcs/532968
" https://www.shortcutfoo.com/blog/top-50-vim-configuration-options/
"------------ OS --------------"
" Fedora: dnf -y install neovim python2-neovim python3-neovim
" Arch Linux: sudo pacman -S neovim python2-neovim python-neovim
" Debian: sudo apt-get install neovim neovim-qt5
" MacOS Brew: brew install neovim
" FreeBSD: pkg install neovim
"
" 
" init.vim ("vimrc"): If you already have Vim installed you can copy %userprofile%\_vimrc to %userprofile%\AppData\Local\nvim\init.vim to use your Vim config with Neovim.
"----------------


let g:python_host_prog='/usr/bin/python3'

set nocompatible
filetype plugin indent on
set omnifunc=syntaxcomplete#Complete

runtime macros/matchit.vim

"--- http://stevelosh.com/blog/2010/09/coming-home-to-vim/#important-vimrc-lines
set modelines=0		"The modelines bit prevents some security exploits having to do with modelines in files. I never use modelines so I don’t miss any functionality here.

set hidden	" allow backgroumd buffers without saving

set iskeyword-=.                    " '.' is an end of word designator
set iskeyword-=#                    " '#' is an end of word designator
set iskeyword-=-                    " '-' is an end of word designator

set spell spelllang=en
set complete+=s,kspell
"faster keyword completion
set complete-=i   " disable scanning included files
set complete-=t   " disable searching tags
"set spellsuggest=15
set spellsuggest=5
set spellfile=$HOME/.config/nvim/config/words/en.utf-8.add
set spellfile=$HOME/.config/nvim/config/words/es.utf-8.add
set thesaurus+=$HOME/.config/nvim/config/words/thesaurus/mthesaur.txt
set thesaurus+=$HOME/.config/nvim/config/words/thesaurus/roget13a.txt
"-- http://usevim.com/2012/07/06/vim101-completion/
set dictionary=/usr/share/dict/words
set dictionary=$HOME/.config/words/spelling/en_US-large.txt
set dictionary=$HOME/.config/words/spelling/en_GB-large.txt
set dictionary=$HOME/.config/words/spelling/List-of-Dirty-Naughty-Obscene-and-Otherwise-Bad-Words/en.txt
set dictionary=$HOME/.config/words/spelling/List-of-Dirty-Naughty-Obscene-and-Otherwise-Bad-Words/es.txt
"runtime config/words/abbrev.vim
  
" http://hacktux.com/vim/spellcheck
" Vim Spell Colors
highlight clear SpellBad
highlight SpellBad term=standout ctermfg=1 term=underline cterm=underline
highlight clear SpellCap
highlight SpellCap term=underline cterm=underline
highlight clear SpellRare
highlight SpellRare term=underline cterm=underline
highlight clear SpellLocal
highlight SpellLocal term=underline cterm=underline

" nvr for VimTex
"nvr --remote-silent %f -c %l

" Disable unsafe commands.
" http://andrew.stwrt.ca/posts/project-specific-vimrc/
set exrc            " enable per-directory .vimrc files
set secure          " disable unsafe commands in local .vimrc files

set splitright	" Split to right by default
set splitbelow  " Split to below by default


set foldcolumn=1
set foldenable                  " Auto fold code
"" fold methods:
""manual	    Folds are created manually.
""indent	    Lines with equal indent form a fold.
""expr	    'foldexpr' gives the fold level of a line.
""marker	    Markers are used to specify folds.
""syntax	    Syntax highlighting items specify folds.
""diff	    Fold text that is not changed.
set foldmethod=syntax                         " Uses {{{ and }}} as foldmarkers
set foldopen-=search
set foldlevelstart=99 "open all folds by default

"--- Install vim-plug if it is not installed
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  execute '!curl --create-dirs -fLo ~/.config/nvim/autoload/plug.vim https://raw.github.com/junegunn/vim-plug/master/plug.vim'
endif

"--- Load plugins
call plug#begin('~/.config/nvim/autoload')
" default plugins
runtime config/plugings.vim
" custom user plugins
if !empty(glob('~/.config/nvim/config/custom.plug.vim'))
  runtime config/custom.plug.vim
endif

call plug#end()


syntax enable

set list                   " Show non-printable characters.
if has('multi_byte') && &encoding ==# 'utf-8'
	let &listchars = 'tab:▸ ,extends:❯,precedes:❮,nbsp:±'
else
	let &listchars = 'tab:> ,extends:>,precedes:<,nbsp:.'
endif
"set listchars=tab:>.,trail:.,extends:#,nbsp:.
"set listchars=tab:\ ,trail:·,extends:#,nbsp:. " Highlight problematic whitespace

set viewoptions=cursor,folds,slash,unix
"set viewoptions=folds,options,cursor,unix,slash " Better Unix / Windows compatibility

set number
set laststatus=2    " for statusline
set showtabline=2
set guioptions-=e

if has("autocmd")  " go back to where you exited
    autocmd BufReadPost *
        \ if line("'\"") > 0 && line ("'\"") <= line("$") |
        \   exe "normal g'\"" |
        \ endif
endif

set completeopt=longest,menu " preview

if has('mouse')
    "set viminfo=%,'50,\"100,:100,n~/.viminfo
    set mouse=a
    "set mouse=r
    set selectmode=mouse,key
    set nomousehide
    " set mousehide
    set mousemodel=popup_setpos
    set pastetoggle=<F12>           " pastetoggle (sane indentation on pastes)
endif

"-------------- Clipboard ---------------"
" set clipboard=unnamed                 " Use the operating system's clipboard.
" set clipboard=unnamedplus             " Use the operating system's clipboard.
" set clipboard^=unnamedplus            " Use the operating system's clipboard.
" set clipboard+=unnamedplus 		" nvim windows
if has('unnamedplus')
  set clipboard+=unnamed,unnamedplus
endif
"-----------------------------------------

set autoindent
set smartindent
set smarttab
set copyindent  " copy the previous indentation on autoindenting

set shiftround    " use multiple of shiftwidth when indenting with '<' and '>'
set nojoinspaces                " Prevents inserting two spaces after punctuation on a join (J)
set matchpairs+=<:>             " Match, to be used with %
set comments=sl:/*,mb:*,elx:*/  " auto format comment blocks

set linebreak
set scrolljump=5                " Lines to scroll when cursor leaves screen
set scrolloff=3                 " Minimum lines to keep above and below cursor
set sidescrolloff=5
set linespace=0                 " No extra spaces between rows

" Tabs
set shiftwidth=4 tabstop=4 softtabstop=4 expandtab
set tabpagemax=15           " Only show 15 tabs
set digraph
set showmode    " display current mode
set showmatch
set matchtime=0
set noswapfile
"set nobackup
set backup  " backups are nice
set nowritebackup

set writebackup
set autoread
set autowriteall

" Backup, Swap and Undo
set history=1000         " remember more commands and search history
set undolevels=1000      " use many muchos levels of undo
set undoreload=10000 " number lines to save for undo on a buffer reload

set wildmode=list:longest,full
set wildmenu                      " Enable ctrl-n and ctrl-p to scroll thru matches
set wildignore=*.o,*.obj,*~,*vim/backups*,*sass-cache*,*DS_Store*,vendor/rails/**,vendor/cache/**,*.gem,log/**,tmp/**,*.png,*.jpg,*.gif,*.so,*.swp,*.zip,*.swp,*.bak,*.pyc,*.class

set whichwrap=b,s,h,l,<,>,[,]   " Backspace and cursor keys wrap too

set shortmess+=filmnrxoOtTI          " Abbrev. of messages (avoids 'hit enter')
"set virtualedit=onemore         " Allow for cursor beyond last character
set virtualedit=block 		" easier to select stuff in visual block mode

" IMPORTANT: grep will sometimes skip displaying the file name if you
" search in a singe file. This will confuse latex-suite. Set your grep
" program to alway generate a file-name".
set grepprg=grep\ -nH\ $*


set title                " change the terminal's title
set titlestring=VIM:\ %-25.55F\ %a%r%m titlelen=70   
set visualbell noerrorbells t_vb=         " don't beep
set undofile " Persistent Undo
set undolevels=1000         " Maximum number of changes that can be undone
set undoreload=10000        " Maximum number lines to save for undo on a buffer reload

set ff=unix
set ffs=unix,dos
set backupskip=/tmp/*,/private/tmp/*

"set shell=/bin/bash
"set shell=/bin/zsh
set shell=sh

silent !mkdir -p ~/.config/nvim/defaults/backup > /dev/null 2>&1
silent !mkdir -p ~/.config/nvim/defaults/vimsessions > /dev/null 2>&1
silent !mkdir -p ~/.config/nvim/defaults/undo > /dev/null 2>&1
silent !mkdir -p ~/.config/nvim/defaults/swap > /dev/null 2>&1

set directory=~/.config/nvim/defaults/swap,/tmp
set backupdir=~/.config/nvim/defaults/backup,/tmp
set undodir=~/.config/nvim/defaults/undo,/tmp
set backupext =-vimbackup


" VimSessions
let g:session_dir= '~/.config/nvim/defaults/vimsessions'

if has('cmdline_info')
    set ruler                   " Show the ruler
    set rulerformat=%30(%=\:b%n%y%m%r%w\ %l,%c%V\ %P%) " A ruler on steroids
    set showcmd                 " Show partial commands in status line and
    " Selected characters/lines in visual mode
    set cmdheight=2 	" height of commandbar
endif

if has('nvim')
  set ttimeout
  set ttimeoutlen=0
endif

set backspace=indent,eol,start

"conceal
set conceallevel=2
set concealcursor=""
set cursorcolumn
set cursorline
let &colorcolumn=join(range(81,999),",")
"gqap    " Reformat a paragraph with `par`


set fenc=utf-8
set fencs=utf-8
set enc=utf-8
scriptencoding utf-8


" Search and Substitute
set gdefault " use global flag by default in s: commands
set hlsearch " highlight searches
set ignorecase 
set smartcase " don't ignore capitals in searches
set winminheight=0              " Windows can be 0 line high
set autochdir

" Text Wrapping
set textwidth=80
set colorcolumn=80
set nowrap
"set wrap

"---Automatically install missing plugins on startup-------"
autocmd VimEnter *
  \  if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \|   PlugInstall --sync | q
  \| endif 
