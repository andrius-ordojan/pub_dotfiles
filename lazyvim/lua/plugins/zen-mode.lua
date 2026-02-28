return {
  "folke/zen-mode.nvim",
  config = function()
    vim.keymap.set("n", "<leader>z", "<cmd>ZenMode<CR>", { desc = "Toggle zen mode" })

    require("zen-mode").setup({
      window = {
        width = 0.85,
      },
      plugins = {
        options = {
          showcmd = false,
          laststatus = 0,
        },
      },
    })
  end,
}
