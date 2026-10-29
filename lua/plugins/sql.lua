-- The lang.sql extra formats with the ANSI dialect; the project uses PostgreSQL.
return {
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = function(_, opts)
      opts.formatters.sqlfluff = { args = { "format", "--dialect=postgres", "-" } }
    end,
  },
  {
    "mfussenegger/nvim-lint",
    optional = true,
    opts = function(_, opts)
      opts.linters = opts.linters or {}
      opts.linters.sqlfluff = {
        args = { "lint", "--format=json", "--dialect=postgres", "-" },
      }
    end,
  },
}
