-- PLEASE KEEP MOD SECTIONS IN ALPHABETICAL ORDER
-- ORGANIZE LOGIC BY THE SOURCE ITEM

local get_modpath = minetest.get_modpath
local register_alias_force = minetest.register_alias_force

if get_modpath("gravelsieve") then
    -- sieved gravel is annoying. just have sand.
    register_alias_force("gravelsieve:sieved_gravel", "default:sand")
end

if get_modpath("homedecor_lighting") then
    -- fix renamed nodes
    register_alias_force("homedecor:plasma_ball_14", "homedecor:plasma_ball_on")
    register_alias_force("homedecor:wall_lamp_14", "homedecor:wall_lamp_on")
end

if get_modpath('terumet') then
    -- hot thermese was removed; revert to regular thermese
    register_alias_force("terumet:block_thermese_hot", "terumet:block_thermese")
end

if get_modpath("titanium") then
    -- remove suprious leftover light nodes from titanium
    register_alias_force("titanium:light", "air")
end


if not get_modpath('walking_light') then
    register_alias_force("walking_light:light", "air")
end

if get_modpath('xdecor') then
    -- we only want one bowl
    if get_modpath('farming') then
        register_alias_force("xdecor:bowl", "farming:bowl")
    end
    -- TODO: why is this?
--    if get_modpath('moreblocks') then
--        register_alias_force("xdecor:stone_tile", "moreblocks:stone_tile")
--    end
end

