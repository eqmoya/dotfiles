return {
  "ellisonleao/gruvbox.nvim",
  priority = 1000,
  config = function()
    local palette = require("gruvbox").palette

    require("gruvbox").setup({
      overrides = {
        SignColumn = { bg = "NONE" },
        DiagnosticSignError = { fg = palette.neutral_red, bg = "NONE" },
        DiagnosticSignWarn = { fg = palette.neutral_yellow, bg = "NONE" },
        DiagnosticSignInfo = { fg = palette.neutral_blue, bg = "NONE" },
        DiagnosticSignHint = { fg = palette.neutral_aqua, bg = "NONE" },
      },
    })

    vim.cmd.colorscheme("gruvbox")
  end,
}
