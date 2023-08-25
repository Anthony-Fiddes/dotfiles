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
	local opts = { noremap = true, silent = false }
	local silent_opts = { noremap = true, silent = true }
	local wk = require("which-key")

	-- telescope
	local find_buffer = { "<cmd>Telescope buffers<CR>", "Find buffer" }
	wk.register(
		{
			["<Leader>f"] = {
				name = "find",
				b = find_buffer,
				f = { "<cmd>Telescope live_grep<CR>", "Live Grep (find in files)" },
				c = { "<cmd>Telescope git_commits<CR>", "Find commit" },
				d = { "<cmd>Telescope diagnostics<CR>", "Find diagnostics" },
				gs = { "<cmd>Telescope git_status<CR>", "(Find) Git status" },
				j = { "<cmd>Telescope jumplist<CR>", "Find jumplist" },
				k = { "<cmd>Telescope keymaps<CR>", "Find keymaps" },
				o = { "<cmd>Telescope vim_options<CR>", "Find options" },
				r = { "<cmd>Telescope resume<CR>", "Finder resume" },
				s = { "<cmd>Telescope lsp_workspace_symbols<CR>", "Find symbols" },
				w = { "<cmd>Telescope grep_string<CR>", "Find word (under cursor)" },
				['/'] = { "<cmd>Telescope search_history<CR>", "Find search history" },
				[':'] = { "<cmd>Telescope command_history<CR>", "Find command history" },
				['"'] = { "<cmd>Telescope registers<CR>", "Find registers" },
			},
			["<Leader>b"] = find_buffer
		},
		opts
	)

	-- TODO: keep converting to WhichKey
	vim.keymap.set("n", "<C-p>", "<cmd>Telescope find_files<CR>", opts)
	vim.keymap.set("n", "<M-p>", "<cmd>Telescope git_files<CR>", opts)
	vim.keymap.set("n", "<C-f>", "<cmd>Telescope current_buffer_fuzzy_find<CR>", opts)
	vim.keymap.set("n", "<Leader>ht", '<cmd>Telescope builtin<CR>', opts)          -- help telescope (get pickers)
	vim.keymap.set("n", "<Leader>H", "<cmd>Telescope help_tags<CR>", opts)         -- HELP
	vim.keymap.set("n", "<Leader>hc", "<cmd>Telescope commands<CR>", opts)         -- help commands
	vim.keymap.set("n", "<Leader>hh", "<cmd>Telescope oldfiles<CR>", opts)         -- history history
	vim.keymap.set("n", "<Leader>h<cmd>", "<cmd>Telescope command_history<CR>", opts) -- history commands
	vim.keymap.set("n", "<Leader>h/", "<cmd>Telescope commands<CR>", opts)         -- history search

	-- Navigation
	vim.keymap.set("n", "<C-PageDown>", "<cmd>bnext<CR>", silent_opts)
	vim.keymap.set("n", "<C-PageUp>", "<cmd>bprev<CR>", silent_opts)
	vim.keymap.set("n", "g/", repeating("bnext"), silent_opts)
	vim.keymap.set("n", "g?", repeating("bprev"), silent_opts)

	-- Documentation
	local ok, neogen = pcall(require, "neogen")
	if ok then
		vim.keymap.set("n", "<Leader>ng", function() neogen.generate() end, opts)
		vim.keymap.set("n", "<Leader>nf", function() neogen.generate({ type = 'func' }) end, opts)
		vim.keymap.set("n", "<Leader>nc", function() neogen.generate({ type = 'class' }) end, opts)
	end

	-- GitSigns
	local ok, gs = pcall(require, "gitsigns")
	if ok then
		vim.keymap.set("n", "<Leader>hp", gs.preview_hunk, opts)                         -- 'hunk preview'
		vim.keymap.set({ "n", "v" }, "<Leader>hr", ":Gitsigns reset_hunk<CR>", opts)     -- 'hunk reset'
		vim.keymap.set({ "n", "v" }, "<Leader>hs", ":Gitsigns stage_hunk<CR>", opts)     -- 'hunk stage'
		vim.keymap.set("n", "<Leader>hu", gs.undo_stage_hunk, opts)                      -- 'hunk undo stage'
		vim.keymap.set("n", "<Leader>hb", function() gs.blame_line({ full = true }) end, opts) -- 'hunk blame'
		vim.keymap.set("n", "<Leader>hn", gs.next_hunk, opts)                            -- 'hunk next'
		vim.keymap.set("n", "<Leader>hN", gs.prev_hunk, opts)                            -- 'hunk prev'
		vim.keymap.set("n", "<Leader>tb", gs.toggle_current_line_blame, opts)            -- 'hunk prev'
	end

	-- Copy/Paste
	vim.keymap.set("n", "<Leader>v", "i<C-r>+<Esc>", opts)
	vim.keymap.set("n", "<Leader>V", "a<C-r>+<Esc>", opts)
	vim.keymap.set("v", "<Leader>c", "\"+y", opts)

	-- Substitute
	vim.keymap.set("v", "<Leader>s", "y:%s/<C-r>\"/", opts)

	-- Misc
	-- change directory to that of the current file
	vim.keymap.set("n", "<Leader>cd", "<Cmd>cd %:p:h<CR>:pwd<CR>", opts)
	vim.keymap.set("n", "<Leader>nh", ":nohlsearch<CR>", opts)
	vim.keymap.set("n", "<Leader>u", ":update<CR>", opts)               -- 'update file'
	vim.keymap.set("n", "<Leader>rf", ":e!<CR>", opts)                  -- 'reload file'
	vim.keymap.set("n", "<Leader>tl", ":set list!<CR>", opts)           -- 'toggle list (show/hide white space)'
	vim.keymap.set("n", "<Leader>ts", ":set spell!<CR>", opts)          -- 'toggle spellcheck'
	vim.keymap.set("n", "<Leader>gp", ":Glow<CR>", opts)                -- 'glow preview'
	vim.keymap.set("n", "<Leader>tf", ":NvimTreeFindFileToggle<CR>", opts) --  'toggle file explorer'
	vim.keymap.set("n", "<Leader>of", ":NvimTreeFindFile!<CR>", opts)   --  'open file explorer'
	vim.keymap.set("n", "<Leader>on", ":on<CR>", opts)                  --  ':only (close all other windows)'
	vim.keymap.set("n", "<Leader>tn", M.toggle_nums, silent_opts)       -- 'toggle line numbers'

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
