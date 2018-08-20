" git
"autocmd vimrc FileType dirvish nmap <silent><buffer><C-n> <Plug>(dirvish_git_next_file)
"autocmd vimrc FileType dirvish nmap <silent><buffer><C-p> <Plug>(dirvish_git_prev_file)

  let g:dirvish_git_indicators = {
  \ 'Modified'  : '✹',
  \ 'Staged'    : '✚',
  \ 'Untracked' : '✭',
  \ 'Renamed'   : '➜',
  \ 'Unmerged'  : '═',
  \ 'Deleted'   : '✖',
  \ 'Ignored'   : '☒',
  \ 'Unknown'   : '?'
  \ }
