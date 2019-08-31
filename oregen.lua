minetest.override_item("default:steel_ingot", {
	inventory_image = "default_steel_ingot.png",
})

minetest.register_ore({
    ore_type = "sheet",
    ore = "default:clay",
    wherein = "default:stone",
    clust_scarcity = 1,
    clust_num_ores = 1,
    clust_size = 3,
    y_min = -25000,
    y_max = -50,
    noise_threshold = 0.4,
    noise_params = {
        offset = 0, scale = 15, spread = {x = 150, y = 150, z = 150},
        seed = 23, octaves = 3, persist = 0.70
    }
})

minetest.register_ore({
    ore_type = "sheet",
    ore = "bls:marble",
    wherein = "default:stone",
    clust_scarcity = 1,
    clust_num_ores = 1,
    clust_size = 3,
    y_min = -25000,
    y_max = -50,
    noise_threshold = 0.4,
    noise_params = {
        offset = 0, scale = 15, spread = {x = 150, y = 150, z = 150},
        seed = 23, octaves = 3, persist = 0.70
    }
})

minetest.register_ore({
    ore_type = "sheet",
    ore = "building_blocks:Marble",
    wherein = "default:stone",
    clust_scarcity = 1,
    clust_num_ores = 1,
    clust_size = 3,
    y_min = -25000,
    y_max = -50,
    noise_threshold = 0.4,
    noise_params = {
        offset = 0, scale = 15, spread = {x = 150, y = 150, z = 150},
        seed = 23, octaves = 3, persist = 0.70
    }
})

minetest.register_ore({
    ore_type = "sheet",
    ore = "default:desert_sandstone",
    wherein = "default:stone",
    clust_scarcity = 1,
    clust_num_ores = 1,
    clust_size = 3,
    y_min = -25000,
    y_max = -50,
    noise_threshold = 0.4,
    noise_params = {
        offset = 0, scale = 15, spread = {x = 150, y = 150, z = 150},
        seed = 23, octaves = 3, persist = 0.70
    }
})

minetest.register_ore({
    ore_type = "sheet",
    ore = "default:sandstone",
    wherein = "default:stone",
    clust_scarcity = 1,
    clust_num_ores = 1,
    clust_size = 3,
    y_min = -25000,
    y_max = -50,
    noise_threshold = 0.4,
    noise_params = {
        offset = 0, scale = 15, spread = {x = 150, y = 150, z = 150},
        seed = 23, octaves = 3, persist = 0.70
    }
})

minetest.register_ore({
    ore_type = "sheet",
    ore = "default:silver_sandstone",
    wherein = "default:stone",
    clust_scarcity = 1,
    clust_num_ores = 1,
    clust_size = 3,
    y_min = -25000,
    y_max = -50,
    noise_threshold = 0.4,
    noise_params = {
        offset = 0, scale = 15, spread = {x = 150, y = 150, z = 150},
        seed = 23, octaves = 3, persist = 0.70
    }
})

minetest.register_ore({
    ore_type = "sheet",
    ore = "default:coral_skeleton",
    wherein = "default:stone",
    clust_scarcity = 1,
    clust_num_ores = 1,
    clust_size = 3,
    y_min = -25000,
    y_max = -50,
    noise_threshold = 0.4,
    noise_params = {
        offset = 0, scale = 15, spread = {x = 150, y = 150, z = 150},
        seed = 23, octaves = 3, persist = 0.70
    }
})

minetest.register_ore({
    ore_type = "sheet",
    ore = "default:desert_stone",
    wherein = "default:stone",
    clust_scarcity = 1,
    clust_num_ores = 1,
    clust_size = 3,
    y_min = -25000,
    y_max = -50,
    noise_threshold = 0.4,
    noise_params = {
        offset = 0, scale = 15, spread = {x = 150, y = 150, z = 150},
        seed = 23, octaves = 3, persist = 0.70
    }
})

minetest.register_ore({
    ore_type = "sheet",
    ore = "default:obsidian",
    wherein = "default:stone",
    clust_scarcity = 1,
    clust_num_ores = 1,
    clust_size = 3,
    y_min = -25000,
    y_max = -1000,
    noise_threshold = 0.4,
    noise_params = {
        offset = 0, scale = 15, spread = {x = 150, y = 150, z = 150},
        seed = 23, octaves = 3, persist = 0.70
    }
})

minetest.register_ore({
    ore_type = "sheet",
    ore = "default:dirt",
    wherein = "default:stone",
    clust_scarcity = 1,
    clust_num_ores = 1,
    clust_size = 3,
    y_min = -25000,
    y_max = -50,
    noise_threshold = 0.4,
    noise_params = {
        offset = 0, scale = 15, spread = {x = 150, y = 150, z = 150},
        seed = 23, octaves = 3, persist = 0.70
    }
})
