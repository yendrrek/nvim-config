vim.filetype.add({ extension = { gradle = "groovy" } })

return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = { "groovy", "kotlin", "xml", "properties", "regex" },
    },
  },
}
