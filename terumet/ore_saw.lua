if not minetest.global_exists("terumet") then return end

if minetest.get_modpath("nether") then
    terumet.options.ore_saw.VALID_ORES["nether:sulfur_ore"] = 1
    terumet.options.ore_saw.VALID_ORES["nether:titanium_ore"] = 1
    terumet.options.ore_saw.VALID_ORES["nether:heart_ore"] = 1
end

if minetest.get_modpath("technic_worldgen") then
    terumet.options.ore_saw.VALID_ORES["technic:mineral_uranium"] = 1
    terumet.options.ore_saw.VALID_ORES["technic:mineral_lead"] = 1
    terumet.options.ore_saw.VALID_ORES["technic:mineral_zinc"] = 1
    terumet.options.ore_saw.VALID_ORES["technic:mineral_chromium"] = 1
    terumet.options.ore_saw.VALID_ORES["technic:mineral_sulfur"] = 1
end
