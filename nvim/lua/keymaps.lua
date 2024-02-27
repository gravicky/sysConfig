-- define common options
local opts = {
    noremap = true,      -- non-recursive
--    silent = true,       -- do not show message
}

-----------------
-- Normal mode --
-----------------

-- Hint: see `:h vim.map.set()`
-- Better window navigation
vim.keymap.set('n', '<C-h>', '<C-w>h', opts)
vim.keymap.set('n', '<C-j>', '<C-w>j', opts)
vim.keymap.set('n', '<C-k>', '<C-w>k', opts)
vim.keymap.set('n', '<C-l>', '<C-w>l', opts)

-- Open terminal in new tab
vim.keymap.set('n', '<C-t>', ':tabnew | startinsert | term<CR>', opts)
-- Open terminal in split window
vim.keymap.set('n', '<C-S-T>', ':vsplit | startinsert | term<CR>', opts)

-- Nvim keymaps
vim.keymap.set('n', '<C-n>', ':NvimTreeToggle<CR>', opts) -- <CR> tells it to press enter after command

-- Markdown Preview
vim.keymap.set('n', '<C-m>', ':MarkdownPreviewToggle<CR>', opts)

-- Resize with arrows
-- delta: 2 lines
-- vim.keymap.set('n', '<C-Up>', ':resize -2<CR>', opts)
-- vim.keymap.set('n', '<C-Down>', ':resize +2<CR>', opts)
-- vim.keymap.set('n', '<C-Left>', ':vertical resize -2<CR>', opts)
-- vim.keymap.set('n', '<C-Right>', ':vertical resize +2<CR>', opts)

-----------------
-- Visual mode --
-----------------

-- Hint: start visual mode with the same area as the previous area and the same mode
-- Pressing '<' or '>' in visual mode will move selected data to left/right
vim.keymap.set('v', '<', '<gv', opts)
vim.keymap.set('v', '>', '>gv', opts)

