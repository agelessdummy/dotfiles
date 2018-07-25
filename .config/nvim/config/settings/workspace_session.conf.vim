" let g:workspace_session_name = 'Session.vim'    " configured if you wish to change the session name
let g:workspace_session_disable_on_args = 1     " not load if you're explicitly loading a file in a workspace directory
let g:workspace_persist_undo_history = 1  " enabled = 1 (default), disabled = 0
" let g:workspace_undodir='.undodir'
let g:workspace_undodir='~/.config/nvim/config/defaults/undo'
let g:workspace_autosave_always = 1     " If you would like autosave to be always on, even outside of a session
"let g:workspace_autosave = 0    " If you would like to disable autosave for some reason

let g:workspace_autosave_untrailspaces = 0  " Untrailing Spaces
let g:workspace_autosave_ignore = ['gitcommit']     " Ignore List
