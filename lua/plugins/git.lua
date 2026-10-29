return {
  {
    "sindrets/diffview.nvim",
    cmd = { "DiffviewOpen", "DiffviewFileHistory", "DiffviewClose" },
    keys = {
      { "<leader>gv", "<cmd>DiffviewOpen<cr>", desc = "Diffview" },
      { "<leader>gV", "<cmd>DiffviewFileHistory<cr>", desc = "Branch History (Diffview)" },
    },
  },
}
