return {
  {
    "mfussenegger/nvim-dap",
    opts = function(_, opts)
      local dap = require("dap")

      -- Example: Python DAP config
      -- dap.adapters.python = {
      --   type = "executable",
      --   command = "/usr/bin/python",
      --   args = { "-m", "debugpy.adapter" },
      -- }

      dap.configurations.python = {
        {
          type = "python",
          request = "launch",
          name = "Launch file",
          program = "${file}",
          console = "integratedTerminal",
          justMyCode = false,
          cwd = "${workspaceFolder}",
        },
        {
          type = "python",
          request = "launch",
          name = "Launch azure_cost_hound",
          module = "azure_cost_hound",
          console = "integratedTerminal",
          justMyCode = false,
          cwd = "${workspaceFolder}",
        },
      }
    end,
  },
}
