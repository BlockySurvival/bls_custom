-- PLEASE KEEP MOD SECTIONS IN ALPHABETICAL ORDER
-- ORGANIZE LOGIC BY THE TARGET ITEM
local S = minetest.get_translator("unified_inventory")
local F = minetest.formspec_escape

if minetest.get_modpath("basic_materials") then
    if minetest.get_modpath("quartz") then
        minetest.clear_craft({
            output="mesecons_materials:silicon"
        })
        minetest.register_craft({
            output="basic_materials:silicon",
            type="cooking",
            recipe="quartz:quartz_crystal_piece",
        })
    end
    if minetest.get_modpath("technic_worldgen") then
        minetest.clear_craft({output="basic_materials:gear_steel"})
        minetest.register_craft({
            output="basic_materials:gear_steel 6",
            recipe={
                {"",                           "technic:carbon_steel_ingot",      ""},
                {"technic:carbon_steel_ingot", "basic_materials:chainlink_steel", "technic:carbon_steel_ingot"},
                {"",                           "technic:carbon_steel_ingot",      ""},
            }
        })

        minetest.clear_craft({output="basic_materials:motor"})
        minetest.register_craft({
            output="basic_materials:motor 4",
            recipe={
                {"default:mese_crystal_fragment", "basic_materials:copper_wire", "basic_materials:plastic_sheet"},
                {"basic_materials:steel_bar",     "basic_materials:steel_bar",   "basic_materials:gear_steel"},
                {"default:mese_crystal_fragment", "basic_materials:copper_wire", "basic_materials:plastic_sheet"},
            }
        })

        minetest.clear_craft({output="basic_materials:steel_strip"})
        minetest.register_craft({
            output="basic_materials:steel_strip 12",
            recipe={
                {"", "technic:stainless_steel_ingot"},
                {"technic:stainless_steel_ingot", ""},
            }
        })

        minetest.clear_craft({output="basic_materials:steel_wire"})
        minetest.register_craft({
            output="basic_materials:steel_wire 2",
            recipe={
                {"technic:carbon_steel_ingot",  "basic_materials:empty_spool"},
                {"basic_materials:empty_spool", ""},
            }
        })
    end
end

if minetest.get_modpath("bbq") then
    minetest.clear_craft({output="bbq:hotdog_raw"})
    minetest.register_craft({
        output="bbq:hotdog_raw",
        type="shapeless",
        recipe={"group:food_meat_raw", "group:food_meat_raw", "bbq:sawdust"}
    })

    minetest.register_craft({
        output="bbq:yeast 4",
        type="shapeless",
        recipe = {"bbq:yeast", "bucket:bucket_water", "group:food_flour"},
        replacements = {{"bucket:bucket_water", "bucket:bucket_empty"}}
    })
    minetest.register_craft({
        output="bbq:yeast 4",
        type="shapeless",
        recipe = {"bbq:yeast", "bucket:bucket_river_water", "group:food_flour"},
        replacements = {{"bucket:bucket_river_water", "bucket:bucket_empty"}}
    })

    minetest.register_craft({
        output="bbq:yeast 4",
        type="shapeless",
        recipe = {"bbq:yeast", "bucket:bucket_water", "group:food_sugar"},
        replacements = {{"bucket:bucket_water", "bucket:bucket_empty"}}
    })
    minetest.register_craft({
        output="bbq:yeast 4",
        type="shapeless",
        recipe = {"bbq:yeast", "bucket:bucket_river_water", "group:food_sugar"},
        replacements = {{"bucket:bucket_river_water", "bucket:bucket_empty"}}
    })

    minetest.clear_craft({output="bbq:vinegar"})
    minetest.register_craft({
        output="bbq:vinegar",
        type="shapeless",
        recipe = {"group:food_vinegarmother", "group:food_sugar", "bucket:bucket_water", "farming:grapes" },
        replacements = {{"bucket:bucket_water", "bucket:bucket_empty"}}
    })
    minetest.register_craft({
        output="bbq:vinegar",
        type="shapeless",
        recipe = {"group:food_vinegarmother", "group:food_sugar", "bucket:bucket_river_water", "farming:grapes" },
        replacements = {{"bucket:bucket_river_water", "bucket:bucket_empty"}}
    })

    minetest.clear_craft({output="bbq:propane"})
    minetest.register_craft({
        output="bbq:propane",
        recipe={
            {"default:steel_ingot", "default:steel_ingot",    "default:steel_ingot"},
            {"default:steel_ingot", "tubelib_addons1:biogas", "default:steel_ingot"},
            {"default:steel_ingot", "default:steel_ingot",    "default:steel_ingot"},
        }
    })
end

if minetest.get_modpath("bike") then
    if minetest.get_modpath("basic_materials") then
        minetest.clear_craft({output="bike:handles"})
        minetest.register_craft({
            output="bike:handles",
            recipe={
                {"basic_materials:steel_bar", "basic_materials:steel_bar", "basic_materials:steel_bar"},
                {"group:wood",                "",                          "group:wood"},
            }
        })
        minetest.clear_craft({output="bike:wheel"})
        minetest.register_craft({
            output="bike:wheel 2",
            recipe={
                {"",                    "terumet:item_rubber",       ""},
                {"terumet:item_rubber", "basic_materials:steel_bar", "terumet:item_rubber"},
                {"",                    "terumet:item_rubber",       ""},
            }
        })
        minetest.clear_craft({output="bike:bike"})
        minetest.register_craft({
            output="bike:bike",
            recipe={
                {"bike:handles",              "",                          "mobs:saddle"},
                {"basic_materials:steel_bar", "basic_materials:steel_bar", "basic_materials:steel_bar"},
                {"bike:wheel",                "",                          "bike:wheel"},
            }
        })
    end
end

if minetest.get_modpath("bbq") then
    minetest.clear_craft({output="bbq:smoker_blueprint"})
    minetest.register_craft({
        output="bbq:smoker_blueprint",
        recipe={
            {"default:paper", "default:paper", "default:paper"},
            {"default:paper", "dye:blue",      "default:paper"},
            {"default:paper", "default:paper", "default:paper"},
        }
    })
    minetest.clear_craft({output="bbq:woodpile"})
    minetest.register_craft({
        output="bbq:woodpile 4",
        recipe={
            {"default:tree", "default:tree", "default:tree"},
            {"default:tree", "default:tree", "default:tree"},
            {"default:tree", "default:tree", "default:tree"},
        }
    })
    minetest.clear_craft({output="bbq:woodpile_acacia"})
    minetest.register_craft({
        output="bbq:woodpile_acacia 4",
        recipe={
            {"default:acacia_tree", "default:acacia_tree", "default:acacia_tree"},
            {"default:acacia_tree", "default:acacia_tree", "default:acacia_tree"},
            {"default:acacia_tree", "default:acacia_tree", "default:acacia_tree"},
        }
    })
    minetest.clear_craft({output="bbq:woodpile_aspen"})
    minetest.register_craft({
        output="bbq:woodpile_aspen 4",
        recipe={
            {"default:aspen_tree", "default:aspen_tree", "default:aspen_tree"},
            {"default:aspen_tree", "default:aspen_tree", "default:aspen_tree"},
            {"default:aspen_tree", "default:aspen_tree", "default:aspen_tree"},
        }
    })
    minetest.clear_craft({output="bbq:woodpile_junglewood"})
    minetest.register_craft({
        output="bbq:woodpile_junglewood 4",
        recipe={
            {"default:jungletree", "default:jungletree", "default:jungletree"},
            {"default:jungletree", "default:jungletree", "default:jungletree"},
            {"default:jungletree", "default:jungletree", "default:jungletree"},
        }
    })
    minetest.clear_craft({output="bbq:woodpile_pine"})
    minetest.register_craft({
        output="bbq:woodpile_pine 4",
        recipe={
            {"default:pine_tree", "default:pine_tree", "default:pine_tree"},
            {"default:pine_tree", "default:pine_tree", "default:pine_tree"},
            {"default:pine_tree", "default:pine_tree", "default:pine_tree"},
        }
    })
end

if minetest.get_modpath("bones") and minetest.get_modpath("bonemeal") then
    if minetest.get_modpath("building_blocks") then
        minetest.register_craft({
            output="bones:bones",
            recipe={
                {"bonemeal:bone", "bonemeal:bone",       "bonemeal:bone"},
                {"bonemeal:bone", "building_blocks:Tar", "bonemeal:bone"},
                {"bonemeal:bone", "bonemeal:bone",       "bonemeal:bone"},
            }
        })
    end
    if minetest.get_modpath("terumet") then
        minetest.register_craft({
            output="bones:bones",
            recipe={
                {"bonemeal:bone", "bonemeal:bone",     "bonemeal:bone"},
                {"bonemeal:bone", "terumet:block_tar", "bonemeal:bone"},
                {"bonemeal:bone", "bonemeal:bone",     "bonemeal:bone"},
            }
        })
    end
end

if minetest.get_modpath("bridger") then
    minetest.clear_craft({output = "bridger:foundation"})
    minetest.register_craft({
        output = "bridger:foundation 6",
        recipe = {
            {"",            "default:clay",""},
            {"default:clay","default:clay","default:clay"},
            {"default:clay","default:clay","default:clay"},
        }
    })
end

if minetest.get_modpath("building_blocks") then
    minetest.clear_craft({output = "building_blocks:sticks"})
    minetest.register_craft({
        output = "building_blocks:sticks",
        recipe={
            {"",             "default:stick",""},
            {"default:stick","default:stick","default:stick"},
        }
    })
end

if minetest.get_modpath("cavestuff") then
    minetest.register_craft({
        output="default:gravel",
        recipe={
            {"group:pebble", "group:pebble", "group:pebble"},
            {"group:pebble", "group:pebble", "group:pebble"},
            {"group:pebble", "group:pebble", "group:pebble"},
        }
    })
end

if minetest.get_modpath("caverealms") then
    minetest.register_craft({type="cooking", recipe="caverealms:glow_amethyst_ore", output="caverealms:glow_amethyst", })
    minetest.register_craft({type="cooking", recipe="caverealms:glow_emerald_ore", output="caverealms:glow_emerald", })
    minetest.register_craft({type="cooking", recipe="caverealms:glow_ore", output="caverealms:glow_crystal", })
    minetest.register_craft({type="cooking", recipe="caverealms:glow_ruby_ore", output="caverealms:glow_ruby", })
end

if minetest.get_modpath("cblocks") then
    -- make colored blocks cheaper, dye-wise
    local colours = {
        black="dye:black",
        blue="dye:blue",
        brown="dye:brown",
        cyan="dye:cyan",
        dark_green="dye:dark_green",
        dark_grey="dye:dark_grey",
        green="dye:green",
        grey="dye:grey",
        magenta="dye:magenta",
        orange="dye:orange",
        pink="dye:pink",
        red="dye:red",
        violet="dye:violet",
        white="dye:white",
        yellow="dye:yellow"
    }
    for color, dye in pairs(colours) do
        minetest.clear_craft({output=("cblocks:wood_%s"):format(color)})
        minetest.register_craft({
            output = ("cblocks:wood_%s 8"):format(color),
            recipe = {
                {"group:wood", "group:wood", "group:wood"},
                {"group:wood", dye,          "group:wood"},
                {"group:wood", "group:wood", "group:wood"},
            }
        })
        minetest.clear_craft({output=("cblocks:stonebrick_%s"):format(color)})
        minetest.register_craft({
            output = ("cblocks:stonebrick_%s 8"):format(color),
            recipe = {
                {"default:stonebrick", "default:stonebrick", "default:stonebrick"},
                {"default:stonebrick", dye,                  "default:stonebrick"},
                {"default:stonebrick", "default:stonebrick", "default:stonebrick"},
            }
        })
        minetest.clear_craft({output=("cblocks:glass_%s"):format(color)})
        minetest.register_craft({
            output = ("cblocks:glass_%s 8"):format(color),
            recipe = {
                {"default:glass", "default:glass", "default:glass"},
                {"default:glass", dye,             "default:glass"},
                {"default:glass", "default:glass", "default:glass"},
            }
        })
    end
end

if minetest.get_modpath("cottages") then
    minetest.clear_craft({output = "cottages:hay_bale"})
    minetest.register_craft({
        output = "cottages:hay_bale 4",
        recipe = {
            {"cottages:hay","cottages:hay"},
            {"cottages:hay","cottages:hay"}
        }
    })
    if minetest.get_modpath("xdecor") then
        -- recipe conflict with xdecor wood framed glass
        minetest.clear_craft({output="cottages:glass_pane"})
        minetest.register_craft({
            output = "cottages:glass_pane 4",
            recipe = {{"default:glass"}}
        })
    end
    if minetest.get_modpath("farming") then
        -- complicated recipe conflict w/ wheat and straw
        minetest.clear_craft({output="cottages:straw_bale"})
        minetest.register_craft({
            output = "cottages:straw_bale",
            recipe = {
                {"cottages:straw_mat"},
                {"cottages:straw_mat"},
                {"cottages:straw_mat"},
            }
        })

        minetest.clear_craft({recipe = {{"farming:straw"}}})
        minetest.clear_craft({recipe = {{"cottages:straw_bale"}}})

        minetest.register_craft({
            output = "cottages:straw_bale 2",
            recipe = {{"farming:straw"}}
        })
        minetest.register_craft({
            output = "farming:straw",
            type = "shapeless",
            recipe = {"cottages:straw_bale","cottages:straw_bale"}
        })
        minetest.register_craft({
            output = "cottages:straw_mat 3",
            recipe = {{"cottages:straw_bale"}}
        })
        minetest.register_craft({
            output = "farming:wheat 6",
            type = "shapeless",
            recipe = {"farming:straw","farming:straw"}
        })
    end
end

if minetest.get_modpath("cucina_vegana") then
    minetest.register_craft({
        output = "basic_materials:oil_extract",
        recipe = {
            {"group:seed",           "group:seed", "group:seed"},
            {"group:seed",           "group:seed", "group:seed"},
            {"vessels:glass_bottle", "group:seed", "group:seed"},
        }
    })

    -- soy
    minetest.register_craft({
        output = "cucina_vegana:soy_seed 3",
        type = "shapeless",
        recipe = {"cucina_vegana:soy"}
    })
    minetest.register_craft({
        output = "cucina_vegana:soy",
        type = "shapeless",
        recipe = {"cucina_vegana:soy_seed", "cucina_vegana:soy_seed", "cucina_vegana:soy_seed"}
    })

    -- rice
    minetest.clear_craft({output="cucina_vegana:rice"})
    minetest.clear_craft({output="cucina_vegana:rice_seed"})
    minetest.clear_craft({output="cucina_vegana:rice_flour"})
    minetest.clear_craft({output="farming:rice"})
    minetest.clear_craft({output="farming:seed_rice"})
    minetest.clear_craft({output="farming:rice_flour"})

    minetest.register_craft({
        output = "cucina_vegana:rice_seed",
        type = "shapeless",
        recipe = {"cucina_vegana:rice"},
    })
    minetest.register_craft({
        output = "cucina_vegana:rice",
        type = "shapeless",
        recipe = {"cucina_vegana:rice_seed"},
    })
    minetest.register_craft({
        output = "farming:rice_flour",
        type = "shapeless",
        recipe = {
            "group:food_rice_raw",
            "group:food_rice_raw",
            "group:food_rice_raw",
            "group:food_rice_raw",
            "farming:mortar_pestle",
        },
        replacements = {
            {"farming:mortar_pestle", "farming:mortar_pestle"}
        }
    })

    -- sunflower
    minetest.register_craft({
        output = "cucina_vegana:sunflower_seed 4",
        type = "shapeless",
        recipe = {"cucina_vegana:sunflower_seeds"},
    })
    minetest.register_craft({
        output = "cucina_vegana:sunflower_seeds",
        type = "shapeless",
        recipe = {"cucina_vegana:sunflower_seed", "cucina_vegana:sunflower_seed", "cucina_vegana:sunflower_seed", "cucina_vegana:sunflower_seed"},
    })

    minetest.clear_craft({output="cucina_vegana:sunflower_seeds_flour"})
    minetest.register_craft({
        output = "cucina_vegana:sunflower_seeds_flour",
        type = "shapeless",
        recipe = {
            "cucina_vegana:sunflower_seeds",
            "cucina_vegana:sunflower_seeds",
            "cucina_vegana:sunflower_seeds",
            "cucina_vegana:sunflower_seeds",
            "farming:mortar_pestle",
        },
        replacements = {
            {"farming:mortar_pestle", "farming:mortar_pestle"}
        }
    })

    -- sushi
    minetest.clear_craft({output = "cucina_vegana:vegan_sushi"})
    minetest.register_craft({
        output = "cucina_vegana:vegan_sushi",
        type = "shapeless",
        recipe = {
            "group:food_fish",
            "group:food_rice",
            "default:sand_with_kelp"
        }
    })

    if minetest.get_modpath("farming") then
        minetest.clear_craft({output="farming:bowl"})
    end
end

if minetest.get_modpath("currency") then
    minetest.clear_craft({output = "currency:minegeld_bundle"})
    minetest.register_craft({
        output = "currency:minegeld_bundle",
        type = "shapeless",
        recipe = {
            "currency:minegeld",
            "currency:minegeld",
            "currency:minegeld",
            "currency:minegeld",
            "currency:minegeld",
            "currency:minegeld",
            "currency:minegeld",
            "currency:minegeld",
            "currency:minegeld",
        }
    })
    minetest.register_craft({
        output = "currency:minegeld 9",
        type = "shapeless",
        recipe = {
            "currency:minegeld_bundle",
        }
    })
end

if minetest.get_modpath("default") then
    minetest.register_craft({
        output = "bucket:bucket_empty",
        recipe = {
            {"default:tin_ingot", "",                  "default:tin_ingot"},
            {"",                  "default:tin_ingot", ""}
        }
    })

    -- force alloying bronze
    minetest.clear_craft({recipe={
        {"default:copper_ingot", "default:copper_ingot", "default:copper_ingot"},
        {"default:copper_ingot", "default:tin_ingot",    "default:copper_ingot"},
        {"default:copper_ingot", "default:copper_ingot", "default:copper_ingot"},
    }})

    -- add some recipes for kinds of dirt
    minetest.register_craft({
        output = "default:dirt_with_snow",
        type = "shapeless",
        recipe = {"default:dirt", "default:snow"}
    })
    minetest.register_craft({
        output = "default:dirt_with_rainforest_litter",
        type = "shapeless",
        recipe = {"default:dirt", "default:jungleleaves"}
    })
    minetest.register_craft({
        output = "default:dirt_with_dry_grass",
        type = "shapeless",
        recipe = {"default:dirt", "default:dry_grass_1"}
    })
    minetest.register_craft({
        output = "default:dirt_with_coniferous_litter",
        type = "shapeless",
        recipe = {"default:dirt", "default:pine_needles"}
    })
    minetest.register_craft({
        output = "default:permafrost",
        type = "shapeless",
        recipe = {"default:dirt", "default:ice"}
    })
    minetest.register_craft({
        output = "default:permafrost_with_moss",
        type = "shapeless",
        recipe = {"default:permafrost", "default:junglegrass"}
    })
    minetest.register_craft({
        output = "default:permafrost_with_stones",
        type = "shapeless",
        recipe = {"default:permafrost", "default:gravel"}
    })
    -- smelt tree into coal (but don't make this a net-gain in heat)
    minetest.register_craft({
        output="default:coal_lump",
        type="cooking",
        cooktime=80,
        recipe="default:tree",
    })

    minetest.register_craft({type="cooking", recipe="default:stone_with_coal", output="default:coal_lump", })
    minetest.register_craft({type="cooking", recipe="default:stone_with_copper", output="default:copper_ingot", })
    minetest.register_craft({type="cooking", recipe="default:stone_with_diamond", output="default:diamond", })
    minetest.register_craft({type="cooking", recipe="default:stone_with_gold", output="default:gold_ingot", })
    minetest.register_craft({type="cooking", recipe="default:stone_with_iron", output="default:iron_ingot", })
    minetest.register_craft({type="cooking", recipe="default:stone_with_mese", output="default:mese_crystal", })
    minetest.register_craft({type="cooking", recipe="default:stone_with_tin", output="default:tin_ingot", })

    minetest.clear_craft({recipe={
        {"default:dry_shrub",},
    }})
    minetest.register_craft( {
        type = "shapeless",
        output = "dye:brown 4",
        recipe = {"default:dry_shrub"}
    })

    if minetest.get_modpath("terumet") then
        minetest.register_craft({
            type = "shapeless",
            output = "default:dirt 4",
            recipe = {"group:sand", "default:clay", "terumet:block_dust_bio", "group:mushroom"}
        })
    end
end

-- TODO digilines:lightsensor

if minetest.get_modpath("extra") then
    -- EDGY1"S ADDITION
    minetest.register_craft({
        output = "extra:french_fries",
        recipe = {
            {"group:food_oil",     "extra:potato_slice", "extra:potato_slice"},
            {"extra:potato_slice", "extra:potato_slice", "extra:potato_slice"},
            {"extra:potato_slice", "extra:potato_slice", "extra:potato_slice"},
        },
    })
    minetest.register_craft({
        output = "extra:onion_rings",
        recipe = {
            {"group:food_oil",    "extra:onion_slice", "extra:onion_slice"},
            {"extra:onion_slice", "extra:onion_slice", "extra:onion_slice"},
            {"extra:onion_slice", "extra:onion_slice", "extra:onion_slice"},
        },
    })
    minetest.register_craft({
        type = "cooking",
        output = "extra:potato_crisps",
        recipe = "extra:potato_slice"
    })


    if minetest.get_modpath("mobs") then
        if extra.pizza_mod then
            minetest.clear_craft({
                output = "extra:cheese_pizza"
            })
            minetest.register_craft({
                type = "shapeless",
                recipe = {"terumet:vacf_extra_cheese_pizza"},
                output = "extra:cheese_pizza"
            })
            minetest.register_craft({
                type = "shapeless",
                output = 'extra:cheese_pizza 8',
                recipe = {"farming:flour", "extra:marinara", "group:food_cheese"},
            })


            minetest.clear_craft({
                output = "extra:pepperoni_pizza"
            })
            minetest.register_craft({
                type = "shapeless",
                recipe = {"terumet:vacf_extra_pepperoni_pizza"},
                output = "extra:pepperoni_pizza"
            })
            minetest.register_craft({
                type = "shapeless",
                output = "extra:pepperoni_pizza 8",
                recipe = {"farming:flour", "extra:marinara", "group:food_cheese",
                            "extra:pepperoni"},
            })


            minetest.clear_craft({
                output = "extra:deluxe_pizza"
            })
            minetest.register_craft({
                type = "shapeless",
                recipe = {"terumet:vacf_extra_deluxe_pizza"},
                output = "extra:deluxe_pizza"
            })
            minetest.register_craft({
                type = "shapeless",
                output = "extra:deluxe_pizza 8",
                recipe = {"farming:flour", "extra:marinara", "group:food_cheese",
                            "extra:pepperoni", "extra:onion_slice",
                            "extra:tomato_slice", "flowers:mushroom_brown"}
            })


            minetest.clear_craft({
                output = "extra:pineapple_pizza"
            })
            minetest.register_craft({
                type = "shapeless",
                recipe = {"terumet:vacf_extra_pineapple_pizza"},
                output = "extra:pineapple_pizza"
            })
            minetest.register_craft({
                type = "shapeless",
                output = "extra:pineapple_pizza 8",
                recipe = {"farming:flour", "extra:marinara", "group:food_cheese",
                            "extra:ground_meat", "farming:pineapple_ring"},
            })
        end

        minetest.clear_craft({
            output = "extra:taco"
        })
        minetest.register_craft({
            type = "shapeless",
            recipe = {"terumet:vacf_extra_taco"},
            output = "extra:taco"
        })
        minetest.register_craft({
            type = "shapeless",
            output = 'extra:taco 5',
            recipe = {'extra:ground_meat', "group:food_cheese", 'extra:flour_tortilla',
            'extra:flour_tortilla', 'extra:flour_tortilla',
            'extra:flour_tortilla', 'extra:flour_tortilla'},
        })


        minetest.clear_craft({
            output = "extra:quesadilla"
        })
        minetest.register_craft({
            type = "shapeless",
            recipe = {"terumet:vacf_extra_quesadilla"},
            output = "extra:quesadilla"
        })
        minetest.register_craft({
            output = "extra:quesadilla 3",
            recipe = {
                {'extra:flour_tortilla', 'extra:flour_tortilla', 'extra:flour_tortilla'},
                {"extra:salsa", "group:food_cheese",""},
                {'extra:flour_tortilla', 'extra:flour_tortilla', 'extra:flour_tortilla'},
            },
        })


        if extra.pasta_mod then
            minetest.clear_craft({
                output = 'extra:lasagna'
            })
            minetest.register_craft({
                type = "shapeless",
                recipe = {"terumet:vacf_extra_lasagna"},
                output = "extra:lasagna"
            })
            minetest.register_craft({
                type = "shapeless",
                output = 'extra:lasagna 5',
                recipe = {"extra:marinara", "extra:pasta", "extra:pasta",
                "extra:pasta", "extra:pasta", "extra:pasta", "group:food_cheese"},
            })
        end


        minetest.clear_craft({
            output = "extra:cheeseburger"
        })
        minetest.register_craft({
            type = "shapeless",
            recipe = {"terumet:vacf_extra_cheeseburger"},
            output = "extra:cheeseburger"
        })
        minetest.register_craft({
            type = "shapeless",
            output = "extra:cheeseburger",
            recipe = {"farming:bread", "extra:grilled_patty", "group:food_cheese",
                        "extra:grilled_patty", "group:food_cheese"},
        })
    end

    if minetest.global_exists("terumet") then
        if minetest.get_modpath("unified_inventory") then
            if minetest.get_modpath("farming") then
                -- add a recipe for the blooming onion that doesn't require techpack
                terumet.register_alloy_recipe({
                    result="extra:blooming_onion",
                    input={"farming:onion", "group:food_oil"},
                    flux=0,
                    time=10,
                })
            end

            terumet.register_alloy_recipe({
                result="extra:fish_sticks",
                input={"group:food_fish", "group:food_oil"},
                flux=0,
                time=10,
            })
        elseif minetest.get_modpath("cucina_vegana") then
            if minetest.get_modpath("farming") then
                -- add a recipe for the blooming onion that doesn't require techpack
                terumet.register_alloy_recipe({
                    result="extra:blooming_onion",
                    input={"farming:onion", "cucina_vegana:peanut_oil"},
                    flux=0,
                    time=10,
                })
            end

            if minetest.get_modpath("mobs_fish") then
                terumet.register_alloy_recipe({
                    result="extra:fish_sticks",
                    input={"mobs_fish:clownfish", "cucina_vegana:peanut_oil"},
                    flux=0,
                    time=10,
                })
            end
        end
    end

    if minetest.get_modpath("farming") then
        minetest.clear_craft({
            output = "extra:pepperoni"
        })
        minetest.register_craft({
            type = "shapeless",
            recipe = {"terumet:vacf_extra_pepperoni"},
            output = "extra:pepperoni"
        })
        minetest.register_craft({
            type = "shapeless",
            recipe = {"group:food_meat","farming:chili_pepper"},
            output = "extra:pepperoni"
        })
        minetest.register_craft({
            type = "shapeless",
            recipe = {"group:food_meat_raw","farming:chili_pepper"},
            output = "extra:pepperoni"
        })

        minetest.clear_craft({
            type = "shapeless",
            recipe = {"extra:cottonseed_oil","farming:flour"}
        })
        minetest.register_craft({
            output = "extra:flour_tortilla 10",
            type = "shapeless",
            recipe = {"group:food_oil","farming:flour"}
        })
        -- slices should require the cutting board
        minetest.clear_craft({output="extra:onion_slice"})
        minetest.register_craft({
            output = "extra:onion_slice 8",
            type = "shapeless",
            recipe = {"farming:onion", "farming:cutting_board"},
            replacements = {{"farming:cutting_board", "farming:cutting_board"}},
        })
        minetest.clear_craft({output="extra:potato_slice"})
        minetest.register_craft({
            output = "extra:potato_slice 8",
            type = "shapeless",
            recipe = {"farming:potato", "farming:cutting_board"},
            replacements = {{"farming:cutting_board", "farming:cutting_board"}},
        })
        minetest.clear_craft({output="extra:tomato_slice"})
        minetest.register_craft({
            output = "extra:tomato_slice 8",
            type = "shapeless",
            recipe = {"farming:tomato", "farming:cutting_board"},
            replacements = {{"farming:cutting_board", "farming:cutting_board"}},
        })
    end
end

if minetest.get_modpath("farming") then
    local function register_hoe_craft(name, material)
        minetest.register_craft({
            output = name,
            recipe = {
                {material, material},
                {"",       "default:stick"},
                {"",       "default:stick"},
            }
        })
    end
    register_hoe_craft("farming:hoe_bronze", "default:bronze_ingot")
    register_hoe_craft("farming:hoe_mese", "default:mese_crystal")
    register_hoe_craft("farming:hoe_diamond", "default:diamond")
    if minetest.get_modpath("moreores") then
        register_hoe_craft("moreores:hoe_silver", "moreores:silver_ingot")
        register_hoe_craft("moreores:hoe_mithril", "moreores:mithril_ingot")
    end

    minetest.clear_craft({output="farming:smoothie_berry"})
    minetest.register_craft({
        output = "farming:smoothie_berry",
        type = "shapeless",
        recipe = {
            "group:food_raspberries", "group:food_blackberries",
            "group:food_strawberry", "farming:blueberries",
            "vessels:drinking_glass"
        }
    })
end

if minetest.get_modpath("gravelsieve") then
    -- make gravelsieve expensive
    minetest.clear_craft({output="gravelsieve:sieve"})
    minetest.register_craft({
        output = "gravelsieve:sieve",
        recipe = {
            {"group:wood", "",                      "group:wood"},
            {"group:wood", "default:diamondblock",  "group:wood"},
            {"group:wood", "",                      "group:wood"},
        },
    })
    -- make autosieve even more expensive
    minetest.clear_craft({output="gravelsieve:auto_sieve"})
    minetest.register_craft({
        output = "gravelsieve:auto_sieve",
        recipe = {
            {"default:diamondblock", "titanium:block",    "default:diamondblock"},
            {"titanium:block",       "gravelsieve:sieve", "titanium:block"},
            {"default:diamondblock", "titanium:block",    "default:diamondblock"},
        },
    })

    -- make compressed gravel behave like other compressed nodes
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

if minetest.get_modpath("hangglider") and minetest.get_modpath("terumet") and minetest.get_modpath("mobs") and minetest.get_modpath("farming") and minetest.get_modpath("moreblocks") then
    minetest.clear_craft({output="hangglider:hangglider"})
    minetest.register_craft({
        output="hangglider:hangglider",
        recipe={
            {"farming:slab_hemp_block_1", "farming:slab_hemp_block_1", "farming:slab_hemp_block_1"},
            {"terumet:item_rebar",        "",                          "terumet:item_rebar"},
            {"",                          "mobs:saddle",               ""}
        }
    })
end

if minetest.get_modpath("homedecor_bathroom") then
    minetest.clear_craft({recipe={
        {"group:marble","group:marble"},
        {"group:marble","group:marble"},
    }})
    minetest.register_craft({
        output="homedecor:bathroom_tiles_light 6",
        recipe={
            {"group:marble","group:marble","group:marble"},
            {"group:marble","group:marble","group:marble"},
        }
    })
end

if minetest.get_modpath("homedecor_electrical") then
    minetest.clear_craft({output="homedecor:doorbell"})
    minetest.register_craft({
        output="homedecor:doorbell",
        recipe = {
            {"homedecor:light_switch_off", "basic_materials:energy_crystal_simple", "homedecor:speaker_driver"}
        }
    })
end

if minetest.get_modpath("homedecor_exterior") then
    minetest.clear_craft({
        recipe = {
            { "moreblocks:slab_stone","","moreblocks:slab_stone" },
            { "","moreblocks:slab_stone","" },
            { "moreblocks:slab_stone","","moreblocks:slab_stone" }
        },
    })
    minetest.register_craft({
        output = "homedecor:stonepath 16",
        recipe = {
            { "moreblocks:slab_stone","","moreblocks:slab_stone" },
            { "","moreblocks:slab_stone","" },
            { "moreblocks:slab_stone","","moreblocks:slab_stone" }
        },
    })
end

if minetest.get_modpath("homedecor_fences") then
    minetest.clear_craft( {
        recipe = {
            { "group:stick", "group:stick", "group:stick" },
            { "group:stick", "", "group:stick" },
            { "group:stick", "group:stick", "group:stick" }
        },
    })
    minetest.register_craft( {
        output="homedecor:fence_picket 6",
        recipe = {
            { "group:stick", "",            "group:stick" },
            { "group:stick", "group:stick", "group:stick" },
            { "group:stick", "group:stick", "group:stick" }
        },
    })
    minetest.clear_craft( {
        recipe = {
            { "group:stick", "group:stick", "group:stick" },
            { "group:stick", "dye:white", "group:stick" },
            { "group:stick", "group:stick", "group:stick" }
        },
    })

    minetest.register_craft( {
        output="homedecor:fence_picket_white 6",
        recipe = {
            { "group:stick", "dye:white",   "group:stick" },
            { "group:stick", "group:stick", "group:stick" },
            { "group:stick", "group:stick", "group:stick" }
        },
    })
    minetest.register_craft({
        output="homedecor:fence_picket_white 6",
        type="shapeless",
        recipe = {"homedecor:fence_picket", "dye:white"}
    })
    minetest.register_craft({
        output="homedecor:fence_picket_corner_white 6",
        type="shapeless",
        recipe = {"homedecor:fence_picket_corner", "dye:white"}
    })
    minetest.register_craft({
        output="homedecor:fence_picket_white_closed 6",
        type="shapeless",
        recipe = {"homedecor:fence_picket_closed", "dye:white"}
    })
end

if minetest.get_modpath("homedecor_furniture_medieval") then
    minetest.register_craft({
        output="homedecor:chains",
        type="shapeless",
        recipe = {
            "homedecor:chain_steel_top", "homedecor:chain_steel_top"
        }
    })
end

if minetest.get_modpath("homedecor_seating") then
    minetest.clear_craft({ output = "homedecor:simple_bench" })
    minetest.register_craft( {
        output = "homedecor:simple_bench",
        recipe = {
            { "moreblocks:slab_wood", "moreblocks:slab_wood", "moreblocks:slab_wood" },
            { "moreblocks:slab_wood", "", "moreblocks:slab_wood" }
        },
    })
end

if minetest.get_modpath("hook") then
    minetest.clear_craft({output="hook:pchest"})
    minetest.register_craft({
        output="hook:pchest",
        recipe = {
            {"terumet:block_entropy",      "terumet:reinf_block_stone3", "titanium:block"},
            {"terumet:reinf_block_stone3", "default:chest",              "terumet:reinf_block_stone3"},
            {"technic:uranium_block",      "terumet:reinf_block_stone3", "technic:stainless_steel_block"},
        }
    })
end

if minetest.get_modpath("hot_air_balloons") and minetest.get_modpath("farming") and minetest.get_modpath("terumet") and minetest.get_modpath("xdecor") and minetest.get_modpath("moreblocks") then
    minetest.clear_craft({output="hot_air_balloons:item"})
    minetest.register_craft({
        output="hot_air_balloons:item",
        recipe={
            {"farming:hemp_block", "farming:hemp_block", "farming:hemp_block"},
            {"farming:hemp_block", "bbq:propane",        "farming:hemp_block"},
            {"moreblocks:rope",    "xdecor:barrel",      "moreblocks:rope"}
        }
    })
end

if minetest.get_modpath("itemframes") and minetest.get_modpath("wool") and minetest.get_modpath("xdecor") then
    -- avoid conflict with xdecor item frame
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


if minetest.get_modpath("mesecons_pressureplates") and minetest.get_modpath("xdecor") then
    -- avoid conflict with xdecor pressure plate
    minetest.clear_craft({output="mesecons_pressureplates:pressure_plate_stone_off"})
    minetest.register_craft({
        output = "mesecons_pressureplates:pressure_plate_stone_off",
        recipe = {
            {"group:stone", "mesecons:wire_00000000_off", "group:stone"},
        },
    })
    minetest.register_craft({
        output = "mesecons_pressureplates:pressure_plate_stone_off",
        type = "shapeless",
        recipe = {"xdecor:pressure_stone_off", "mesecons:wire_00000000_off"},
    })
    minetest.register_craft({
        output = "xdecor:pressure_stone_off",
        type = "shapeless",
        recipe = {"mesecons_pressureplates:pressure_plate_stone_off"},
    })
    -- avoid conflict with mesecon pressure plate
    minetest.clear_craft({output="mesecons_pressureplates:pressure_plate_wood_off"})
    minetest.register_craft({
        output = "mesecons_pressureplates:pressure_plate_wood_off",
        recipe = {
            {"group:wood", "mesecons:wire_00000000_off", "group:wood"},
        },
    })
    minetest.register_craft({
        output = "xdecor:pressure_wood_off",
        type = "shapeless",
        recipe = {"mesecons_pressureplates:pressure_plate_wood_off"},
    })
    minetest.register_craft({
        output = "mesecons_pressureplates:pressure_plate_wood_off",
        type = "shapeless",
        recipe = {"xdecor:pressure_wood_off", "mesecons:wire_00000000_off"},
    })
end

if minetest.get_modpath("missions") then
    minetest.clear_craft({output="missions:wand"})
    minetest.clear_craft({output="missions:mission"})
end

if minetest.get_modpath("mobs") and mobs.mod == "redo" then
    minetest.clear_craft({output="mobs:lasso"})
    minetest.register_craft({
        output = "mobs:lasso",
        recipe = {
            {"",            "group:rope", "group:rope"},
            {"",            "group:rope", "group:rope"},
            {"group:rope", "",            ""},
        },
    })
end

if minetest.get_modpath("moreblocks") and minetest.get_modpath("xdecor") then
    -- avoid conflict with xdecor cactus brick
    minetest.clear_craft({recipe={"default:cactus", "default:brick"}, type="shapeless"})
    minetest.register_craft({
            output = "moreblocks:cactus_brick",
            recipe = {{"default:cactus", "default:brick"}}
    })

    -- moreblocks:grey_bricks and xdecor:moonbrick
    minetest.clear_craft({recipe={"default:stone", "default:brick"}, type="shapeless"})
    minetest.register_craft({
            output = "moreblocks:grey_bricks 2",
            recipe = {{"default:stone", "default:brick"}}
    })
    minetest.clear_craft({output="xdecor:stone_rune"})
    minetest.register_craft({
        output = "xdecor:stone_rune 4",
        recipe = {
            {"default:stone", "default:stone",           "default:stone"},
            {"default:stone", "moreblocks:slab_stone_1", "default:stone"},
            {"default:stone", "default:stone",           "default:stone"},
        }
    })


end

if minetest.get_modpath("moreores") then
    minetest.register_craft({type="cooking", recipe="moreores:mineral_mithril", output="moreores:mithril_ingot", })
    minetest.register_craft({type="cooking", recipe="moreores:mineral_silver", output="moreores:silver_ingot", })
end

if minetest.get_modpath("my_castle_doors") then
    minetest.clear_craft({output="my_castle_doors:door11"})
    minetest.register_craft({
        output="my_castle_doors:door11",
        recipe={
            {"my_door_wood:wood_brown", "default:steel_ingot"},
            {"my_door_wood:wood_brown", "my_door_wood:wood_dark_grey"},
            {"my_door_wood:wood_brown", "my_door_wood:wood_brown"},
        }
    })
end

if minetest.get_modpath("my_future_doors") then
    minetest.clear_craft({output="my_future_doors:door2a"})
    minetest.register_craft({
        output="my_future_doors:door2a 2",
        recipe={
            {"default:steelblock",  "default:steel_ingot"},
            {"default:steel_ingot", "default:steel_ingot"},
            {"default:steelblock",  "default:steel_ingot"},
        }
    })
end

if minetest.get_modpath("my_fancy_doors") then
    minetest.register_craft({
        output = "my_fancy_doors:door8_locked 1",
        recipe = {
            {"default:glass", "my_door_wood:wood_red", ""},
            {"my_door_wood:wood_red", "default:glass", "default:steel_ingot"},
            {"default:glass", "my_door_wood:wood_red", ""}
        }
    })
end

if minetest.get_modpath("my_garage_door") then
    minetest.register_craft({
        output="my_garage_door:garage_door",
        recipe={
            {"my_door_wood:wood_white", "my_door_wood:wood_white", "my_door_wood:wood_white"},
            {"my_door_wood:wood_white", "my_door_wood:wood_white", "my_door_wood:wood_white"},
            {"my_door_wood:wood_white", "my_door_wood:wood_white", "my_door_wood:wood_white"},
        }
    })
end

if minetest.get_modpath("my_saloon_doors") then
    local door_colors = {"white","red","black","brown","grey","dark_grey","yellow"}
    for _,door_color in ipairs(door_colors) do
        local wood = "my_door_wood:wood_"..door_color
        minetest.register_craft({
            output="my_saloon_doors:door1a_"..door_color,
            recipe={
                {wood, "", wood},
                {wood, "", wood},
                {wood, "", wood},
            }
        })
    end
end

if minetest.get_modpath("my_sliding_doors") then
    minetest.register_craft({
        output="my_sliding_doors:jpanel1",
        recipe={
            {"group:wood", "default:paper", "group:wood"},
            {"group:wood", "default:paper", "group:wood"},
            {"group:wood", "default:paper", "group:wood"},
        }
    })
    minetest.register_craft({
        output="my_sliding_doors:jpanel2",
        recipe={
            {"group:wood", "default:paper", "group:wood"},
            {"group:wood", "dye:red",       "group:wood"},
            {"group:wood", "default:paper", "group:wood"},
        }
    })
    minetest.register_craft({
        output="my_sliding_doors:jpanel3",
        recipe={
            {"group:wood", "default:paper", "group:wood"},
            {"group:wood", "group:wood",    "group:wood"},
            {"group:wood", "default:paper", "group:wood"},
        }
    })
    for n=1,3 do
        local ns = tostring(n)
        local panel = "my_sliding_doors:jpanel"..ns
        local corner = "my_sliding_doors:jpanel_corner_"..ns
        minetest.register_craft({
            output="my_sliding_doors:door"..ns.."a",
            type = "shapeless",
            recipe={panel,panel}
        })
        minetest.register_craft({
            output=corner.." 3",
            recipe={
                {"",    panel},
                {panel, panel},
            }
        })
        minetest.register_craft({
            output=corner.." 3",
            recipe={
                {panel, ""},
                {panel, panel},
            }
        })
        minetest.register_craft({
            output=corner.." 3",
            recipe={
                {panel, panel},
                {"",    panel},
            }
        })
        minetest.register_craft({
            output=corner.." 3",
            recipe={
                {panel, panel},
                {panel, ""},
            }
        })
    end
end

if minetest.get_modpath("nether") then
    minetest.register_craft({type="cooking", recipe="nether:sulfur_ore", output="technic:sulfur_lump", })
    minetest.register_craft({type="cooking", recipe="nether:titanium_ore", output="titanium:titanium", })
end

if minetest.get_modpath("other_worlds") then
    minetest.register_craft({type="cooking", recipe="asteroid:copperore", output="default:copper_ingot", })
    minetest.register_craft({type="cooking", recipe="asteroid:diamondore", output="default:diamond", })
    minetest.register_craft({type="cooking", recipe="asteroid:goldore", output="default:gold_ingot", })
    minetest.register_craft({type="cooking", recipe="asteroid:ironore", output="default:iron_ingot", })
    minetest.register_craft({type="cooking", recipe="asteroid:meseore", output="default:mese_crystal", })
end

if minetest.get_modpath("palm") then
    minetest.register_craft({
        output="palm:coconut_slice 4",
        type="shapeless",
        recipe={"palm:coconut"}
    })

    minetest.register_craft({
        output="palm:coconut",
        type="shapeless",
        recipe={"palm:coconut_slice", "palm:coconut_slice", "palm:coconut_slice", "palm:coconut_slice"}
    })
end

if minetest.get_modpath("quartz") then
    minetest.register_craft({
        output="quartz:quartz_crystal 4",
        type="shapeless",
        recipe={"quartz:block"}
    })

    minetest.clear_craft({
        recipe={
                {"quartz:quartz_crystal", "quartz:quartz_crystal"},
                {"quartz:quartz_crystal", "quartz:quartz_crystal"},
        }

    })

    minetest.register_craft({
        output="quartz:block",
        recipe={
            {"quartz:quartz_crystal", "quartz:quartz_crystal"},
            {"quartz:quartz_crystal", "quartz:quartz_crystal"},
        }
    })

    minetest.register_craft({type="cooking", recipe="quartz:quartz_ore", output="quartz:quartz_crystal", })
end

if minetest.get_modpath("ropes") and minetest.get_modpath("default") and minetest.get_modpath("basic_materials") then
    -- avoid conflict w/ steel leggings from 3d armor
    minetest.clear_craft({output="ropes:ladder_steel"})
    minetest.register_craft({
        output="ropes:ladder_steel",
        recipe={
            {"basic_materials:steel_bar", "",                     "basic_materials:steel_bar"},
            {"",                          "default:ladder_steel", "" },
            {"basic_materials:steel_bar", "",                     "basic_materials:steel_bar"},
        }
    })
    -- just being consistent w/ the above recipe
    minetest.clear_craft({output="ropes:ladder_wood"})
    minetest.register_craft({
        output="ropes:ladder_wood",
        recipe={
            {"default:stick", "",                    "default:stick"},
            {"",              "default:ladder_wood", "" },
            {"default:stick", "",                    "default:stick"},
        }
    })
    minetest.clear_craft({output="ropes:ropeladder_top"})
    minetest.register_craft({
        output="ropes:ropeladder_top",
        recipe={
            {"",           "default:stick", ""},
            {"group:rope", "default:stick", "group:rope" },
            {"",           "default:stick", ""},
        }
    })
    minetest.clear_craft({output="ropes:wood1rope_block"})
    minetest.register_craft({
        output="ropes:wood1rope_block",
        recipe={
            {"group:wood", ""},
            {"group:rope", ""},
        }
    })
    minetest.clear_craft({output="ropes:steel1rope_block"})
    minetest.register_craft({
        output="ropes:steel1rope_block",
        recipe={
            {"default:steel_ingot", ""},
            {"group:rope", ""},
        }
    })
    minetest.clear_craft({output="ropes:copper1rope_block"})
    minetest.register_craft({
        output="ropes:copper1rope_block",
        recipe={
            {"default:copper_ingot", ""},
            {"group:rope", ""},
        }
    })
    minetest.register_craft({
        output="ropes:ropesegment",
        recipe={
            {"group:vines", "group:vines"},
            {"group:vines", "group:vines"},
            {"group:vines", "group:vines"},
        }
    })
end

if minetest.get_modpath("scifi_nodes") then
    bls.log("debug", "TODO")
    --[[
            blackpipe
            blackvent
            blackvnt
            scifi node builder (probably not)
            crate
            doom engine wall
            doom wall 4
            engine
            green wall panel

            metal with holes
            junk
            teleporter (probably not)
            umbrella weed
            prickly plant
            wall monitor
            blocks labeled slopes (we have saw)

            dirty metal block
            wind tower
    ]]--
    minetest.clear_craft({output="scifi_nodes:plant8"})
    minetest.register_craft({
        output = "scifi_nodes:plant8",
        recipe = {
            {"flowers:viola",""},
            {"default:dirt","default:junglegrass"},
            {"scifi_nodes:greybolts",""}
        }
    })

    minetest.clear_craft({
        recipe = {
            {"scifi_nodes:white","dye:black","scifi_nodes:white"},
            {"scifi_nodes:black","dye:dark_green","scifi_nodes:black"},
            {"scifi_nodes:white","dye:yellow","scifi_nodes:white"}
        }
    })

    minetest.register_craft({
        output = 'scifi_nodes:doomwall42 6',
        recipe = {
            {"scifi_nodes:white","dye:black","scifi_nodes:white"},
            {"scifi_nodes:black","dye:dark_green","scifi_nodes:black"},
            {"scifi_nodes:white","dye:yellow","scifi_nodes:white"}
        }
    })


    -- Clear slopes, they conflict with panels and are duplicated by moreblocks / stairsplus

    minetest.clear_craft({ output = "scifi_nodes:slope_white2" })
    minetest.clear_craft({ output = "scifi_nodes:slope_white" })
    minetest.clear_craft({ output = "scifi_nodes:slope_black" })
    minetest.clear_craft({ output = "scifi_nodes:slope_bluebars" })
    minetest.clear_craft({ output = "scifi_nodes:slope_mesh2" })
    minetest.clear_craft({ output = "scifi_nodes:slope_mesh" })
    minetest.clear_craft({ output = "scifi_nodes:slope_stripes" })
    minetest.clear_craft({ output = "scifi_nodes:slope_vent" })
    minetest.clear_craft({ output = "scifi_nodes:slope_purple" })
    minetest.clear_craft({ output = "scifi_nodes:slope_greenmetal" })
    minetest.clear_craft({ output = "scifi_nodes:slope_grey" })
    minetest.clear_craft({ output = "scifi_nodes:slope_bluemetal" })
    minetest.clear_craft({ output = "scifi_nodes:slope_wall" })
    minetest.clear_craft({ output = "scifi_nodes:slope_rough" })
    minetest.clear_craft({ output = "scifi_nodes:slope_blight2" })
    minetest.register_alias_force("scifi_nodes:slope_blight2", "scifi_nodes:slope_bluwllight")
end

if minetest.get_modpath("soundblocks") then
    minetest.clear_craft({output="soundblocks:ironbellitem"})
    minetest.register_craft({
        output="soundblocks:ironbellitem",
        recipe={{"default:stick", "default:steel_ingot"}}
    })
end

if minetest.get_modpath("technic_chests") then
    minetest.register_craft({
        output="technic:iron_chest",
        type="shapeless",
        recipe={"technic:iron_locked_chest"},
    })
    minetest.register_craft({
        output="technic:copper_chest",
        type="shapeless",
        recipe={"technic:copper_locked_chest"},
    })
    minetest.register_craft({
        output="technic:silver_chest",
        type="shapeless",
        recipe={"technic:silver_locked_chest"},
    })
    minetest.register_craft({
        output="technic:gold_chest",
        type="shapeless",
        recipe={"technic:gold_locked_chest"},
    })
end

if minetest.get_modpath("technic_worldgen") then
    minetest.register_craft({type="cooking", recipe="technic:mineral_chromium", output="technic:chromium_ingot", })
    minetest.register_craft({type="cooking", recipe="technic:mineral_lead", output="technic:lead_ingot", })
    minetest.register_craft({type="cooking", recipe="technic:mineral_sulfur", output="technic:sulfur_lump", })
    minetest.register_craft({type="cooking", recipe="technic:mineral_uranium", output="technic:uranium_ingot", })
    minetest.register_craft({type="cooking", recipe="technic:mineral_zinc", output="technic:zinc_ingot", })
end

if minetest.get_modpath("techpack_warehouse") then
    minetest.clear_craft({output="techpack_warehouse:box_steel"})
    minetest.register_craft({
        output = "techpack_warehouse:box_steel",
        recipe = {
            {"default:steel_ingot", "tubelib_addons3:pusher", "default:steel_ingot"},
            {"default:steel_ingot", "tubelib_addons1:chest",  "default:steel_ingot"},
            {"default:steel_ingot", "default:steel_ingot",    "default:steel_ingot"},
        }
    })

    minetest.clear_craft({output="techpack_warehouse:box_copper"})
    minetest.register_craft({
        output = "techpack_warehouse:box_copper",
        recipe = {
            {"default:copper_ingot", "techpack_warehouse:box_steel", "default:copper_ingot"},
            {"default:copper_ingot", "tubelib_addons3:chest",        "default:copper_ingot"},
            {"default:copper_ingot", "default:copper_ingot",         "default:copper_ingot"},
        }
    })

    minetest.clear_craft({output="techpack_warehouse:box_gold"})
    minetest.register_craft({
        output = "techpack_warehouse:box_gold",
        recipe = {
            {"default:gold_ingot", "techpack_warehouse:box_copper", "default:gold_ingot"},
            {"default:gold_ingot", "technic:gold_chest",            "default:gold_ingot"},
            {"default:gold_ingot", "default:gold_ingot",            "default:gold_ingot"},
        }
    })
end

if minetest.get_modpath("terumet") then
    if minetest.get_modpath("tubelib") then
        -- make tubelib upgrade recipe a little more sensical
        minetest.clear_craft({output="terumet:item_upg_tubelib"})
        minetest.register_craft({
            output = "terumet:item_upg_tubelib",
            recipe = {
                {"",              "group:glue",            ""},
                {"tubelib:tubeS", "terumet:item_upg_base", "tubelib:tubeS"},
                {"",              "terumet:item_thermese", ""},
            }
        })
    end
    if minetest.get_modpath("extra") and minetest.get_modpath("bucket") and minetest.get_modpath("farming") then
        -- fix conflict between pasta and item glue
        minetest.clear_craft({recipe={"farming:flour", "bucket:bucket_water"}, type="shapeless"})
        local def = minetest.registered_items["farming:rice_flour"]
        if def then
            local groups = table.copy(def.groups or {})
            groups.food_flour = 1
            minetest.override_item("farming:rice_flour", {groups=groups})
        end

        minetest.register_craft({
            output="extra:pasta 5",
            recipe={{"group:food_flour", "bucket:bucket_water"}},
            replacements = {{"bucket:bucket_water", "bucket:bucket_empty"}},
        })
        minetest.register_craft({
            output="terumet:item_glue 8",
            recipe={{"bucket:bucket_water", "group:food_flour"}},
            replacements = {{"bucket:bucket_water", "bucket:bucket_empty"}},
        })
    end

    minetest.register_craft({type="cooking", recipe="terumet:ore_dense_raw", output="terumet:ingot_raw 5", })
    minetest.register_craft({type="cooking", recipe="terumet:ore_raw", output="terumet:ingot_raw", })
    minetest.register_craft({type="cooking", recipe="terumet:ore_raw_desert", output="terumet:ingot_raw 2", })
    minetest.register_craft({type="cooking", recipe="terumet:ore_raw_desert_dense", output="terumet:ingot_raw 10", })

end

if minetest.get_modpath("tnt") and minetest.get_modpath("bonemeal") then
    -- make tnt stuff more expensive
    minetest.clear_craft({output="tnt:gunpowder"})
    minetest.register_craft({
        output = "tnt:gunpowder 6",
        type = "shapeless",
        recipe = {"technic:sulfur_lump", "default:coal_lump", "bonemeal:fertiliser"}
    })
end

if minetest.get_modpath("titanium") then
    minetest.register_craft({type="cooking", recipe="titanium:titanium_in_ground", output="titanium:titanium", })
end

if minetest.get_modpath("travelnet") then
    if minetest.get_modpath("titanium") then
        -- make elevator expensive
        minetest.clear_craft({output="travelnet:elevator"})
        minetest.register_craft({
            output = "travelnet:elevator",
            recipe = {
                {"default:glass", "default:steelblock", "default:glass", },
                {"default:glass", "titanium:block",     "default:glass", },
                {"default:glass", "default:steelblock", "default:glass", }
            },
        })

        -- make travelnet even more expensive
        minetest.clear_craft({output="travelnet:travelnet"})
        if minetest.get_modpath("caverealms") then
            minetest.register_craft({
                output = "travelnet:travelnet",
                recipe = {
                    {"caverealms:glow_mese", "titanium:block", "caverealms:glow_mese", },
                    {"caverealms:glow_mese", "default:mese",   "caverealms:glow_mese", },
                    {"caverealms:glow_mese", "titanium:block", "caverealms:glow_mese", }
                },
            })
        else
            minetest.register_craft({
                output = "travelnet:travelnet",
                recipe = {
                    {"default:glass", "titanium:block", "default:glass", },
                    {"default:mese",  "default:mese",   "default:mese", },
                    {"default:glass", "titanium:block", "default:glass", }
                },
            })
        end
    end
    if minetest.get_modpath("locked_travelnet") then
        minetest.register_craft({
            output = "travelnet:travelnet",
            type = "shapeless",
            recipe = {"locked_travelnet:travelnet"},
        })
    end
end

if minetest.get_modpath("tubelib") then
    if minetest.get_modpath("basic_materials") then
        minetest.clear_craft({output="tubelib:tubeS"})
        minetest.register_craft({
            output = "tubelib:tubeS 4",
            recipe = {
                {"basic_materials:brass_ingot", "",           "group:wood"},
                {"",                            "group:wood", ""},
                {"group:wood",                  "",           "default:bronze_ingot"},
            },
        })

        minetest.clear_craft({output="tubelib:end_wrench"})
        minetest.register_craft({
            output = "tubelib:end_wrench 4",
            recipe = {
                {"", "", "technic:stainless_steel_ingot"},
                {"", "technic:stainless_steel_ingot", ""},
                {"technic:stainless_steel_ingot", "", ""},
            },
        })

        minetest.clear_craft({output="tubelib:blackhole"})
        minetest.register_craft({
            output = "tubelib:blackhole 2",
            recipe = {
                {"group:wood",    "",                    "group:wood"},
                {"tubelib:tubeS", "homedecor:trash_can", "default:coal_lump"},
                {"group:wood",    "",                    "group:wood"},
            },
        })

        minetest.clear_craft({output="tubelib:distributor"})
        minetest.register_craft({
            output = "tubelib:distributor 2",
            recipe = {
                {"group:wood",    "tubelib:tubeS",         "group:wood"},
                {"tubelib:tubeS", "basic_materials:motor", "tubelib:tubeS"},
                {"group:wood",    "tubelib:tubeS",         "group:wood"},
            },
        })

        minetest.clear_craft({output="tubelib:lamp"})
        minetest.register_craft({
            output = "tubelib:lamp 4",
            recipe = {
                {"basic_materials:plastic_sheet", "basic_materials:plastic_sheet", "basic_materials:plastic_sheet"},
                {"tubelib:wlanchip",              "default:mese_crystal_fragment", ""},
                {"group:wood",                    "",                              "group:wood"},
            },
        })

        minetest.clear_craft({output="tubelib:pusher"})
        minetest.register_craft({
            output = "tubelib:pusher 2",
            recipe = {
                {"group:wood",    "group:wool",            "group:wood"},
                {"tubelib:tubeS", "basic_materials:motor", "tubelib:tubeS"},
                {"group:wood",    "group:wool",            "group:wood"},
            },
        })

        minetest.clear_craft({output="tubelib:wlanchip"})
        minetest.register_craft({
            output = "tubelib:wlanchip 8",
            recipe = {
                {"default:mese_crystal", "default:copper_ingot"},
                {"default:gold_ingot",   "basic_materials:silicon"},
            },
        })

        if minetest.get_modpath("titanium") then
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
end

if minetest.get_modpath("tubelib_addons1") then
    if minetest.get_modpath("basic_materials") then

        minetest.clear_craft({output="tubelib_addons1:autocrafter"})
        minetest.register_craft({
            output = "tubelib_addons1:autocrafter",
            recipe = {
                {"group:wood",          "basic_materials:ic",         "group:wood"},
                {"tubelib:tubeS",       "basic_materials:motor",      "tubelib:tubeS"},
                {"default:steel_ingot", "basic_materials:gear_steel", "default:steel_ingot"},
            },
        })

        minetest.clear_craft({output="tubelib_addons1:fermenter"})
        minetest.register_craft({
            output = "tubelib_addons1:fermenter",
            recipe = {
                {"basic_materials:steel_strip", "group:soil",            "basic_materials:steel_strip"},
                {"tubelib:tubeS",               "basic_materials:motor", "tubelib:tubeS"},
                {"technic:lead_ingot", "bucket:bucket_empty",   "technic:lead_ingot"},
            },
        })

        minetest.clear_craft({output="tubelib_addons1:reformer"})
        minetest.register_craft({
            output = "tubelib_addons1:reformer",
            recipe = {
                {"basic_materials:steel_strip", "default:clay",          "basic_materials:steel_strip"},
                {"tubelib:tubeS",               "basic_materials:motor", "tubelib:tubeS"},
                {"technic:lead_ingot", "bucket:bucket_empty",   "technic:lead_ingot"},
            },
        })

        minetest.clear_craft({output="tubelib_addons1:funnel"})
        minetest.register_craft({
            output = "tubelib_addons1:funnel",
            recipe = {
                {"bucket:bucket_empty"},
                {"tubelib_addons1:chest"},
            },
        })

        minetest.clear_craft({output="tubelib_addons1:grinder"})
        minetest.register_craft({
            output = "tubelib_addons1:grinder",
            recipe = {
                {"group:wood",    "basic_materials:gear_steel", "group:wood"},
                {"tubelib:tubeS", "basic_materials:motor",      "tubelib:tubeS"},
                {"group:wood",    "technic:lead_block",         "group:wood"},
            },
        })

        minetest.clear_craft({output="tubelib_addons1:harvester_base"})
        minetest.register_craft({
            output = "tubelib_addons1:harvester_base",
            recipe = {
                {"default:sword_mese", "default:axe_mese",      "moreores:hoe_silver"},
                {"group:wood",         "basic_materials:motor", "tubelib:tubeS"},
                {"group:wood",         "group:wood",            "group:wood"},
            },
        })

        minetest.clear_craft({output="tubelib_addons1:liquidsampler"})
        minetest.register_craft({
            output = "tubelib_addons1:liquidsampler",
            recipe = {
                {"group:wood",            "technic:lead_ingot",  "group:wood"},
                {"basic_materials:motor", "bucket:bucket_empty", "tubelib:tubeS"},
                {"group:wood",            "technic:lead_ingot",  "group:wood"},
            },
        })

        minetest.clear_craft({output="tubelib_addons1:quarry"})
        minetest.register_craft({
            output = "tubelib_addons1:quarry",
            recipe = {
                {"default:pick_mese",   "group:wood",            "group:wood"},
                {"default:shovel_mese", "basic_materials:motor", "tubelib:tubeS"},
                {"default:pick_mese",   "group:wood",            "group:wood"},
            },
        })

    end
end

if minetest.get_modpath("tubelib_addons2") then
    if minetest.get_modpath("basic_materials") then

        minetest.clear_craft({output="tubelib_addons2:sequencer"})
        minetest.register_craft({
            output = "tubelib_addons2:sequencer",
            recipe = {
                {"group:wood",         "group:wood"},
                {"basic_materials:ic", "tubelib:wlanchip"},
                {"group:wood",         "group:wood"},
            },
        })

        minetest.clear_craft({output="tubelib_addons2:timer"})
        minetest.register_craft({
            output = "tubelib_addons2:timer",
            recipe = {
                {"group:wood",                  "group:wood"},
                {"quartz:quartz_crystal_piece", "tubelib:wlanchip"},
                {"group:wood",                  "group:wood"},
            },
        })

        minetest.clear_craft({output="tubelib_addons2:invisiblelamp"})
        minetest.register_craft({
            output = "tubelib_addons2:invisiblelamp",
            recipe = {
                {"tubelib:lamp"},
                {"default:obsidian_glass"},
            },
        })
    end
end

if minetest.get_modpath("tubelib_addons3") then
    if minetest.get_modpath("basic_materials") then
        minetest.clear_craft({output="tubelib_addons3:chest"})
        minetest.register_craft({
            output = "tubelib_addons3:chest",
            recipe = {
                {"technic:stainless_steel_ingot", "tubelib_addons1:chest"},
                {"tubelib_addons1:chest",         "terumet:ingot_tgol"},
            },
        })
        minetest.clear_craft({output="tubelib_addons3:distributor"})
        minetest.register_craft({
            output = "tubelib_addons3:distributor",
            recipe = {
                {"technic:stainless_steel_ingot", "tubelib:distributor"},
                {"tubelib:distributor",           "terumet:ingot_tgol"},
            },
        })
        minetest.clear_craft({output="tubelib_addons3:funnel"})
        minetest.register_craft({
            output = "tubelib_addons3:funnel",
            recipe = {
                {"technic:stainless_steel_ingot", "tubelib_addons1:funnel"},
                {"tubelib_addons1:funnel",        "terumet:ingot_tgol"},
            },
        })
        minetest.clear_craft({output="tubelib_addons3:pusher"})
        minetest.register_craft({
            output = "tubelib_addons3:pusher",
            recipe = {
                {"technic:stainless_steel_ingot", "tubelib_addons1:pusher_fast"},
                {"tubelib_addons1:pusher_fast",   "terumet:ingot_tgol"},
            },
        })
        minetest.clear_craft({output="tubelib_addons3:pushing_chest"})
        minetest.register_craft({
            output = "tubelib_addons3:pushing_chest",
            recipe = {
                {"technic:stainless_steel_ingot", "tubelib_addons3:pusher"},
                {"tubelib_addons3:chest",         "terumet:ingot_tgol"},
            },
        })
        minetest.clear_craft({output="tubelib_addons3:teleporter"})
        minetest.register_craft({
            output = "tubelib_addons3:teleporter",
            recipe = {
                {"terumet:item_cryst_uranium", "group:wood",              "terumet:item_cryst_uranium"},
                {"terumet:item_cryst_mese",    "terumet:item_cryst_mese", "tubelib:tubeS"},
                {"terumet:item_cryst_uranium", "group:wood",              "terumet:item_cryst_uranium"},
            },
        })
    end
end

if minetest.get_modpath("wool") then
    -- make colored wool cheaper (dye-wise)
    local colours = {
        black="dye:black",
        blue="dye:blue",
        brown="dye:brown",
        cyan="dye:cyan",
        dark_green="dye:dark_green",
        dark_grey="dye:dark_grey",
        green="dye:green",
        grey="dye:grey",
        magenta="dye:magenta",
        orange="dye:orange",
        pink="dye:pink",
        red="dye:red",
        violet="dye:violet",
        white="dye:white",
        yellow="dye:yellow"
    }
    for color, dye in pairs(colours) do
        minetest.clear_craft({output=("wool:%s"):format(color)})
        minetest.register_craft({
            output = ("wool:%s 8"):format(color),
            recipe = {
                {"group:wool", "group:wool", "group:wool"},
                {"group:wool", dye,          "group:wool"},
                {"group:wool", "group:wool", "group:wool"},
            }
        })
    end

    if minetest.get_modpath("farming") then
        minetest.register_craft({
            output = "wool:white",
            recipe = {
                {"farming:cotton", "farming:cotton"},
                {"farming:cotton", "farming:cotton"},
            }
        })
    end
end

if minetest.get_modpath("xdecor") then
    minetest.clear_craft({output="xdecor:cobweb"})
    if minetest.get_modpath("farming") then
        minetest.register_craft({
            output = "xdecor:cobweb 5",
            recipe = {
                {"",               "farming:string", ""},
                {"farming:string", "farming:string", "farming:string"},
                {"",               "farming:string", ""},
            }
        })
        minetest.register_craft({
            output = "xdecor:cobweb",
            recipe = {
                {"homedecor:cobweb_corner"},
            }
        })
        minetest.register_craft({
            output = "homedecor:cobweb_corner",
            recipe = {
                {"xdecor:cobweb"},
            }
        })
    end

    if minetest.get_modpath("farming") then
        -- avoid conflict with farming tatami
        minetest.clear_craft({output="xdecor:tatami"})
        minetest.register_craft({
            output = "xdecor:tatami",
            recipe = {
                {"farming:wheat", "",              "farming:wheat"},
                {"",              "farming:wheat", ""},
            },
        })
    end

    if minetest.get_modpath("wool") then
        minetest.clear_craft({output="xdecor:cushion"})
        minetest.register_craft({
            output="xdecor:cushion 2",
            recipe={{"wool:red", "wool:red"}}
        })
    end
end

if minetest.get_modpath("xpanes") then
    minetest.clear_craft({output="xpanes:door_steel_bar"})
    minetest.register_craft({
        output="xpanes:door_steel_bar",
        recipe={
            {"xpanes:bar_flat", "", "xpanes:bar_flat"},
            {"xpanes:bar_flat", "", "xpanes:bar_flat"},
            {"xpanes:bar_flat", "", "xpanes:bar_flat"},
        }
    })
    minetest.clear_craft({output="xpanes:trapdoor_steel_bar"})
    minetest.register_craft({
        output="xpanes:trapdoor_steel_bar",
        recipe={
            {"xpanes:bar_flat", "", "xpanes:bar_flat"},
            {"xpanes:bar_flat", "", "xpanes:bar_flat"},
        }
    })
end

if minetest.get_modpath("mobs") then
    minetest.clear_craft({ output = "mobs:butter" })
    minetest.register_craft({
        output = "mobs:butter",
        type = "shapeless",
        recipe = {
            "mobs:bucket_milk", "group:food_salt",
        }
    })
end

if minetest.get_modpath("bbq") and minetest.get_modpath("cucina_vegana") then
    minetest.clear_craft({
        output = "bbq:beef_raw",
    })
    minetest.register_craft( {
        output = "bbq:beef_raw",
        recipe = {
            {"bbq:basting_brush", "group:dye,color_red", "group:food_salt"},
            {"cucina_vegana:imitation_meat", "cucina_vegana:imitation_meat", ""},
        },
        replacements = {{"bbq:basting_brush", "bbq:basting_brush"}}
    })
end

if minetest.get_modpath("caverealms") and minetest.get_modpath("farming") then
    minetest.clear_craft({
        output = "farming:salt",
    })
    minetest.register_craft( {
        output = "farming:salt 2",
        recipe = {
            {"caverealms:micro_salt_crystal"},
        },
    })
end

if minetest.get_modpath("digiscreen") then
    minetest.clear_craft({
        output = "digiscreen:digiscreen",
    })
    minetest.register_craft({
        output = "digiscreen:digiscreen",
        recipe = {
            {"mesecons_luacontroller:luacontroller0000", "default:mese", "default:mese"},
            {"digilines:lcd", "digilines:lcd", "digilines:lcd"},
            {"mesecons_lightstone:lightstone_red_off", "mesecons_lightstone:lightstone_green_off", "mesecons_lightstone:lightstone_blue_off"},
        },
    })
end

if minetest.get_modpath("swaz") then
    minetest.clear_craft({
        output = "swaz:mudbrick",
    })
    minetest.register_craft({
        output = "swaz:mudbrick 4",
        type = "shapeless",
        recipe = {"swaz:adobe", "swaz:adobe", "swaz:adobe", "swaz:adobe"},
    })

    minetest.clear_craft({
        output = "swaz:adobe",
    })
    minetest.register_craft({
        output = "swaz:adobe",
        type = "shapeless",
        recipe = {"swaz:mud", "farming:straw"},
    })
end

if minetest.get_modpath("unified_inventory") then
    unified_inventory.register_craft_type("submerge", {
        description = F(S("Submerge")),
        icon = "default_water.png",
        width = 1,
        height = 1,
        uses_crafting_grid = false,
    })
    if minetest.get_modpath("terumet") then
        unified_inventory.register_craft{
            type = 'submerge',
            output = "terumet:block_con_black",
            items = {"terumet:block_conmix_black"}
        }
        unified_inventory.register_craft{
            type = 'submerge',
            output = "terumet:block_con_blue",
            items = {"terumet:block_conmix_blue"}
        }
        unified_inventory.register_craft{
            type = 'submerge',
            output = "terumet:block_con_brown",
            items = {"terumet:block_conmix_brown"}
        }
        unified_inventory.register_craft{
            type = 'submerge',
            output = "terumet:block_con_cyan",
            items = {"terumet:block_conmix_cyan"}
        }
        unified_inventory.register_craft{
            type = 'submerge',
            output = "terumet:block_con_dark_green",
            items = {"terumet:block_conmix_dark_green"}
        }
        unified_inventory.register_craft{
            type = 'submerge',
            output = "terumet:block_con_dark_grey",
            items = {"terumet:block_conmix_dark_grey"}
        }
        unified_inventory.register_craft{
            type = 'submerge',
            output = "terumet:block_con_green",
            items = {"terumet:block_conmix_green"}
        }
        unified_inventory.register_craft{
            type = 'submerge',
            output = "terumet:block_con_grey",
            items = {"terumet:block_conmix_grey"}
        }
        unified_inventory.register_craft{
            type = 'submerge',
            output = "terumet:block_con_magenta",
            items = {"terumet:block_conmix_magenta"}
        }
        unified_inventory.register_craft{
            type = 'submerge',
            output = "terumet:block_con_orange",
            items = {"terumet:block_conmix_orange"}
        }
        unified_inventory.register_craft{
            type = 'submerge',
            output = "terumet:block_con_pink",
            items = {"terumet:block_conmix_pink"}
        }
        unified_inventory.register_craft{
            type = 'submerge',
            output = "terumet:block_con_red",
            items = {"terumet:block_conmix_red"}
        }
        unified_inventory.register_craft{
            type = 'submerge',
            output = "terumet:block_con_violet",
            items = {"terumet:block_conmix_violet"}
        }
        unified_inventory.register_craft{
            type = 'submerge',
            output = "terumet:block_con_white",
            items = {"terumet:block_conmix_white"}
        }
        unified_inventory.register_craft{
            type = 'submerge',
            output = "terumet:block_con_yellow",
            items = {"terumet:block_conmix_yellow"}
        }
    end
end