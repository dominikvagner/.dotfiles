-- Override LazyVim Go extra to match project's .golangci.yaml:
--   project uses gofmt + gci, not gofumpt + goimports
return {
  -- Disable gofumpt in gopls (project uses standard gofmt)
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        gopls = {
          settings = {
            gopls = {
              gofumpt = false,
            },
          },
        },
      },
    },
  },

  -- Use gofmt + gci to match project's .golangci.yaml
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = {
      formatters_by_ft = {
        go = { "gofmt", "gci" },
      },
    },
  },

  -- Ensure gci is installed via Mason
  {
    "mason-org/mason.nvim",
    opts = {
      ensure_installed = { "gci" },
    },
  },

  -- Remove goimports + gofumpt from none-ls (let conform handle formatting)
  {
    "nvimtools/none-ls.nvim",
    optional = true,
    opts = function(_, opts)
      local nls = require("null-ls")
      opts.sources = vim.tbl_filter(function(source)
        return source ~= nls.builtins.formatting.goimports
          and source ~= nls.builtins.formatting.gofumpt
      end, opts.sources or {})
    end,
  },
}
