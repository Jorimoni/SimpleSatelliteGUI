satellitegui = {}

local mod_gui = require("mod-gui")

-----------------------------------------------------------
--- Handle events
-----------------------------------------------------------
function satellitegui.on_init()
    satellitegui.update_players()
end

function satellitegui.on_player_joined_game(event)
    local player = game.players[event.player_index]
    if not (player and player.valid) then return end
    satellitegui.create_gui(player)
end

function satellitegui.on_rocket_launched()
    satellitegui.update_players()
end

-----------------------------------------------------------
--- Main functionality
-----------------------------------------------------------
function satellitegui.create_gui(player)
    local satellites_launched = satellitegui.get_satellites_launched(player)
    local satellitegui_ui = mod_gui.get_frame_flow(player)
    local satellitegui_frame = satellitegui_ui.satellitegui_frame

    if satellites_launched == '0' then return end

    if satellitegui_frame then
        satellitegui_frame.destroy()
    end

    local satellitegui_frame = satellitegui_ui.add{type = "frame", name = "satellitegui_frame", direction = "horizontal", style = mod_gui.frame_style}
    satellitegui_frame.style.bottom_padding = 4
    satellitegui.update_gui(player)
end

function satellitegui.update_gui(player)
    if not (player and player.valid) then return end
    local satellites_launched = satellitegui.get_satellites_launched(player)
    local satellitegui_frame = mod_gui.get_frame_flow(player).satellitegui_frame

    if not satellitegui_frame then
        satellitegui.create_gui(player)
    else
        satellitegui_frame.clear()

        local sprite = satellitegui_frame.add{type = "sprite-button", sprite = "item/satellite", style = "transparent_slot"}
        sprite.style.height = 20
        sprite.style.width = 20
        satellitegui_frame.add{type = "label", caption = satellites_launched}
    end
end

function satellitegui.update_players()
    for _, player in pairs(game.connected_players) do
        satellitegui.update_gui(player)
    end
end

-----------------------------------------------------------
--- Utility
-----------------------------------------------------------
function satellitegui.get_satellites_launched(player)
    return satellitegui.format_number(player.force.get_item_launched("satellite"))
end

function satellitegui.format_number(number)
    local formatted = number
    while true do
        formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", '%1,%2')
        if (k == 0) then
            break
        end
    end
    return formatted
end

-----------------------------------------------------------
--- Main
-----------------------------------------------------------
return satellitegui
