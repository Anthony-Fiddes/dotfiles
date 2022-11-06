local M = {}

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
	vim.keymap.set("n", "<Leader>e", vim.diagnostic.open_float, opts)
	vim.keymap.set("n", "<Leader>td", M.toggle_diagnostics, opts)
	vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
	vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
	vim.keymap.set("n", "<Leader>q", vim.diagnostic.setloclist, opts)

	if pcall(require, "lsp_signature") then
		require("lsp_signature").on_attach()
	end

	local function setup_formatting(client, bufnr)
		-- using the current client to format helps to avoid the issue of having
		-- to choose from multiple LSP clients when formatting. Simply add any
		-- offending clients to the formatting_disabled table below.
		local function client_format()
			local params = vim.lsp.util.make_formatting_params({})
			client.request('textDocument/formatting', params, nil, bufnr)
		end

		vim.keymap.set('n', '<leader>fo', client_format, { buffer = bufnr })

		local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
		if client.supports_method("textDocument/formatting") then
			vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
			vim.api.nvim_create_autocmd("BufWritePre", {
				group = augroup,
				buffer = bufnr,
				callback = client_format,
			})
		end
	end

	local formatting_disabled = {}
	formatting_disabled["tsserver"] = true
	if not formatting_disabled[client.name] == true then
		setup_formatting(client, bufnr)
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
	local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
	lspconfig.tsserver.setup({
		capabilities = capabilities, on_attach = M.on_attach
	})
	lspconfig.sumneko_lua.setup({
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
end

return M
