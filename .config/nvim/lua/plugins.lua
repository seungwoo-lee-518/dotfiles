require('packer').startup(function(use)
	use 'wbthomason/packer.nvim'
	use 'neovim/nvim-lspconfig'
	use { 'ms-jpq/coq_nvim', run = 'python3 -m coq deps' }
	use 'ms-jpq/coq.artifacts'
	use 'ms-jpq/coq.thirdparty'
	use 'ray-x/go.nvim'
	use 'ray-x/guihua.lua' -- recommended if need floating window support
	use 'nvim-treesitter/nvim-treesitter'
	use 'folke/tokyonight.nvim' -- theme
end)

vim.g.coq_settings = { auto_start = 'shut-up' }

local opts = { noremap=true, silent=true }
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)
  vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = true } end, bufopts)
end

vim.cmd [[packadd packer.nvim]]

require('lspconfig').pylsp.setup {
	require('coq').lsp_ensure_capabilities({
		on_attach = on_attach,
		settings = {
			pylsp = {
				plugins = {
					pycodestyle = {
						maxLength = 100
					}
				}
			}
		}
	})
}

require('lspconfig').yamlls.setup {
		settings = {
			yaml = {
				schemas = {
					kubernetes = "/*.yaml"
				}
			}
		}
}

require('lspconfig').gopls.setup{}

require('lspconfig').marksman.setup {
	require('coq').lsp_ensure_capabilities({
	})
}

require('lspconfig').bashls.setup {}

require('lspconfig').volar.setup {
		filetypes = {'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue', 'json'},
		init_options = {
			typescript = {
				tsdk = '/home/seungwoo/.local/share/pnpm/global/5/node_modules/typescript/lib'
			}
		}
}

require('go').setup()
