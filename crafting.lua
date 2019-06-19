-- PLEASE KEEP MOD SECTIONS IN ALPHABETICAL ORDER
-- ORGANIZE LOGIC BY THE TARGET ITEM

local get_modpath = minetest.get_modpath
local clear_craft = minetest.clear_craft
local register_craft = minetest.register_craft

if get_modpath('cblocks') then
    -- make colored blocks cheaper
    local colours = {
        black='dye:black',
        blue='dye:blue',
        brown='dye:brown',
        cyan='dye:cyan',
        dark_green='dye:dark_green',
        dark_grey='dye:dark_grey',
        green='dye:green',
        grey='dye:grey',
        magenta='dye:magenta',
        orange='dye:orange',
        pink='dye:pink',
        red='dye:red',
        violet='dye:violet',
        white='dye:white',
        yellow='dye:yellow'
    }
    for color, dye in pairs(colours) do
        clear_craft({output=("cblocks:wood_%s"):format(color)})
        register_craft({
            output = ("cblocks:wood_%s 8"):format(color),
            recipe = {
                {"group:wood", "group:wood", "group:wood"},
                {"group:wood", dye,          "group:wood"},
                {"group:wood", "group:wood", "group:wood"},
            }
        })
        clear_craft({output=("cblocks:stonebrick_%s"):format(color)})
        register_craft({
            output = ("cblocks:stonebrick_%s 8"):format(color),
            recipe = {
                {"default:stonebrick", "default:stonebrick", "default:stonebrick"},
                {"default:stonebrick", dye,                  "default:stonebrick"},
                {"default:stonebrick", "default:stonebrick", "default:stonebrick"},
            }
        })
        clear_craft({output=("cblocks:glass_%s"):format(color)})
        register_craft({
            output = ("cblocks:glass_%s 8"):format(color),
            recipe = {
                {"default:glass", "default:glass", "default:glass"},
                {"default:glass", dye,             "default:glass"},
                {"default:glass", "default:glass", "default:glass"},
            }
        })
    end
end

if get_modpath("cottages") and get_modpath("xdecor") then
    -- recipe conflict with xdecor wood framed glass
    clear_craft({output="cottages:glass_pane"})
    register_craft({
        output = "cottages:glass_pane 4",
        recipe = {{'default:glass'}}
    })
end

if get_modpath('default') then
    -- add some recipes for kinds of dirt
    register_craft({
        output = "default:dirt_with_snow",
        type = "shapeless",
        recipe = {"default:dirt", "default:snow"}
    })
    register_craft({
        output = "default:dirt_with_rainforest_litter",
        type = "shapeless",
        recipe = {"default:dirt", "default:jungleleaves"}
    })
    register_craft({
        output = "default:dirt_with_dry_grass",
        type = "shapeless",
        recipe = {"default:dirt", "default:dry_grass_1"}
    })
    register_craft({
        output = "default:dirt_with_coniferous_litter",
        type = "shapeless",
        recipe = {"default:dirt", "default:pine_needles"}
    })
    register_craft({
        output = "default:permafrost",
        type = "shapeless",
        recipe = {"default:dirt", "default:ice"}
    })
    register_craft({
        output = "default:permafrost_with_moss",
        type = "shapeless",
        recipe = {"default:permafrost", "default:junglegrass"}
    })
    register_craft({
        output = "default:permafrost_with_stones",
        type = "shapeless",
        recipe = {"default:permafrost", "default:gravel"}
    })
end

if get_modpath("extra") then
    if get_modpath("terumet") then
        if get_modpath('farming') then
            -- add a recipe for the blooming onion that doesn't require techpack
            terumet.register_alloy_recipe({
                result="extra:blooming_onion",
                input={"farming:onion", "extra:cottonseed_oil"},
                flux=0,
                time=10,
            })
        end

        if get_modpath('mobs_fish') then
            terumet.register_alloy_recipe({
                result="extra:fish_sticks",
                input={"mobs_fish:clownfish", "extra:cottonseed_oil"},
                flux=0,
                time=10,
            })
            terumet.register_alloy_recipe({
                result="extra:fish_sticks",
                input={"mobs_fish:tropical", "extra:cottonseed_oil"},
                flux=0,
                time=10,
            })
        end
    end
end

if get_modpath("gravelsieve") then
    -- make gravelsieve expensive
    clear_craft({output="gravelsieve:sieve"})
    register_craft({
        output = "gravelsieve:sieve",
        recipe = {
            {"group:wood", "",                      "group:wood"},
            {"group:wood", "default:diamondblock",  "group:wood"},
            {"group:wood", "",                      "group:wood"},
        },
    })
    -- make autosieve even more expensive
    clear_craft({output="gravelsieve:auto_sieve"})
    register_craft({
        output = "gravelsieve:auto_sieve",
        recipe = {
            {"default:diamondblock", "default:diamondblock", "default:diamondblock"},
            {"default:mese",         "gravelsieve:sieve",    "default:mese"},
            {"default:diamondblock", "default:mese",         "default:diamondblock"},
        },
    })

    -- make comopressed gravel behave like other compressed nodes
    clear_craft({output="gravelsieve:compressed_gravel"})
    clear_craft({recipe="gravelsieve:compressed_gravel", type="cooking"})
    register_craft({
        output = "gravelsieve:compressed_gravel",
        recipe = {
            {"default:gravel", "default:gravel", "default:gravel"},
            {"default:gravel", "default:gravel", "default:gravel"},
            {"default:gravel", "default:gravel", "default:gravel"},
        },
    })
    register_craft({
        output = "default:gravel 9",
        recipe = {
            {"gravelsieve:compressed_gravel"},
        },
    })
end

if get_modpath("itemframes") and get_modpath("wool") and get_modpath('xdecor') then
    -- avoid conflict with xdecor item frame
    clear_craft({output="itemframes:frame"})
    register_craft({
        output = "itemframes:frame",
        recipe = {
            {"default:stick", "default:stick", "default:stick"},
            {"default:stick", "group:wool",    "default:stick"},
            {"default:stick", "default:stick", "default:stick"},
        },
    })
end

if get_modpath("moreblocks") and get_modpath('xdecor') then
    -- avoid conflict with xdecor empty_shelf (craft into each other)
    clear_craft({output="moreblocks:empty_shelf"})
    register_craft({
        output = "moreblocks:empty_shelf",
        type = "shapeless",
        recipe = {"xdecor:empty_shelf"}
    })
    register_craft({
        output = "xdecor:empty_shelf",
        type = "shapeless",
        recipe = {"moreblocks:empty_shelf"}
    })
    -- avoid conflict with xdecor cactus brick
    clear_craft({recipe={"default:cactus", "default:brick"}, type="shapeless"})
    register_craft({
            output = "moreblocks:cactus_brick",
            recipe = {{"default:cactus", "default:brick"}}
    })
end

if get_modpath("terumet") and get_modpath("tubelib_addons1") then
    -- make tubelib upgrade recipe a little more sensical
    clear_craft({output="terumet:item_upg_tubelib"})
    register_craft({
        output = "terumet:item_upg_tubelib",
        recipe = {
            {"terumet:item_coil_tcop", "terumet:item_coil_tcop", "terumet:item_coil_tcop"},
            {"tubelib_addons1:chest",  "terumet:item_upg_base",  "tubelib_addons1:chest"},
            {"terumet:item_coil_tcop", "terumet:item_coil_tcop", "terumet:item_coil_tcop"},
        }
    })
end

if get_modpath('tnt') and get_modpath('bonemeal') then
    -- make tnt stuff more expensive
    clear_craft({output="tnt:gunpowder"})
    register_craft({
        output = "tnt:gunpowder",
        type = "shapeless",
        recipe = {"default:gravel", "default:coal_lump", "bonemeal:fertiliser"}
    })
end

if get_modpath("travelnet") and get_modpath("titanium") then
    -- make elevator expensive
    clear_craft({output="travelnet:elevator"})
    register_craft({
        output = "travelnet:elevator",
        recipe = {
            {"default:glass", "default:steelblock", "default:glass", },
            {"default:glass", "titanium:block",     "default:glass", },
            {"default:glass", "default:steelblock", "default:glass", }
        },
    })

    -- make travelnet even more expensive
    clear_craft({output="travelnet:travelnet"})
    if get_modpath('caverealms') then
        register_craft({
            output = "travelnet:travelnet",
            recipe = {
                {"caverealms:glow_mese", "titanium:block", "caverealms:glow_mese", },
                {"caverealms:glow_mese", "default:mese",   "caverealms:glow_mese", },
                {"caverealms:glow_mese", "titanium:block", "caverealms:glow_mese", }
            },
        })
    else
        register_craft({
            output = "travelnet:travelnet",
            recipe = {
                {"default:glass", "titanium:block", "default:glass", },
                {"default:mese",  "default:mese",   "default:mese", },
                {"default:glass", "titanium:block", "default:glass", }
            },
        })
    end
end

if get_modpath("tubelib") then
    -- don't require dark green wool to craft the pusher
    clear_craft({output="tubelib:pusher"})
    register_craft({
        output = "tubelib:pusher 2",
        recipe = {
            {"group:wood",    "group:wool",           "group:wood"},
            {"tubelib:tubeS", "default:mese_crystal", "tubelib:tubeS"},
            {"group:wood",    "group:wool",           "group:wood"},
        },
    })

    -- make the forceload block super expensive
    if get_modpath("titanium") and get_modpath("basic_materials") then
        clear_craft({output="tubelib:forceload"})
        register_craft({
            output = "tubelib:forceload",
            recipe = {
                {"group:wood",                            "",                       "group:wood"},
                {"basic_materials:energy_crystal_simple", "titanium:titanium_tv_1", "basic_materials:energy_crystal_simple"},
                {"group:wood",                            "tubelib:wlanchip",       "group:wood"},
            },
        })
    end
end

if get_modpath('wool') then
    -- make colored wool cheaper
    local colours = {
        black='dye:black',
        blue='dye:blue',
        brown='dye:brown',
        cyan='dye:cyan',
        dark_green='dye:dark_green',
        dark_grey='dye:dark_grey',
        green='dye:green',
        grey='dye:grey',
        magenta='dye:magenta',
        orange='dye:orange',
        pink='dye:pink',
        red='dye:red',
        violet='dye:violet',
        white='dye:white',
        yellow='dye:yellow'
    }
    for color, dye in pairs(colours) do
        clear_craft({output=("wool:%s"):format(color)})
        register_craft({
            output = ("wool:%s 8"):format(color),
            recipe = {
                {"group:wool", "group:wool", "group:wool"},
                {"group:wool", dye,          "group:wool"},
                {"group:wool", "group:wool", "group:wool"},
            }
        })
    end

    if get_modpath('farming') then
        register_craft({
            output = "wool:white",
            recipe = {
                {"farming:cotton", "farming:cotton"},
                {"farming:cotton", "farming:cotton"},
            }
        })
    end
end

if get_modpath("xdecor") then
    -- avoid conflict with mesecons pressure plate
    clear_craft({output="xdecor:pressure_stone_off"})
    register_craft({
        output = "xdecor:pressure_stone_off",
        recipe = {
            {"group:stone", "", "group:stone"},
            {"",            "", ""},
            {"",            "", ""},
        },
    })
    -- avoid conflict with mesecons pressure plate
    clear_craft({output="xdecor:pressure_wood_off"})
    register_craft({
        output = "xdecor:pressure_wood_off",
        recipe = {
            {"group:wood", "", "group:wood"},
            {"",           "", ""},
            {"",           "", ""},
        },
    })

    if get_modpath("farming") then
        -- avoid conflict with farming tatami
        clear_craft({output="xdecor:tatami"})
        register_craft({
            output = "xdecor:tatami",
            recipe = {
                {"farming:wheat", "",              "farming:wheat"},
                {"",              "farming:wheat", ""},
                {"",              "",              ""},
            },
        })
    end
end
