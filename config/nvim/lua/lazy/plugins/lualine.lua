return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    require("lualine").setup({
      options = {
        component_separators = "",
        section_separators = { left = "", right = "" },
      },
      sections = {
        lualine_a = {
          "mode",
        },
        lualine_b = {
          "filename",
          "branch",
        },
        lualine_c = {
          "diff",
        },
        lualine_x = {
          {
            "diagnostics",
            symbols = { error = " ", warn = " ", info = " ", hint = " " },
          },
        },
        lualine_y = { "progress" },
        lualine_z = { "location" },
      },
    })
  end,
}
