local M = {}

-- toggle line numbers
function M.toggle_nums()
	vim.opt.nu = not vim.opt.nu:get()
	vim.opt.rnu = not vim.opt.rnu:get()
end

-- execute command count times
local function repeating(command)
	return function()
		local count = vim.v.count
		if count == 0 then
			count = 1
		end
		for _ = 1, count do
			vim.cmd(command)
		end
	end
end

--- Sets all of my custom keybindings
function M.set()
	local opts = { noremap = true }
	local silent_opts = { noremap = true, silent = true }

	-- fzf-lua
	-- I've noticed some bugginess with certain commands, if it gets too bad, I
	-- may try telescope.
	vim.keymap.set("n", "<C-p>", ":FzfLua files<CR>", opts)
	vim.keymap.set("n", "<M-p>", ":FzfLua git_files<CR>", opts)
	vim.keymap.set("n", "<C-f>", ":FzfLua blines<CR>", opts)
	vim.keymap.set("n", "<Leader>fb", ":FzfLua buffers<CR>", opts) -- 'find in buffer'
	vim.keymap.set("n", "<Leader>ff", ":FzfLua live_grep<CR>", opts) -- 'find in files'
	vim.keymap.set("n", "<Leader>fr", ":FzfLua live_grep_resume<CR>", opts) -- 'find in files resume'
	vim.keymap.set("n", "<Leader>fc", ":FzfLua git_commits<CR>", opts) -- 'find commit'
	vim.keymap.set("n", "<Leader>fd", ":FzfLua lsp_workspace_diagnostics<CR>", opts) -- find diagnostics
	vim.keymap.set("n", "<Leader>fs", ":FzfLua lsp_live_workspace_symbols<CR>", opts) -- find symbols
	vim.keymap.set("n", "<Leader>fl", ":FzfLua builtin<CR>", opts) -- fzf-lua pickers
	vim.keymap.set("n", "<Leader>H", ":FzfLua help_tags<CR>", opts)
	vim.keymap.set("n", "<Leader>hh", ":FzfLua oldfiles<CR>", opts)
	vim.keymap.set("n", "<Leader>hc", ":FzfLua commands<CR>", opts)
	vim.keymap.set("n", "<Leader>h:", ":FzfLua command_history<CR>", opts)
	vim.keymap.set("n", "<Leader>h/", ":FzfLua search_history<CR>", opts)

	-- Navigation
	vim.keymap.set("n", "<C-PageDown>", ":bnext<CR>", silent_opts)
	vim.keymap.set("n", "<C-PageUp>", ":bprev<CR>", silent_opts)
	vim.keymap.set("n", "gb", repeating("bnext"), silent_opts)
	vim.keymap.set("n", "gB", repeating("bprev"), silent_opts)

	-- Documentation
	vim.keymap.set("n", "<Leader>ng", function() require('neogen').generate() end, opts)
	vim.keymap.set("n", "<Leader>nf", function() require('neogen').generate({ type = 'func' }) end, opts)
	vim.keymap.set("n", "<Leader>nc", function() require('neogen').generate({ type = 'class' }) end, opts)

	-- GitSigns
	local ok, gs = pcall(require, "gitsigns")
	if ok then
		vim.keymap.set("n", "<Leader>hp", gs.preview_hunk, opts) -- 'hunk preview'
		vim.keymap.set({ "n", "v" }, "<Leader>hr", ":Gitsigns reset_hunk<CR>", opts) -- 'hunk reset'
		vim.keymap.set({ "n", "v" }, "<Leader>hs", ":Gitsigns stage_hunk<CR>", opts) -- 'hunk stage'
		vim.keymap.set("n", "<Leader>hu", gs.undo_stage_hunk, opts) -- 'hunk undo stage'
		vim.keymap.set("n", "<Leader>hb", function() gs.blame_line({full=true}) end, opts) -- 'hunk blame'
		vim.keymap.set("n", "<Leader>hn", gs.next_hunk, opts) -- 'hunk next'
		vim.keymap.set("n", "<Leader>hN", gs.prev_hunk, opts) -- 'hunk prev'
		vim.keymap.set("n", "<Leader>tb", gs.toggle_current_line_blame, opts) -- 'hunk prev'
	end

	-- Misc
	-- change directory to that of the current file
	vim.keymap.set("n", "<Leader>cd", "<Cmd>cd %:p:h<CR>:pwd<CR>", opts)
	vim.keymap.set("n", "<Leader>nh", ":nohlsearch<CR>", opts)
	vim.keymap.set("n", "<Leader>uf", ":update<CR>", opts) -- 'update file'
	vim.keymap.set("n", "<Leader>rf", ":e!<CR>", opts) -- 'reload file'
	vim.keymap.set("n", "<Leader>tl", ":set list!<CR>", opts) -- 'toggle list (show/hide white space)'
	vim.keymap.set("n", "<Leader>ts", ":set spell!<CR>", opts) -- 'toggle spellcheck'
	vim.keymap.set("n", "<Leader>tz", ":ZenMode<CR>", opts) -- 'toggle zen'
	vim.keymap.set("n", "<Leader>gp", ":Glow<CR>", opts) -- 'glow preview'
	vim.keymap.set("n", "<Leader>tf", repeating(":NvimTreeFindFileToggle"), opts) --  'toggle file explorer'
	vim.keymap.set("n", "<Leader>tn", M.toggle_nums, silent_opts) -- 'toggle line numbers'

	-- IPA Keybindings
	local function append(str)
		return "a" .. str .. "<Esc>"
	end

	vim.keymap.set("n", "<Leader>ia", append("ɑ"), opts)
	vim.keymap.set("n", "<Leader>ic", append("ç"), opts)
	vim.keymap.set("n", "<Leader>id", append("ð"), opts)
	vim.keymap.set("n", "<Leader>i3", append("ɛ"), opts)
	vim.keymap.set("n", "<Leader>ie", append("ə"), opts)
	vim.keymap.set("n", "<Leader>if", append("ɸ"), opts)
	vim.keymap.set("n", "<Leader>ii", append("ɪ"), opts)
	vim.keymap.set("n", "<Leader>in", append("ŋ"), opts)
	vim.keymap.set("n", "<Leader>io", append("ɔ"), opts)
	vim.keymap.set("n", "<Leader>ir", append("ɾ"), opts)
	vim.keymap.set("n", "<Leader>is", append("ʃ"), opts)
	vim.keymap.set("n", "<Leader>it", append("θ"), opts)
	vim.keymap.set("n", "<Leader>iu", append("ʊ"), opts)
	vim.keymap.set("n", "<Leader>iv", append("ʌ"), opts)
	vim.keymap.set("n", "<Leader>iw", append("ɯ"), opts)
	vim.keymap.set("n", "<Leader>iy", append("ɣ"), opts)
	vim.keymap.set("n", "<Leader>iz", append("ʒ"), opts)
	vim.keymap.set("n", "<Leader>i?", append("ʔ"), opts)
end

return M
