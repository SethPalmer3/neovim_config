return {
  {
    'morhetz/gruvbox',
    config = function()
      vim.g.gruvbox_contrast_dark = "soft"
      vim.cmd [[colorscheme gruvbox]]
    end,
  },
  {
    'loctvl842/monokai-pro.nvim',
    -- config = function()
    --   vim.cmd [[colorscheme monokai-pro-ristretto]]
    -- end,
  }
}
