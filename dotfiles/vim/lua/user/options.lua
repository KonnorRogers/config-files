vim.opt.fileencoding = "utf-8"                  -- the encoding written to a file
vim.opt.backup = false                          -- creates a backup file
vim.opt.clipboard = "unnamedplus"               -- allows neovim to access the system clipboard
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
vim.opt.smartindent = true                      -- make indenting smarter again
vim.opt.splitbelow = true                       -- force all horizontal splits to go below current window
vim.opt.splitright = true                       -- force all vertical splits to go to the right of current window
vim.opt.swapfile = false                        -- creates a swapfile
vim.opt.termguicolors = true                    -- set term gui colors (most terminals support this)
vim.opt.timeoutlen = 1000                       -- time to wait for a mapped sequence to complete (in milliseconds)
vim.opt.undofile = true                         -- enable persistent undo
vim.opt.updatetime = 300                        -- faster completion (4000ms default)
vim.opt.writebackup = false                     -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
vim.opt.expandtab = true                        -- convert tabs to spaces
vim.opt.shiftwidth = 2                          -- the number of spaces inserted for each indentation
vim.opt.tabstop = 2                             -- insert 2 spaces for a tab
vim.opt.cursorline = true                       -- highlight the current line
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
vim.opt.undodir = "$HOME/.vim/undodir"
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

-- Stupid clipboard crap, configure this accordingly
vim.opt.clipboard = vim.opt.clipboard + "unnamedplus"

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
vim.opt.completeopt = "menu,menuone,noselect"
vim.opt.helpheight = 20
vim.opt.wrap = true
vim.opt.linebreak = true

