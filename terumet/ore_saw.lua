if not minetest.global_exists("terumet") then return end

if minetest.get_modpath("caverealms") then
    terumet.options.ore_saw.VALID_ORES["caverealms:stone_with_algae"] = 1
    terumet.options.ore_saw.VALID_ORES["caverealms:stone_with_lichen"] = 1
    terumet.options.ore_saw.VALID_ORES["caverealms:stone_with_moss"] = 1
    terumet.options.ore_saw.VALID_ORES["caverealms:stone_with_salt"] = 1
end

if minetest.get_modpath("nether") then
    terumet.options.ore_saw.VALID_ORES["nether:sulfur_ore"] = 1
    terumet.options.ore_saw.VALID_ORES["nether:sulfur_ore_new"] = 1

    terumet.options.ore_saw.VALID_ORES["nether:titanium_ore"] = 1
    terumet.options.ore_saw.VALID_ORES["nether:titanium_ore_deep"] = 1
    terumet.options.ore_saw.VALID_ORES["nether:titanium_ore_new"] = 1

    terumet.options.ore_saw.VALID_ORES["nether:heart_ore"] = 1
    terumet.options.ore_saw.VALID_ORES["nether:heart_ore_deep"] = 1
    terumet.options.ore_saw.VALID_ORES["nether:heart_ore_new"] = 1
    
    terumet.options.ore_saw.VALID_ORES["nether:gold_ore"] = 1
    terumet.options.ore_saw.VALID_ORES["nether:gold_ore_blackstone"] = 1
    terumet.options.ore_saw.VALID_ORES["nether:gold_ore_deep"] = 1
end

if minetest.get_modpath("technic_worldgen") then
    terumet.options.ore_saw.VALID_ORES["technic:mineral_uranium"] = 1
    terumet.options.ore_saw.VALID_ORES["technic:mineral_lead"] = 1
    terumet.options.ore_saw.VALID_ORES["technic:mineral_zinc"] = 1
    terumet.options.ore_saw.VALID_ORES["technic:mineral_chromium"] = 1
    terumet.options.ore_saw.VALID_ORES["technic:mineral_sulfur"] = 1
end

terumet.options.ore_saw.VALID_ORES["default:coral_brown"] = 1
terumet.options.ore_saw.VALID_ORES["default:coral_cyan"] = 1
terumet.options.ore_saw.VALID_ORES["default:coral_green"] = 1
terumet.options.ore_saw.VALID_ORES["default:coral_orange"] = 1
terumet.options.ore_saw.VALID_ORES["default:coral_pink"] = 1
