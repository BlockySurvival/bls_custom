local mod_storage = bls.mod_storage

local registered_listeners = {}

minetest.register_on_mods_loaded(function()
    registered_listeners = minetest.deserialize(mod_storage:get_string("snoop_cheats") or "return {}") or {}
end)

local function persist_registered_listeners()
    mod_storage:set_string("snoop_cheats", minetest.serialize(registered_listeners))
end

minetest.register_chatcommand("snoop_cheats", {
    params = "",
    description = "toggles cheat snooping",
    privs = {server=true},
    func = function(name, param)
        if registered_listeners[name] then
            registered_listeners[name] = nil
            persist_registered_listeners()
            return true, "Turned off cheat snooping."
        else
            registered_listeners[name] = true
            persist_registered_listeners()
            return true, "Turned on cheat snooping."
        end
    end,
})

minetest.register_on_cheat(function(player, cheat_info)
    local player_name = player:get_player_name()
    for listener_name, _ in pairs(registered_listeners) do
        local listener = minetest.get_player_by_name(listener_name)
        if not listener then
            return
        end
        minetest.chat_send_player(listener_name, ("%s %s"):format(player_name, cheat_info.type))
    end
end)
