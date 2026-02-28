return {
  { "EdenEast/nightfox.nvim" },
  {
    "rockyzhang24/arctic.nvim",
    dependencies = { "rktjmp/lush.nvim" },
    name = "arctic",
    branch = "main",
    priority = 1000,
  },
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {},
  },
  { "rose-pine/neovim", as = "rose-pine" },
  {
    "AlexvZyl/nordic.nvim",
    lazy = false,
    priority = 1000,
  },
  {
    "vague2k/vague.nvim",
    config = function()
      require("vague").setup({
        -- optional configuration here
      })
    end,
  },
  {
    "rebelot/kanagawa.nvim",
    opts = {
      colors = {
        theme = {
          all = {
            ui = {
              bg_gutter = "none",
            },
          },
        },
      },
    },
  },
  {
    "sainnhe/gruvbox-material",
    lazy = false,
    priority = 1000,
    config = function()
      vim.g.gruvbox_material_transparent_background = 1
      vim.g.gruvbox_material_foreground = "mix"
      vim.g.gruvbox_material_background = "hard"
      vim.g.gruvbox_material_ui_contrast = "hard"
      vim.g.gruvbox_material_float_style = "dim"
      vim.g.gruvbox_material_statusline_style = "material"
      vim.g.gruvbox_material_cursor = "auto"
      vim.g.gruvbox_material_enable_bold = 0
      vim.g.gruvbox_material_diagnostic_virtual_text = "highlighted"
      vim.g.gruvbox_material_better_performance = 1

      -- Only tweak yellow for variables, leave rest to theme
      -- vim.g.gruvbox_material_colors_override = {
      --   yellow = { "#e0b869", "179" }, -- warmer, softer yellow for vars
      -- }

      -- Softer highlights
      vim.api.nvim_create_autocmd("ColorScheme", {
        group = vim.api.nvim_create_augroup("gruvbox_material_tweaks", {}),
        pattern = "gruvbox-material",
        callback = function()
          local cfg = vim.fn["gruvbox_material#get_configuration"]()
          local pal = vim.fn["gruvbox_material#get_palette"](cfg.background, cfg.foreground, cfg.colors_override)
          local set_hl = vim.fn["gruvbox_material#highlight"]

          -- pcall(set_hl, "@string", { "#f0b97a", "215" }, pal.none)
          --
          pcall(set_hl, "@parameter", { "#a8d5c1", "215" }, pal.none)
          pcall(set_hl, "@variable.parameter", { "#a8d5c1", "215" }, pal.none)
          pcall(set_hl, "@variable.member", { "#a8d5c1", "215" }, pal.none)

          pcall(set_hl, "LspReferenceText", pal.none, pal.bg3) -- subtle background
          pcall(set_hl, "LspReferenceRead", pal.none, pal.bg3)
          pcall(set_hl, "LspReferenceWrite", pal.none, pal.bg3) -- slightly stronger
          -- Keywords: softer purple
          pcall(set_hl, "Keyword", pal.purple, pal.none)
          pcall(set_hl, "@keyword", pal.purple, pal.none)
          pcall(set_hl, "@keyword.repeat", pal.purple, pal.none)
          pcall(set_hl, "@keyword.conditional", pal.purple, pal.none)
          pcall(set_hl, "@keyword.return", pal.purple, pal.none)
          pcall(set_hl, "@keyword.exception", pal.purple, pal.none)
          pcall(set_hl, "@keyword.function", pal.purple, pal.none)
          pcall(set_hl, "@keyword.import", pal.purple, pal.none)
          pcall(set_hl, "@lsp.type.keyword", pal.purple, pal.none)
        end,
      })
    end,
  },
  {
    "catppuccin/nvim",
    lazy = false,
    name = "catppuccin",
    config = function()
      require("catppuccin").setup({
        color_overrides = {
          mocha = {
            rosewater = "#ffc0b9",
            flamingo = "#f5aba3",
            pink = "#f592d6",
            mauve = "#c0afff",
            red = "#ea746c",
            maroon = "#ff8595",
            peach = "#fa9a6d",
            yellow = "#ffe081",
            green = "#99d783",
            teal = "#47deb4",
            sky = "#00d5ed",
            sapphire = "#00dfce",
            blue = "#00baee",
            lavender = "#abbff3",
            text = "#cccccc",
            subtext1 = "#bbbbbb",
            subtext0 = "#aaaaaa",
            overlay2 = "#999999",
            overlay1 = "#888888",
            overlay0 = "#777777",
            surface2 = "#666666",
            surface1 = "#555555",
            surface0 = "#444444",
            base = "#202020",
            mantle = "#222222",
            crust = "#333333",
          },
        },
      })
    end,
  },
  {
    "LazyVim/LazyVim",
    opts = {
      -- colorscheme = "catppuccin-mocha",
      colorscheme = "gruvbox-material",
    },
  },
}
