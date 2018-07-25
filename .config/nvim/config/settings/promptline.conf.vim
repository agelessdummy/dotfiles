
"    In vim :PromptlineSnapshot ~/.shell_prompt.sh airline
"    In bash/zsh source ~/.shell_prompt.sh
"    ZLE_RPROMPT_INDENT=0 in zshrc.


"--- Symbols
let g:promptline_powerline_symbols = 0 " 0 disable, 1 enable

let g:promptline_symbols = {
      \ 'left'           : '',
      \ 'right'          : '',
      \ 'left_alt'       : '>',
      \ 'right_alt'      : '<',
      \ 'dir_sep'        : ' / ',
      \ 'truncation'     : '...',
      \ 'vcs_branch'     : '',
      \ 'battery'        : '',
      \ 'space'          : ' '}

" promptline preset layout
"let g:promptline_preset = 'clear'
let g:promptline_preset = 'full'
"let g:promptline_preset = 'powerlineclone'
