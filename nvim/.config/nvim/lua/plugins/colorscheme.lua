return {
  -- add the melange theme
  { "savq/melange-nvim" },
  { "nuvic/flexoki-nvim", name = "flexoki" },
  { "rose-pine/neovim", name = "rose-pine" },
  { "nyoom-engineering/oxocarbon.nvim" },
  { "rebelot/kanagawa.nvim" },
  { "vague2k/vague.nvim" },
  -- Configure LazyVim to load melange
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "vague",
    },
  },
}
