

-- FIRST deal with items that have now been moved into this mod
minetest.register_alias_force("core:honey_bottle", "bls:honey_bottle")
minetest.register_alias_force("main:honey_bottle", "bls:honey_bottle")
minetest.register_alias_force("core:fake_stone", "bls:fake_stone")
minetest.register_alias_force("main:fake_stone", "bls:fake_stone")
minetest.register_alias_force("core:marble", "bls:marble")
minetest.register_alias_force("main:marble", "bls:marble")
minetest.register_alias_force("core:marble_block", "bls:marble_block")
minetest.register_alias_force("main:marble_block", "bls:marble_block")

minetest.register_alias_force("main:marble_mini_brick", "bls:marble_mini_brick")
minetest.register_alias_force("main:marble_base", "bls:marble_base")
minetest.register_alias_force("main:marble_column", "bls:marble_column")
minetest.register_alias_force("main:marble_pillar", "bls:marble_pillar")
minetest.register_alias_force("main:marble_pillar_base", "bls:marble_pillar_base")

if minetest.global_exists("stairsplus") then
    stairsplus:register_alias_force_all("main", "marble", "bls", "marble")
    stairsplus:register_alias_force_all("main", "marble_block", "bls", "marble_block")
    stairsplus:register_alias_force_all("main", "marble_mini_brick", "bls", "marble_mini_brick")
    stairsplus:register_alias_force_all("main", "marble_base", "bls", "marble_base")
    stairsplus:register_alias_force_all("main", "marble_column", "bls", "marble_column")
    stairsplus:register_alias_force_all("main", "marble_pillar", "bls", "marble_pillar")
    stairsplus:register_alias_force_all("main", "marble_pillar_base", "bls", "marble_pillar_base")
end

minetest.register_alias_force("bls_overrides:door_steel_protected", "bls:door_steel_protected")
minetest.register_alias_force("bls_overrides:door_steel_protected_a", "bls:door_steel_protected_a")
minetest.register_alias_force("bls_overrides:door_steel_protected_b", "bls:door_steel_protected_b")

minetest.register_alias_force("bls_admin_flair:shield_bls", "bls:shield_bls")
minetest.register_alias_force("bls_admin_flair:shield_staff", "bls:shield_staff")

-------------------------------------------------------------------------------
-- PLEASE KEEP MOD SECTIONS IN ALPHABETICAL ORDER
-- ORGANIZE LOGIC BY THE SOURCE ITEM

if minetest.get_modpath("basic_materials") then
    if minetest.global_exists("stairsplus") then
        stairsplus:register_alias_force_all("technic", "concrete", "basic_materials", "concrete_block")
        stairsplus:register_alias_force_all("gloopblocks", "cement", "basic_materials", "cement_block")
        stairsplus:register_alias_force_all("technic", "brass_block", "basic_materials", "brass_block")
    end
end

if minetest.get_modpath("bbq") then
    if minetest.get_modpath("extra") then
        minetest.clear_craft({output = "bbq:tomato_sauce"})
        minetest.register_alias_force("extra:marinara", "bbq:tomato_sauce")
    end
    if minetest.get_modpath("farming") and farming.mod == "redo" then
        minetest.clear_craft({output="bbq:sugar"})
        minetest.register_alias_force("farming:sugar", "bbq:sugar")
    end
    if minetest.get_modpath("cucina_vegana") then
        minetest.register_alias_force("cucina_vegana:molasses", "bbq:molasses")
    end
end

if minetest.get_modpath("cucina_vegana") then
    minetest.register_alias_force("cucina_vegana:flax_raw", "cucina_vegana:flax")
    if minetest.get_modpath("farming") then
        minetest.register_alias_force("farming:bowl", "cucina_vegana:bowl")

        minetest.register_alias_force("farming:rice", "cucina_vegana:rice")
        minetest.register_alias_force("farming:seed_rice", "cucina_vegana:rice_seed")
        minetest.register_alias_force("cucina_vegana:rice_flour", "farming:rice_flour")
        minetest.register_alias_force("farming:rice_1", "cucina_vegana:rice_1")
        minetest.register_alias_force("farming:rice_2", "cucina_vegana:rice_2")
        minetest.register_alias_force("farming:rice_3", "cucina_vegana:rice_3")
        minetest.register_alias_force("farming:rice_4", "cucina_vegana:rice_4")
        minetest.register_alias_force("farming:rice_5", "cucina_vegana:rice_5")
        minetest.register_alias_force("farming:rice_6", "cucina_vegana:rice_6")
        minetest.register_alias_force("farming:rice_7", "cucina_vegana:rice_6")
        minetest.register_alias_force("farming:rice_8", "cucina_vegana:rice_6")
    end
end

if minetest.get_modpath("farming") then
    minetest.register_alias_force("default:blueberries", "farming:blueberries")
end

if minetest.get_modpath("gravelsieve") then
    -- sieved gravel is annoying. just have sand.
    minetest.register_alias_force("gravelsieve:sieved_gravel", "default:sand")
end

if minetest.get_modpath("homedecor_doors_and_gates") and minetest.get_modpath("doors") then
    -- fix renamed homedecor doors
    minetest.register_alias_force("doors:wood_plain", "doors:homedecor_wood_plain")
    minetest.register_alias_force("homedecor:door_wood_plain_left", "doors:homedecor_wood_plain")
    minetest.register_alias_force("doors:bedroom", "doors:homedecor_basic_panel")
    minetest.register_alias_force("homedecor:door_bedroom_left", "doors:homedecor_basic_panel")
    minetest.register_alias_force("doors:wood_glass_mahogany", "doors:homedecor_french_mahogany")
    minetest.register_alias_force("homedecor:door_wood_glass_mahogany_left", "doors:homedecor_french_mahogany")
    minetest.register_alias_force("doors:wood_glass_oak", "doors:homedecor_french_oak")
    minetest.register_alias_force("homedecor:door_wood_glass_oak_left", "doors:homedecor_french_oak")
    minetest.register_alias_force("doors:wood_glass_white", "doors:homedecor_french_white")
    minetest.register_alias_force("homedecor:door_wood_glass_white_left", "doors:homedecor_french_white")
    minetest.register_alias_force("doors:closet_mahogany", "doors:homedecor_closet_mahogany")
    minetest.register_alias_force("homedecor:door_closet_mahogany_left", "doors:homedecor_closet_mahogany")
    minetest.register_alias_force("doors:closet_oak", "doors:homedecor_closet_oak")
    minetest.register_alias_force("homedecor:door_closet_oak_left", "doors:homedecor_closet_oak")
    minetest.register_alias_force("doors:woodglass2", "doors:homedecor_carolina")
    minetest.register_alias_force("homedecor:door_woodglass2_left", "doors:homedecor_carolina")
    minetest.register_alias_force("doors:woodglass", "doors:homedecor_woodglass")
    minetest.register_alias_force("homedecor:door_woodglass_left", "doors:homedecor_woodglass")
    minetest.register_alias_force("doors:exterior_fancy", "doors:homedecor_exterior_fancy")
    minetest.register_alias_force("homedecor:door_exterior_fancy_left", "doors:homedecor_exterior_fancy")
    minetest.register_alias_force("doors:wrought_iron", "doors:homedecor_wrought_iron")
    minetest.register_alias_force("homedecor:door_wrought_iron_left", "doors:homedecor_wrought_iron")
end

if minetest.get_modpath("homedecor_lighting") then
    -- fix renamed nodes
    minetest.register_alias_force("homedecor:plasma_ball_14", "homedecor:plasma_ball_on")
    minetest.register_alias_force("homedecor:wall_lamp_14", "homedecor:wall_lamp_on")
end

if minetest.get_modpath("terumet") then
    -- hot thermese was removed; revert to regular thermese
    minetest.register_alias_force("terumet:block_thermese_hot", "terumet:block_thermese")

    if minetest.get_modpath("bonemeal") then
        minetest.clear_craft({output="bonemeal:mulch"})
        minetest.register_alias_force("bonemeal:mulch", "bbq:sawdust")
    end
    if minetest.get_modpath("bbq") then
        minetest.clear_craft({output="bbq:sawdust"})
        minetest.register_alias_force("terumet:item_dust_wood", "bbq:sawdust")
    end
end

if minetest.get_modpath("titanium") then
    -- remove suprious leftover light nodes from titanium
    minetest.register_alias_force("titanium:light", "air")
end

if minetest.get_modpath("trunks") then
    minetest.register_alias_force("trunks:twig_1", "default:stick")
end

if not minetest.get_modpath("walking_light") then
    minetest.register_alias_force("walking_light:light", "air")
end

if minetest.get_modpath("xdecor") and minetest.get_modpath("farming")then
    -- we only want one bowl
    minetest.register_alias_force("xdecor:bowl", "cucina_vegana:bowl")
end
