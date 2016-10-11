local wibox = require("wibox")
local naughty = require("naughty")

local prev_id = 0

volume_widget = wibox.widget.textbox()
volume_widget:set_align("right")

function update_volume(widget, notify)
  local fd = io.popen("amixer sget Master")
  local status = fd:read("*all")
  fd:close()

  local volume = string.match(status, "(%d?%d?%d)%%")
  volume = string.format("% 3d", volume)

  status = string.match(status, "%[(o[^%]]*)%]")

  if string.find(status, "on", 1, true) then
    -- For the volume numbers
    local volume_perc = math.floor(tonumber(volume) / 10)
    status = "[" .. string.rep("=", volume_perc) .. string.rep(" ", 10 - volume_perc) .. "]"

    volume = volume .. "%"
  else
    -- For the mute button
    status = "[" .. string.rep(" ", 10) .. "]"
    volume = volume .. "M"

  end
  widget:set_markup(volume)

  if notify then
    local options = {
      title = "Volume",
      text = status,
      font = "Monospace 11",
      icon = "/usr/share/icons/Adwaita/48x48/apps/multimedia-volume-control.png"
    }
    if prev_id ~= 0 then
      options.replaces_id = prev_id
    end
    prev_id = naughty.notify(options).id
  end
end
 
update_volume(volume_widget, false)
