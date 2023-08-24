local M       = {}
-- only create the augroup once
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
function M.on_attach(client, bufnr)
	local function buf_set_option(...)
		vim.api.nvim_buf_set_option(bufnr, ...)
	end

	-- Enable completion triggered by <c-x><c-o>
	buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

	-- Mappings.
	local opts = { noremap = true, silent = true }
	-- See `:help vim.lsp.*` for documentation on any of the below functions
	vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
	vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
	vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
	vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
	vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
	vim.keymap.set("n", "<Leader>wa", vim.lsp.buf.add_workspace_folder, opts)
	vim.keymap.set("n", "<Leader>wr", vim.lsp.buf.remove_workspace_folder, opts)
	vim.keymap.set("n", "<Leader>wl", function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end, opts)
	vim.keymap.set("n", "<Leader>D", vim.lsp.buf.type_definition, opts)
	vim.keymap.set("n", "<Leader>rn", vim.lsp.buf.rename, opts)
	vim.keymap.set("n", "<Leader>ca", vim.lsp.buf.code_action, opts)
	vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
	vim.keymap.set("n", "<Leader>d", vim.diagnostic.open_float, opts)
	vim.keymap.set("n", "<Leader>td", M.toggle_diagnostics, opts)
	vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
	vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
	vim.keymap.set("n", "<Leader>q", vim.diagnostic.setloclist, opts)

	if pcall(require, "lsp_signature") then
		require("lsp_signature").on_attach()
	end

	local formatting_disabled = {}
	formatting_disabled["tsserver"] = true
	formatting_disabled["jedi_language_server"] = true
	if not formatting_disabled[client.name] then
		M.setup_formatting(client, bufnr)
	end
end

function M.setup_formatting(client, bufnr)
	-- use a buffer variable to determine whether formatting is
	-- enabled per buffer
	if vim.b.auto_format_enabled == nil then
		if vim.g.auto_format_enabled ~= nil then
			-- buffer variable default can be configured globally
			vim.b.auto_format_enabled = vim.g.auto_format_enabled
		else
			-- default if there's not global config
			vim.b.auto_format_enabled = true
		end
	end

	local function toggle_auto_formatting()
		vim.b.auto_format_enabled = not vim.b.auto_format_enabled
		if vim.b.auto_format_enabled then
			print("autoformatting enabled")
		else
			print("autoformatting disabled")
		end
	end

	-- using the current client to format helps to avoid the issue of having
	-- to choose from multiple LSP clients when formatting. Simply add any
	-- offending clients to the formatting_disabled table below.
	local function client_format()
		vim.lsp.buf.format({ async = false })
	end

	-- give the option to disable auto formatting per buffer
	local function format_buf()
		if not vim.b.auto_format_enabled then
			return
		end
		client_format()
	end

	vim.keymap.set('n', '<leader>fo', client_format, { buffer = bufnr })       -- format
	vim.keymap.set('n', '<leader>ft', toggle_auto_formatting, { buffer = bufnr }) -- format toggle
	if client.supports_method("textDocument/rangeFormatting") then
		-- makes gq use lsp if it can		
		-- I believe this is required because null-ls can mess up formatexpr
		vim.api.nvim_buf_set_option(bufnr, "formatexpr", "v:lua.vim.lsp.formatexpr()")
	end
	-- reference doc: https://github.com/jose-elias-alvarez/null-ls.nvim/wiki/Formatting-on-save
	if client.supports_method("textDocument/formatting") then
		-- clear autocmds so the formatting command is only set once
		vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
		vim.api.nvim_create_autocmd("BufWritePre", {
			group = augroup,
			buffer = bufnr,
			callback = format_buf,
		})
	end
end

-- Toggles the rendering of LSP diagnostic information.
-- This is useful when writing and using prose linters.
function M.toggle_diagnostics()
	if vim.w.diag_disabled then
		vim.diagnostic.enable()
		vim.w.diag_disabled = false
	else
		vim.diagnostic.disable()
		vim.w.diag_disabled = true
	end
end

function M.setup_servers()
	local lspconfig = require("lspconfig")
	local capabilities = require('cmp_nvim_lsp').default_capabilities()

	if pcall(require, "efmls-configs") then
		local eslint = require('efmls-configs.linters.eslint')
		local prettier = require('efmls-configs.formatters.prettier')
		local stylua = require('efmls-configs.formatters.stylua')
		local gofmt = require('efmls-configs.formatters.gofmt')
		local goimports = require('efmls-configs.formatters.goimports')
		local black = require('efmls-configs.formatters.black')
		local flake8 = require('efmls-configs.linters.flake8')
		local yamllint = require('efmls-configs.linters.yamllint')
		local fish = require('efmls-configs.linters.fish')
		local fish_indent = require('efmls-configs.formatters.fish_indent')

		local languages = {
			fish = { fish, fish_indent },
			go = { gofmt, goimports },
			lua = { stylua },
			python = { black, flake8 },
			typescript = { eslint, prettier },
			javascript = { eslint, prettier },
			json = { prettier },
			yaml = { yamllint },
		}

		local efmls_config = {
			filetypes = vim.tbl_keys(languages),
			settings = {
				rootMarkers = { '.git/' },
				languages = languages,
			},
			init_options = {
				documentFormatting = true,
				documentRangeFormatting = true,
			},
		}

		require('lspconfig').efm.setup(vim.tbl_extend('force', efmls_config, {
			on_attach = M.on_attach,
			capabilities = capabilities,
		}))
	end

	lspconfig.tsserver.setup({
		capabilities = capabilities, on_attach = M.on_attach
	})
	lspconfig.lua_ls.setup({
		capabilities = capabilities,
		settings = {
			Lua = {
				diagnostics = {
					enable = true,
					globals = { "vim", "use" },
				},
			},
		},
		on_attach = M.on_attach
	})
	lspconfig.gopls.setup({
		capabilities = capabilities,
		on_attach = M.on_attach
	})
	lspconfig.jedi_language_server.setup({
		capabilities = capabilities,
		on_attach = M.on_attach
	})
	lspconfig.julials.setup({
		capabilities = capabilities,
		on_attach = M.on_attach
	})

	local ok, rt = pcall(require, "rust-tools")
	if ok then
		rt.setup({
			server = {
				capabilities = capabilities,
				on_attach = M.on_attach
			},
		})
	end
end

return M
