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
	Plug 'preservim/nerdcommenter'
	Plug 'vimwiki/vimwiki'
	Plug 'vim-pandoc/vim-pandoc'
	Plug 'vim-pandoc/vim-pandoc-syntax'
    Plug 'folke/which-key.nvim'
	Plug 'neovim/nvim-lspconfig'
	Plug 'airblade/vim-gitgutter'
	Plug 'tpope/vim-fugitive'
	Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
	Plug 'junegunn/fzf.vim'
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
autocmd FileType go nmap <leader>D  <Plug>(go-def)
lua << EOF
require'lspconfig'.gopls.setup{}
EOF

" FZF
" 'find buffer'
nnoremap <silent> <Leader>fb :Buffers<CR> 
nnoremap <silent> <C-p> :Files<CR>
nnoremap <silent> <M-p> :GFiles<CR>
nnoremap <silent> <C-f> :BLines<CR>
" 'find commit'
nnoremap <silent> <Leader>fc :Commits<CR> 
nnoremap <silent> <Leader>H :Helptags<CR>
nnoremap <silent> <Leader>hh :History<CR>
nnoremap <silent> <Leader>hc :Commands<CR>
nnoremap <silent> <Leader>h: :History:<CR>
nnoremap <silent> <Leader>h/ :History/<CR> 

" Vimwiki
let g:vimwiki_list = [{'path': '~/Documents/second_brain',
                      \ 'syntax': 'markdown', 'ext': '.md'}]

" Pandoc Syntax
let g:pandoc#syntax#conceal#use = 1
let g:pandoc#keyboard#blacklist_submodule_mappings = ["checkboxes"]

" IPA Keybindings
inoremap <leader>ia<Space>  ɑ
inoremap <leader>iae        æ
inoremap <leader>id         ð
inoremap <leader>i3         ɛ
inoremap <leader>ie         ə
inoremap <leader>ii         ɪ
inoremap <leader>in         ŋ
inoremap <leader>io         ɔ
inoremap <leader>ir         ɾ
inoremap <leader>is         ʃ
inoremap <leader>it         θ
inoremap <leader>iu         ʊ
inoremap <leader>iv         ʌ
inoremap <leader>iz         ʒ
inoremap <leader>i?         ʔ

" LSP Keybindings
lua << EOF
local nvim_lsp = require('lspconfig')

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<space>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)
  buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
end

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = { 'gopls' }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    on_attach = on_attach,
    flags = {
      debounce_text_changes = 150,
    }
  }
end
EOF

" Whichkey
lua << EOF
  require("which-key").setup {
  }
EOF

