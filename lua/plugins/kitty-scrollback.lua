-- Copy mode for kitty: `alt+c` then `x` opens the screen and scrollback in this buffer.
return {
  {
    "mikesmithgh/kitty-scrollback.nvim",
    lazy = true,
    cmd = { "KittyScrollbackGenerateKittens", "KittyScrollbackCheckHealth", "KittyScrollbackGenerateCommandLineEditing" },
    event = { "User KittyScrollbackLaunch" },
    config = function()
      require("kitty-scrollback").setup()
      -- The kitten sets KITTY_SCROLLBACK_NVIM, so this never applies to an ordinary Neovim session.
      if vim.env.KITTY_SCROLLBACK_NVIM == "true" then
        -- Ctrl+c copies the selection to the system clipboard and returns to kitty.
        vim.keymap.set("x", "<C-c>", function()
          vim.cmd('normal! "+y')
          require("kitty-scrollback.api").quit_all()
        end, { desc = "Copy selection and leave copy mode" })
      end
    end,
  },
}
