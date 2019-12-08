if not minetest.global_exists("terumet") then return end

terumet.register_alloy_recipe({
    result="technic:carbon_steel_ingot 3",
    input={"default:steel_ingot 3", "default:coal_lump"},
    time=30,
    flux=0,
})
terumet.register_alloy_recipe({
    result="technic:carbon_steel_block 3",
    input={"default:steelblock 3", "default:coalblock"},
    time=100,
    flux=0,
})

terumet.register_alloy_recipe({
    result="technic:cast_iron_ingot 3",
    input={"technic:carbon_steel_ingot 3", "default:coal_lump"},
    time=60,
    flux=0,
})
terumet.register_alloy_recipe({
    result="technic:cast_iron_block 3",
    input={"technic:carbon_steel_block 3", "default:coalblock"},
    time=200,
    flux=0,
})

terumet.register_alloy_recipe({
    result="technic:stainless_steel_ingot 8",
    input={"technic:carbon_steel_ingot 7", "technic:chromium_ingot"},
    time=30,
    flux=0,
})
terumet.register_alloy_recipe({
    result="technic:stainless_steel_block 7",
    input={"technic:carbon_steel_block 7", "technic:chromium_block"},
    time=100,
    flux=0,
})

if minetest.get_modpath("basic_materials") then
    local recipes_trimmed = {}
    for _, data in ipairs(terumet.options.smelter.recipes) do
        if data.result ~= "basic_materials:brass_ingot 3" and data.result ~= "basic_materials:brass_block 3" then
            table.insert(recipes_trimmed, data)
        end
    end
    terumet.options.smelter.recipes = recipes_trimmed

    terumet.register_alloy_recipe{result="basic_materials:brass_ingot 3", flux=0, time=4.0, input={"default:copper_lump 2", "technic:zinc_lump"}}
    terumet.register_alloy_recipe{result="basic_materials:brass_ingot 3", flux=0, time=8.0, input={"default:copper_ingot 2", "technic:zinc_ingot"}}
    terumet.register_alloy_recipe{result="basic_materials:brass_block 3", flux=0, time=40.0, input={"default:copperblock 2", "technic:zinc_block"}}
    terumet.register_alloy_recipe{result="basic_materials:brass_ingot 3", flux=0, time=2.0, input={"terumet:item_cryst_copper 2", zinc_crystal}}
end
