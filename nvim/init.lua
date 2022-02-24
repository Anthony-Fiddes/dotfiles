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

require("afiddes/settings")
load_plugins()
require("afiddes/mappings").set()
