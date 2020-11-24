if not minetest.get_modpath("default") then return end

local function set_formspec(meta)
    meta:set_string("formspec",
        "size[8,10;]"..
        "list[context;recipe;0,0;3,3;]"..
        "list[context;out;5,0;3,3;]"..
        "list[context;main;0,3;8,2;]"..
        "list[current_player;main;0,6;8,4;]"..
        default.gui_bg..
        default.gui_bg_img..
        default.gui_slots
    )
end

local function on_construct(pos)
    local meta = minetest.get_meta(pos)
    local inv = meta:get_inventory()
    inv:set_size("main", 8*2)
    inv:set_size("recipe", 3*3)
    inv:set_size("out", 3*3)
    set_formspec(meta)
end

local function on_receive_fields(pos, formname, fields, sender) end

local function allow_metadata_inventory_move(pos, from_list, from_index, to_list, to_index, count, player) end
local function allow_metadata_inventory_put(pos, listname, index, stack, player) end
local function allow_metadata_inventory_take(pos, listname, index, stack, player) end
local function on_metadata_inventory_move() end
local function on_metadata_inventory_put(pos, listname, index, stack, player) end
local function on_metadata_inventory_take(pos, listname, index, stack, player) end

minetest.register_node("bls:crafting_table", {
    description = "Crafting Table",
    paramtype = "light",
    paramtype2 = "facedir",
    groups = {cracky = 2, choppy = 2, oddly_breakable_by_hand = 1, flammable = 2},
    sounds = default.node_sound_wood_defaults(),
    groups = {dig_immediate = 3},
    tiles = {
        "bls_crafting_table_top.png",
        "bls_crafting_table_top.png",
        "bls_crafting_table_sides.png",
        "bls_crafting_table_sides.png",
        "bls_crafting_table_front.png",
        "bls_crafting_table_front.png"
    },
    on_construct = on_construct,
    --on_receive_fields = on_receive_fields,
    --on_metadata_inventory_put = on_metadata_inventory_put,
    --on_metadata_inventory_take = on_metadata_inventory_take,
    --allow_metadata_inventory_put = allow_metadata_inventory_put,
    --allow_metadata_inventory_move = allow_metadata_inventory_move
})
