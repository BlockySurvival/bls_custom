--[[
if a player dies, and disconnects before reviving, they will
still be dead on next login, w/ no ability to revive.

]]--
local spawn_pos = minetest.string_to_pos(minetest.settings:get("static_spawnpoint") or "(0, 0, 0)")

minetest.register_on_joinplayer(function(player)
    if player:get_hp() == 0 then
        player:set_hp(20, "respawn")
        player:set_pos(spawn_pos)
    end

    local pos = player:get_pos()
    if (
            -30912 > pos.x or pos.x > 30927 or
            -30912 > pos.y or pos.y > 30927 or
            -30912 > pos.z or pos.z > 30927
    ) then
        bls.log("action", "%s was outside the map (%s) when they joined, moving them to spawn", player:get_player_name(), minetest.pos_to_string(pos))
        player:set_pos(spawn_pos)
    end
end)
