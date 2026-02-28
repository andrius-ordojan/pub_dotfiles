-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.opt.scrolloff = 15
vim.opt.list = false
vim.g.snacks_animate = false

-- ~/.config/nvim/init.lua
-- "ver:1" means scroll 1 line vertically per tick
-- "hor:6" is the default horizontal scroll, you can lower that too if needed
vim.opt.mousescroll = "ver:2,hor:6"

vim.opt.swapfile = false

local is_ssh = vim.env.SSH_TTY ~= nil or vim.env.SSH_CONNECTION ~= nil

vim.o.clipboard = "unnamedplus"

if is_ssh then
  local function paste()
    return {
      vim.fn.split(vim.fn.getreg(""), "\n"),
      vim.fn.getregtype(""),
    }
  end

  vim.g.clipboard = {
    name = "OSC 52",
    copy = {
      ["+"] = require("vim.ui.clipboard.osc52").copy("+"),
      ["*"] = require("vim.ui.clipboard.osc52").copy("*"),
    },
    paste = {
      ["+"] = paste,
      ["*"] = paste,
    },
  }
else
  vim.g.clipboard = {
    name = "wl-clipboard (timeout)",
    copy = {
      ["+"] = "wl-copy --type text/plain",
      ["*"] = "wl-copy --primary --type text/plain",
    },
    paste = {
      ["+"] = "timeout 0.5s wl-paste --no-newline",
      ["*"] = "timeout 0.5s wl-paste --primary --no-newline",
    },
    cache_enabled = 0,
  }
end
