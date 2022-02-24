local M = {}

local function word_count()
	local counts = vim.fn.wordcount()
	local result = counts.words
	if counts.visual_words then
		result = counts.visual_words
	end
	return string.format("%d Words", result)
end

-- I copied most of the default config over to the extension. The next order of
-- business would be figuring out how to make it apply specifically to ".md"
-- files instead of the pandoc filetype.
M.word_count_extension = {
	options = {
		icons_enabled = true,
		theme = "auto",
		component_separators = { left = "", right = "" },
		section_separators = { left = "", right = "" },
		disabled_filetypes = {},
		always_divide_middle = true,
	},
	sections = {
		lualine_a = { "mode" },
		lualine_c = { "filename" },
		lualine_x = { word_count },
		lualine_y = { "progress" },
		lualine_z = { "location" },
	},
	inactive_sections = {
		lualine_c = { "filename" },
		lualine_x = { "location" },
	},
	filetypes = { "pandoc" },
}

return M
