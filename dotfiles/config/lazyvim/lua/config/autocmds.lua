-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- Make the picker's dimmed directory paths readable on the light theme.
local function fix_picker_hl()
  vim.api.nvim_set_hl(0, "SnacksPickerDir", { link = "Directory" })
  vim.api.nvim_set_hl(0, "SnacksPickerPathHidden", { link = "Directory" })
  vim.api.nvim_set_hl(0, "SnacksPickerPathIgnored", { link = "Comment" })
end

vim.api.nvim_create_autocmd("ColorScheme", { callback = fix_picker_hl })
fix_picker_hl() -- apply for the current session too
