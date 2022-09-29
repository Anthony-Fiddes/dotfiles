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
				require("mini.indentscope").setup({
					draw = {
						delay = 25,
					}
				})
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
		use('tpope/vim-fugitive')
		use({
			"lewis6991/gitsigns.nvim",
			requires = { "nvim-lua/plenary.nvim" },
			config = function()
				require("gitsigns").setup()
			end,
		})
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
			requires = {
				"windwp/nvim-ts-autotag",
				"JoosepAlviste/nvim-ts-context-commentstring"
			},
			config = function()
				require("nvim-treesitter.configs").setup({
					autotag = {
						enable = true,
					},
					context_commentstring = {
						enable = true,
						enable_autocmd = false,
					},
					highlight = {
						enable = true,
					},
					indent = {
						enable = true,
					},
				})
			end,
		})
		-- TODO: Remove once 0.8 drops
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
			},
			config = function()
				require("mason").setup({})
				require("mason-lspconfig").setup({})
			end,
		})
		use({
			"L3MON4D3/LuaSnip",
			tag = "v<CurrentMajor>.*",
			requires = {
				"rafamadriz/friendly-snippets"
			},
			config = function()
				require("luasnip.loaders.from_vscode").lazy_load()
			end
		})
		use({
			"hrsh7th/nvim-cmp",
			requires = {
				"neovim/nvim-lspconfig",
				"hrsh7th/cmp-calc",
				"hrsh7th/cmp-buffer",
				"hrsh7th/cmp-path",
				"hrsh7th/cmp-cmdline",
				"hrsh7th/cmp-nvim-lsp",
				"hrsh7th/cmp-nvim-lsp-signature-help",
				"hrsh7th/cmp-nvim-lua",
				"L3MON4D3/LuaSnip",
				"windwp/nvim-autopairs",
			},
			config = function()
				local cmp = require("cmp")

				local cmp_autopairs = require('nvim-autopairs.completion.cmp')
				cmp.event:on(
					'confirm_done',
					cmp_autopairs.on_confirm_done()
				)

				cmp.setup({
					snippet = {
						expand = function(args) require("luasnip").lsp_expand(args.body) end
					},
					mapping = cmp.mapping.preset.insert({
						['<C-b>'] = cmp.mapping.scroll_docs(-4),
						['<C-f>'] = cmp.mapping.scroll_docs(4),
						['<C-Space>'] = cmp.mapping.complete(),
						['<C-e>'] = cmp.mapping.abort(),
						['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
					}),
					sources = cmp.config.sources(
						{
							{ name = 'nvim_lsp_signature_help' },
							{ name = 'nvim_lsp' },
							{ name = 'nvim_lua' },
							{ name = 'luasnip' }, -- For luasnip users.
							{ name = 'calc' },
							{ name = 'fish' },
							{ name = 'buffer' },
							{ name = 'path' },
						}
					)
				})

				-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
				for _, v in pairs({ '/', '?' }) do
					cmp.setup.cmdline(v, {
						mapping = cmp.mapping.preset.cmdline(),
						sources = {
							{ name = 'buffer' }
						}
					})
				end

				-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
				cmp.setup.cmdline(':', {
					mapping = cmp.mapping.preset.cmdline(),
					sources = cmp.config.sources({
						{ name = 'path' }
					}, {
						{ name = 'cmdline' }
					})
				})
			end
		})
		use({
			"ray-x/go.nvim",
			config = function()
				require("go").setup()
			end,
			ft = "go"
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
			ft = "py",
			-- Uncomment next line if you want to follow only stable versions
			-- tag = "*"
		})
		use({ "khaveesh/vim-fish-syntax", ft = "fish" })
		use({ "mtoohey31/cmp-fish", ft = "fish" })

		-- Markdown Things
		use({ "ellisonleao/glow.nvim", ft = "md" })
		use({ "vim-pandoc/vim-pandoc", ft = "md" })
		use({ "vim-pandoc/vim-pandoc-syntax", ft = "md" })
		--   needed for smart autoformatting to play nicely with vim-table-mode
		use({ "vim-pandoc/vim-pandoc-after", ft = "md" })
		use({ "dhruvasagar/vim-table-mode", ft = "md" })

		-- Pretty Things
		-- use("arcticicestudio/nord-vim") trying out onedark
		use({
			"navarasu/onedark.nvim",
			config = function()
				require("onedark").setup()
				require('onedark').load()
			end
		})
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
		use {
			"numToStr/Comment.nvim",
			requires = { "JoosepAlviste/nvim-ts-context-commentstring" },
			config = function()
				require('Comment').setup({
					pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook()
				})
			end
		}
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

pcall(require, "impatient") -- call impatient if installed
require("afiddes/settings")
load_plugins()
require("afiddes/mappings").set()
require("afiddes/lsp-config").setup_servers()
