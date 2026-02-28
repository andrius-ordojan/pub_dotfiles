return {
  --   {
  --     "hrsh7th/nvim-cmp",
  --     opts = function(_, opts)
  --       local cmp = require("cmp")
  --
  --       opts.experimental = opts.experimental or {}
  --       opts.experimental.ghost_text = false
  --
  --       opts.mapping = vim.tbl_extend("force", cmp.mapping.preset.insert(opts.mapping or {}), {
  --         ["<Tab>"] = cmp.mapping.select_next_item(),
  --         ["<S-Tab>"] = cmp.mapping.select_prev_item(),
  --         ["<C-e>"] = cmp.mapping.abort(),
  --       })
  --     end,
  --   },
}
