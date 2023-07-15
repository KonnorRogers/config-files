local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
  return
end

local actions = require "telescope.actions"
local builtin = require "telescope.builtin"

pcall(require('telescope').load_extension, 'fzf')
local function find_files ()
  return builtin.find_files({hidden=true})
end

vim.keymap.set('n', '<leader>ff', find_files, { desc = "[F]ind [F]iles" })
vim.keymap.set('n', '<leader>sf', find_files, { desc = "[S]earch [F]iles" })
vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
vim.keymap.set('n', '<leader>st', builtin.live_grep, { desc = '[S]earch by [T]ext' })
vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })

telescope.setup {
  defaults = {

    prompt_prefix = " ",
    selection_caret = " ",
    path_display = { "smart" },
    file_ignore_patterns = { ".git/", "node_modules" },

    mappings = {
      i = {
        ["<Down>"] = actions.cycle_history_next,
        ["<Up>"] = actions.cycle_history_prev,
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
      },
  		n = {
    		["<C-j>"] = actions.move_selection_next,
    		["<C-k>"] = actions.move_selection_previous,
  		},
    },
  },
}
