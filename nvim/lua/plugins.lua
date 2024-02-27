-- Install Packer automatically if it's not installed(Bootstraping)
-- Hint: string concatenation is done by `..`
local ensure_packer = function()
    local fn = vim.fn
    local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
        vim.cmd [[packadd packer.nvim]]
        return true
    end
    return false
end
local packer_bootstrap = ensure_packer()


-- Reload configurations if we modify plugins.lua
-- Hint
--     <afile> - replaced with the filename of the buffer being manipulated
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])


-- Install plugins here - `use ...`
-- Packer.nvim hints
--     after = string or list,           -- Specifies plugins to load before this plugin. See "sequencing" below
--     config = string or function,      -- Specifies code to run after this plugin is loaded
--     requires = string or list,        -- Specifies plugin dependencies. See "dependencies". 
--     ft = string or list,              -- Specifies filetypes which load this plugin.
--     run = string, function, or table, -- Specify operations to be run after successful installs/updates of a plugin
return require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'
	use { 'ellisonleao/gruvbox.nvim' }									-- gruvbox theme for neovim
	use { 'neovim/nvim-lspconfig' }										-- configure Language Server Protocol
	use { 'williamboman/mason.nvim' }									-- package manager for LSP servers, DAP servers, linters, and formatters
	use { 'williamboman/mason-lspconfig.nvim'}							-- Extension to mason.nvim that makes it easier to use lspconfig with mason.nvim
	use { 'hrsh7th/nvim-cmp', config = [[require('config.nvim-cmp')]] } -- framework for various completion sources
	use { 'hrsh7th/cmp-nvim-lsp', after = 'nvim-cmp' }					-- extends nvim-cmp by providing a source that integrates with the LSP servers configured through nvim-lspconfig 
	use { 'hrsh7th/cmp-buffer', after = 'nvim-cmp' }    			    -- buffer auto-completion
	use { 'hrsh7th/cmp-path', after = 'nvim-cmp' }      			    -- path auto-completion
	use { 'hrsh7th/cmp-cmdline', after = 'nvim-cmp' }   			    -- cmdline auto-completion
	use 'L3MON4D3/LuaSnip'           									-- code snippet engine
	use 'saadparwaiz1/cmp_luasnip'                      			    -- enables autocompletion of snippets provided by LuaSnip 
    use {'iamcco/markdown-preview.nvim'}                                -- instant markdown-preview
    use {                                                               -- enables autocompletion of inverted commas and brackets
	    "windwp/nvim-autopairs",
        config = function() require("nvim-autopairs").setup {} end
    }
    use {                                                               -- adds nvim-tree file explorer
        'nvim-tree/nvim-tree.lua',
        requires = {
            'nvim-tree/nvim-web-devicons', -- optional
        },
    } 
 	-- more plugins here
  
    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if packer_bootstrap then
        require('packer').sync()
    end
end)

