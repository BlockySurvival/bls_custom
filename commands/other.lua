local mod_storage = bls.mod_storage

minetest.register_chatcommand("sunlight", {
    -- Give players with "settime" priv the ability to override their day-night ratio
    params = "<ratio>",
    description = "Override one\"s day night ratio. (1 = always day, 0 = always night)",
    privs = {settime = true},
    func = function(player_name, param)
        local ratio = tonumber(param)
        if not ratio or ratio < 0 or ratio > 1 then
            return false, "Please enter a number between 0 and 1"
        end
        minetest.get_player_by_name(player_name):override_day_night_ratio(ratio)
        mod_storage:set_string(player_name .. "_sunlight", tostring(ratio))
    end
})

minetest.register_on_joinplayer(function(player)
    local player_name = player:get_player_name()
    if not minetest.check_player_privs(player_name, {settime=true}) then return end
    local ratio = mod_storage:get_string(player_name .. "_sunlight")
    if ratio == "" then
        return
    else
        player:override_day_night_ratio(tonumber(ratio))
    end
end)


minetest.register_chatcommand("whatisthis", {
	params = "",
	description = "Get itemstring of wielded item",
	func = function(player_name, param)
		local player = minetest.get_player_by_name(player_name)
		minetest.chat_send_player(player_name, player:get_wielded_item():to_string())
		return
	end
})

minetest.register_chatcommand("memory", {
    description = "Get server\"s Lua memory usage",
    privs = {server = true},
    func = function(name, param)
		minetest.chat_send_player(
            name,
            ("Lua is using %uMB"):format(collectgarbage("count") / 1024)
        )
    end
})

