let g:LanguageClient_serverCommands = {
    \ 'rust': ['~/.cargo/bin/rustup', 'run', 'stable', 'rls'],
    \ 'python': ['pyls'],
    \ 'sh': ['bash-language-server', 'start']
    \}

"let g:langserver_executables = {
"      \ 'go': {
"        \ 'name': 'sourcegraph/langserver-go',
"        \ 'cmd': ['langserver-go', '-trace', '-logfile', expand('~/Desktop/langserver-go.log')],
        \ },
      \ }



"To start the language server, run the command:

":LSPStart

"After starting the language server, you should be able to run commands like:

":LSPGoto
":LSPHover
