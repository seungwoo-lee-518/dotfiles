require('plugins')
-- Set Colorscheme
vim.cmd[[ colorscheme tokyonight-storm ]]

-- Mandatory
vim.wo.number = true
vim.cmd[[ set noexpandtab ]]
vim.cmd[[ set tabstop=2 ]]
vim.cmd[[ set shiftwidth=2 ]]
vim.cmd[[ set mouse+=a ]]
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

local builtin = require('telescope.builtin')
-- Fuzzy Finder
vim.keymap.set('n', '<Space> ff', builtin.find_files, {})
vim.keymap.set('n', '<Space> fg', builtin.live_grep, {})
vim.keymap.set('n', '<Space> fb', builtin.buffers, {})
vim.keymap.set('n', '<Space> fh', builtin.help_tags, {})

-- NerdTree
vim.keymap.set('n', '<C-n>', ':NERDTree<CR>')
vim.keymap.set('n', '<C-t>', ':NERDTreeToggle<CR>')
vim.keymap.set('n', '<C-f>', ':NERDTreeFind<CR>')

require("toggleterm").setup{}

vim.keymap.set('n', '<C-A-t>', ':ToggleTerm<CR>')

local rt = require("rust-tools")

rt.setup({
  server = {
    on_attach = function(_, bufnr)
      -- Hover actions
      vim.keymap.set("n", "<C-space>", rt.hover_actions.hover_actions, { buffer = bufnr })
      -- Code action groups
      vim.keymap.set("n", "<Leader>a", rt.code_action_group.code_action_group, { buffer = bufnr })
    end,
  },
})
