if minetest.get_modpath("gravelsieve") then
    minetest.clear_craft({output="gravelsieve:sieve"})
    minetest.register_craft({
        output = "gravelsieve:sieve",
        recipe = {
            {"group:wood", "",                      "group:wood"},
            {"group:wood", "default:diamondblock",  "group:wood"},
            {"group:wood", "",                      "group:wood"},
        },
    })
    minetest.clear_craft({output="gravelsieve:auto_sieve"})
    minetest.register_craft({
        output = "gravelsieve:auto_sieve",
        recipe = {
            {"default:diamondblock", "default:diamondblock", "default:diamondblock"},
            {"default:mese",         "gravelsieve:sieve",    "default:mese"},
            {"default:diamondblock", "default:mese",         "default:diamondblock"},
        },
    })

    minetest.register_alias_force("gravelsieve:sieved_gravel", "default:sand")
    minetest.register_alias_force("gravelsieve:compressed_gravel", "default:cobble")
    minetest.clear_craft({output="gravelsieve:compressed_gravel"})
end

if minetest.get_modpath("travelnet") and minetest.get_modpath("titanium") then
    minetest.clear_craft({output="travelnet:elevator"})
    minetest.register_craft({
        output = "travelnet:elevator",
        recipe = {
            {"default:steel_ingot", "default:glass",  "default:steel_ingot", },
            {"default:steel_ingot", "titanium:block", "default:steel_ingot", },
            {"default:steel_ingot", "default:glass",  "default:steel_ingot", }
        },
    })

    minetest.clear_craft({output="travelnet:travelnet"})
    minetest.register_craft({
        output = "travelnet:travelnet",
        recipe = {
            {"default:glass", "titanium:block", "default:glass", },
            {"default:mese",  "default:mese",   "default:mese", },
            {"default:glass", "titanium:block", "default:glass", }
        },
    })
end

if minetest.get_modpath("tubelib") then
    minetest.clear_craft({output="tubelib:pusher"})
    minetest.register_craft({
        output = "tubelib:pusher 2",
        recipe = {
            {"group:wood",    "group:wool",           "group:wood"},
            {"tubelib:tubeS", "default:mese_crystal", "tubelib:tubeS"},
            {"group:wood",    "group:wool",           "group:wood"},
        },
    })

    if minetest.get_modpath("titanium") and minetest.get_modpath("basic_materials") then
        minetest.clear_craft({output="tubelib:forceload"})
        minetest.register_craft({
            output = "tubelib:forceload",
            recipe = {
                {"group:wood",                            "",                       "group:wood"},
                {"basic_materials:energy_crystal_simple", "titanium:titanium_tv_1", "basic_materials:energy_crystal_simple"},
                {"group:wood",                            "tubelib:wlanchip",       "group:wood"},
            },
        })
    end
end

if minetest.get_modpath("cottages") then
    minetest.clear_craft({output="cottages:glass_pane"})
    minetest.register_craft({
        output = "cottages:glass_pane 4",
        recipe = {
            {"", "",              ""},
            {"", "default:glass", ""},
            {"", "",              ""},
        },
    })
end

if minetest.get_modpath("itemframes") and minetest.get_modpath("wool") then
    minetest.clear_craft({output="itemframes:frame"})
    minetest.register_craft({
        output = "itemframes:frame",
        recipe = {
            {"default:stick", "default:stick", "default:stick"},
            {"default:stick", "group:wool",    "default:stick"},
            {"default:stick", "default:stick", "default:stick"},
        },
    })
end

if minetest.get_modpath("xdecor") then
    minetest.clear_craft({output="xdecor:pressure_stone_off"})
    minetest.register_craft({
        output = "xdecor:pressure_stone_off",
        recipe = {
            {"group:stone", "", "group:stone"},
            {"",            "", ""},
            {"",            "", ""},
        },
    })
    minetest.clear_craft({output="xdecor:pressure_wood_off"})
    minetest.register_craft({
        output = "xdecor:pressure_wood_off",
        recipe = {
            {"group:wood", "", "group:wood"},
            {"",           "", ""},
            {"",           "", ""},
        },
    })

    if minetest.get_modpath("farming") then
        minetest.clear_craft({output="xdecor:tatami"})
        minetest.register_craft({
            output = "xdecor:tatami",
            recipe = {
                {"farming:wheat", "",              "farming:wheat"},
                {"",              "farming:wheat", ""},
                {"",              "",              ""},
            },
        })

        minetest.register_alias_force("xdecor:bowl", "farming:bowl")
    end

    if minetest.get_modpath("moreblocks") then
        minetest.clear_craft({output="moreblocks:empty_shelf"})
        minetest.register_craft({
            output = "moreblocks:empty_shelf",
            type = "shapeless",
            recipe = {"xdecor:empty_shelf"}
        })
        minetest.register_craft({
            output = "xdecor:empty_shelf",
            type = "shapeless",
            recipe = {"moreblocks:empty_shelf"}
        })

        minetest.register_alias_force("xdecor:stone_tile", "moreblocks:stone_tile")
    end
end

if minetest.get_modpath("titanium") then
    if minetest.get_modpath("maptools") then
        minetest.register_alias_force("titanium:light", "maptools:lightbulb")
    else
        minetest.register_alias_force("titanium:light", "air")
    end
end

if minetest.get_modpath("quartz") then
    minetest.clear_craft({output="quartz:chiseled"})
    minetest.register_craft({
        output = "quartz:chiseled 4",
        recipe = {
            {"quartz:block", "quartz:block", ""},
            {"quartz:block", "quartz:block", ""},
            {"",             "",             ""},
        }
    })
end

if minetest.get_modpath("extra") and minetest.get_modpath("terumet") and minetest.get_modpath("farming") then
    terumet.register_alloy_recipe({
        result="extra:blooming_onion",
        input={"farming:onion", "extra:cottonseed_oil"},
        flux=0,
        time=10,
    })
end

if minetest.get_modpath("terumet") then
    minetest.clear_craft({output="terumet:item_upg_cryst"})
    minetest.register_craft({
        output = "terumet:item_upg_cryst",
        recipe = {
            {"terumet:item_cryst_dia", "terumet:item_entropy",  "terumet:item_cryst_dia"},
            {"terumet:item_entropy",   "terumet:item_upg_base", "terumet:item_entropy"},
            {"terumet:item_cryst_dia", "terumet:item_entropy",  "terumet:item_cryst_dia"},
        }
    })
end

if minetest.get_modpath("creative") then
    local creative_mode_cache = minetest.settings:get_bool("creative_mode")

    function creative.is_enabled_for(name)
            return creative_mode_cache or minetest.check_player_privs(name, {creative = true})
    end
end
