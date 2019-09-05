-- Honey bottle
minetest.register_node("bls:honey_bottle", {
    description = "Bottle of Honey",
    drawtype = "plantlike",
    tiles = {"bls_honey_bottle.png"},
    inventory_image = "bls_honey_bottle.png",
    paramtype = "light",
    is_ground_content = false,
    walkable = false,
    selection_box = {
        type = "fixed",
        fixed = {-0.25, -0.5, -0.25, 0.25, 0.3, 0.25}
    },
    groups = {food_honey = 1, food_sugar = 1, vessel = 1, dig_immediate = 3, attached_node = 1},
    on_use = minetest.item_eat(16, "vessels:glass_bottle")
})

minetest.register_craft({
    type = "shapeless",
    output = "bls:honey_bottle",
    recipe = {"vessels:glass_bottle", "xdecor:honey", "xdecor:honey", "xdecor:honey", "xdecor:honey", "xdecor:honey", "xdecor:honey", "xdecor:honey", "xdecor:honey"}
})


