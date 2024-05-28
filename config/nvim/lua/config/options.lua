-- automatically read files when changed
vim.o.autoread = true
-- remove swap files
-- vim.o.noswapfile = true

-- vim.o.list listchars=tab:»·,precedes:-,trail:·,nbsp:+
vim.o.mouse = 'a'

-- show line numbers
vim.o.relativenumber = true

-- spaces instead of tabs
vim.o.expandtab = true
-- 1 tab = 2 spaces
vim.o.shiftwidth = 2
vim.o.tabstop = 2

-- open new split panes to bottom and the right
vim.o.splitbelow = true
vim.o.splitright = true

-- default text width is 80
vim.o.textwidth=80
-- highlight lines over that 1 column after 'textwidth'
vim.o.colorcolumn = "+1"
-- always show sign column to avoid plugins toggling on/off
--vim.o.signcolumn = true

-- vim.o.wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.class,*DS_Store* " general
-- vim.o.wildignore+=*bower_components/**,*node_modules/**,*build/**,*dist/** " JS
-- vim.o.wildignore+=*deps/**,*_build/** " elixir
