-- disable space charecter
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

-- use - and | for horizontal or vertical splits
vim.keymap.set('n', '|', "<cmd>vsplit<cr>")
vim.keymap.set('n', '-', "<cmd>split<cr>")

-- enable spelling
vim.keymap.set({ "n", "i" }, "<C-s>", "<cmd>setlocal spell! spelllang=en_us<cr>")

-- disable arrow keys in insert mode
vim.keymap.set("i", "<up>", "<nop>", { silent = true })
vim.keymap.set("i", "<down>", "<nop>", { silent = true })
vim.keymap.set("i", "<left>", "<nop>", { silent = true })
vim.keymap.set("i", "<right>", "<nop>", { silent = true })
