-- helpers stolen from oroques.dev/notes/neovim-init/
local g = vim.g -- a table to access global variables
local opt = vim.opt -- to set options

--- Plugins
local function load_plugins()
	return require("packer").startup(function()
		use("wbthomason/packer.nvim")

		-- Useful Things
		use({ "junegunn/fzf", run = "fzf#install()" })
		use("junegunn/fzf.vim")
		use("tpope/vim-surround")
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
				require("mini.comment").setup({})
				require("mini.pairs").setup({})
			end,
		})
		use({
			"folke/which-key.nvim",
			config = function()
				require("which-key").setup({
					plugins = {
						spelling = { enabled = true, suggestions = 10 },
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
		use({ "stevearc/gkeep.nvim", run = ":UpdateRemotePlugins" })
		use("rafcamlet/nvim-luapad")
		use({
			"ggandor/lightspeed.nvim",
			requires = { "tpope/vim-repeat" },
		})
		use({
			"ethanholz/nvim-lastplace",
			config = function()
				require("nvim-lastplace").setup({})
			end,
		})

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
					null_ls.builtins.code_actions.gitsigns,
					null_ls.builtins.diagnostics.write_good.with({
						extra_filetypes = { "pandoc" },
					}),
					null_ls.builtins.diagnostics.proselint.with({
						extra_filetypes = { "pandoc" },
					}),
				}
				null_ls.setup({
					sources = sources,
					on_attach = require("afiddes/lsp-config").on_attach,
				})
			end,
			requires = { "nvim-lua/plenary.nvim" },
		})

		-- Markdown Things
		use("vim-pandoc/vim-pandoc")
		use("vim-pandoc/vim-pandoc-syntax")
		--   needed for smart autoformatting to play nicely with vim-table-mode
		use("vim-pandoc/vim-pandoc-after")
		use("dhruvasagar/vim-table-mode")
		use("ellisonleao/glow.nvim")

		-- Pretty Things
		use("arcticicestudio/nord-vim")
		use({
			"nvim-lualine/lualine.nvim",
			requires = { "kyazdani42/nvim-web-devicons", opt = true },
			config = function()
				require("lualine").setup({ extensions = { require("afiddes/lualine_ext").word_count_extension } })
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
		use({
			"folke/zen-mode.nvim",
			config = function()
				require("zen-mode").setup({
					plugins = {
						kitty = {
							enabled = true,
							font = "+2",
						},
					},
				})
			end,
		})
	end)
end

g.mapleader = " "
g.maplocalleader = "\\"
load_plugins()
require("afiddes/mappings").set()

-- Pandoc
g["pandoc#syntax#conceal#use"] = 1
g["pandoc#syntax#conceal#backslash"] = 1
g["pandoc#formatting#mode"] = "hA"
g["pandoc#folding#fastfolds"] = 1
g["pandoc#folding#level"] = 1
g["pandoc#after#modules#enabled"] = { "tablemode" }

local function ensure_dir(path)
	vim.validate({ path = { path, "string" } })
	local dir_exists = vim.fn.isdirectory(path) == 1
	if not dir_exists then
		print(vim.fn.mkdir(path, "p"))
	end
end

-- Don't let Vim do unsafe stuff
opt.modelines = 0
-- No annoying beep
opt.visualbell = true
-- visual autocomplete for the command menu
opt.wildmenu = true
-- insert "tabstop" number of spaces on tab
opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
-- highlight the line under the cursor
opt.cursorline = true
-- Pay attention to case if there is an upper case letter
opt.smartcase = true
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
opt.syntax = "ON"
opt.ignorecase = true
opt.spell = true
opt.spelllang = "en,de"
opt.lazyredraw = true
opt.encoding = "utf-8"
opt.textwidth = 80
opt.showcmd = true
opt.termguicolors = true
opt.compatible = false
opt.undofile = true
opt.backup = true
opt.writebackup = true
opt.backupcopy = "auto"
local backup_dir = vim.fn.stdpath("data") .. "/backup//"
ensure_dir(backup_dir)
-- add the current directory as a backup
opt.backupdir = backup_dir .. ",."

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

" Vimwiki
let g:vimwiki_list = [{'path': '~/Documents/second_brain',
                      \ 'syntax': 'markdown', 'ext': '.md'}]

execute "digraphs as " . 0x2090
execute "digraphs es " . 0x2091
execute "digraphs hs " . 0x2095
execute "digraphs is " . 0x1D62
execute "digraphs js " . 0x2C7C
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

execute "digraphs aS " . 0x1d43
execute "digraphs bS " . 0x1d47
execute "digraphs cS " . 0x1d9c
execute "digraphs dS " . 0x1d48
execute "digraphs eS " . 0x1d49
execute "digraphs fS " . 0x1da0
execute "digraphs gS " . 0x1d4d
execute "digraphs hS " . 0x02b0
execute "digraphs iS " . 0x2071
execute "digraphs jS " . 0x02b2
execute "digraphs kS " . 0x1d4f
execute "digraphs lS " . 0x02e1
execute "digraphs mS " . 0x1d50
execute "digraphs nS " . 0x207f
execute "digraphs oS " . 0x1d52
execute "digraphs pS " . 0x1d56
execute "digraphs rS " . 0x02b3
execute "digraphs sS " . 0x02e2
execute "digraphs tS " . 0x1d57
execute "digraphs uS " . 0x1d58
execute "digraphs vS " . 0x1d5b
execute "digraphs wS " . 0x02b7
execute "digraphs xS " . 0x02e3
execute "digraphs yS " . 0x02b8
execute "digraphs zS " . 0x1dbb
]])

local lsp_installer = require("nvim-lsp-installer")

-- Register a handler that will be called for each installed server when it's
-- ready (i.e. when installation is finished
-- or if the server is already installed).
lsp_installer.on_server_ready(function(server)
	local opts = {
		on_attach = require("afiddes/lsp-config").on_attach,
	}

	if server.name == "sumneko_lua" then
		opts.settings = {
			Lua = {
				diagnostics = {
					enable = true,
					globals = { "vim", "use" },
				},
			},
		}
	end

	-- This setup() function will take the provided server configuration and decorate it with the necessary properties
	-- before passing it onwards to lspconfig.
	-- Refer to https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
	server:setup(opts)
end)

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = { "gopls" }
for _, lsp in pairs(servers) do
	require("lspconfig")[lsp].setup({
		on_attach = require("afiddes/lsp-config").on_attach,
		flags = {
			-- This will be the default in neovim 0.7+
			debounce_text_changes = 150,
		},
	})
end
