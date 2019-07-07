-- PLEASE KEEP MOD SECTIONS IN ALPHABETICAL ORDER
-- ORGANIZE LOGIC BY THE SOURCE ITEM

local get_modpath = minetest.get_modpath
local register_alias_force = minetest.register_alias_force

-- deal with items that have now been moved into this mod
register_alias_force("core:honey_bottle", "bls:honey_bottle")
register_alias_force("main:honey_bottle", "bls:honey_bottle")
register_alias_force("core:fake_stone", "bls:fake_stone")
register_alias_force("main:fake_stone", "bls:fake_stone")
register_alias_force("core:marble", "bls:marble")
register_alias_force("main:marble", "bls:marble")
register_alias_force("core:marble_block", "bls:marble_block")
register_alias_force("main:marble_block", "bls:marble_block")

register_alias_force("main:marble_mini_brick", "bls:marble_mini_brick")
register_alias_force("main:marble_base", "bls:marble_base")
register_alias_force("main:marble_column", "bls:marble_column")
register_alias_force("main:marble_pillar", "bls:marble_pillar")
register_alias_force("main:marble_pillar_base", "bls:marble_pillar_base")

register_alias_force("bls_admin_flair:shield_bls", "bls:shield_bls")
register_alias_force("bls_admin_flair:shield_staff", "bls:shield_staff")

if get_modpath('farming') then
    register_alias_force('default:blueberries', 'farming:blueberries')
end

if get_modpath("gravelsieve") then
    -- sieved gravel is annoying. just have sand.
    register_alias_force("gravelsieve:sieved_gravel", "default:sand")
end

if get_modpath('homedecor_doors_and_gates') and get_modpath('doors') then
    -- fix renamed homedecor doors
    register_alias_force('doors:wood_plain', 'doors:homedecor_wood_plain')
    register_alias_force('homedecor:door_wood_plain_left', 'doors:homedecor_wood_plain')
    register_alias_force('doors:bedroom', 'doors:homedecor_basic_panel')
    register_alias_force('homedecor:door_bedroom_left', 'doors:homedecor_basic_panel')
    register_alias_force('doors:wood_glass_mahogany', 'doors:homedecor_french_mahogany')
    register_alias_force('homedecor:door_wood_glass_mahogany_left', 'doors:homedecor_french_mahogany')
    register_alias_force('doors:wood_glass_oak', 'doors:homedecor_french_oak')
    register_alias_force('homedecor:door_wood_glass_oak_left', 'doors:homedecor_french_oak')
    register_alias_force('doors:wood_glass_white', 'doors:homedecor_french_white')
    register_alias_force('homedecor:door_wood_glass_white_left', 'doors:homedecor_french_white')
    register_alias_force('doors:closet_mahogany', 'doors:homedecor_closet_mahogany')
    register_alias_force('homedecor:door_closet_mahogany_left', 'doors:homedecor_closet_mahogany')
    register_alias_force('doors:closet_oak', 'doors:homedecor_closet_oak')
    register_alias_force('homedecor:door_closet_oak_left', 'doors:homedecor_closet_oak')
    register_alias_force('doors:woodglass2', 'doors:homedecor_carolina')
    register_alias_force('homedecor:door_woodglass2_left', 'doors:homedecor_carolina')
    register_alias_force('doors:woodglass', 'doors:homedecor_woodglass')
    register_alias_force('homedecor:door_woodglass_left', 'doors:homedecor_woodglass')
    register_alias_force('doors:exterior_fancy', 'doors:homedecor_exterior_fancy')
    register_alias_force('homedecor:door_exterior_fancy_left', 'doors:homedecor_exterior_fancy')
    register_alias_force('doors:wrought_iron', 'doors:homedecor_wrought_iron')
    register_alias_force('homedecor:door_wrought_iron_left', 'doors:homedecor_wrought_iron')
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
end

