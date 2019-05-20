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
    end
end

if minetest.get_modpath("moreblocks") then
    minetest.clear_craft({output="moreblocks:wood_tile_center"})
    minetest.register_craft({
        output = "moreblocks:wood_tile_center 5",
        recipe = {
            {"group:wood", "",                     "group:wood"},
            {"",           "moreblocks:wood_tile", ""},
            {"group:wood", "",                     "group:wood"},
        },
    })
end
