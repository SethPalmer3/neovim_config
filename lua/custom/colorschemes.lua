return {
  {
    'morhetz/gruvbox',
    config = function()
      vim.g.gruvbox_contrast_dark = "soft"
      vim.cmd [[colorscheme gruvbox]]
    end,
  },
}
