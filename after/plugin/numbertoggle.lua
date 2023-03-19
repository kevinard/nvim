local augroup = vim.api.nvim_create_augroup("numbertoggle", {})

local function set_relativenumber(relative, event)
  if vim.o.number then
    vim.opt.relativenumber = relative and vim.api.nvim_get_mode().mode ~= "i"

    if event == "CmdlineEnter" then
      vim.cmd "redraw"
    end
  end
end

vim.api.nvim_create_autocmd({ "BufEnter", "FocusGained", "InsertLeave", "CmdlineLeave", "WinEnter" }, {
  pattern = "*",
  group = augroup,
  callback = function(ev)
    set_relativenumber(true, ev.event)
  end,
})

vim.api.nvim_create_autocmd({ "BufLeave", "FocusLost", "InsertEnter", "CmdlineEnter", "WinLeave" }, {
  pattern = "*",
  group = augroup,
  callback = function(ev)
    set_relativenumber(false, ev.event)
  end,
})
