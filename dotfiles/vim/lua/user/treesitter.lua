local status_ok, treesitter = pcall(require, "nvim-treesitter")
if not status_ok then
	return
end

local status_ok, configs = pcall(require, "nvim-treesitter.configs")
if not status_ok then
	return
end

local disable_fn = function(lang, bufnr) -- Disable in large C++ buffers
	local filetypes = lang == "TelescopePrompt" or lang == "netrw" or lang == "markdown"
	return filetypes or vim.api.nvim_buf_line_count(bufnr) > 2000
end

configs.setup({
  ensure_installed = { "lua", "bash", "yaml", "jsdoc", "typescript", "javascript", "ruby" }, -- put the language you want in this array
	ignore_install = { "" }, -- List of parsers to ignore installing
	sync_install = false, -- install languages synchronously (only applied to `ensure_installed`)
	disable = disable_fn,

  highlight = {
		enable = true, -- false will disable the whole extension
		disable = disable_fn, -- list of language that will be disabled
	},

	indent = { enable = true, disable = disable_fn },

	context_commentstring = {
		enable = true,
		enable_autocmd = false,
		disable = disable_fn
	},

  rainbow = {
		disable = disable_fn,
    enable = true,
    -- disable = { "jsx", "cpp" }, list of languages you want to disable the plugin for
    extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
    max_file_lines = 2000, -- Do not enable for files with more than n lines, int
    -- colors = {}, -- table of hex strings
    -- termcolors = {} -- table of colour name strings
  }
})
