-- helpers stolen from oroques.dev/notes/neovim-init/
local g = vim.g -- a table to access global variables
local opt = vim.opt -- to set options

local function map(mode, lhs, rhs, opts)
	local options = { noremap = true }
	if opts then
		options = vim.tbl_extend("force", options, opts)
	end
	vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

local function silent_map(mode, lhs, rhs)
	map(mode, lhs, rhs, { noremap = true, silent = true })
end

--- Plugins
local function load_plugins()
	return require("packer").startup(function()
		use("wbthomason/packer.nvim")

		-- Useful Things
		use({ "junegunn/fzf", run = "fzf#install()" })
		use("junegunn/fzf.vim")
		use({
			"kyazdani42/nvim-tree.lua",
			config = function()
				require("nvim-tree").setup({})
			end,
		})
		use({
			"echasnovski/mini.nvim",
			branch = "stable",
			config = function()
				require("mini.pairs").setup({})
				require("mini.surround").setup({})
				require("mini.comment").setup({})
			end,
		})
		use({
			"folke/which-key.nvim",
			config = function()
				require("which-key").setup({
					plugins = {
						spelling = { enabled = true },
					},
				})
			end,
		})
		use({
			"lewis6991/gitsigns.nvim",
			requires = { "nvim-lua/plenary.nvim" },
			config = function()
				require("gitsigns").setup()
			end,
		})
		use("tpope/vim-fugitive")
		use("SirVer/ultisnips")
		use("vim-pandoc/vim-pandoc")
		use("vim-pandoc/vim-pandoc-syntax")
		use({ "stevearc/gkeep.nvim", run = ":UpdateRemotePlugins" })

		-- Language Things
		use({
			"nvim-treesitter/nvim-treesitter",
			run = ":TSUpdate",
			config = function()
				require("nvim-treesitter.configs").setup({
					highlight = {
						enable = true,
					},
					indent = {
						enable = true,
					},
				})
			end,
		})
		-- this makes spell check WAY less aggressive looking when coding.
		use({
			"lewis6991/spellsitter.nvim",
			config = function()
				require("spellsitter").setup()
			end,
		})
		use("neovim/nvim-lspconfig")
		use("williamboman/nvim-lsp-installer")
		use({ "fatih/vim-go", run = ":GoUpdateBinaries" })
		use({
			"jose-elias-alvarez/null-ls.nvim",
			config = function()
				local null_ls = require("null-ls")
				local sources = {
					null_ls.builtins.formatting.stylua,
				}
				null_ls.setup({
					sources = sources,
					on_attach = function(client)
						if client.resolved_capabilities.document_formatting then
							vim.cmd([[ 
							augroup LspFormatting 
								autocmd! * <buffer>
								autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync() 
							augroup END 
							]])
						end
					end,
				})
			end,
			requires = { "nvim-lua/plenary.nvim" },
		})

		-- Pretty Things
		use("arcticicestudio/nord-vim")
		use({
			"nvim-lualine/lualine.nvim",
			config = function()
				require("lualine").setup()
			end,
		})
		use({
			"kyazdani42/nvim-web-devicons",
			config = function()
				require("nvim-web-devicons").setup({
					-- globally enable default icons (default to false)
					-- will get overridden by `get_icons` option
					default = true,
				})
			end,
		})
		use({
			"goolord/alpha-nvim",
			config = function()
				require("alpha").setup(require("alpha.themes.startify").config)
			end,
		})
	end)
end

load_plugins()

local function insert(str)
	return "i" .. str .. "<Esc>"
end

--- Keybindings
g.mapleader = " "
g.maplocalleader = "\\"

-- IPA Keybindings
map("n", "<Leader>ia", insert("ɑ"))
map("n", "<Leader>id", insert("ð"))
map("n", "<Leader>i3", insert("ɛ"))
map("n", "<Leader>ie", insert("ə"))
map("n", "<Leader>ii", insert("ɪ"))
map("n", "<Leader>in", insert("ŋ"))
map("n", "<Leader>io", insert("ɔ"))
map("n", "<Leader>ir", insert("ɾ"))
map("n", "<Leader>is", insert("ʃ"))
map("n", "<Leader>it", insert("θ"))
map("n", "<Leader>iu", insert("ʊ"))
map("n", "<Leader>iv", insert("ʌ"))
map("n", "<Leader>iz", insert("ʒ"))
map("n", "<Leader>i?", insert("ʔ"))

-- FZF
silent_map("n", "<C-p>", ":Files<CR>")
silent_map("n", "<M-p>", ":GFiles<CR>")
silent_map("n", "<C-f>", ":BLines<CR>")
silent_map("n", "<Leader>fb", ":Buffers<CR>") -- 'find buffer'
silent_map("n", "<Leader>ff", ":Rg<CR>") -- 'find files'
silent_map("n", "<Leader>fc", ":Commits<CR>") -- 'find commit'
silent_map("n", "<Leader>H", ":Helptags<CR>")
silent_map("n", "<Leader>hh", ":History<CR>")
silent_map("n", "<Leader>hc", ":Commands<CR>")
silent_map("n", "<Leader>h:", ":History:<CR>")
silent_map("n", "<Leader>h/", ":History/<CR>")

-- change directory to that of the current file
map("n", "<Leader>cd", "<Cmd>cd %:p:h<CR>:pwd<CR>")
map("n", "<Leader>nh", ":nohlsearch<CR>")

-- Don't let Vim do unsafe stuff
opt.modelines = 0
-- No annoying beep
opt.visualbell = true
-- visual autocomplete for the command menu
opt.wildmenu = true
-- insert "tabstop" number of spaces on tab
opt.tabstop = 4
opt.smarttab = true
opt.softtabstop = 4
opt.shiftwidth = 4
-- highlight the line under the cursor
opt.cursorline = true
-- Pay attention to case if there is an upper case letter
opt.smartcase = true
-- Increase undo history
opt.history = 1000
-- Set window title to reflect the file being edited
opt.title = true
-- Enable line wrapping, but not in  the middle of a word
opt.wrap = true
opt.linebreak = true
-- Write the contents of a file on calling make or GoBuild
opt.autowrite = true
-- Make buffers useful
opt.hidden = true

-- Hopefully self-explanatory stuff
opt.autoindent = true
opt.number = true
opt.syntax = "ON"
opt.hlsearch = true
opt.incsearch = true
opt.ignorecase = true
opt.spell = true
opt.spelllang = "en,de"
opt.lazyredraw = true
opt.encoding = "utf-8"
opt.textwidth = 80
opt.showcmd = true
opt.termguicolors = true
opt.relativenumber = true
opt.compatible = false

--- Everything else ---
vim.cmd([[
"Omni Completion
filetype plugin on

colorscheme nord

" Go
autocmd FileType go nmap <LocalLeader>b  <Plug>(go-build)
autocmd FileType go nmap <LocalLeader>r  <Plug>(go-run)
autocmd FileType go nmap <LocalLeader>d  <Plug>(go-doc)
autocmd FileType go nmap <LocalLeader>D  <Plug>(go-def)
lua << EOF
require'lspconfig'.gopls.setup{}
EOF

" Vimwiki
let g:vimwiki_list = [{'path': '~/Documents/second_brain',
                      \ 'syntax': 'markdown', 'ext': '.md'}]

" Pandoc Syntax
let g:pandoc#syntax#conceal#use = 1
let g:pandoc#syntax#conceal#backslash = 1
let g:pandoc#formatting#mode = "hA"
let g:pandoc#formatting#smart_autoformat_on_cursormoved = 1
let g:pandoc#folding#mode = "relative"
let g:pandoc#folding#level = 1

execute "digraphs ks " . 0x2096 
execute "digraphs as " . 0x2090
execute "digraphs es " . 0x2091
execute "digraphs hs " . 0x2095
execute "digraphs is " . 0x1D62
execute "digraphs ks " . 0x2096
execute "digraphs ls " . 0x2097
execute "digraphs ms " . 0x2098
execute "digraphs ns " . 0x2099
execute "digraphs os " . 0x2092
execute "digraphs ps " . 0x209A
execute "digraphs rs " . 0x1D63
execute "digraphs ss " . 0x209B
execute "digraphs ts " . 0x209C
execute "digraphs us " . 0x1D64
execute "digraphs vs " . 0x1D65
execute "digraphs xs " . 0x2093
]])

--- LSP Keybindings ---
local nvim_lsp = require("lspconfig")

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
	local function buf_set_keymap(...)
		vim.api.nvim_buf_set_keymap(bufnr, ...)
	end
	local function buf_set_option(...)
		vim.api.nvim_buf_set_option(bufnr, ...)
	end

	-- Enable completion triggered by <c-x><c-o>
	buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

	-- Mappings.
	local opts = { noremap = true, silent = true }

	-- See `:help vim.lsp.*` for documentation on any of the below functions
	buf_set_keymap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
	buf_set_keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
	buf_set_keymap("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
	buf_set_keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
	buf_set_keymap("n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
	buf_set_keymap("n", "<Leader>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", opts)
	buf_set_keymap("n", "<Leader>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", opts)
	buf_set_keymap("n", "<Leader>wl", "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", opts)
	buf_set_keymap("n", "<Leader>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
	buf_set_keymap("n", "<Leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
	buf_set_keymap("n", "<Leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
	buf_set_keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
	buf_set_keymap("n", "<Leader>e", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
	buf_set_keymap("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
	buf_set_keymap("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)
	buf_set_keymap("n", "<Leader>q", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)
	buf_set_keymap("n", "<Leader>fo", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
end

local lsp_installer = require("nvim-lsp-installer")

-- Register a handler that will be called for each installed server when it's
-- ready (i.e. when installation is finished
-- or if the server is already installed).
lsp_installer.on_server_ready(function(server)
	local opts = {}
	-- This setup() function will take the provided server configuration and decorate it with the necessary properties
	-- before passing it onwards to lspconfig.
	-- Refer to https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
	server:setup(opts)
end)

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = { "gopls", "sumneko_lua" }
for _, lsp in ipairs(servers) do
	nvim_lsp[lsp].setup({
		on_attach = on_attach,
		flags = {
			debounce_text_changes = 150,
		},
	})
end
