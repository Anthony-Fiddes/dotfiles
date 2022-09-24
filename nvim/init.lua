-- Bootstrap packer.nvim
local fn = vim.fn
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
	packer_bootstrap = fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
end

--- Plugins
local function load_plugins()
	return require("packer").startup(function()
		use("wbthomason/packer.nvim")
		use("lewis6991/impatient.nvim")

		-- Useful Things
		use({ "junegunn/fzf", run = "fzf#install()" })
		use({ 'ibhagwan/fzf-lua',
			-- optional for icon support
			requires = { 'kyazdani42/nvim-web-devicons' }
		})
		use("tpope/vim-surround")
		use({
			"kyazdani42/nvim-tree.lua",
			requires = { "kyazdani42/nvim-web-devicons" },
			config = function()
				require("nvim-tree").setup({})
			end,
		})
		use({
			"echasnovski/mini.nvim",
			branch = "stable",
			config = function()
				require("mini.comment").setup({})
				require("mini.indentscope").setup({
					draw = {
						delay = 25,
					}
				})
				require("mini.pairs").setup({})
				require("mini.tabline").setup({})
				require("mini.starter").setup({})
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
		use({
			"nmac427/guess-indent.nvim",
			config = function()
				require('guess-indent').setup({})
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
		use({
			"neovim/nvim-lspconfig",
			requires = {
				"williamboman/mason.nvim",
				"williamboman/mason-lspconfig.nvim",
				"ms-jpq/coq_nvim"
			},
			config = function()
				require("mason").setup({})
				require("mason-lspconfig").setup({})
			end,
		})
		use({ "ms-jpq/coq_nvim", branch = "coq" })
		use({ "ms-jpq/coq.artifacts", branch = "artifacts" })
		use({
			"ray-x/go.nvim",
			config = function()
				require("go").setup()
			end
		})
		use({
			"ray-x/lsp_signature.nvim",
			config = function()
				require("lsp_signature").setup()
			end,
		})
		use({
			"jose-elias-alvarez/null-ls.nvim",
			config = function()
				local null_ls = require("null-ls")
				local sources = {
					null_ls.builtins.formatting.prettier,
					null_ls.builtins.formatting.black,
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
		use({
			"danymat/neogen",
			config = function()
				require('neogen').setup({
					languages = {
						python = {
							template = {
								annotation_convention = "reST"
							}
						}
					}
				})
			end,
			requires = "nvim-treesitter/nvim-treesitter",
			-- Uncomment next line if you want to follow only stable versions
			-- tag = "*"
		})
		use("khaveesh/vim-fish-syntax")

		-- Markdown Things
		use("ellisonleao/glow.nvim")
		use("vim-pandoc/vim-pandoc")
		use("vim-pandoc/vim-pandoc-syntax")
		--   needed for smart autoformatting to play nicely with vim-table-mode
		use("vim-pandoc/vim-pandoc-after")
		use("dhruvasagar/vim-table-mode")

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
			"folke/todo-comments.nvim",
			requires = { "nvim-lua/plenary.nvim" },
			config = function()
				require("todo-comments").setup {
					-- your configuration comes here
					-- or leave it empty to use the default settings
					-- refer to the configuration section below
				}
			end
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

		if packer_bootstrap then
			require('packer').sync()
		end
	end

	)

end

pcall(require, "impatient")
require("afiddes/settings")
load_plugins()
require("afiddes/mappings").set()
require("afiddes/lsp-config").setup_servers()
