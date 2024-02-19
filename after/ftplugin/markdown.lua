vim.opt_local.colorcolumn = "100"
vim.opt_local.spell = true
vim.opt_local.linebreak = true
vim.opt_local.textwidth = 100
vim.opt_local.spelllang = "en"
vim.opt_local.concealcursor = "nv"
vim.opt_local.formatoptions = "tcqjn"


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

local function setup_obsidian()
  vim.keymap.set("n", "<localleader>oo", [[<cmd>ObsidianOpen<cr>]], { silent = true, buffer = true })
  vim.keymap.set("n", "<localleader>so", [[<cmd>ObsidianSearch<cr>]], { silent = true, buffer = true })
  vim.keymap.set("n", "<localleader>on", [[<cmd>ObsidianNew<cr>]], { silent = true, buffer = true })
  vim.keymap.set("v", "<localleader>oe", [[<cmd>ObsidianExtractNote<cr>]], { silent = true, buffer = true })
end


local workspaces = get_obsidian_workspaces()
for _, ws in ipairs(workspaces) do
  if (vim.startswith(vim.fn.expand('%:h'), ws.path)) then
    setup_obsidian()
    break
  end
end

-- vim.opt_local.formatlistpat = [[^\s*\([~]\+\|[-]\+\)\s*]]
