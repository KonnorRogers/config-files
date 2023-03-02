--[[
lvim is the global options object

Linters should be
filled in as strings with either
a global executable or a path to
an executable
]]
-- THESE ARE EXAMPLE CONFIGS FEEL FREE TO CHANGE TO WHATEVER YOU WANT

-- general
lvim.log.level = "warn"
lvim.format_on_save = false
lvim.colorscheme = "xcodedarkhc"
-- lvim.colorscheme = "xcodelighthc"
lvim.builtin.autopairs.active = false
lvim.builtin.nvimtree.active = false
lvim.builtin.lir.active = false
lvim.builtin.lualine.active = false
lvim.builtin.bufferline.active = false
lvim.builtin.breadcrumbs.active = false

lvim.leader = "space"
-- set termguicolors to enable highlight groups
-- vim.opt.termguicolors = true
-- to disable icons and use a minimalist setup, uncomment the following
-- lvim.use_icons = false

-- keymappings [view all the defaults by pressing <leader>Lk]
-- add your own keymapping
-- lvim.keys.normal_mode["<C-s>"] = ":w<cr>"
-- lvim.keys.normal_mode["<S-l>"] = ":BufferLineCycleNext<CR>"
-- lvim.keys.normal_mode["<S-h>"] = ":BufferLineCyclePrev<CR>"
-- unmap a default keymapping
-- vim.keymap.del("n", "<C-Up>")
-- override a default keymapping
-- lvim.keys.normal_mode["<C-q>"] = ":q<cr>" -- or vim.keymap.set("n", "<C-q>", ":q<cr>" )

-- Change Telescope navigation to use j and k for navigation and n and p for history in both input and normal mode.
-- we use protected-mode (pcall) just in case the plugin wasn't loaded yet.
local _, actions = pcall(require, "telescope.actions")
lvim.builtin.telescope.defaults.mappings = {
  -- for input mode
  i = {
    ["<C-j>"] = actions.move_selection_next,
    ["<C-k>"] = actions.move_selection_previous,
    ["<C-n>"] = actions.cycle_history_next,
    ["<C-p>"] = actions.cycle_history_prev,
  },
  -- for normal mode
  n = {
    ["<C-j>"] = actions.move_selection_next,
    ["<C-k>"] = actions.move_selection_previous,
  },
}

-- Use which-key to add extra bindings with the leader-key prefix
lvim.builtin.which_key.mappings["P"] = { "<cmd>Telescope projects<CR>", "Projects" }

-- After changing plugin config exit and reopen LunarVim, Run :PackerInstall :PackerCompile
lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"
lvim.builtin.terminal.active = true


vim.cmd([[
function! RenameFile()
  let old_name = expand('%')
  let new_name = input('New file name: ', expand('%'), 'file')
  if new_name != '' && new_name != old_name
    exec ':saveas ' . new_name
    exec ':silent !rm ' . old_name
    exec ':e ' . new_name
    exec ':bwipeout ' . old_name
    redraw!
  endif
endfunction

" Run ctags
function! GitCtags()
  let s:git_root = systemlist('git rev-parse --show-toplevel')[0]
  let s:tag_dir = '/.git/tags'

  execute "!ctags -R --tag-relative -f " . s:git_root . s:tag_dir
endfunction

" Strip whitespace
autocmd BufWritePre * %s/\s\+$//e

" Return cursor to original position
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
  \| exe "normal g'\"" | endif
endif
"}}}

"Status line
set laststatus=2
set statusline=
set statusline+=\ %<%F\ %m\ %r\ %h\ %=%=%=%y\ [%c]%=

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
]])

lvim.builtin.treesitter.rainbow.enable = true

-- if you don't want all the parsers change this to a table of the ones you want
lvim.builtin.treesitter.ensure_installed = {
  "bash",
  "c",
  "javascript",
  "json",
  "lua",
  "python",
  "typescript",
  "tsx",
  "css",
  "rust",
  "java",
  "yaml",
}

lvim.builtin.treesitter.ignore_install = { "haskell" }
lvim.builtin.treesitter.highlight.enable = true

-- generic LSP settings

-- -- make sure server will always be installed even if the server is in skipped_servers list
-- lvim.lsp.installer.setup.ensure_installed = {
--     "sumneko_lua",
--     "jsonls",
-- }
-- -- change UI setting of `LspInstallInfo`
-- -- see <https://github.com/williamboman/nvim-lsp-installer#default-configuration>
-- lvim.lsp.installer.setup.ui.check_outdated_servers_on_open = false
-- lvim.lsp.installer.setup.ui.border = "rounded"
-- lvim.lsp.installer.setup.ui.keymaps = {
--     uninstall_server = "d",
--     toggle_server_expand = "o",
-- }

-- ---@usage disable automatic installation of servers
-- lvim.lsp.installer.setup.automatic_installation = false

-- ---configure a server manually. !!Requires `:LvimCacheReset` to take effect!!
-- ---see the full default list `:lua print(vim.inspect(lvim.lsp.automatic_configuration.skipped_servers))`
-- vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "pyright" })
-- local opts = {} -- check the lspconfig documentation for a list of all possible options
-- require("lvim.lsp.manager").setup("pyright", opts)

-- ---remove a server from the skipped list, e.g. eslint, or emmet_ls. !!Requires `:LvimCacheReset` to take effect!!
-- ---`:LvimInfo` lists which server(s) are skipped for the current filetype
-- lvim.lsp.automatic_configuration.skipped_servers = vim.tbl_filter(function(server)
--   return server ~= "emmet_ls"
-- end, lvim.lsp.automatic_configuration.skipped_servers)

-- -- you can set a custom on_attach function that will be used for all the language servers
-- -- See <https://github.com/neovim/nvim-lspconfig#keybindings-and-completion>
-- lvim.lsp.on_attach_callback = function(client, bufnr)
--   local function buf_set_option(...)
--     vim.api.nvim_buf_set_option(bufnr, ...)
--   end
--   --Enable completion triggered by <c-x><c-o>
--   buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")
-- end

-- -- set a formatter, this will override the language server formatting capabilities (if it exists)
-- local formatters = require "lvim.lsp.null-ls.formatters"
-- formatters.setup {
--   { command = "black", filetypes = { "python" } },
--   { command = "isort", filetypes = { "python" } },
--   {
--     -- each formatter accepts a list of options identical to https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#Configuration
--     command = "prettier",
--     ---@usage arguments to pass to the formatter
--     -- these cannot contain whitespaces, options such as `--line-width 80` become either `{'--line-width', '80'}` or `{'--line-width=80'}`
--     extra_args = { "--print-with", "100" },
--     ---@usage specify which filetypes to enable. By default a providers will attach to all the filetypes it supports.
--     filetypes = { "typescript", "typescriptreact" },
--   },
-- }

-- -- set additional linters
-- local linters = require "lvim.lsp.null-ls.linters"
-- linters.setup {
--   { command = "flake8", filetypes = { "python" } },
--   {
--     -- each linter accepts a list of options identical to https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#Configuration
--     command = "shellcheck",
--     ---@usage arguments to pass to the formatter
--     -- these cannot contain whitespaces, options such as `--line-width 80` become either `{'--line-width', '80'}` or `{'--line-width=80'}`
--     extra_args = { "--severity", "warning" },
--   },
--   {
--     command = "codespell",
--     ---@usage specify which filetypes to enable. By default a providers will attach to all the filetypes it supports.
--     filetypes = { "javascript", "python" },
--   },
-- }

-- Additional Plugins
-- lvim.plugins = {
-- }

-- Autocommands (https://neovim.io/doc/user/autocmd.html)
-- vim.api.nvim_create_autocmd("BufEnter", {
--   pattern = { "*.json", "*.jsonc" },
--   -- enable wrap mode for json files only
--   command = "setlocal wrap",
-- })
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "*" },
  callback = function()
		local lang = vim.bo.filetype

		local filetypes = lang == "TelescopePrompt" or lang == "netrw" or lang == "markdown"
		local buffer_number = vim.api.nvim_win_get_buf(0)


		if filetypes or vim.api.nvim_buf_line_count(buffer_number) > 2000 then
			lvim.builtin.treesitter.highlight.disable(lang, buffer_number)
		end
  end,
})
--
  -- Tpope
lvim.plugins = {
  { "arzg/vim-colors-xcode" },
  { "mattn/emmet-vim" },
  { "ap/vim-css-color" },
  { "tpope/vim-surround" },
  { "tpope/vim-ragtag" },
  { "tpope/vim-fugitive" },
	{ "p00f/nvim-ts-rainbow" },
	{
  	"ray-x/lsp_signature.nvim",
  	event = "BufRead",
  	config = function() require"lsp_signature".on_attach() end,
  }
}

lvim.keys.normal_mode["]d"] = "<cmd>lua vim.diagnostic.goto_next({buffer=0})<cr>"
lvim.keys.normal_mode["[d"] = "<cmd>lua vim.diagnostic.goto_prev({buffer=0})<cr>"

vim.opt.fileencoding = "utf-8"                  -- the encoding written to a file
vim.opt.backup = false                          -- creates a backup file
vim.opt.cmdheight = 1                           -- more space in the neovim command line for displaying messages
vim.opt.completeopt = { "menuone", "noselect" } -- mostly just for cmp
vim.opt.conceallevel = 0                        -- so that `` is visible in markdown files
vim.opt.hlsearch = true                         -- highlight all matches on previous search pattern
vim.opt.ignorecase = true                       -- ignore case in search patterns
vim.opt.mouse = "a"                             -- allow the mouse to be used in neovim
vim.opt.pumheight = 10                          -- pop up menu height
vim.opt.showmode = false                        -- we don't need to see things like -- INSERT -- anymore
vim.opt.showtabline = 0                         -- always show tabs
vim.opt.smartcase = true                        -- smart case
-- vim.opt.smartindent = true                      -- make indenting smarter again
vim.opt.splitbelow = true                       -- force all horizontal splits to go below current window
vim.opt.splitright = true                       -- force all vertical splits to go to the right of current window
vim.opt.swapfile = false                        -- creates a swapfile
vim.opt.termguicolors = true                    -- set term gui colors (most terminals support this)
vim.opt.timeoutlen = 0                       -- time to wait for a mapped sequence to complete (in milliseconds)
vim.opt.undofile = true                         -- enable persistent undo
vim.opt.updatetime = 300                        -- faster completion (4000ms default)
vim.opt.writebackup = false                     -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
vim.opt.expandtab = true                        -- convert tabs to spaces
vim.opt.shiftwidth = 2                          -- the number of spaces inserted for each indentation
vim.opt.tabstop = 2                             -- insert 2 spaces for a tab
vim.opt.number = true                           -- set numbered lines
vim.opt.laststatus = 3                          -- only the last window will always have a status line
vim.opt.showcmd = false                         -- hide (partial) command in the last line of the screen (for performance)
vim.opt.ruler = false                           -- hide the line and column number of the cursor position
vim.opt.numberwidth = 4                         -- minimal number of columns to use for the line number {default 4}
vim.opt.signcolumn = "yes"                      -- always show the sign column, otherwise it would shift the text each time
vim.opt.wrap = false                            -- display lines as one long line
vim.opt.scrolloff = 8                           -- minimal number of screen lines to keep above and below the cursor
vim.opt.sidescrolloff = 8                       -- minimal number of screen columns to keep to the left and right of the cursor if wrap is `false`
vim.opt.guifont = "monospace:h17"               -- the font used in graphical neovim applications
vim.opt.fillchars.eob=" "                       -- show empty lines at the end of a buffer as ` ` {default `~`}
vim.opt.shortmess:append "c"                    -- hide all the completion messages, e.g. "-- XXX completion (YYY)", "match 1 of 2", "The only match", "Pattern not found"
vim.opt.whichwrap:append("<,>,[,],h,l")         -- keys allowed to move to the previous/next line when the beginning/end of line is reached
vim.opt.iskeyword:append("-")                   -- treats words with `-` as single words

-- Path variables, prepend current directory
vim.opt.path = vim.opt.path ^ ".,,"
vim.opt.autowrite = true

-- indentations
vim.opt.smartindent = true
vim.opt.autoindent = true
vim.opt.preserveindent = true
vim.opt.copyindent = true


vim.opt.expandtab = false -- expand tabs into spaces
vim.opt.tabstop = 2 -- when indenting with '>', use 2 spaces width
vim.opt.shiftwidth = 2 -- On pressing tab, -- insert 2 spaces
vim.opt.shiftround = true -- always even spaces
vim.opt.colorcolumn = "81" -- Make it obvious where 80 characters is
vim.opt.number = true -- Left hand column numbers
vim.opt.list = true
vim.opt.listchars = { eol = '↲', tab = '▸ ', trail = '·', nbsp = '·' } -- Display extra whitespace
vim.opt.showmatch = true -- show matching brackets
vim.opt.ruler = true -- show cursor position at all times
-- vim.opt.nohls = true -- don't highlight the previous search term
vim.opt.incsearch = true -- incremental searching

-- incremental commands
if vim.fn.exists('+inccommand') == 1 then
	vim.opt.inccommand = "nosplit"
end

vim.opt.wrap = true -- turn on visual word wrapping
vim.opt.linebreak = true -- only break lines on 'breakat' characters
vim.opt.foldmethod = "syntax" -- Folds
vim.opt.syntax = "on" -- Syntax highlighting

-- Enable filetypes, indentation and plugins
vim.opt.filetype.plugin = true
vim.opt.filetype.indent = true
vim.opt.filetype.on = true

-- Say no to file backups
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.swapfile = false
vim.opt.undodir = vim.fs.normalize('$HOME/.vim/undodir')
vim.opt.undofile = true

vim.opt.backspace = "indent,eol,start" -- fixes backspace in vim
vim.opt.bs = "2" -- fix backspace on some consoles

-- Tabbing menu
vim.opt.wildmenu = true
vim.opt.wildmode = "full"
vim.opt.wildignorecase = true

vim.opt.wildignore = vim.opt.wildignore
		+ "*/node_modules/*"
		+ "*/coverage/*"
		+ "*/public/*"
		+ "*/.git/*,*/tmp/*,*/.tmp/*"
		+ "*/.bundle/*,*/vendor/*,*/log/*"

vim.opt.showcmd = true -- show command line
vim.opt.history = 50 -- keep small history
vim.opt.hidden = true -- Keep buffers alive in background
vim.opt.lazyredraw = true -- Fixes files at the end of macros, better performance
vim.opt.ttyfast = true
vim.opt.synmaxcol = 200

-- Stupid clipboard crap, configure this accordingly
vim.opt.clipboard = "unnamedplus" -- allows neovim to access the system clipboard

vim.opt.cursorcolumn = true -- Provide a line of what column youre in
vim.opt.cursorline = true -- Adds a horizontal highlight to current line
vim.opt.gdefault = true -- Global substitutions by default

-- -- Fixing splits to be more natural
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.diffopt = vim.opt.diffopt + "vertical" -- Always use vertical diffs
vim.opt.tags = vim.opt.tags + "./.git/tags" + "./tags"

vim.opt.cmdheight = 2
vim.opt.updatetime = 300
vim.opt.shortmess = vim.opt.shortmess + "c"
vim.opt.helpheight = 20
vim.opt.wrap = true
vim.opt.linebreak = true


-- Jump based on folds
lvim.keys.normal_mode["j"] = "gj"
lvim.keys.normal_mode["k"] = "gk"

-- Movement
-- Using splits
lvim.keys.normal_mode["<Leader>sp"] = ":split<space>"
lvim.keys.normal_mode["<Leader>vs"] = ":vsplit<space>"

-- Buffer switching
lvim.keys.normal_mode["<Leader><Leader>"] = "<C-^>"
lvim.keys.normal_mode["[b"] = ":bprev<CR>"
lvim.keys.normal_mode["]b"] = ":bnext<CR>"
lvim.keys.normal_mode["<C-b>"] = ":bdelete<CR>"

-- Tab switching
lvim.keys.normal_mode["<Leader>tn"] = ":tabnew<CR>"
lvim.keys.normal_mode["<Leader>tj"] = ":tabnext<CR>"
lvim.keys.normal_mode["<Leader>tk"] = ":tabprev<CR>"
lvim.keys.normal_mode["<Leader>tc"] = ":tabclose<CR>"

-- editing vim config
lvim.keys.normal_mode["<Leader>rc"] = ":edit $HOME/.vim/vimrc<CR>"
lvim.keys.normal_mode["<Leader>dv"] = ":edit $HOME/.vim<CR>"
lvim.keys.normal_mode["<Leader>rv"] = ":source $MYVIMRC<CR>"

-- saving made eaiser
lvim.keys.normal_mode["<Leader>ww"] = ":w!<CR>"
lvim.keys.normal_mode["<Leader>wq"] = ":wq!<CR>"

-- quit
lvim.keys.normal_mode["<Leader>qq"] = ":q!<CR>"

-- Quickfix Navigation
lvim.keys.normal_mode["]q"] = ":cnext<CR>zz"
lvim.keys.normal_mode["[q"] = ":cprevious<CR>zz"
lvim.keys.normal_mode["[Q"] = ":cfirst<CR>zz"
lvim.keys.normal_mode["]Q"] = ":clast<CR>zz"

-- Custom commands
lvim.keys.normal_mode["<Leader>kp"] = ":!kubs pull && kubs git_push"
lvim.keys.normal_mode["<Leader>kc"] = ":!kubs git_pull && kubs copy<cr>"

-- Vim based file navigation
lvim.keys.normal_mode["<Leader>vf"] = ":find ./**/*"
lvim.keys.normal_mode["<Leader>vF"] = ":find "
lvim.keys.normal_mode["<Leader>e"] = ":edit ./"
lvim.keys.normal_mode["<Leader>E"] = ":edit<space>"
-- bind <Leader>gw to grep word under cursor
lvim.keys.normal_mode["<Leader>gw"] = ':grep! "\b<C-R><C-W>\b"<CR>:cw<CR>'

lvim.keys.normal_mode["<Leader>rf"] = ":call RenameFile()<cr>"

-- Create a new file
lvim.keys.normal_mode["<Leader>to"] = ":edit <C-R>=expand('%:p:h') . '/'<CR>"
lvim.keys.normal_mode["<Leader>td"] = ":!mkdir -p <C-R>=expand('%:p:h') . '/'<CR>"

-- Run ctags on current directory
lvim.keys.normal_mode["<Leader>gt"] = ":call GitCtags()<CR>"

-- Ragtag
lvim.keys.insert_mode["<M-o>"] = "<Esc>o"
lvim.keys.insert_mode["<C-j>"] = "<Down>"

lvim.keys.normal_mode["<C-n>"] = ":Explore<CR>"
lvim.keys.insert_mode["<C-n>"] = ":Explore<CR>"
lvim.keys.visual_mode["<C-n>"] = ":Explore<CR>"

vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
vim.g.netrw_mkdir_cmd = 'mkdir -p'
vim.g.netrw_winsize = 25
vim.g.netrw_liststyle=0
vim.g.netrw_keepdir = 1
vim.g.netrw_localcopydircmd = 'cp -r'

local status, ls = pcall(require, 'luasnip')
if status then
	ls.filetype_extend("typescript", { "javascript", "typescriptreact", "javascriptreact" })
	ls.filetype_extend("javascriptreact", { "javascript" })
	ls.filetype_extend("typescriptreact", { "typescript", "typescriptreact", "javascriptreact" })
end

lvim.builtin.indentlines.options.show_current_context_start = false
lvim.builtin.indentlines.options.show_current_context = true
lvim.builtin.indentlines.options.use_treesitter = true
lvim.builtin.indentlines.options.indent_blankline_use_treesitter_scope = true

-- vim.cmd [[highlight indentblanklineindent1 guifg=#e06c75 gui=nocombine]]
-- vim.cmd [[highlight indentblanklineindent2 guifg=#e5c07b gui=nocombine]]
-- vim.cmd [[highlight indentblanklineindent3 guifg=#98c379 gui=nocombine]]
-- vim.cmd [[highlight IndentBlanklineIndent4 guifg=#56B6C2 gui=nocombine]]
-- vim.cmd [[highlight IndentBlanklineIndent5 guifg=#61AFEF gui=nocombine]]
-- vim.cmd [[highlight IndentBlanklineIndent6 guifg=#C678DD gui=nocombine]]

-- lvim.builtin.indentlines.options.char_highlight_list = {
--   "IndentBlanklineIndent1",
--   "IndentBlanklineIndent2",
--   "IndentBlanklineIndent3",
--   "IndentBlanklineIndent4",
--   "IndentBlanklineIndent5",
--   "IndentBlanklineIndent6",
-- }

-- Move current line / block with Alt-j/k ala vscode.
lvim.keys.insert_mode["<A-j>"] = false -- "<Esc>:m .+1<CR>==gi",

-- Move current line / block with Alt-j/k ala vscode.
lvim.keys.insert_mode["<A-k>"] = false -- "<Esc>:m .-2<CR>==gi",

lvim.keys.normal_mode["<Leader>off"] = ":set syntax=off foldmethod=manual noshowmatch<CR>"
lvim.keys.normal_mode["<Leader>cl"] = ":colorscheme xcodelighthc<CR>"
lvim.keys.normal_mode["<Leader>cd"] = ":colorscheme xcodedarkhc<CR>"
