require "user.lsp"
require "user.alpha"
require "user.autocommands"
require "user.cmp"
require "user.colorscheme"
require "user.comment"
require "user.dap"
require "user.gitsigns"
require "user.impatient"
require "user.indent-blankline"
require "user.keymaps"
require "user.luasnip"
require "user.nvim-cmp"
require "user.options"
require "user.plugins"
require "user.project"
require "user.telescope"
require "user.treesitter"
require "user.which-key"

local in_wsl = os.getenv('WSL_DISTRO_NAME') ~= nil

if in_wsl then
    vim.g.clipboard = {
        name = 'wsl clipboard',
        copy =  { ["+"] = { "clip.exe" },   ["*"] = { "clip.exe" } },
        paste = { ["+"] = { "nvim-paste" }, ["*"] = { "nvim-paste" } },
        cache_enabled = true
    }
end
