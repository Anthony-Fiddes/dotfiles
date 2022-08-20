local M = {}

-- helpers stolen from oroques.dev/notes/neovim-init/
function M.map(mode, lhs, rhs, opts)
	local options = { noremap = true }
	if opts then
		options = vim.tbl_extend("force", options, opts)
	end
	vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

function M.silent_map(mode, lhs, rhs)
	M.map(mode, lhs, rhs, { noremap = true, silent = true })
end

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
	-- FZF
	M.silent_map("n", "<C-p>", ":Files<CR>")
	M.silent_map("n", "<M-p>", ":GFiles<CR>")
	M.silent_map("n", "<C-f>", ":BLines<CR>")
	M.silent_map("n", "<Leader>fb", ":Buffers<CR>") -- 'find buffer'
	M.silent_map("n", "<Leader>ff", ":Rg<CR>") -- 'find files'
	M.silent_map("n", "<Leader>fc", ":Commits<CR>") -- 'find commit'
	M.silent_map("n", "<Leader>H", ":Helptags<CR>")
	M.silent_map("n", "<Leader>hh", ":History<CR>")
	M.silent_map("n", "<Leader>hc", ":Commands<CR>")
	M.silent_map("n", "<Leader>h:", ":History:<CR>")
	M.silent_map("n", "<Leader>h/", ":History/<CR>")

	-- Navigation
	M.silent_map("n", "<C-PageDown>", ":bnext<CR>")
	M.silent_map("n", "<C-PageUp>", ":bprev<CR>")
	M.silent_map("n", "gb", ":lua require('afiddes/mappings').next_tab()<CR>")
	M.silent_map("n", "gB", ":lua require('afiddes/mappings').prev_tab()<CR>")

	-- Misc
	-- change directory to that of the current file
	M.map("n", "<Leader>cd", "<Cmd>cd %:p:h<CR>:pwd<CR>")
	M.map("n", "<Leader>nh", ":nohlsearch<CR>")
	M.map("n", "<Leader>fw", ":update<CR>") -- 'file write'
	M.map("n", "<Leader>tl", ":set list!<CR>") -- 'toggle list (show/hide white space)'
	M.map("n", "<Leader>tz", ":ZenMode<CR>") -- 'toggle zen'
	M.map("n", "<Leader>gp", ":Glow<CR>") -- 'glow preview'
	M.map("n", "<Leader>fe", ":NvimTreeToggle<CR>") --  'file explorer'
	M.silent_map("n", "<Leader>tn", ":lua require('afiddes/mappings').toggle_nums()<CR>") -- 'toggle line numbers'

	-- IPA Keybindings
	local function append(str)
		return "a" .. str .. "<Esc>"
	end

	M.map("n", "<Leader>ia", append("ɑ"))
	M.map("n", "<Leader>ic", append("ç"))
	M.map("n", "<Leader>id", append("ð"))
	M.map("n", "<Leader>i3", append("ɛ"))
	M.map("n", "<Leader>ie", append("ə"))
	M.map("n", "<Leader>if", append("ɸ"))
	M.map("n", "<Leader>ii", append("ɪ"))
	M.map("n", "<Leader>in", append("ŋ"))
	M.map("n", "<Leader>io", append("ɔ"))
	M.map("n", "<Leader>ir", append("ɾ"))
	M.map("n", "<Leader>is", append("ʃ"))
	M.map("n", "<Leader>it", append("θ"))
	M.map("n", "<Leader>iu", append("ʊ"))
	M.map("n", "<Leader>iv", append("ʌ"))
	M.map("n", "<Leader>iw", append("ɯ"))
	M.map("n", "<Leader>iy", append("ɣ"))
	M.map("n", "<Leader>iz", append("ʒ"))
	M.map("n", "<Leader>i?", append("ʔ"))

end

return M
