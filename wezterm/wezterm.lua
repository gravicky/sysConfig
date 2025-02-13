local wezterm = require("wezterm") -- Pull in the wezterm API
local powerline = require("powerline") -- Load the functions from the powerline.lua file

-- This will hold the configuration.
local config = wezterm.config_builder()
local mux = wezterm.mux

-- This is where you actually apply your config choices

config.leader = { key = 'a', mods = 'CTRL' }

-- note: capital letters mean SHIFT+letter
config.keys = {

  { key = 'w', mods = 'CMD', action = wezterm.action.CloseCurrentTab { confirm = false }, },
  { key = 'x', mods = 'CMD', action = wezterm.action.ActivateCopyMode, },

  -- search for the lowercase string "hash" matching the case exactly
  { key = 'F', mods = 'CMD', action = wezterm.action.Search { CaseSensitiveString = 'hash' }, },

  -- search for the string "hash" matching regardless of case
  { key = 'f', mods = 'CMD', action = wezterm.action.Search { CaseInSensitiveString = 'hash' }, },

  -- CTRL-SHIFT-l activates the debug overlay for wezterm
  { key = 'L', mods = 'CTRL', action = wezterm.action.ShowDebugOverlay },

  -- ----------------------------------- Panes -----------------------------------

  { key = '_', mods = 'CMD', action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' }, },
  { key = '|', mods = 'CMD', action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' }, },
  { key = '[', mods = 'CMD|OPT', action = wezterm.action.AdjustPaneSize { 'Left', 5 }, },
  { key = ']', mods = 'CMD|OPT', action = wezterm.action.AdjustPaneSize { 'Right', 5 }, },

  -- ActivatePaneDirection
  { key = 'LeftArrow', mods = 'CMD|OPT', action = wezterm.action.ActivatePaneDirection 'Left', },
  { key = 'RightArrow', mods = 'CMD|OPT', action = wezterm.action.ActivatePaneDirection 'Right', },
  { key = 'UpArrow', mods = 'CMD|OPT', action = wezterm.action.ActivatePaneDirection 'Up', },
  { key = 'DownArrow', mods = 'CMD|OPT', action = wezterm.action.ActivatePaneDirection 'Down', },
  { key = 'W', mods = 'CMD', action = wezterm.action.CloseCurrentPane{ confirm = false }, },
  { key = 'z', mods = 'CMD|OPT', action = wezterm.action.TogglePaneZoomState, },

  -- ----------------------------------- Tabs -----------------------------------

  { key = 'T', mods = 'CMD', action = wezterm.action.ActivateLastTab, },

  -- Move the current tab relative to its peers
  { key = '[', mods = 'CMD', action = wezterm.action.MoveTabRelative(-1) },
  { key = ']', mods = 'CMD', action = wezterm.action.MoveTabRelative(1) },
  { key = 'H', mods = 'CMD', action = wezterm.action.ActivateTabRelative(-1) },
  { key = 'L', mods = 'CMD', action = wezterm.action.ActivateTabRelative(1) },

  -- The tab navigator displays a list of tabs and allows you to select and activate a tab from that list
  { key = 'N', mods = 'CMD', action = wezterm.action.ShowTabNavigator },

  -- ----------------------------------- workspaces -----------------------------------

  -- Present a list of existing workspaces
  { key = 'f', mods = 'LEADER', action = wezterm.action.ShowLauncherArgs { flags = 'FUZZY|WORKSPACES' }, },

  { key = 'l', mods = 'LEADER', action = wezterm.action.SwitchWorkspaceRelative(1) },
  { key = 'h', mods = 'LEADER', action = wezterm.action.SwitchWorkspaceRelative(-1) },

  -- Switch to a monitoring workspace, which will have `top` launched into it
  {
    key = 'm',
    mods = 'LEADER',
    action = wezterm.action.SwitchToWorkspace {
      name = 'monitoring',
      spawn = {
        args = { '/opt/homebrew/bin/glances' },
      },
    },
  },

  -- Prompt for a name to use for a new workspace and switch to it.
  {
    key = 'n',
    mods = 'LEADER',
    action = wezterm.action.PromptInputLine {
      description = wezterm.format {
        { Attribute = { Intensity = 'Bold' } },
        { Foreground = { AnsiColor = 'Fuchsia' } },
        { Text = 'Enter name for new workspace' },
      },
      action = wezterm.action_callback(function(window, pane, line)
        -- line will be `nil` if they hit escape without entering anything
        -- An empty string if they just hit enter
        -- Or the actual line of text they wrote
        if line then
          window:perform_action(
            wezterm.action.SwitchToWorkspace {
              name = line,
            },
            pane
          )
        end
      end),
    },
  },

  -- To delete a workspace, delete all tabs in that workspace

}

-- switch between Panes
for i = 1, 8 do
  -- CMD+OPT + number to switch between panes
    table.insert(config.keys, { key = tostring(i), mods = 'CMD|OPT', action = wezterm.action.ActivatePaneByIndex(i - 1), })
end

-- Move the tab so that it has the index specified by the argument. eg: 1  moves the tab to be leftmost, while 2 moves the tab so that it is second tab from the left, and so on
for i = 1, 8 do
  -- CMD+ALT + number to move to that position
  table.insert(config.keys, { key = tostring(i), mods = 'CMD|CTRL', action = wezterm.action.MoveTab(i - 1), })
end

-- ActivateTab
-- for i = 1, 8 do
--   -- CTRL+ALT + number to activate that tab
--   table.insert(config.keys, { key = tostring(i), mods = 'CTRL|ALT', action = wezterm.action.ActivateTab(i - 1), })
-- end

-- Bind the update-status handler from powerline.lua
wezterm.on('update-status', function(window, _)
  powerline.update_right_status(window)
end)

-- and finally, return the configuration to wezterm
return config









-- Keybindings

-- CTRL+d -> Close current Pane
-- CTRL+Tab/CTRL+SHIFT+Tab -> Move forward/backward across tabs
-- CMD++ -> Increase font size
-- CMD+- -> Decrease font size
-- CMD+t -> New tab in current window
-- CMD+n -> New window

