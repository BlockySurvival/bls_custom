if not minetest.global_exists("terumet") then return end

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

