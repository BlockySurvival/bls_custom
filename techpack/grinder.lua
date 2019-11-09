if not minetest.get_modpath("tubelib_addons1") then return end
local gr = tubelib.add_grinder_recipe

if minetest.get_modpath("bonemeal") then
    gr({input="bonemeal:bone", output="bonemeal:bonemeal 4"})
    gr({input="default:coral_skeleton", output="bonemeal:bonemeal 4"})
end

if minetest.get_modpath("bamboo") then
    gr({input="bamboo:trunk", output="bamboo:leaves 8"})
end
if minetest.get_modpath("birch") then
    gr({input="birch:trunk", output="birch:leaves 8"})
end
if minetest.get_modpath("cherrytree") then
    gr({input="cherrytree:trunk", output="cherrytree:leaves 8"})
end
if minetest.get_modpath("chestnuttree") then
    gr({input="chestnuttree:trunk", output="chestnuttree:leaves 8"})
end
if minetest.get_modpath("clementinetree") then
    gr({input="clementinetree:trunk", output="clementinetree:leaves 8"})
end
if minetest.get_modpath("ebony") then
    gr({input="ebony:trunk", output="ebony:leaves 8"})
end
if minetest.get_modpath("jacaranda") then
    gr({input="jacaranda:trunk", output="jacaranda:leaves 8"})
end
if minetest.get_modpath("larch") then
    gr({input="larch:trunk", output="larch:leaves 8"})
end
if minetest.get_modpath("lemontree") then
    gr({input="lemontree:trunk", output="lemontree:leaves 8"})
end
if minetest.get_modpath("mahogany") then
    gr({input="mahogany:trunk", output="mahogany:leaves 8"})
end
if minetest.get_modpath("palm") then
    gr({input="palm:trunk", output="palm:leaves 8"})
end
