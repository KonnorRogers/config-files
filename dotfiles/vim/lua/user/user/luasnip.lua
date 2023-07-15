local status, ls = pcall(require, 'luasnip')
if not status then
	return
end

require("luasnip.loaders.from_lua").lazy_load({
	paths = "~/.vim/snippets"
})

ls.filetype_extend("typescript", { "javascript", "typescriptreact", "javascriptreact" })
ls.filetype_extend("javascriptreact", { "javascript" })
ls.filetype_extend("typescriptreact", { "typescript", "typescriptreact", "javascriptreact" })
