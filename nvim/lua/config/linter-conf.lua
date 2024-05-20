-- nvim-lint config
require('lint').linters_by_ft = {
   python= {'flake8',}
}

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
  callback = function()

    -- try_lint without arguments runs the linters defined in `linters_by_ft`
    -- for the current filetype
    require("lint").try_lint()
  end,
})

-- mason-nvim-lint config
require ('mason-nvim-lint').setup({
    ensure_installed = {'flake8'},
})
