local lsp = require('lsp-zero').preset({})

lsp.on_attach(function(_client, bufnr)
  -- see :help lsp-zero-keybindings
  -- to learn the available actions
  lsp.default_keymaps({ buffer = bufnr })

  vim.keymap.set({ 'n', 'x' }, '<leader>f', function()
    vim.lsp.buf.format({ async = false, timeout_ms = 10000 })
  end, {})
end)

-- (Optional) Configure lua language server for neovim
require('lspconfig').lua_ls.setup(lsp.nvim_lua_ls())

lsp.setup()
