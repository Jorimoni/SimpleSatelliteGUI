local satellitegui = require("satellitegui")

script.on_event(defines.events.on_player_joined_game, satellitegui.on_player_joined_game)
script.on_event(defines.events.on_rocket_launched, satellitegui.on_rocket_launched)
script.on_init(satellitegui.on_init)
