minetest.register_node(":maptools:clean_glass", {
        description = "Unbreakable Clean Glass",
        range = 12,
        stack_max = 10000,
        drawtype = "glasslike_framed_optional",
        tiles = {"moreblocks_clean_glass.png", "moreblocks_clean_glass_detail.png"},
        paramtype = "light",
        sunlight_propagates = true,
        is_ground_content = false,
        drop = "",
        groups = {unbreakable = 1, not_in_creative_inventory = maptools.creative},
        sounds = default.node_sound_glass_defaults(),
        on_drop = maptools.drop_msg
})
