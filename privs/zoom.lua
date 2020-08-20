if not minetest.get_modpath("binoculars") and binoculars then return end

minetest.register_privilege("zoom", "Allows player to use zoom (binoculars) w/out the item")

-- Load support for MT game translation.
local S = minetest.get_translator("binoculars")


-- Detect creative mod
local creative_mod = minetest.get_modpath("creative")
-- Cache creative mode setting as fallback if creative mod not present
local creative_mode_cache = minetest.settings:get_bool("creative_mode")

local old_binoculars_update_player_property = binoculars.update_player_property

local function has_zoom_priv(player)
    local player_name = player:get_player_name()
    local privs = minetest.get_player_privs(player_name)

    return (
            (creative_mod and creative.is_enabled_for(player_name)) or
            creative_mode_cache or
            privs.zoom
    )
end

function binoculars.update_player_property(player)
        local new_zoom_fov = 0

        if player:get_inventory():contains_item("main", "binoculars:binoculars") then
                new_zoom_fov = 10
        elseif has_zoom_priv(player) then
                new_zoom_fov = 15
        end

        -- Only set property if necessary to avoid player mesh reload
        if player:get_properties().zoom_fov ~= new_zoom_fov then
                player:set_properties({zoom_fov = new_zoom_fov})
        end
end
