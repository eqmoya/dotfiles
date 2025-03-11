return {
  "nvim-orgmode/orgmode",
  event = "VeryLazy",
  ft = { "org" },
  config = function()
    require("orgmode").setup({
      org_agenda_files = "~/Documents/**/*.org",
      org_default_notes_file = "~/Documents/Notes/Org/refile.org",
    })
  end,
}
