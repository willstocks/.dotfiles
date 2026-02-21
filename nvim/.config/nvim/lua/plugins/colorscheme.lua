return {
  -- Configure LazyVim to use Catppuccin
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin",
    },
  },

  -- Add the Catppuccin plugin
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000, -- Ensures it loads before other plugins [1, 7]
    opts = {
      -- Optional: customize flavour (e.g., "mocha", "latte", "macchiato", "frappe")
      flavour = "mocha", 
    },
  },
}
