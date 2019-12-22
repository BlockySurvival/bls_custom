-- water for builders, that doesn't freeze in winter

minetest.register_node("bls:water_source", {
    description = "Builder Water Source",
    drawtype = "liquid",
    waving = 3,
    tiles = {{
            name = "default_water_source_animated.png",
            backface_culling = false,
            animation = {
                type = "vertical_frames",
                aspect_w = 16,
                aspect_h = 16,
                length = 2.0,
            },
        }, {
            name = "default_water_source_animated.png",
            backface_culling = true,
            animation = {
                type = "vertical_frames",
                aspect_w = 16,
                aspect_h = 16,
                length = 2.0,
            },
        },
    },
    alpha = 191,
    paramtype = "light",
    walkable = false,
    pointable = false,
    diggable = false,
    buildable_to = true,
    is_ground_content = false,
    drop = "",
    drowning = 1,
    liquidtype = "source",
    liquid_alternative_flowing = "bls:water_flowing",
    liquid_alternative_source = "bls:water_source",
    liquid_viscosity = 1,
    liquid_renewable = false,
    post_effect_color = { a = 103, r = 30, g = 60, b = 90 },
    groups = { liquid = 3, not_in_creative_inventory = 1 },
    sounds = default.node_sound_water_defaults(),
})

minetest.register_node("bls:water_flowing", {
    description = "Flowing Builder Water",
    drawtype = "flowingliquid",
    waving = 3,
    tiles = { "default_water.png" },
    special_tiles = {
        {
            name = "default_water_flowing_animated.png",
            backface_culling = false,
            animation = {
                type = "vertical_frames",
                aspect_w = 16,
                aspect_h = 16,
                length = 0.8,
            },
        },
        {
            name = "default_water_flowing_animated.png",
            backface_culling = true,
            animation = {
                type = "vertical_frames",
                aspect_w = 16,
                aspect_h = 16,
                length = 0.8,
            },
        },
    },
    alpha = 191,
    paramtype = "light",
    paramtype2 = "flowingliquid",
    walkable = false,
    pointable = false,
    diggable = false,
    buildable_to = true,
    is_ground_content = false,
    drop = "",
    drowning = 1,
    liquidtype = "flowing",
    liquid_alternative_flowing = "bls:water_flowing",
    liquid_alternative_source = "bls:water_source",
    liquid_viscosity = 1,
    liquid_renewable = false,
    post_effect_color = { a = 103, r = 30, g = 60, b = 90 },
    groups = { liquid = 3, not_in_creative_inventory = 1 },
    sounds = default.node_sound_water_defaults(),
})


bucket.register_liquid(
    "bls:water_source",
    "bls:water_flowing",
    "bls:bucket_water",
    "bucket_water.png",
    "Builder Water Bucket",
    {tool = 1, not_in_creative_inventory = 1}
)
