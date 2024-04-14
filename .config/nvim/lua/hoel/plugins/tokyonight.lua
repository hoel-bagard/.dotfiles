return {
  "folke/tokyonight.nvim",
  lazy = false,
  priority = 1000,
  opts = {},
  init = function()
    vim.cmd.colorscheme "tokyonight-night"
  end,
}
-- TODO: https://github.com/folke/tokyonight.nvim?tab=readme-ov-file#fix-undercurls-in-tmux
