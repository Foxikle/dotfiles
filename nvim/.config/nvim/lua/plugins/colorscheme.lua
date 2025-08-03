return {
  {
    "sainnhe/everforest",
    lazy = false,
    priority = 1000,
    config = function()
      vim.g.everforest_background = "hard" -- or "medium" / "hard"
      vim.cmd("colorscheme everforest")
    end,
  },
}
