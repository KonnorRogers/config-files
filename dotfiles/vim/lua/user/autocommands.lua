vim.api.nvim_create_autocmd({ "FileType" }, {
	pattern = { "qf", "help", "man", "lspinfo", "spectre_panel" },
	callback = function()
		vim.cmd([[
      nnoremap <silent> <buffer> q :close<CR>
      set nobuflisted
    ]])
	end,
})

vim.api.nvim_create_autocmd({ "FileType" }, {
	pattern = { "gitcommit"},
	callback = function()
		vim.opt_local.wrap = true
		vim.opt_local.spell = true
	end,
})

vim.api.nvim_create_autocmd({ "FileType" }, {
	pattern = { "markdown" },
	callback = function()
		vim.opt_local.wrap = true
		vim.opt_local.spell = true
	end,
})


vim.api.nvim_create_autocmd({ "VimResized" }, {
	callback = function()
		vim.cmd("tabdo wincmd =")
	end,
})

vim.api.nvim_create_autocmd({ "CmdWinEnter" }, {
	callback = function()
		vim.cmd("quit")
	end,
})
vim.api.nvim_create_autocmd({ "BufWinEnter" }, {
	callback = function()
		vim.cmd("set formatoptions-=cro")
	end,
})

vim.api.nvim_create_autocmd({ "TextYankPost" }, {
	callback = function()
		vim.highlight.hl_op({ higroup = "Visual", timeout = 200 })
	end,
})

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
	pattern = { "*.java" },
	callback = function()
		vim.lsp.codelens.refresh()
	end,
})

-- vim.api.nvim_create_autocmd({ "VimEnter" }, {
-- 	callback = function()
--		if vim.opt
-- 		vim.cmd([[highlight Normal guibg=#0c1021]])
-- 	end,
-- })

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
local function setup_netrw_image_preview()
  local group = vim.api.nvim_create_augroup("netrw_image_preview", { clear = true })
  local preview = { win = nil, placement = nil }

  local function close_preview()
    if preview.placement then
      pcall(function() preview.placement:close() end)
      preview.placement = nil
    end
    if preview.win then
      pcall(function() preview.win:close() end)
      preview.win = nil
    end
  end

  -- full path if the entry under the cursor is an image, else nil
  local function netrw_target()
    local ok, name = pcall(vim.fn["netrw#Call"], "NetrwGetWord")
    if not ok or not name or name == "" or name:sub(-1) == "/" then
      return nil
    end
    local path = vim.fs.joinpath(vim.b.netrw_curdir, name)
    return Snacks.image.supports_file(path) and path or nil
  end

  local function netrw_preview()
    close_preview()
    local path = netrw_target()
    if not path then
      return
    end
    local buf = vim.api.nvim_create_buf(false, true)
    vim.bo[buf].bufhidden = "wipe"
    preview.win = Snacks.win({
      buf = buf,
      relative = "editor",
      row = 1, col = 0.5, width = 0.5, height = 0.9,
      border = "rounded",
      focusable = false,
      enter = false,
      backdrop = false,
    })
    preview.placement = Snacks.image.placement.new(buf, path, { fit = "contain" })
  end

  -- open the file's contents as plain text in a scratch buffer
  local function open_as_text(path)
    -- name doesn't end in an image extension, so snacks never claims it
    local name = path .. " [text]"
    local buf = vim.fn.bufnr(name)
    if buf == -1 then
      local f = assert(io.open(path, "rb"))
      local data = f:read("*a")
      f:close()
      buf = vim.api.nvim_create_buf(true, true) -- listed, nofile, bufhidden=hide
      vim.api.nvim_buf_set_name(buf, name)
      vim.api.nvim_buf_set_lines(buf, 0, -1, false, vim.split(data, "\n", { plain = true }))
      vim.bo[buf].modifiable = false
    end
    vim.api.nvim_win_set_buf(0, buf)
  end

  local function netrw_enter()
    local path = netrw_target()
    close_preview()
    if path then
      vim.bo.bufhidden = "hide" -- keep the listing in memory for <C-^>
      open_as_text(path)
    else
      vim.api.nvim_feedkeys(vim.keycode("<Plug>NetrwLocalBrowseCheck"), "m", false)
    end
  end

  vim.api.nvim_create_autocmd("FileType", {
    group = group,
    pattern = "netrw",
    callback = function(ev)
      vim.api.nvim_create_autocmd("CursorMoved", { group = group, buffer = ev.buf, callback = netrw_preview })
      vim.api.nvim_create_autocmd({ "BufLeave", "BufWipeout" }, { group = group, buffer = ev.buf, callback = close_preview })
      vim.keymap.set("n", "<CR>", netrw_enter, { buffer = ev.buf, desc = "Open image as text" })
    end,
  })

  -- if a directory buffer is ever re-entered blank, have netrw redraw it
  vim.api.nvim_create_autocmd("BufEnter", {
    group = group,
    callback = function(ev)
      local name = vim.api.nvim_buf_get_name(ev.buf)
      if vim.fn.isdirectory(name) == 0 then
        return
      end
      vim.schedule(function()
        if vim.api.nvim_get_current_buf() ~= ev.buf then
          return
        end
        local lines = vim.api.nvim_buf_get_lines(ev.buf, 0, 2, false)
        if #lines == 1 and lines[1] == "" then
          vim.cmd("silent Explore " .. vim.fn.fnameescape(name))
        end
      end)
    end,
  })
end

setup_netrw_image_preview()
