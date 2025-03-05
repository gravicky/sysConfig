Failed to run `config` for obsidian.nvim

...ocal/share/nvim/lazy/obsidian.nvim/lua/obsidian/path.lua:402: FileNotFoundError: /Users/vicky/Library/CloudStorage/Dropbox/obsidian

# stacktrace:
  - /obsidian.nvim/lua/obsidian/path.lua:402 _in_ **resolve**
  - /obsidian.nvim/lua/obsidian/workspace.lua:79 _in_ **new_from_spec**
  - /obsidian.nvim/lua/obsidian/workspace.lua:169 _in_ **get_workspace_for_cwd**
  - /obsidian.nvim/lua/obsidian/workspace.lua:206 _in_ **get_from_opts**
  - /obsidian.nvim/lua/obsidian/client.lua:93 _in_ **new**
  - /obsidian.nvim/lua/obsidian/init.lua:95 _in_ **setup**
  - /opt/homebrew/Cellar/neovim/0.10.3/share/nvim/runtime/filetype.lua:36
  - /opt/homebrew/Cellar/neovim/0.10.3/share/nvim/runtime/filetype.lua:35

[null-ls] failed to load builtin rustfmt for method formatting; please check your config

Combine or make completions and lang in lsp modules

Auto install pyright, rust lsp (mason?) - can we use lazy?

ts_ls instead of tsserver

[ERROR][2025-02-18 12:42:07] ...m/lsp/client.lua:974	"LSP[pyright]"	"on_error"	{  code = "ON_INIT_CALLBACK_ERROR",  err = "...im/lazy/navigator.lua/lua/navigator/lspclient/python.lua:15: invalid value (nil) at index 1 in table for 'concat'"}

delete adds data to buffer 0 and overwrites copy

