require('telescope').setup({
    defaults = {
      layout_config = { preview_width = 0.6 }
    }
})

local builtin = require('telescope.builtin')

vim.keymap.set('n', '<c-p>', builtin.find_files, {})
vim.keymap.set('n', '<leader>g', builtin.live_grep, {})
vim.keymap.set('n', '<leader>G', builtin.grep_string, {})