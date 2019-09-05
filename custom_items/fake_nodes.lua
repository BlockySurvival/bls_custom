-- Trap stone
minetest.register_node("bls:fake_stone", {
    description = "Fake Stone",
    tiles = {"default_stone.png"},
    walkable = false,
    groups = {cracky = 3, stone = 1, not_in_creative_inventory=1},
})

