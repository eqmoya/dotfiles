return {
  {
    "stevearc/oil.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("oil").setup({
        keymaps = {
          ["<C-h>"] = false,
          ["<C-l>"] = false,
        },
        view_options = {
          show_hidden = true,
        },
        delete_to_trash = true,
        skip_confirm_for_simple_edits = true,
      })

      vim.keymap.set("n", "<leader>ff", "<CMD>Oil<CR>", { desc = "Open parent directory" })
    end,
  },
}
