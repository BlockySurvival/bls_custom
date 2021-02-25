if not minetest.get_modpath("gravelsieve") or not gravelsieve.api then
    return
end

local gs_api = gravelsieve.api

gs_api.remove_input("default:gravel")

gs_api.register_input("default:gravel", 1 - (1 / 40), {
    ["default:silver_sand"] = 1,
    ["default:sand"] = 1 / 2,
    ["default:desert_sand"] = 1 / 4,
    ["default:gravel"] = 1 / 8,
})

gs_api.register_input("gravelsieve:compressed_gravel", 1 - (1 / 10), {
    ["default:gravel"] = 1,
    ["default:gravel 2"] = 1/2,
    ["default:gravel 3"] = 1/4,
    ["default:gravel 4"] = 1/8,
    ["default:gravel 5"] = 1/16,
    ["default:gravel 6"] = 1/32,
})

gs_api.register_output("default:gravel", "default:flint", 1 / 4)
gs_api.register_output("default:gravel", "default:clay_lump", 1 / 5)
gs_api.register_output("default:gravel", "default:mese_crystal_fragment", 1 / 15)
gs_api.register_output("default:gravel", "default:obsidian_shard", 1 / 15)
gs_api.register_output("default:gravel", "default:coal_lump", 1 / 10)
gs_api.register_output("default:gravel", "default:iron_lump", 1 / 12)
gs_api.register_output("default:gravel", "default:copper_lump", 1 / 25)
gs_api.register_output("default:gravel", "default:tin_lump", 1 / 50)

gs_api.register_output("gravelsieve:compressed_gravel", "default:flint", 1 / 5)
gs_api.register_output("gravelsieve:compressed_gravel", "default:mese_crystal_fragment", 1 / 5)
gs_api.register_output("gravelsieve:compressed_gravel", "default:coal_lump", 1 / 3)
gs_api.register_output("gravelsieve:compressed_gravel", "default:iron_lump", 1 / 3)
gs_api.register_output("gravelsieve:compressed_gravel", "default:copper_lump", 1 / 4)
gs_api.register_output("gravelsieve:compressed_gravel", "default:tin_lump", 1 / 5)
gs_api.register_output("gravelsieve:compressed_gravel", "default:gold_lump", 1 / 10)
gs_api.register_output("gravelsieve:compressed_gravel", "default:mese_crystal", 1 / 50)
gs_api.register_output("gravelsieve:compressed_gravel", "default:diamond", 1 / 500)

if minetest.get_modpath("cavestuff") then
    gs_api.register_output("default:gravel", "cavestuff:pebble_1", 1 / 4)
    gs_api.register_output("default:gravel", "cavestuff:desert_pebble_1", 1 / 4)
end

if minetest.get_modpath("moreores") then
    gs_api.register_output("default:gravel", "moreores:silver_lump", 1 / 1000)

    gs_api.register_output("gravelsieve:compressed_gravel", "moreores:silver_lump", 1 / 20)
    gs_api.register_output("gravelsieve:compressed_gravel", "moreores:mithril_lump", 1 / 400)
end

if minetest.get_modpath("quartz") then
    gs_api.register_output("default:gravel", "quartz:quartz_crystal", 1 / 30)
    gs_api.register_output("default:gravel", "quartz:quartz_crystal_piece", 1 / 4)

    gs_api.register_output("gravelsieve:compressed_gravel", "quartz:quartz_crystal", 1 / 4)
end

if minetest.get_modpath("technic") then
    gs_api.register_output("default:gravel", "technic:lead_lump", 1 / 30)
    gs_api.register_output("default:gravel", "technic:zinc_lump", 1 / 40)
    gs_api.register_output("default:gravel", "technic:chromium_lump", 1 / 200)
    gs_api.register_output("default:gravel", "technic:sulfur_lump", 1 / 100)


    gs_api.register_output("gravelsieve:compressed_gravel", "technic:lead_lump", 1 / 4)
    gs_api.register_output("gravelsieve:compressed_gravel", "technic:zinc_lump", 1 / 5)
    gs_api.register_output("gravelsieve:compressed_gravel", "technic:chromium_lump", 1 / 20)
    gs_api.register_output("gravelsieve:compressed_gravel", "technic:uranium_lump", 1 / 50)
    gs_api.register_output("gravelsieve:compressed_gravel", "technic:sulfur_lump", 1 / 2)
end

if minetest.get_modpath("terumet") then
    gs_api.register_output("default:gravel", "terumet:lump_raw", 1 / 30)

    gs_api.register_output("gravelsieve:compressed_gravel", "terumet:lump_raw 4", 1 / 20)
end

if minetest.get_modpath("titanium") then
    gs_api.register_output("gravelsieve:compressed_gravel", "titanium:titanium", 1 / 5000)
end
