return {
  "neovim/nvim-lspconfig",
  ---@class PluginLspOpts
  opts = {
    ---@type lspconfig.options
    inlay_hints = {
      -- pyright will be automatically installed with mason and loaded with lspconfig
      exclude = { "go" },
    },
  },
}
