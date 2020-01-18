if not minetest.global_exists("terumet") then return end

-- register_vulcan_result(source, result, count_modifier, specialized)

if minetest.get_modpath("technic_worldgen") then
    local uranium_crystal = terumet.register_crystal({
        suffix="uranium",
        name="Crystallized Uranium",
        cooking_result="technic:uranium_ingot",
        color="#C0FCB8",
    })
    local lead_crystal = terumet.register_crystal({
        suffix="lead",
        name="Crystallized Lead",
        cooking_result="technic:lead_ingot",
        color="#C6C6C6",
    })
    local zinc_crystal = terumet.register_crystal({
        suffix="zinc",
        name="Crystallized Zinc",
        cooking_result="technic:zinc_ingot",
        color="#DAEEF5",
    })
    local chromium_crystal = terumet.register_crystal({
        suffix="chromium",
        name="Crystallized Chromium",
        cooking_result="technic:chromium_ingot",
        color="#CEDDDD",
    })

    terumet.register_vulcan_result("technic:uranium_lump", uranium_crystal)
    terumet.register_vulcan_result("technic:mineral_uranium", uranium_crystal, 1)
    terumet.register_vulcan_result("technic:lead_lump", lead_crystal)
    terumet.register_vulcan_result("technic:mineral_lead", lead_crystal, 1)
    terumet.register_vulcan_result("technic:zinc_lump", zinc_crystal)
    terumet.register_vulcan_result("technic:mineral_zinc", zinc_crystal, 1)
    terumet.register_vulcan_result("technic:chromium_lump", chromium_crystal)
    terumet.register_vulcan_result("technic:mineral_chromium", chromium_crystal, 1)
end

if minetest.get_modpath("other_worlds") then
    terumet.register_vulcan_result("asteroid:copperore", "terumet:item_cryst_copper", 1)
    terumet.register_vulcan_result("asteroid:diamondore", "terumet:item_cryst_dia", 1)
    terumet.register_vulcan_result("asteroid:goldore", "terumet:item_cryst_gold", 1)
    terumet.register_vulcan_result("asteroid:ironore", "terumet:item_cryst_iron", 1)
    terumet.register_vulcan_result("asteroid:meseore", "terumet:item_cryst_mese", 1)
end
