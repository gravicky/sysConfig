-- define your colorscheme here
local colorscheme = 'gruvbox'

local is_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not is_ok then
    vim.notify('colorscheme ' .. colorscheme .. ' not found!')
    return
end

vim.o.background = "dark" -- or "light" for light mode
