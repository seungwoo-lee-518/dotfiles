require('packer').startup(function(use)
	use 'wbthomason/packer.nvim'
	use 'neovim/nvim-lspconfig'
	use 'hrsh7th/nvim-cmp' -- Autocompletion plugin
	use 'hrsh7th/cmp-nvim-lsp' -- LSP source for nvim-cmp
	use 'saadparwaiz1/cmp_luasnip' -- Snippets source for nvim-cmp
	use 'L3MON4D3/LuaSnip' -- Snippets plugin
	use 'ray-x/go.nvim'
	use 'ray-x/guihua.lua' -- recommended if need floating window support
	use { 'nvim-telescope/telescope.nvim', tag = '0.1.1', requires = { {'nvim-lua/plenary.nvim'} } }
	use { 'nvim-treesitter/nvim-treesitter' }
	use 'folke/tokyonight.nvim' -- theme
	use 'nvim-tree/nvim-web-devicons'
	use {'romgrk/barbar.nvim', wants = 'nvim-web-devicons'}
	use 'jparise/vim-graphql'
	use 'preservim/nerdtree'
	use {"akinsho/toggleterm.nvim", tag = '*', config = function()
		require("toggleterm").setup()
	end}
end)

vim.cmd [[packadd packer.nvim]]

-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
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

local lsp_flags = {
  -- This is the default in Nvim 0.7+
  debounce_text_changes = 150,
}

require('lspconfig').pyright.setup {
	on_attach = on_attach,
	flags = lsp_flags
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

require('lspconfig').gopls.setup{
	on_attach = on_attach,
	flags = lsp_flags
}

require('lspconfig').marksman.setup {
	on_attach = on_attach,
	flags = lsp_flags
}

require('lspconfig').bashls.setup {
	on_attach = on_attach,
	flags = lsp_flags
}

require('lspconfig').volar.setup {
	on_attach = on_attach,
	flags = lsp_flags,
	filetypes = {'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue', 'json'},
	init_options = {
		typescript = {
			tsdk = '/home/seungwoo/.local/share/pnpm/global/5/node_modules/typescript/lib'
		}
	}
}

require('lspconfig').nil_ls.setup {
	on_attach = on_attach,
	flags = lsp_flags
}

require('lspconfig').tailwindcss.setup {
	on_attach = on_attach,
	flags = lsp_flags
}

-- pnpm install -g graphql graphql-language-service-cli
-- NOTE: https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#graphql
-- NOTE: https://the-guild.dev/graphql/config/docs
require('lspconfig').graphql.setup {
	on_attach = on_attach,
	flags = lsp_flags,
	filetypes = {'vue', 'typescript', 'javascriptreact', 'typescriptreact', 'graphql'}
}

-- npm install -g dockerfile-language-server-nodejs
require('lspconfig').dockerls.setup {
	on_attach = on_attach,
	flags = lsp_flags
}

-- luasnip setup
local luasnip = require 'luasnip'

-- nvim-cmp setup
local cmp = require 'cmp'
cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-u>'] = cmp.mapping.scroll_docs(-4), -- Up
    ['<C-d>'] = cmp.mapping.scroll_docs(4), -- Down
    -- C-b (back) C-f (forward) for snippet placeholder navigation.
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  }),
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  },
}

require('nvim-treesitter.configs').setup {}
