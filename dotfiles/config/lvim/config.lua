-- Read the docs: https://www.lunarvim.org/docs/configuration
-- Example configs: https://github.com/LunarVim/starter.lvim
-- Video Tutorials: https://www.youtube.com/watch?v=sFA9kX-Ud_c&list=PLhoH5vyxr6QqGu0i7tt_XoVK9v-KvZ3m6
-- Forum: https://www.reddit.com/r/lunarvim/
-- Discord: https://discord.com/invite/Xb9B4Ny
--
--
--
lvim.plugins = {
  { "arzg/vim-colors-xcode" },
  {
    "tpope/vim-surround",

    -- make sure to change the value of `timeoutlen` if it's not triggering correctly, see https://github.com/tpope/vim-surround/issues/117
    -- setup = function()
      --  vim.o.timeoutlen = 500
    -- end
  },
  -- Other color stuff
  { "ap/vim-css-color" }, -- Add color to .css files
  -- Git related plugins
  { 'tpope/vim-fugitive' },
  { 'tpope/vim-rhubarb' },

  -- Tpope
  { 'tpope/vim-surround' },
  { 'tpope/vim-ragtag' },

  -- Detect tabstop and shiftwidth automatically
  { 'tpope/vim-sleuth' },
  {
    "stevearc/dressing.nvim",
    config = function()
      require("dressing").setup({
        input = { enabled = false },
      })
    end,
  },
  {
    "nvim-neorg/neorg",
    ft = "norg", -- lazy-load on filetype
    config = true, -- run require("neorg").setup()
    dependencies = {
      "vhyrro/luarocks.nvim"
    }
  },
  {
    "JoosepAlviste/nvim-ts-context-commentstring",
    event = "BufRead",
  },
  {
    "mrjones2014/nvim-ts-rainbow",
  },
}

local colorscheme = os.getenv("COLORSCHEME") or "xcodelighthc"
lvim.colorscheme = colorscheme

local linters = require "lvim.lsp.null-ls.linters"
linters.setup {
  { command = "eslint", filetypes = { "typescript", "typescriptreact" } }
}

local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
  {
    command = "prettier",
    filetypes = { "typescript", "typescriptreact" },
  },
}

lvim.builtin.lualine.active = false
lvim.builtin.lir.active = false
lvim.builtin.bufferline.active = false
lvim.builtin.breadcrumbs.active = false
lvim.builtin.autopairs.active = false

lvim.builtin.treesitter.rainbow.enable = true

vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
vim.g.netrw_mkdir_cmd = 'mkdir -p'
vim.g.netrw_winsize = 25
vim.g.netrw_liststyle=0
vim.g.netrw_keepdir = 1
vim.g.netrw_localcopydircmd = 'cp -r'

vim.g.autochdir = false

local actions = require "telescope.actions"
lvim.builtin.telescope.defaults.mappings = vim.tbl_deep_extend("force", lvim.builtin.telescope.defaults.mappings, {
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
})

-- Statusline
vim.cmd[[
" Treat <li> and <p> tags like the block tags they are
let g:html_indent_tags = 'li\|p'

"File nav
if executable('ag')
  set grepprg=ag\ --vimgrep
  set grepformat=%f:%l:%c%m

  "populate quickfix with \
  command! -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!
  nnoremap \ :Ag<space>
endif

let g:ragtag_global_maps = 1

" Emmet
" Dont let it override <C-y>
let g:user_emmet_leader_key = '<C-e>'

" Remove backward jump interference
inoremap <c-x><c-k> <c-x><c-k>


"Vim-Go
let g:go_def_mode='gopls'
let g:go_info_mode='gopls'


" 'matchit.vim' is built-in so let's enable it!
" " Hit '%' on 'if' to jump to 'else'.
runtime macros/matchit.vim

" Strip whitespace
autocmd BufWritePre * %s/\s\+$//e

" Return cursor to original position
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
  \| exe "normal g'\"" | endif
endif
"}}}

"Colorscheme / appearance
if exists('+termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif

"Status line
set laststatus=2
set statusline=
set statusline+=\ %<%F\ %m\ %r\ %h\ %=%=%=%y\ [%c]%=
]]


-- vim.opt.runtimepath:prepend(.. "/.config/lvim")
-- package.path  = pac.o.runtimepath
package.path = package.path .. ";" .. os.getenv("HOME") .. "/.config/lvim/after/?.lua"
require("keymaps")

-- LSP stuff
local opts = { noremap = true, silent = true }
local keymap = vim.api.nvim_set_keymap
keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
