-- helpers stolen from oroques.dev/notes/neovim-init/
local g = vim.g -- a table to access global variables
local opt = vim.opt -- to set options

g.mapleader = " "
g.maplocalleader = "\\"

-- matchparen.vim is annoyingly slow
g["matchparen_timeout"] = 10

-- Pandoc
g["pandoc#syntax#conceal#use"] = 1
g["pandoc#syntax#conceal#backslash"] = 1
g["pandoc#formatting#mode"] = "hA"
g["pandoc#folding#fastfolds"] = 1
g["pandoc#folding#level"] = 1
g["pandoc#after#modules#enabled"] = { "tablemode" }
g["pandoc#command#autoexec_on_writes"] = 1
g["pandoc#command#autoexec_command"] = "Pandoc html --filter mermaid-filter"

-- COQ
g.coq_settings = { auto_start = "shut-up" }

local function ensure_dir(path)
	vim.validate({ path = { path, "string" } })
	local dir_exists = vim.fn.isdirectory(path) == 1
	if not dir_exists then
		print(vim.fn.mkdir(path, "p"))
	end
end

-- Don't let Vim do unsafe stuff
opt.modelines = 0
-- No annoying beep
opt.visualbell = true
-- visual autocomplete for the command menu
opt.wildmenu = true
-- insert "tabstop" number of spaces on tab
opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
-- highlight the line under the cursor
opt.cursorline = true
-- Pay attention to case if there is an upper case letter
opt.smartcase = true
-- Set window title to reflect the file being edited
opt.title = true
-- Enable line wrapping, but not in  the middle of a word
opt.wrap = true
opt.linebreak = true
-- Write the contents of a file on calling make or GoBuild
opt.autowrite = true
-- Make buffers useful
opt.hidden = true

-- Hopefully self-explanatory stuff
opt.number = true
opt.relativenumber = true
opt.syntax = "ON"
opt.ignorecase = true
opt.spell = true
opt.spelllang = "en,de"
opt.lazyredraw = true
opt.encoding = "utf-8"
opt.textwidth = 80
opt.showcmd = true
opt.termguicolors = true
opt.compatible = false
opt.undofile = true
opt.backup = true
opt.writebackup = true
opt.backupcopy = "auto"
local backup_dir = vim.fn.stdpath("data") .. "/backup//"
ensure_dir(backup_dir)
-- add the current directory as a backup
opt.backupdir = backup_dir .. ",."

--- Everything else ---
vim.cmd([[

try
	colorscheme nord
catch
	echo "Nord colorscheme not available"
endtry

"Also provides omni Completion
filetype plugin on

execute "digraphs as " . 0x2090
execute "digraphs es " . 0x2091
execute "digraphs hs " . 0x2095
execute "digraphs is " . 0x1D62
execute "digraphs js " . 0x2C7C
execute "digraphs ks " . 0x2096
execute "digraphs ls " . 0x2097
execute "digraphs ms " . 0x2098
execute "digraphs ns " . 0x2099
execute "digraphs os " . 0x2092
execute "digraphs ps " . 0x209A
execute "digraphs rs " . 0x1D63
execute "digraphs ss " . 0x209B
execute "digraphs ts " . 0x209C
execute "digraphs us " . 0x1D64
execute "digraphs vs " . 0x1D65
execute "digraphs xs " . 0x2093

execute "digraphs aS " . 0x1d43
execute "digraphs bS " . 0x1d47
execute "digraphs cS " . 0x1d9c
execute "digraphs dS " . 0x1d48
execute "digraphs eS " . 0x1d49
execute "digraphs fS " . 0x1da0
execute "digraphs gS " . 0x1d4d
execute "digraphs hS " . 0x02b0
execute "digraphs iS " . 0x2071
execute "digraphs jS " . 0x02b2
execute "digraphs kS " . 0x1d4f
execute "digraphs lS " . 0x02e1
execute "digraphs mS " . 0x1d50
execute "digraphs nS " . 0x207f
execute "digraphs oS " . 0x1d52
execute "digraphs pS " . 0x1d56
execute "digraphs rS " . 0x02b3
execute "digraphs sS " . 0x02e2
execute "digraphs tS " . 0x1d57
execute "digraphs uS " . 0x1d58
execute "digraphs vS " . 0x1d5b
execute "digraphs wS " . 0x02b7
execute "digraphs xS " . 0x02e3
execute "digraphs yS " . 0x02b8
execute "digraphs zS " . 0x1dbb
]])
