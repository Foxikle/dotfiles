return {
  {
    "sainnhe/everforest",
    lazy = false,
    priority = 1000,
    config = function()
      vim.g.everforest_background = "medium" -- or "medium" / "hard"
      vim.cmd("colorscheme everforest")
    end,
  },
}
