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

if minetest.get_modpath("dye") then
    --gr({input="group:coal", output="dye:black 8"})
    gr({input="default:coal_lump", output="dye:black 8"})
    gr({input="terumet:item_coke", output="dye:black 8"})
    --gr({input="group:horsetail", output="dye:green 2"})
    gr({input="ferns:horsetail_01", output="dye:green 2"})
    gr({input="ferns:horsetail_02", output="dye:green 2"})
    gr({input="ferns:horsetail_03", output="dye:green 2"})
    gr({input="ferns:horsetail_04", output="dye:green 2"})

    gr({input="default:dry_shrub", output="dye:brown 8"})
    gr({input="default:cactus", output="dye:green 8"})
    gr({input="default:coral_brown", output="dye:violet 2"})
    gr({input="default:coral_cyan", output="dye:cyan 2"})
    gr({input="default:coral_green", output="dye:green 2"})
    gr({input="default:coral_orange", output="dye:orange 2"})
    gr({input="default:coral_pink", output="dye:pink 2"})

    if minetest.get_modpath("bakedclay") then
        gr({input="bakedclay:delphinium", output="dye:cyan 8"})
        gr({input="bakedclay:mannagrass", output="dye:dark_green 8"})
        gr({input="bakedclay:thistle", output="dye:magenta 8"})
        gr({input="bakedclay:lazarus", output="dye:pink 8"})
    end

    if minetest.get_modpath("farming") then
        gr({input="farming:cocoa_beans", output="dye:brown 4"})
        gr({input="farming:beans", output="dye:green 2"})
        gr({input="farming:chili_pepper", output="dye:red 2"})
        gr({input="farming:beetroot", output="dye:red 2"})
        --gr({input="group:food_blueberries", output="dye:violet 4"})
        gr({input="farming:blueberries", output="dye:violet 4"})
        gr({input="farming:grapes", output="dye:violet 2"})
        gr({input="farming:carrot", output="dye:orange 2"})
        gr({input="farming:onion", output="dye:yellow 2"})
        gr({input="farming:raspberries", output="dye:red 2"})
        gr({input="farming:rhubarb", output="dye:yellow 2"})
    end

    if minetest.get_modpath("flowers") then
        gr({input="flowers:tulip_black", output="dye:black 8"})
        gr({input="flowers:geranium", output="dye:blue 8"})
        gr({input="flowers:chrysanthemum_green", output="dye:green 8"})
        gr({input="flowers:tulip", output="dye:orange 8"})
        gr({input="flowers:rose", output="dye:red 8"})
        gr({input="flowers:viola", output="dye:violet 8"})
        gr({input="flowers:dandelion_white", output="dye:white 8"})
        gr({input="flowers:dandelion_yellow", output="dye:yellow 8"})
    end
    if minetest.get_modpath("moreplants") then
        gr({input="moreplants:aliengrass", output="dye:orange 4"})
        gr({input="moreplants:bigflower", output="dye:red 8"})
        gr({input="moreplants:blueflower", output="dye:blue 8"})
        gr({input="moreplants:bluespike", output="dye:blue 8"})
        gr({input="moreplants:caveflower", output="dye:magenta 8"})
        gr({input="moreplants:jungleflower", output="dye:red 8"})
        gr({input="moreplants:medflower", output="dye:magenta 8"})
        gr({input="moreplants:moonflower", output="dye:cyan 8"})
    end
    if minetest.get_modpath("redtrees") then
        gr({input="redtrees:rleaves", output="dye:red 4"})
    end
    if minetest.get_modpath("sakuragi") then
        gr({input="sakuragi:sleaves", output="dye:pink 4"})
    end
end

if minetest.get_modpath("ebony") then
    gr({input="ebony:trunk", output="ebony:leaves 8"})
end

if minetest.get_modpath("farming") then
    gr({input="farming:seed_wheat", output="farming:flour"})
    gr({input="farming:seed_barley", output="farming:flour_multigrain"})
    gr({input="farming:seed_oat", output="farming:flour_multigrain"})
    gr({input="farming:seed_rye", output="farming:flour_multigrain"})
    --gr({input="group:food_rice_raw", output="farming:rice_flour"})
    gr({input="cucina_vegana:rice", output="farming:rice_flour"})
end

if minetest.get_modpath("jacaranda") then
    gr({input="jacaranda:trunk", output="jacaranda:blossom_leaves 8"})
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
if minetest.get_modpath("redtrees") then
    gr({input="redtrees:rtree", output="redtrees:rleaves 8"})
end
if minetest.get_modpath("sakuragi") then
    gr({input="sakuragi:stree", output="sakuragi:sleaves 8"})
end
