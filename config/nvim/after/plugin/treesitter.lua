require('nvim-treesitter.configs').setup {
  ensure_installed = {
    'cpp',
    'elixir',
    'eex',
    'heex',
    'fish',
    'go',
    'lua',
    'python',
    'ruby',
    'rust',
    'tsx',
    'typescript',
    'vim',
    'vimdoc',
  },
  auto_install = false,
  highlight = { enable = true },
  indent = { enable = true }
}

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })
