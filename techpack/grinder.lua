if not minetest.get_modpath("tubelib_addons1") then return end

if minetest.get_modpath("bonemeal") then
    tubelib.add_grinder_recipe({input="bonemeal:bone", output="bonemeal:bonemeal 4"})
    tubelib.add_grinder_recipe({input="default:coral_skeleton", output="bonemeal:bonemeal 4"})
end
