if not minetest.get_modpath("tubelib_addons1") then return end

local gn = tubelib_addons1.register_ground_node

gn("bls:marble")

-- This one line breaks the cobblegen > autosieve pathway completely
gn("default:stone","default:stone")

if minetest.get_modpath("building_blocks") then
    gn("building_blocks:Marble")
end

if minetest.get_modpath("default") then
    gn("default:silver_sandstone")
end

if minetest.get_modpath("moreores") then
    gn("moreores:mineral_mithril", "moreores:mithril_lump")
    gn("moreores:mineral_silver", "moreores:silver_lump")
end

if minetest.get_modpath("other_worlds") then
    gn("asteroid:cobble")
    gn("asteroid:copperore", "default:copper_lump")
    gn("asteroid:diamondore", "default:diamond")
    gn("asteroid:dust")
    gn("asteroid:goldore", "default:gold_lump")
    gn("asteroid:gravel")
    gn("asteroid:ironore", "default:iron_lump")
    gn("asteroid:meseore", "default:mese_crystal")
    gn("asteroid:redcobble")
    gn("asteroid:reddust")
    gn("asteroid:redgravel")
    gn("asteroid:redstone")
end

if minetest.get_modpath("quartz") then
    gn("quartz:quartz_ore", "quartz:quartz_crystal")
end

if minetest.get_modpath("technic_worldgen") then
    gn("technic:marble")
    gn("technic:granite")

    gn("technic:mineral_chromium", "technic:chromium_lump")
    gn("technic:mineral_lead", "technic:lead_lump")
    gn("technic:mineral_sulfur", "technic:sulfur_lump")
    gn("technic:mineral_uranium", "technic:uranium_lump")
    gn("technic:mineral_zinc", "technic:zinc_lump")
end

if minetest.get_modpath("terumet") then
    gn("terumet:ore_dense_raw", "terumet:lump_raw 5")
    gn("terumet:ore_raw", "terumet:lump_raw")
    gn("terumet:ore_raw_desert", "terumet:lump_raw 2")
    gn("terumet:ore_raw_desert_dense", "terumet:lump_raw 10")

    local sandcrete_blocks = {
        "terumet:block_con_black",
        "terumet:block_con_blue",
        "terumet:block_con_brown",
        "terumet:block_con_cyan",
        "terumet:block_con_dark_green",
        "terumet:block_con_dark_grey",
        "terumet:block_con_green",
        "terumet:block_con_grey",
        "terumet:block_con_magenta",
        "terumet:block_con_orange",
        "terumet:block_con_pink",
        "terumet:block_con_red",
        "terumet:block_con_violet",
        "terumet:block_con_white",
        "terumet:block_con_yellow",
    }
    for _, sandcrete in ipairs(sandcrete_blocks) do
        gn(sandcrete)
    end
end

if minetest.get_modpath("titanium") then
    gn("titanium:titanium_in_ground", "titanium:titanium")
end