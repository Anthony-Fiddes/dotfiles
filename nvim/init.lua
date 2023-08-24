-- Bootstrap packer.nvim
local fn = vim.fn
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
	packer_bootstrap = fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim',
		install_path })
end

--- Plugins
local function load_plugins()
	return require("packer").startup(function()
		use("wbthomason/packer.nvim")
		use("lewis6991/impatient.nvim")

		-- Useful Things
		use({ "junegunn/fzf", run = "fzf#install()" })
		use {
			'nvim-telescope/telescope.nvim', tag = '0.1.1',
			requires = { { 'nvim-lua/plenary.nvim' } }
		}
		use({
			"kylechui/nvim-surround",
			tag = "*", -- Use for stability; omit to use `main` branch for the latest features
			config = function()
				require("nvim-surround").setup()
			end
		})
		use({
			"kyazdani42/nvim-tree.lua",
			requires = { "kyazdani42/nvim-web-devicons" },
			config = function()
				require("nvim-tree").setup({})
				local function open_nvim_tree(data)
					-- buffer is a directory
					local directory = vim.fn.isdirectory(data.file) == 1
					if not directory then
						return
					end
					-- change to the directory
					vim.cmd.cd(data.file)
					-- open the tree
					require("nvim-tree.api").tree.open()
				end

				vim.api.nvim_create_autocmd({ "VimEnter" }, { callback = open_nvim_tree })
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
		use("neovim/nvim-lspconfig")
		use({
			"williamboman/mason.nvim",
			config = function()
				require("mason").setup({})
			end
		})
		use({
			"williamboman/mason-lspconfig.nvim",
			config = function()
				require("mason-lspconfig").setup({})
			end
		})
		use({
			"simrat39/rust-tools.nvim",
			requires = {
				'nvim-lua/plenary.nvim',
				'mfussenegger/nvim-dap'
			}
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
				"saadparwaiz1/cmp_luasnip",
				"rafamadriz/friendly-snippets",
				"L3MON4D3/LuaSnip",
				"windwp/nvim-autopairs",
			},
			config = function()
				local cmp = require("cmp")

				require("nvim-autopairs").setup()
				local cmp_autopairs = require('nvim-autopairs.completion.cmp')
				cmp.event:on(
					'confirm_done',
					cmp_autopairs.on_confirm_done()
				)

				local has_words_before = function()
					local line, col = unpack(vim.api.nvim_win_get_cursor(0))
					return col ~= 0 and
						vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
				end
				require("luasnip.loaders.from_vscode").lazy_load()
				local luasnip = require("luasnip")

				cmp.setup({
					snippet = {
						expand = function(args) luasnip.lsp_expand(args.body) end
					},
					mapping = cmp.mapping.preset.insert({
						['<C-b>'] = cmp.mapping.scroll_docs(-4),
						['<C-f>'] = cmp.mapping.scroll_docs(4),
						['<C-Space>'] = cmp.mapping.complete(),
						['<C-e>'] = cmp.mapping.abort(),
						['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
						["<Tab>"] = cmp.mapping(function(fallback)
							if cmp.visible() then
								cmp.select_next_item()
							elseif luasnip.expand_or_jumpable() then
								luasnip.expand_or_jump()
							elseif has_words_before() then
								cmp.complete()
							else
								fallback()
							end
						end, { "i", "s" }),
						["<S-Tab>"] = cmp.mapping(function(fallback)
							if cmp.visible() then
								cmp.select_prev_item()
							elseif luasnip.jumpable(-1) then
								luasnip.jump(-1)
							else
								fallback()
							end
						end, { "i", "s" }),
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
			'creativenull/efmls-configs-nvim',
			tag = 'v1.*', -- tag is optional, but recommended
			requires = { 'neovim/nvim-lspconfig' },
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
						},
					},
					snippet_engine = "luasnip"
				})
			end,
			requires = "nvim-treesitter/nvim-treesitter",
			-- Uncomment next line if you want to follow only stable versions
			-- tag = "*"
		})
		use({ "khaveesh/vim-fish-syntax", ft = "fish" })
		use({ "mtoohey31/cmp-fish", ft = "fish" })

		-- Markdown Things
		use({ "ellisonleao/glow.nvim", ft = { "md", "pandoc" } })
		use({ "vim-pandoc/vim-pandoc", ft = { "md", "pandoc" } })
		use({ "vim-pandoc/vim-pandoc-syntax", ft = { "md", "pandoc" } })
		--   needed for smart autoformatting to play nicely with vim-table-mode
		use({ "vim-pandoc/vim-pandoc-after", ft = { "md", "pandoc" } })
		use({ "dhruvasagar/vim-table-mode", ft = { "md", "pandoc" } })

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
				local lualine = require("lualine")
				lualine.setup({
					tabline = {},
					extensions = { require("afiddes/lualine_ext").word_count_extension }
				})
				lualine.hide({
					place = { "tabline" }, -- The segment this change applies to.
					unhide = false, -- whether to reenable lualine again/
				})
			end,
		})
		use({
			"akinsho/bufferline.nvim",
			tag = "v3.*",
			requires = "nvim-tree/nvim-web-devicons",
			config = function()
				require("bufferline").setup({
					options = {
						indicator = {
							style = 'underline'
						}
					}
				})
			end
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
