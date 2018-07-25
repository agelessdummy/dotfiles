Plug 'junegunn/vim-plug'

"--- Tab Completion
"Plug 'autozimu/LanguageClient-neovim', {
"    \ 'branch': 'next',
"    \ 'do': [ 'bash install.sh', 'npm i -g bash-language-server' ]
"    \ }
"if has('nvim')
"    Plug 'Shougo/deoplete.nvim', { 'do': [ ':UpdateRemotePlugins', 'pip3 install --user --upgrade' ] }
"else
"    Plug 'Shougo/deoplete.nvim'
"    Plug 'roxma/nvim-yarp'
"    Plug 'roxma/vim-hug-neovim-rpc'
"endif
"Plug 'ujihisa/neco-look'
"Plug 'Shougo/neco-vim'
"Plug 'zchee/deoplete-zsh'
"Plug 'Shougo/neco-syntax'
"Plug 'SevereOverfl0w/deoplete-github'
"Plug 'thalesmello/webcomplete.vim'
"Plug 'lionawurscht/deoplete-biblatex', {
    \ 'do': 'pip3 install --user --upgrade bibtexparser'}
"---
Plug 'ervandew/supertab'
Plug 'vim-scripts/SearchComplete'
Plug 'shawncplus/phpcomplete.vim', { 'for': 'php' } 

" Snippets
"Plug 'SirVer/ultisnips'
"Plug 'honza/vim-snippets'

"Linters
Plug 'w0rp/ale', {
    \ 'do': 'npm i -g',}
Plug 'prettier/vim-prettier', {
    \ 'do': 'npm i -g',
    \ 'for': [ 'markdown', 'yaml' ] }
Plug 'PotatoesMaster/i3-vim-syntax'

" Language Tools
Plug 'rhysd/vim-grammarous', { 'for': ['markdown', 'tex'] }
Plug 'kana/vim-operator-user'
"Plug 'reedes/vim-wordy', { 'for': ['markdown', 'tex'] }

" File browse
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'

" LaTex
"Plug 'lervag/vimtex', { 'for': 'tex', 'do': 'pip3 install --user --upgrade neovim-remote' }
Plug 'lervag/vimtex', {
    \ 'for': 'tex', 
    \ 'do': 'pip3 install --user --upgrade' }
Plug 'donRaphaco/neotex', { 'for': 'tex' }

" Focus Plugins
Plug 'junegunn/goyo.vim', {'on': 'Goyo'}
Plug 'junegunn/limelight.vim', {'on': 'Goyo'}

" Pandoc
Plug 'vim-pandoc/vim-pandoc', {
    \ 'for': [ 'pandoc','markdown'] }
Plug 'vim-pandoc/vim-criticmarkup' 
" post install (yarn install | npm install) then load plugin only for editing supported files
Plug 'vim-pandoc/vim-pandoc-syntax', {
    \ 'for': [ 'paandoc','markdown' ] }
"Plug 'vim-pandoc/vim-pandoc-after'
Plug 'dhruvasagar/vim-table-mode'
Plug 'derdennis/vim-markdownfootnotes'
Plug 'mmai/vim-markdown-wiki'
"Plug 'prashanthellina/follow-markdown-links'
Plug 'shime/vim-livedown', {
    \ 'do': 'npm install', 
    \ 'for': 'markdown' }
"Plug "fmoralesc/vim-bibliographer"

" Vim Startify
Plug 'mhinz/vim-startify'
"Plug 'xolox/vim-session'

"--- Colorscheme
Plug 'challenger-deep-theme/vim', { 'as': 'challenger-deep' }
Plug 'dracula/vim', { 'as': 'dracula' }

"--- Searching
Plug 'junegunn/fzf', {
    \ 'dir': '~/.fzf', 
    \ 'do': './install --all' }
Plug 'junegunn/fzf.vim' 

"--- Fonts
Plug 'ryanoasis/vim-devicons'

"--- abbreviation
"Plug 'tpope/vim-abolish'

" buffer tab list
"Plug 'ap/vim-buftabline'
Plug 'bagrat/vim-workspace'

"--- Remname the currect file
"Plug 'danro/rename.vim'

"--- Unix Conmands
Plug 'tpope/vim-eunuch'

"--- Git Things from NVIM
"Plug 'tpope/vim-rhubarb'
"Plug 'tpope/vim-fugitive'
"Plug 'tpope/vim-git'

" pomodoro
Plug 'adelarsq/vim-pomodoro'

" FastFolds
Plug 'wsdjeg/vim-fetch'
Plug 'Konfekt/FastFold'
Plug 'Konfekt/FoldText'
Plug 'kopischke/vim-stay'

"--- Insert or delete brackets, parens, quotes in pair
Plug 'jiangmiao/auto-pairs'
"Plug 'tpope/vim-unimpaired'
"Plug 'Shougo/neopairs.vim'

"--- Vim Wiki
" Plug 'vimwiki/vimwiki', { 'branch': 'dev' }

"--- Vim Notes
"Plug 'xolox/vim-notes'
"Plug 'xolox/vim-tools', { 'do': 'pip3 install' }
Plug 'xolox/vim-easytags'
Plug 'xolox/vim-misc'

"--- Install vim-plug if it is not installed
"if empty(glob('~/.config/nvim/autoload/plug.vim'))
"  execute '!curl --create-dirs -fLo ~/.config/nvim/autoload/plug.vim https://raw.github.com/junegunn/vim-plug/master/plug.vim'
"endif
