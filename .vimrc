" change directory to that of the current file
nnoremap <leader>cd :cd %:p:h<CR>:pwd<CR>

" For security
set modelines=0

" Show line numbers 
set number

" Enable syntax highlighting
syntax enable

" Add visual autocomplete for the command menu
set wildmenu

" Set visualbell. (It won't do the annoying beep)
set visualbell

" Match indent of the previous line
set autoindent

" Expand tabs into spaces
" set expandtab

" Insert 'tabstop' number of spaces on tab.
set smarttab
set tabstop=4
set softtabstop=4
set shiftwidth=4

" Highlight the line under the cursor
" set cursorline

" Set search highlighting
set hlsearch

" Set incremental search. This will show partial matches
set incsearch

" Ignore case while searching, unless there is an upper case letter.
set ignorecase
set smartcase

" Enable spell checker
set spell
set spelllang=en,de

" Increase undo history
set history=1000

" Set window title to reflect the file being edited
set title

" Enable line wrapping, but not in  the middle of a word
set wrap
set linebreak

" Make buffers useful
set hidden

" Write the contents of a file on calling make or GoBuild
set autowrite

"Omni Completion
filetype plugin on

" Hopefully self-explanatory stuff
set lazyredraw
set encoding=utf-8
set textwidth=80
set showcmd
set termguicolors
set relativenumber
set nocompatible
