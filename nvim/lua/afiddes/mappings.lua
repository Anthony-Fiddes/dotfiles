local M = {}

-- toggle line numbers
function M.toggle_nums()
	vim.opt.nu = not vim.opt.nu:get()
	vim.opt.rnu = not vim.opt.rnu:get()
end

-- execute command count times
local function repeating(command)
	local count = vim.v.count
	if count == 0 then
		count = 1
	end
	for _ = 1, count do
		vim.cmd(command)
	end
end

function M.next_tab()
	repeating(":bnext")
end

function M.prev_tab()
	repeating(":bprev")
end

--- Sets all of my custom keybindings
function M.set()
	local opts = { noremap = true }
	local silent_opts = { noremap = true, silent = true }
	-- FZF
	vim.keymap.set("n", "<C-p>", ":Files<CR>", opts)
	vim.keymap.set("n", "<M-p>", ":GFiles<CR>", opts)
	vim.keymap.set("n", "<C-f>", ":BLines<CR>", opts)
	vim.keymap.set("n", "<Leader>fb", ":Buffers<CR>", opts) -- 'find buffer'
	vim.keymap.set("n", "<Leader>ff", ":Rg<CR>", opts) -- 'find files'
	vim.keymap.set("n", "<Leader>fc", ":Commits<CR>", opts) -- 'find commit'
	vim.keymap.set("n", "<Leader>H", ":Helptags<CR>", opts)
	vim.keymap.set("n", "<Leader>hh", ":History<CR>", opts)
	vim.keymap.set("n", "<Leader>hc", ":Commands<CR>", opts)
	vim.keymap.set("n", "<Leader>h:", ":History:<CR>", opts)
	vim.keymap.set("n", "<Leader>h/", ":History/<CR>", opts)

	-- Navigation
	vim.keymap.set("n", "<C-PageDown>", ":bnext<CR>", silent_opts)
	vim.keymap.set("n", "<C-PageUp>", ":bprev<CR>", silent_opts)
	vim.keymap.set("n", "gb", M.next_tab, silent_opts)
	vim.keymap.set("n", "gB", M.prev_tab, silent_opts)

	-- Documentation
	vim.keymap.set("n", "<Leader>ng", function() require('neogen').generate() end, opts)
	vim.keymap.set("n", "<Leader>nf", function() require('neogen').generate({ type = 'func' }) end, opts)
	vim.keymap.set("n", "<Leader>nc", function() require('neogen').generate({ type = 'class' }) end, opts)

	-- Misc
	-- change directory to that of the current file
	vim.keymap.set("n", "<Leader>cd", "<Cmd>cd %:p:h<CR>:pwd<CR>", opts)
	vim.keymap.set("n", "<Leader>nh", ":nohlsearch<CR>", opts)
	vim.keymap.set("n", "<Leader>fw", ":update<CR>", opts) -- 'file write'
	vim.keymap.set("n", "<Leader>tl", ":set list!<CR>", opts) -- 'toggle list (show/hide white space)'
	vim.keymap.set("n", "<Leader>tz", ":ZenMode<CR>", opts) -- 'toggle zen'
	vim.keymap.set("n", "<Leader>gp", ":Glow<CR>", opts) -- 'glow preview'
	vim.keymap.set("n", "<Leader>fe", ":NvimTreeToggle<CR>", opts) --  'file explorer'
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
