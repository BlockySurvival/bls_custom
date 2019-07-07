local get_modpath = minetest.get_modpath

-- dummy ATM for decoration
if get_modpath('lurkcoin') and get_modpath('default') and get_modpath('dye') then
    minetest.register_node(':lurkcoin:dummy_atm', {
        description = 'Dummy ATM',
        groups = {cracky = 1},
        tiles = {'lurkcoin_atm_side.png', 'lurkcoin_atm_side.png',
            'lurkcoin_atm_side.png', 'lurkcoin_atm_side.png',
            'lurkcoin_atm_side.png', 'lurkcoin_atm_side.png^lurkcoin_atm_top.png'},
        paramtype2 = 'facedir',
    })
    minetest.register_craft({
        output = "lurkcoin:dummy_atm",
        type = "shapeless",
            recipe = {'default:steelblock', 'dye:blue'},
    })
end

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


-- Trap stone
minetest.register_node("bls:fake_stone", {
    description = "Fake Stone",
    tiles = {"default_stone.png"},
    walkable = false,
    groups = {cracky = 3, stone = 1, not_in_creative_inventory=1},
})

-- Marble
local marble = {
    description = "Marble",
    tiles = {"bls_marble.png"},
    groups = {cracky = 3}
}
minetest.register_node("bls:marble", marble)
stairsplus:register_all("bls", "marble", "bls:marble", marble)
minetest.register_craft({
    type = "cooking",
    output = "bls:marble",
    recipe = "default:stone",
    cooktime = 5
})

local marble_block = {
    description = "Marble Block",
    tiles = {"bls_marble_block.png"},
    groups = {cracky = 3}
}
minetest.register_node("bls:marble_block", marble_block)
stairsplus:register_all("bls", "marble_block", "bls:marble_block", marble_block)
minetest.register_craft({
    output = "bls:marble_block 9",
    recipe = {{"bls:marble", "bls:marble", "bls:marble"},
              {"bls:marble", "bls:marble", "bls:marble"},
              {"bls:marble", "bls:marble", "bls:marble"}}
})

local marble_mini_brick = {
    description = "Marble Mini-Brick",
    tiles = {"bls_marble_mini_brick.png"},
    groups = {cracky = 3}
}
minetest.register_node("bls:marble_mini_brick", marble_mini_brick)
stairsplus:register_all("bls", "marble_mini_brick", "bls:marble_mini_brick", marble_mini_brick)
minetest.register_craft({
    type = "shapeless",
    output = "bls:marble_mini_brick 4",
    recipe = {"bls:marble", "bls:marble", "bls:marble", "bls:marble"}
})

local marble_base = {
    description = "Marble Base",
    tiles = {"bls_marble_base.png"},
    groups = {cracky = 3}
}
minetest.register_node("bls:marble_base", marble_base)
stairsplus:register_all("bls", "marble_base", "bls:marble_base", marble_base)
minetest.register_craft({
    output = "bls:marble_base 2",
    recipe = {{"bls:marble", "bls:marble"}}
})

local marble_column = {
    description = "Marble Column",
    tiles = {"bls_marble.png", "bls_marble.png", "bls_marble_column.png", "bls_marble_column.png", "bls_marble_column.png", "bls_marble_column.png"},
    groups = {cracky = 3}
}
minetest.register_node("bls:marble_column", marble_column)
stairsplus:register_all("bls", "marble_column", "bls:marble_column", marble_column)
minetest.register_craft({
    output = "bls:marble_column 3",
    recipe = {{"bls:marble", "", ""}, {"bls:marble", "", ""}, {"bls:marble", "", ""}}
})

-- Marble pillars
minetest.register_node("bls:marble_pillar", {
    description = "Marble Pillar",
    drawtype = "nodebox",
    tiles = {"bls_marble.png"},
    paramtype = "light",
    paramtype2 = "facedir",
    sunlight_propagates = true,
    is_ground_content = true,
    groups = group,
    node_box = {
        type = "fixed",
        fixed = {
            {-0.5, -0.5, -0.1875, 0.5, 0.5, 0.1875},
            {-0.4375, -0.5, -0.3125, 0.4375, 0.5, 0.3125},
            {-0.375, -0.5, -0.375, 0.375, 0.5, 0.375},
            {-0.3125, -0.5, -0.4375, 0.3125, 0.5, 0.4375},
            {-0.1875, -0.5, -0.5, 0.1875, 0.5, 0.5},
        }
    },
    selection_box = {
        type = "fixed",
        fixed = {
            {-0.5,-0.5,-0.5,0.5,0.5,0.5},
        }
    },
    on_place = minetest.rotate_node,
    groups = {cracky = 3}
})
minetest.register_craft({
    type = "shapeless",
    output = "bls:marble_pillar",
    recipe = {"bls:marble_column"}
})

minetest.register_node("bls:marble_pillar_base", {
    description = "Marble Pillar Base",
    drawtype = "nodebox",
    tiles = {"bls_marble.png"},
    paramtype = "light",
    paramtype2 = "facedir",
    sunlight_propagates = true,
    is_ground_content = true,
    groups = group,
    node_box = {
        type = "fixed",
        fixed = {
            {-0.5, -0.5, -0.1875, 0.5, 0.5, 0.1875},
            {-0.4375, -0.5, -0.3125, 0.4375, 0.5, 0.3125},
            {-0.375, -0.5, -0.375, 0.375, 0.5, 0.375},
            {-0.3125, -0.5, -0.4375, 0.3125, 0.5, 0.4375},
            {-0.1875, -0.5, -0.5, 0.1875, 0.5, 0.5},
            {-0.5, -0.5, -0.5, 0.5, -0.1875, 0.5},
        }
    },
    selection_box = {
        type = "fixed",
        fixed = {
            {-0.5,-0.5,-0.5,0.5,0.5,0.5},
        }
    },
    on_place = minetest.rotate_node,
    groups = {cracky = 3}
})
minetest.register_craft({
    type = "shapeless",
    output = "bls:marble_pillar_base 2",
    recipe = {"bls:marble_pillar", "bls:marble"}
})
