"""" Websites
" http://www.blog.bdauria.com/?p=609
" https://github.com/bigeagle/neovim-config/blob/master/init.vim
" https://www.gregjs.com/vim/2015/linting-code-with-neovim-and-neomake-eslint-edition/
" https://vi.stackexchange.com/questions/300/other-ways-to-exit-insert-mode-besides-escape#301

" general
let mapleader = ","
let maplocalleader = ","

" Swap and close buffers quickly
" :nnoremap <Tab> :bnext<CR>
" :nnoremap <S-Tab> :bprevious<CR>
" :nnoremap <C-X> :bdelete<CR>

" SearchMe
noremap <Leader>ss :<C-u>SearchCurrentText<CR>
vnoremap <Leader>sv :<C-u>SearchVisualText<CR>
noremap <Leader>sm :Search<space>

" Vim Workspace
"noremap <Tab> :WSNext<CR>
"noremap <S-Tab> :WSPrev<CR>
"noremap <Leader><Tab> :WSClose<CR>
"noremap <Leader><S-Tab> :WSClose!<CR>
"noremap <C-t> :WSTabNew<CR>
"cabbrev bonly WSBufOnly

" markdown footnotes
"<leader>f    " Insert new footnote 
"<leader>r    " Return from footnote

" Up and Down
vmap j gj
vmap k gk
nmap j gj
nmap k gk

" <esc> 
"inoremap jj <esc>

" move to beginning/end of line
nnoremap B ^
nnoremap E $
" movement by word
" b = previous word
" w = next word
" v = select visually
" shirt-v = line select

" Return to the last file opened
nmap <Leader><Leader> <c-^>

" $/^ doesn't do anything
nnoremap $ <nop>
nnoremap ^ <nop>

" Ale lintings events
nnoremap ]r :ALENextWrap<CR>
nnoremap [r :ALEPreviousWrap<CR>
nnoremap ]d :ALEDetail<CR>
nnoremap <space>l :lnext<CR>
nnoremap <space>p :lprevious<CR>
nnoremap <space>r :lrewind<CR>

" Skuld ,a pomodoro time
" Mapping for opening the task buffer
let g:skuld_buffer_map = '<leader>sb'
" Mapping for displaying the current state
let g:skuld_state_map = '<leader>ss'

" Nuake
nnoremap <F6> :Nuake<CR>
inoremap <F6> <C-\><C-n>:Nuake<CR>
nnoremap <F6> <C-\><C-n>:Nuake<CR>

" Tab New
nmap T :tabnew<cr>

" no nohls
nnoremap <leader><space> :nohls <enter>

" NetRW: explore in vertical split
nnoremap <Leader>e :Explore! <enter>

" cycle through buffers
"nnoremap <C-H> :bp <enter>	 
"nnoremap <C-L> :bn <enter>

" comma-w to save
nnoremap <Leader>w :w <enter>

" comma-q to quit buffer
nnoremap <Leader>q :bd <enter>	

" Fzf
nnoremap <leader>o :Files<cr>

" spelling
map <leader>s :set spell<cr>
map <F1> [s     " previous
map <F2> z=     " suggestions
map <F3> ]s     " next
map <F4> zg     " add current
map <F5> zG     " add internal

" fzf-neoyank
nnoremap <leader>y :FZFNeoyank<cr>	" normal mode after cursor
nnoremap <leader>Y :FZFNeoyank " P<cr>	" visual mode replaces selection
vnoremap <leader>y :FZFNeoyankSelection<cr>	"  normal mode after cursor
nnoremap <leader>= FZFNeoyank +<cr> " normal mode history buffer

" goyo
nnoremap <silent> <leader>z :Goyo<cr>

" LanguageClient
nnoremap <F7> :call LanguageClient_contextMenu()<CR>
" Or map each action separately
nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
nnoremap <silent> <F7> :call LanguageClient#textDocument_rename()<CR>

" wordy
"noremap <silent> <F8> :<C-u>NextWordy<cr>
"xnoremap <silent> <F8> :<C-u>NextWordy<cr>
"inoremap <silent> <F8> <C-o>:NextWordy<cr>
