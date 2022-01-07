set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc

call plug#begin()
    " Themes
    Plug 'EdenEast/nightfox.nvim'
    Plug 'arcticicestudio/nord-vim'
    Plug 'vim-airline/vim-airline'
    " Things that make my life easier
    Plug 'preservim/nerdtree' |
           \ Plug 'Xuyuanp/nerdtree-git-plugin' |
	Plug 'jiangmiao/auto-pairs'
	Plug 'SirVer/ultisnips'
	Plug 'tpope/vim-surround'
	" Go
    Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
call plug#end()

colorscheme nord

" Airline
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif
let g:airline_powerline_fonts = 1
let g:airline_symbols.colnr = ' '
let g:airline_symbols.linenr = ' '
let g:airline_symbols.maxlinenr = '☰'

" Go
autocmd FileType go nmap <leader>b  <Plug>(go-build)
autocmd FileType go nmap <leader>r  <Plug>(go-run)
autocmd FileType go nmap <leader>d  <Plug>(go-doc)
autocmd FileType go nmap <leader>f  <Plug>(go-def)
