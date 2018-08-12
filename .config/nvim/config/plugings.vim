Plug 'junegunn/vim-plug'

"--- Tab Completion
"Plug 'autozimu/LanguageClient-neovim', {
"    \ 'branch': 'next',
"    \ 'do': [ 'bash install.sh', 'npm install --upgrade bash-language-server' ]
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
    \ 'do': 'npm i --upgrade',}
Plug 'prettier/vim-prettier', {
    \ 'do': 'npm i --upgrade',
    \ 'for': [ 'markdown', 'yaml', 'javascript', 'typescript', 'css', 'less', 'scss'] }
Plug 'PotatoesMaster/i3-vim-syntax'

" Language Tools
Plug 'rhysd/vim-grammarous', { 'for': ['markdown', 'tex'] }
Plug 'kana/vim-operator-user'
"Plug 'reedes/vim-wordy', { 'for': ['markdown', 'tex'] }

" File browse
"Plug 'scrooloose/nerdtree'
"Plug 'Xuyuanp/nerdtree-git-plugin'
"Plug 'tiagofumo/vim-nerdtree-syntax-highlight'

" LaTex
"Plug 'lervag/vimtex', { 'for': 'tex', 'do': 'pip3 install --user --upgrade neovim-remote' }
Plug 'lervag/vimtex', {
    \ 'for': 'tex', 
    \ 'do': 'pip3 install --user --upgrade' }
Plug 'donRaphaco/neotex', { 'for': 'tex' }

" Focus Plugins
Plug 'junegunn/goyo.vim', {'on': 'Goyo'}
"Plug 'junegunn/limelight.vim', {'on': 'Goyo'}
Plug 'amix/vim-zenroom2', {'on': 'Goyo'}

" Pandoc
Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-criticmarkup' 
" post install (yarn install | npm install) then load plugin only for editing supported files
Plug 'vim-pandoc/vim-pandoc-syntax'
"Plug 'vim-pandoc/vim-pandoc-after'
Plug 'dhruvasagar/vim-table-mode'
Plug 'derdennis/vim-markdownfootnotes'
Plug 'mmai/vim-markdown-wiki'
"Plug 'prashanthellina/follow-markdown-links'
Plug 'ferrine/md-img-paste.vim'
function! BuildComposer(info)
  if a:info.status != 'unchanged' || a:info.force
    if has('nvim')
      !cargo build --release
    else
      !cargo build --release --no-default-features --features json-rpc
    endif
  endif
endfunction

Plug 'euclio/vim-markdown-composer', { 'do': function('BuildComposer') }

" Vim Startify
Plug 'mhinz/vim-startify'
"Plug 'xolox/vim-session'

"--- Colorscheme
Plug 'challenger-deep-theme/vim', { 'as': 'challenger-deep' }
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'cocopon/iceberg.vim'

"--- Searching
Plug 'junegunn/fzf', {
    \ 'dir': '~/.fzf', 
    \ 'do': './install --all' }
Plug 'junegunn/fzf.vim' 

"--- Fonts
Plug 'ryanoasis/vim-devicons'

"--- abbreviation
"Plug 'nelstrom/vim-americanize'
"Plug 'tpope/vim-abolish'
Plug 'tpope/tpope-vim-abolish'
Plug 'jdelkins/vim-correction'

" buffer tab list
"Plug 'ap/vim-buftabline'
Plug 'bagrat/vim-workspace'
"Plug 'bling/vim-bufferline'
Plug 'bling/vim-bufferline'

"--- Remname the currect file
"Plug 'danro/rename.vim'

"--- Unix Conmands
Plug 'tpope/vim-eunuch'

"--- Git Things from NVIM
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-git'

" pomodoro
"Plug 'pydave/AsyncCommand'
"Plug 'adelarsq/vim-pomodoro'
"Plug 'l04m33/vim-skuld'

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
"Plug 'vimwiki/vimwiki', { 'branch': 'dev' }
" Plug 'yysfire/vimwiki2markdown'

"--- Vim Notes
"Plug 'xolox/vim-notes'
"Plug 'xolox/vim-tools', { 'do': 'pip3 install' }
Plug 'xolox/vim-easytags'
Plug 'xolox/vim-misc'

"--- Status Line
Plug 'itchyny/lightline.vim'
Plug 'mgee/lightline-bufferline'
Plug 'popkirby/lightline-iceberg'
Plug 'maximbaz/lightline-ale'

"--- Install vim-plug if it is not installed
"if empty(glob('~/.config/nvim/autoload/plug.vim'))
"  execute '!curl --create-dirs -fLo ~/.config/nvim/autoload/plug.vim https://raw.github.com/junegunn/vim-plug/master/plug.vim'
"endif
