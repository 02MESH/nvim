return -- mason.nvim integration
{
  "jay-babu/mason-nvim-dap.nvim",
  dependencies = {
    "williamboman/mason.nvim",
    "mfussenegger/nvim-dap",
  },
  -- cmd = { "dapinstall", "dapuninstall" },
  opts = {
    automatic_installation = true,
    handlers = {},
    ensure_installed = {
      "codelldb",
    },
  },
  -- mason-nvim-dap is loaded when nvim-dap loads
}
