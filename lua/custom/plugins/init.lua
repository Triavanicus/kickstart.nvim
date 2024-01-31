-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  {
    -- LSP conpletion from cli tools
    'jay-babu/mason-null-ls.nvim',
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      'nvimtools/none-ls.nvim',
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
    },
  },
  {
    -- Note taking
    'nvim-neorg/neorg',
    tag = 'v7.0.0',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-treesitter/nvim-treesitter'
    },
    build = ':Neorg sync-parsers',
    --ft = 'norg',
    opts = {
      load = {
        ["core.defaults"] = {},  -- Loads default behaviour
        ["core.concealer"] = {}, -- Adds pretty icons to your documents
        ["core.summary"] = {},   -- Generates workspace summaries
        ["core.dirman"] = {      -- Manages Neorg workspaces
          config = {
            workspaces = {
              notes = "~/notes",
            },
            default_workspace = 'notes',
          },
        },
      },
    },
    config = function(_, opts)
      require('neorg').setup(opts)
      vim.wo.conceallevel = 2
      vim.wo.foldlevel = 99
    end
  },
}

-- vim: ts=2 sts=2 sw=2 et
