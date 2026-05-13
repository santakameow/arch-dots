return {
  {
    "ellisonleao/gruvbox.nvim",
    priority = 1000,
    opts = {
      terminal_colors = true,
      contrast = "hard",
      italic = {
        strings = false,
        comments = false,
        operators = false,
        folds = false,
      },
    },
  },

  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "gruvbox",
    },
  },
}
