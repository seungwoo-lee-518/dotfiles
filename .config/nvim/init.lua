require('plugins')
-- Set Colorscheme
vim.cmd[[ colorscheme tokyonight-storm ]]

require('gitsigns').setup()

-- Mandatory
vim.wo.number = true
vim.cmd[[ set noexpandtab ]]
vim.cmd[[ set tabstop=4 ]]
vim.cmd[[ set shiftwidth=4 ]]
-- Go Specific Configuration
local format_sync_grp = vim.api.nvim_create_augroup("GoImport", {})
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.go",
  callback = function()
   require('go.format').goimport()
  end,
  group = format_sync_grp,
})

require('go').setup()

-- nvim-tree Configuration
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.opt.termguicolors = true
-- empty setup using defaults
require("nvim-tree").setup()
