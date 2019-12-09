if not minetest.global_exists("terumet") then return end

terumet.register_repair_material("technic:uranium_ingot", 2)
terumet.register_repair_material("technic:lead_ingot", 2)
terumet.register_repair_material("technic:zinc_ingot", 5)
terumet.register_repair_material("technic:chromium_ingot", 200)
terumet.register_repair_material("technic:carbon_steel_ingot", 30)     -- default:steel_ingot + coal
terumet.register_repair_material("technic:cast_iron_ingot", 60)        -- technic:carbon_steel_ingot + coal
terumet.register_repair_material("technic:stainless_steel_ingot", 150) -- 3xtechnic:carbon_steel_ingot + technic:chromium_ingot

terumet.register_repair_material("moreores:mithril_ingot", 150)
terumet.register_repair_material("moreores:silver_ingot", 40)


local mrv = { -- material repair value
    bronze = 30,
    diamond = 100,
    gold = 50,
    mese = 90,
    mithril = 120,
    silver = 40,
    steel = 10,
    teruchalcum = 60,
    titanium = 150,
}

local cost = {
    axe = 3,
    boots = 4,
    chest = 8,
    helm = 5,
    hoe = 2,
    legs = 7,
    pick = 3,
    scythe = 3,
    shield = 7,
    shovel = 1,
    sword = 2,
}

terumet.register_repairable_item("shields:shield_bronze", mrv.bronze * cost.shield)
terumet.register_repairable_item("shields:shield_diamond", mrv.diamond * cost.shield)

terumet.register_repairable_item("goldtools:goldaxe", mrv.gold * cost.axe)
terumet.register_repairable_item("goldtools:goldpick", mrv.gold * cost.pick)
terumet.register_repairable_item("goldtools:goldshovel", mrv.gold * cost.shovel)
terumet.register_repairable_item("goldtools:goldsword", mrv.gold * cost.sword)
terumet.register_repairable_item("shields:shield_gold", mrv.gold * cost.shield)

terumet.register_repairable_item("moreores:axe_mithril", mrv.mithril * cost.axe)
terumet.register_repairable_item("moreores:pick_mithril", mrv.mithril * cost.pick)
terumet.register_repairable_item("moreores:shovel_mithril", mrv.mithril * cost.shovel)
terumet.register_repairable_item("moreores:sword_mithril", mrv.mithril * cost.sword)
terumet.register_repairable_item("moreores:hoe_mithril", mrv.mithril * cost.hoe)
terumet.register_repairable_item("shields:shield_mithril", mrv.mithril * cost.shield)
terumet.register_repairable_item("farming:scythe_mithril", mrv.mithril * cost.scythe)
terumet.register_repairable_item("3d_armor:boots_mithril", mrv.mithril * cost.boots)
terumet.register_repairable_item("3d_armor:helmet_mithril", mrv.mithril * cost.helm)
terumet.register_repairable_item("3d_armor:leggings_mithril", mrv.mithril * cost.legs)
terumet.register_repairable_item("3d_armor:chestplate_mithril", mrv.mithril * cost.chest)

terumet.register_repairable_item("moreores:axe_silver", mrv.silver * cost.axe)
terumet.register_repairable_item("moreores:pick_silver", mrv.silver * cost.pick)
terumet.register_repairable_item("moreores:shovel_silver", mrv.silver * cost.shovel)
terumet.register_repairable_item("moreores:sword_silver", mrv.silver * cost.sword)
terumet.register_repairable_item("moreores:hoe_silver", mrv.silver * cost.hoe)

terumet.register_repairable_item("farming:hoe_steel", mrv.steel * cost.hoe)
terumet.register_repairable_item("shields:shield_steel", mrv.steel * cost.shield)
terumet.register_repairable_item("shields:shield_enhanced_wood", mrv.steel * 2)
terumet.register_repairable_item("shields:shield_enhanced_cactus", mrv.steel * 2)
terumet.register_repairable_item("gravelsieve:hammer", mrv.steel * 2)
terumet.register_repairable_item("mobs:shears", mrv.steel * 2)
terumet.register_repairable_item("xdecor:hammer", mrv.steel * 2)
terumet.register_repairable_item("fire:flint_and_steel", mrv.steel * 1)
terumet.register_repairable_item("screwdriver:screwdriver", mrv.steel * 1)
terumet.register_repairable_item("cottages:hammer", mrv.steel * 8)

terumet.register_repairable_item("titanium:axe", mrv.titanium * cost.axe)
terumet.register_repairable_item("titanium:pick", mrv.titanium * cost.pick)
terumet.register_repairable_item("titanium:shovel", mrv.titanium * cost.shovel)
terumet.register_repairable_item("titanium:sword", mrv.titanium * cost.sword)

terumet.register_repairable_item("titanium:sam_titanium", mrv.titanium * 8)
terumet.register_repairable_item("hangglider:hangglider", mrv.teruchalcum * 6)

terumet.register_repairable_item("mobs:lasso", mrv.diamond * 1)
terumet.register_repairable_item("mobs:net", mrv.diamond * 1)
terumet.register_repairable_item("fireflies:bug_net", mrv.diamond * 1)
