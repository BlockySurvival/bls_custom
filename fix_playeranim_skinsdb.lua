if minetest.global_exists("player_api") and minetest.get_modpath("playeranim") then
    local m = player_api.registered_models["skinsdb_3d_armor_character_5.b3d"]
    if m and m.animations then
        for _, v in pairs(m.animations) do
            v.x = 0
            v.y = 0
        end
    end
end
