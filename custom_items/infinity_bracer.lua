armor:register_armor("bls:infinity_bracer", {
    description = "Infinity Bracer",
    inventory_image = "bls_infinity_bracer_inv.png",
    texture = "bls_infinity_bracer_armor.png",
    preview = "bls_infinity_bracer_preview.png",
    groups = {
        armor_terumet_brcr = 1,
        not_in_creative_inventory = 1,
        armor_use = 0,
        armor_heal = 10,
        armor_water = 1,
        armor_fire = 99,
        physics_speed = 0.8,
        physics_gravity = -0.5,
        physics_jump = 0.5,
    },
    armor_groups = {fleshy = 0},
    damage_groups = {cracky=3, snappy=3, choppy=3, crumbly=3, level=1}
})

armor:register_armor("bls:flux_bracer", {
    description = "Flux's Bracer",
    inventory_image = "bls_infinity_bracer_inv.png",
    texture = "bls_infinity_bracer_armor.png",
    preview = "bls_infinity_bracer_preview.png",
    groups = {
        armor_terumet_brcr = 1,
        not_in_creative_inventory = 1,
        armor_use = 0,
        armor_heal = 0,
        physics_speed = 0.5,
        physics_jump = 0.8,
        physics_gravity = 0.5,
    },
    armor_groups = {fleshy = 0},
})
