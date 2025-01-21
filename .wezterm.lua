-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices

config.leader = { key = 'a', mods = 'CTRL' }

-- note: capital letters mean SHIFT+letter
config.keys = {

  {
    key = 'w',
    mods = 'CMD',
    action = wezterm.action.CloseCurrentTab { confirm = true },
  },
  {
    key = 'x',
    mods = 'CMD',
    action = wezterm.action.ActivateCopyMode,
  },
  -- search for the lowercase string "hash" matching the case exactly
  {
    key = 'F',
    mods = 'CMD',
    action = wezterm.action.Search { CaseSensitiveString = 'hash' },
  },
  -- search for the string "hash" matching regardless of case
  {
    key = 'f',
    mods = 'CMD',
    action = wezterm.action.Search { CaseInSensitiveString = 'hash' },
  },
  -- CTRL-SHIFT-l activates the debug overlay for wezterm
  { key = 'L',
  mods = 'CTRL',
  action = wezterm.action.ShowDebugOverlay
  },

  -- ----------------------------------- Panes -----------------------------------
  {
    key = '_',
    mods = 'CMD',
    action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' },
  },
  {
    key = '|',
    mods = 'CMD',
    action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' },
  },
  {
    key = '[',
    mods = 'CMD|OPT',
    action = wezterm.action.AdjustPaneSize { 'Left', 5 },
  },
  {
    key = ']',
    mods = 'CMD|OPT',
    action = wezterm.action.AdjustPaneSize { 'Right', 5 },
  },
  -- ActivatePaneDirection
  {
    key = 'LeftArrow',
    mods = 'CMD|OPT',
    action = wezterm.action.ActivatePaneDirection 'Left',
  },
  {
    key = 'RightArrow',
    mods = 'CMD|OPT',
    action = wezterm.action.ActivatePaneDirection 'Right',
  },
  {
    key = 'UpArrow',
    mods = 'CMD|OPT',
    action = wezterm.action.ActivatePaneDirection 'Up',
  },
  {
    key = 'DownArrow',
    mods = 'CMD|OPT',
    action = wezterm.action.ActivatePaneDirection 'Down',
  },

  -- ----------------------------------- Tabs -----------------------------------

  -- CTRL-a, followed by o will switch back to the last active tab
  {
    key = 'T',
    mods = 'CMD',
    action = wezterm.action.ActivateLastTab,
  },
  -- Move the current tab relative to its peers
  { key = '[',
    mods = 'CMD',
    action = wezterm.action.MoveTabRelative(-1)
  },
  { key = ']',
  mods = 'CMD',
  action = wezterm.action.MoveTabRelative(1)
  },

  -- The tab navigator displays a list of tabs and allows you to select and activate a tab from that list
  { key = 'N',
  mods = 'CMD',
  action = wezterm.action.ShowTabNavigator
  },
}

-- switch between Panes
for i = 1, 8 do
  -- CMD+OPT + number to switch between panes
    table.insert(config.keys, {
    key = tostring(i),
    mods = 'CMD|OPT',
    action = wezterm.action.ActivatePaneByIndex(i - 1),
  })
end

-- Move the tab so that it has the index specified by the argument. eg: 1  moves the tab to be leftmost, while 2 moves the tab so that it is second tab from the left, and so on
for i = 1, 8 do
  -- CMD+ALT + number to move to that position
  table.insert(config.keys, {
    key = tostring(i),
    mods = 'CMD|CTRL',
    action = wezterm.action.MoveTab(i - 1),
  })
end

-- ActivateTab
-- for i = 1, 8 do
--   -- CTRL+ALT + number to activate that tab
--   table.insert(config.keys, {
--     key = tostring(i),
--     mods = 'CTRL|ALT',
--     action = act.ActivateTab(i - 1),
--   })
--   -- F1 through F8 to activate that tab
--   table.insert(config.keys, {
--     key = 'F' .. tostring(i),
--     action = act.ActivateTab(i - 1),
--   })
-- end

-- and finally, return the configuration to wezterm
return config

-- Keybindings

-- CTRL+d -> Close current Pane
-- CTRL+Tab/CTRL+SHIFT+Tab -> Move forward/backward across tabs
-- CMD++ -> Increase font size
-- CMD+- -> Decrease font size
-- CMD+t -> New tab in current window
-- CMD+n -> New window

