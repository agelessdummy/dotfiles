" OmniCompletion
let g:SuperTabDefaultCompletionType = "<C-X><C-O>"
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"

" context should work with OmniCompletion
let g:SuperTabDefaultCompletionType = "context"

" close the preview window when you're not using it
"let g:SuperTabClosePreviewOnPopupClose = 1

