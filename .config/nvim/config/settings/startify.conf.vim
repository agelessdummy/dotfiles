		let g:startify_session_dir = "~/.config/nvim/defaults/vimsessions"
		let g:startify_list_order = ['files', 'dir', 'bookmarks', 'sessions']

		let g:startify_list_order = [
		            \ ['   These are my sessions:'],
		            \ 'sessions',
		            \ ['   My most recently', '   used files'],
		            \ 'files',
		            \ ['   My most recently used files in the current directory:'],
		            \ 'dir',
		            \ ['   These are my bookmarks:'],
		            \ 'bookmarks',
		            \ ]

		let g:startify_bookmarks = [
			\ {'v': '$MYVIMRC'},
			\ ]

		let g:startify_files_number = 15

		let g:startify_change_to_dir = 1
		let g:startify_fortune_use_unicode = 1
		"let g:startify_custom_header = ''
		let g:startify_custom_footer = ['', " Vim is charityware. Please read ':help uganda'.", '']
		"let g:startify_session_autoload = 0
		"let g:startify_session_persistence = 0
		let g:startify_change_to_dir = 1

		let g:startify_custom_header = [
			\ ' ███╗   ███╗███████╗███╗   ██╗██████╗ ███████╗███████╗███████╗    ██╗   ██╗██╗███╗   ███╗ ',
			\ ' ████╗ ████║██╔════╝████╗  ██║██╔══██╗██╔════╝╚══███╔╝██╔════╝    ██║   ██║██║████╗ ████║ ',
			\ ' ██╔████╔██║█████╗  ██╔██╗ ██║██║  ██║█████╗    ███╔╝ ███████╗    ██║   ██║██║██╔████╔██║ ',
			\ ' ██║╚██╔╝██║██╔══╝  ██║╚██╗██║██║  ██║██╔══╝   ███╔╝  ╚════██║    ╚██╗ ██╔╝██║██║╚██╔╝██║ ',
			\ ' ██║ ╚═╝ ██║███████╗██║ ╚████║██████╔╝███████╗███████╗███████║     ╚████╔╝ ██║██║ ╚═╝ ██║ ',
			\ ' ╚═╝     ╚═╝╚══════╝╚═╝  ╚═══╝╚═════╝ ╚══════╝╚══════╝╚══════╝      ╚═══╝  ╚═╝╚═╝     ╚═╝ ',
			\ '',
			\ '',
		\ ]

		let g:startify_custom_footer =
			\ ['',"This is Startify's Commands: SSave [session]; SDelete [session]; SLoad [session]; SClose; Startify",'']

		autocmd VimEnter *
		                \   if !argc()
		                \ |   Startify
		               \ |   NERDTree
		               \ |   wincmd w
		                \ | endif

		"set NERDTreeHijackNetrw = 0

