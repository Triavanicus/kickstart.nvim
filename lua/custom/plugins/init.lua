-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information

local function get_obsidian_workspaces()
  local workspaces = {}
  local function add_to_ws(mod)
    if pcall(function() require(mod) end) then
      local tbl = require(mod)
      for _, v in ipairs(tbl.workspaces) do
        table.insert(workspaces, v)
      end
    end
  end

  add_to_ws('custom.personal.obsidian')
  add_to_ws('custom.work.obsidian')

  return workspaces
end

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
    'epwalsh/obsidian.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
    opts = {
      workspaces = get_obsidian_workspaces()
    },
    config = function(_, opts)
      require('obsidian').setup(opts)
      vim.keymap.set("n", "<leader>os", [[<cmd>ObsidianQuickSwitch<cr>]], { silent = true})
    end
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
        ["core.concealer"] = { -- Adds pretty icons to your documents
          config = {
            icon_preset = "diamond",
          },
        },
        ["core.summary"] = {},   -- Generates workspace summaries
        ["core.dirman"] = {      -- Manages Neorg workspaces
          config = {
            workspaces = {
              notes = "~/Documents/notes",
              work_notes = "~/Documents/work_notes"
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
  { import = 'custom.personal.plugins' },
  --{ import = 'custom.work.plugins' },
}

-- vim: ts=2 sts=2 sw=2 et
