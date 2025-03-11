return {
  "folke/zen-mode.nvim",
  config = function()
    vim.keymap.set("n", "<leader>zz", function()
      require("zen-mode").setup({
        window = {
          backdrop = 0.98,
          width = 90,
          options = {},
        },
        plugins = {
          tmux = { enabled = true },
        },
        on_open = function(win)
          vim.opt.showmode = true
        end,
        on_close = function()
          vim.opt.showmode = false
        end,
      })
      require("zen-mode").toggle()
      vim.opt.colorcolumn = "80"
    end)

    vim.keymap.set("n", "<leader>zZ", function()
      require("zen-mode").setup({
        window = {
          backdrop = 0.98,
          width = 80,
          options = {},
        },
        plugins = {
          tmux = { enabled = true },
          kitty = {
            enabled = true,
            font = "+4",
          },
        },
        on_open = function(win)
          vim.opt.colorcolumn = "0"
          vim.opt.showmode = true
          vim.opt.signcolumn = "no"
        end,
        on_close = function()
          vim.opt.colorcolumn = "80"
          vim.opt.showmode = false
          vim.opt.signcolumn = "auto"
        end,
      })
      require("zen-mode").toggle()
    end)
  end,
}
