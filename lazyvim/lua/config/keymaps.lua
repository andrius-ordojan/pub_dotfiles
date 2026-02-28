-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.api.nvim_set_keymap("i", "jj", "<Esc>j", { noremap = true, silent = true })
vim.api.nvim_set_keymap("i", "kk", "<Esc>k", { noremap = true, silent = true })
vim.api.nvim_set_keymap("i", "<C-i>", "<Esc>", { noremap = true, silent = true })

vim.api.nvim_set_keymap("n", "<A-o>", "o<Esc>k", { desc = "New line below without moving cursor" })
vim.api.nvim_set_keymap("n", "<A-O>", "O<Esc>j", { desc = "New line above without moving cursor" })

-- DAP (Debug Adapter Protocol) F-key shortcuts
local dap = require("dap")
vim.keymap.set("n", "<F5>", dap.continue, { desc = "Debug: Continue" })
vim.keymap.set("n", "<F6>", dap.restart, { desc = "Debug: Restart" })
vim.keymap.set("n", "<F9>", dap.toggle_breakpoint, { desc = "Debug: Toggle Breakpoint" })
vim.keymap.set("n", "<F10>", dap.step_over, { desc = "Debug: Step Over" })
vim.keymap.set("n", "<F11>", dap.step_into, { desc = "Debug: Step Into" })
vim.keymap.set("n", "<F12>", dap.step_out, { desc = "Debug: Step Out" })
