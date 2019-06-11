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
    minetest.clear_craft({output="gravelsieve:compressed_gravel"})
    minetest.clear_craft({recipe="gravelsieve:compressed_gravel", type="cooking"})
    minetest.register_craft({
        output = "gravelsieve:compressed_gravel",
        recipe = {
            {"default:gravel", "default:gravel", "default:gravel"},
            {"default:gravel", "default:gravel", "default:gravel"},
            {"default:gravel", "default:gravel", "default:gravel"},
        },
    })
    minetest.register_craft({
        output = "default:gravel 9",
        recipe = {
            {"gravelsieve:compressed_gravel"},
        },
    })
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
        recipe = {{'default:glass'}}
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

        minetest.clear_craft({recipe={"default:cactus", "default:brick"}, type="shapeless"})
        minetest.register_craft({
                output = "moreblocks:cactus_brick",
                recipe = {{"default:cactus", "default:brick"}}
        })
    end
end

if minetest.get_modpath("titanium") then
    if minetest.get_modpath("maptools") then
        minetest.register_alias_force("titanium:light", "maptools:lightbulb")
    else
        minetest.register_alias_force("titanium:light", "air")
    end
end

if minetest.get_modpath("extra") and minetest.get_modpath("terumet") and minetest.get_modpath("farming") then
    terumet.register_alloy_recipe({
        result="extra:blooming_onion",
        input={"farming:onion", "extra:cottonseed_oil"},
        flux=0,
        time=10,
    })
end

if minetest.get_modpath("terumet") and minetest.get_modpath("tubelib_addons1") then
    minetest.clear_craft({output="terumet:item_upg_tubelib"})
    minetest.register_craft({
        output = "terumet:item_upg_tubelib",
        recipe = {
            {"terumet:item_coil_tcop", "terumet:item_coil_tcop", "terumet:item_coil_tcop"},
            {"tubelib_addons1:chest",  "terumet:item_upg_base",  "tubelib_addons1:chest"},
            {"terumet:item_coil_tcop", "terumet:item_coil_tcop", "terumet:item_coil_tcop"},
        }
    })

    minetest.register_alias_force("terumet:block_thermese_hot", "terumet:block_thermese")
end

if minetest.get_modpath("creative") then
    local creative_mode_cache = minetest.settings:get_bool("creative_mode")

    function creative.is_enabled_for(name)
            return creative_mode_cache or minetest.check_player_privs(name, {creative = true})
    end
end

if minetest.get_modpath("homedecor_lighting") then
    minetest.register_alias_force("homedecor:plasma_ball_14", "homedecor:plasma_ball_on")
    minetest.register_alias_force("homedecor:wall_lamp_14", "homedecor:wall_lamp_on")
end

if minetest.get_modpath("3d_armor") then
    local admin_armor_list = {
        ['3d_armor:helmet_admin']=true,
        ['3d_armor:chestplate_admin']=true,
        ['3d_armor:leggings_admin']=true,
        ['3d_armor:boots_admin']=true,
        ['shields:shield_admin']=true,
        ['bls_admin_flair:shield_bls']=true,
    }
    local armor_punch = armor.punch
    armor.punch = function(self, player, hitter, time_from_last_punch, tool_capabilities)
        -- when wearing admin armor, don't damage other armor :\
        local name, armor_inv = self:get_valid_player(player, "[punch]")
        if not name then
                return
        end
        local list = armor_inv:get_list("armor")
        for _, stack in pairs(list) do
            local name = stack:get_name()
            if admin_armor_list[name] then
                return
            end
        end
        return armor_punch(self, player, hitter, time_from_last_punch, tool_capabilities)
    end
end

if minetest.get_modpath('tnt') and minetest.get_modpath('bonemeal') then
    minetest.clear_craft({output="tnt:gunpowder"})
    minetest.register_craft({
        output = "tnt:gunpowder",
        type = "shapeless",
        recipe = {"default:gravel", "default:coal", "bonemeal:fertiliser"}
    })
end
