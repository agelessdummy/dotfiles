let g:auto_save = 1  " enable AutoSave on Vim startup
let g:auto_save_silent = 1  " do not display the auto-save notification

let g:auto_save_events = ["InsertLeave", "TextChanged"]
"    TextChangedI will save after a change was made to the text in the current buffer in insert mode.
"    CursorHold will save every amount of milliseconds as defined in the updatetime option in normal mode.
"    CursorHoldI will do the same thing in insert mode.
"    CompleteDone will also trigger a save after every completion event.


" (Pre/Post) save Hooks
" This will run :TagsGenerate after each save
let g:auto_save_postsave_hook = 'TagsGenerate'

" This will run AbortIfNotGitDirectory function before each save
let g:auto_save_presave_hook = 'call AbortIfNotGitDirectory()'

" Example hook from vim-auto-save-git-hook plugin
function! AbortIfNotGitDirectory()
  if ...
    let g:auto_save_abort = 0
  else
    let g:auto_save_abort = 1
  endif
endfunction

" let g:auto_save_write_all_buffers = 1  " write all open buffers as if you would use :wa
