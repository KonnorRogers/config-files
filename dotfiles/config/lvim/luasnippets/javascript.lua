local status, ls = pcall(require, 'luasnip')
if not status then
	return {}
end

local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
-- local sn = ls.snippet_node
-- local isn = ls.indent_snippet_node
-- local f = ls.function_node
-- local c = ls.choice_node
-- local d = ls.dynamic_node
-- local r = ls.restore_node
-- local events = require("luasnip.util.events")
-- local ai = require("luasnip.nodes.absolute_indexer")
-- local fmt = require("luasnip.extras.fmt").fmt
-- local extras = require("luasnip.extras")
-- local m = extras.m
-- local l = extras.l
-- local rep = extras.rep
-- local postfix = require("luasnip.extras.postfix").postfix

return {
	s("jsdoc", { t({"/**", " * "}), i(0), t({"", " */"}) }),
	s("jsdoci", { t("/** "), i(0), t(" */") }),
}
