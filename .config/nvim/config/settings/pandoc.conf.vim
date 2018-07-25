" https://github.com/wbthomason/dotfiles/blob/linux/neovim/.config/nvim/init.vim

let g:pandoc#syntax#conceal#use = 1 " enable = 1, disable = 0
let g:pandoc#syntax#conceal#blacklist = []
let g:pandoc#syntax#conceal#urls = 1
let g:pandoc#after#modules#enabled = []
"let g:pandoc#after#modules#enabled = [ "supertab", "tablemode", "ultisnips", "neosnippets" ]
let g:pandoc#formatting#mode = 'haA'
let g:pandoc#formatting#textwidth = 100
"let g:pandoc#modules#disabled = [ 'commands', 'templates', 'formatting']
let g:pandoc#completion#bib#use_preview = 0
let g:pandoc#biblio#use_bibtool = 1
let g:pandoc#completion#bib#mode = 'citeproc'

let g:pandoc#command#autoexec_on_writes = 1
"let g:pandoc#command#autoexec_command = "Pandoc! pdf"
let g:pandoc#command#autoexec_command = "Pandoc! html"
let g:pandoc#command#latex_engine = "xelatex"


let g:pandoc#filetypes#handled = ["pandoc", "markdown"]
let g:pandoc#filetypes#pandoc_markdown = 1


let g:pandoc#hypertext#create_if_no_alternates_exists = 1 " Automatically save the current file when following some link in the same window for editing.

let g:pandoc#syntax#codeblocks#embeds#langs = ['python', 'vim', 'make',
            \  'bash=sh', 'html', 'css', 'scss', 'javascript']

let g:pandoc#folding#fold_fenced_codeblocks = 1
let g:markdown_fenced_languages = ['python', 'csharp=cs', 'javascript', 'ruby', 
				\ 'bash=sh', 'yaml', 'javascript', 'tex', 'latex', 'plaintex', 'xml', 
				\ 'context', 'csh', 'c', 'html', 'viml=vim', 'coffee', 
				\ 'json', 'diff', 'c++=cpp', 'ini=dosini',
				\ 'css', 'js=javascript', 'json=javascript'
				\ ]

"let g:pandoc#command#templates_file = ""
