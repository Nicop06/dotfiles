local awful = require("awful")
local naughty = require("naughty")

-- {{{ Mcabber event function
function mcabber_event_hook(kind, direction, jid, msg)
    if kind == "MSG" then
        if direction == "IN" then
            local filehandle = io.open(msg)
            local txt = filehandle:read("*all")
            filehandle:close()
            awful.util.spawn("rm "..msg)
            naughty.notify{
                icon = "chat_msg_recv",
                text = awful.util.escape(txt),
                title = jid
            }
        end
    end
end
-- }}}
