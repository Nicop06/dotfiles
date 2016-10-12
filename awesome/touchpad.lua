local naughty = require("naughty")
local awful = require("awful")

local prev_id = 0

function toggle_touchpad()
  local icon
  local fd = io.popen("synclient -l")
  local status = fd:read("*all")
  fd:close()

  if string.match(status, "TouchpadOff *= *1") then
    awful.util.spawn("synclient TouchpadOff=0")
    status = "Enabled"
    icon = "input-touchpad.png"
  else
    awful.util.spawn("synclient TouchpadOff=1")
    status = "Disabled"
    icon = "input-touchpad-symbolic.symbolic.png"
  end

  local options = {
    title = "Touchpad",
    text = status,
    timeout = 1,
    icon = "/usr/share/icons/Adwaita/48x48/devices/" .. icon
  }
  if prev_id ~= 0 then
    options.replaces_id = prev_id
  end
  prev_id = naughty.notify(options).id
end
