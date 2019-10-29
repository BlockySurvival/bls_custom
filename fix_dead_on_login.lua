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
end)
