return {
  "nvim-neo-tree/neo-tree.nvim",
  version = "*",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
  },
  cmd = "Neotree",
  keys = {
    { "<leader>ft", ":Neotree reveal<CR>", desc = "NeoTree reveal", silent = true },
  },
  opts = {
    filesystem = {
      window = {
        mappings = {
          ["<leader>ft"] = "close_window",
        },
      },
    },
  },
  config = function()
    require("neo-tree").setup({
      close_if_last_window = false,
      buffers = {
        follow_current_file = {
          enabled = true,
          leave_dirs_open = false,
        },
      },
      filesystem = {
        follow_current_file = {
          enabled = true,
          leave_dirs_open = false,
        },
      },
    })
  end,
}
