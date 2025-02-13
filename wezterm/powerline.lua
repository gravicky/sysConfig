local wezterm = require("wezterm") -- Pull in the wezterm API

-- Function to generate segments for the right status
local function segments_for_right_status(window)
  -- Get the active workspace
  local workspace = window:active_workspace()

  -- Get current date and time
  local date_time = wezterm.strftime('%a %b %-d %H:%M')

  -- Return the segments (this can be changed to reflect the info you need)
  return {
    workspace,
    date_time,
  }
end

-- The function to handle the 'update-status' event
local function update_right_status(window)
  local SOLID_LEFT_ARROW = utf8.char(0xe0b2)
  local segments = segments_for_right_status(window)

  -- Get color scheme
  local color_scheme = window:effective_config().resolved_palette
  local bg = color_scheme.background or "#000000"
  local fg = color_scheme.foreground or "#FFFFFF"

  bg = wezterm.color.parse(bg)
  fg = wezterm.color.parse(fg)

  -- Assume background is dark, so lighten the gradient
  local gradient_from = bg:lighten(0.2)
  local gradient_to = bg

  -- Create a gradient
  local gradient = wezterm.color.gradient(
    {
      orientation = 'Horizontal',
      colors = { gradient_from, gradient_to },
    },
    #segments
  )

  -- Prepare the elements for the status bar format
  local elements = {}

  for i, seg in ipairs(segments) do
    local is_first = i == 1
    if is_first then
      table.insert(elements, { Background = { Color = 'none' } })
    end
    table.insert(elements, { Foreground = { Color = gradient[i] } })
    table.insert(elements, { Text = SOLID_LEFT_ARROW })

    table.insert(elements, { Foreground = { Color = fg } })
    table.insert(elements, { Background = { Color = gradient[i] } })
    table.insert(elements, { Text = ' ' .. seg .. ' ' })
  end

  window:set_right_status(wezterm.format(elements))
end

-- Return the function to be used in the main config
return {
  update_right_status = update_right_status
}

