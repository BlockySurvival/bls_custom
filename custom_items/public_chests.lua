local function make_formspec(width, height)
    return (
        "size[%i,%i;]" ..
        "list[context;main;0,0;%i,%i;]" ..
        "list[current_player;main;%i,%i;8,4;]" ..
        "listring[]"
    ):format(width, height + 5, width, height, (width - 8) / 2, height + 1)
end

local _TUBELIB_CALLBACKS = {
    on_pull_item = function(pos, side, player_name)
        local inv = minetest.get_meta(pos):get_inventory()
        for _, stack in pairs(inv:get_list("main")) do
            if not stack:is_empty() then
                return inv:remove_item("main", stack:get_name())
            end
        end
        return nil
    end,
    on_push_item = function(pos, side, item, player_name)
        local inv = minetest.get_meta(pos):get_inventory()
        if inv:room_for_item("main", item) then
            inv:add_item("main", item)
            return true
        end
        return false
    end,
    on_unpull_item = function(pos, side, item, player_name)
        local inv = minetest.get_meta(pos):get_inventory()
        if inv:room_for_item("main", item) then
            inv:add_item("main", item)
            return true
        end
        return false
    end,
}


local function make_public_chest(name, description, craft_from, width, height)
    local base_def = minetest.registered_nodes[craft_from]

    local def = {}
    def.description = description

    def.tiles = {}
    for i = 1, #base_def.tiles do
        def.tiles[i] = base_def.tiles[i] .. "^bls_pchest.png"
    end

    def.is_ground_content = false
    def.paramtype = "light"
    def.paramtype2 = "facedir"
    def.groups = {choppy = 2, oddly_breakable_by_hand = 2}
    def.on_construct = function(pos)
        local meta = minetest.get_meta(pos)
        meta:from_table(nil)
        meta:set_string("infotext", description)
        meta:set_string("formspec", make_formspec(width, height))

        local inv = meta:get_inventory()
        inv:set_size("main", width * height)
    end
    def.can_dig = function(pos, player)
        local meta = minetest.get_meta(pos)
        local inv = meta:get_inventory()
        return inv:is_empty("main")
    end
    def.on_blast = function(pos)
        local drops = {}
        default.get_inventory_drops(pos, "main", drops)
        drops[#drops+1] = name
        minetest.remove_node(pos)
        return drops
    end
    def.on_metadata_inventory_move = function(pos, from_list, from_index, to_list, to_index, count, player)
        bls.log("action",
                "%s moves stuff in %s at %s",
                player:get_player_name(),
                description:lower(),
                minetest.pos_to_string(pos)
        )
    end
    def.on_metadata_inventory_put = function(pos, listname, index, stack, player)
        bls.log("action",
                "%s puts %s in %s at %s",
                player:get_player_name(),
                stack:to_string(),
                description:lower(),
                minetest.pos_to_string(pos)
        )
    end
    def.on_metadata_inventory_take = function(pos, listname, index, stack, player)
        bls.log("action",
                "%s takes %s from %s at %s",
                player:get_player_name(),
                stack:to_string(),
                description:lower(),
                minetest.pos_to_string(pos)
        )
    end

    minetest.register_node(name, def)
    if minetest.global_exists("tubelib") then
        tubelib.register_node(name, {}, _TUBELIB_CALLBACKS)
    end

    minetest.register_craft({
        output = name,
        type = "shapeless",
        recipe = {craft_from}
    })
    minetest.register_craft({
        output = craft_from,
        type = "shapeless",
        recipe = {name}
    })
end

make_public_chest("bls:chest_public", "Public Chest", "default:chest",8, 4)
make_public_chest("bls:bookshelf_public", "Public Bookshelf", "default:bookshelf",8, 2)

if minetest.get_modpath("technic_chests") then
    make_public_chest("bls:iron_chest_public", "Iron Public Chest", "technic:iron_chest",9, 5)
    make_public_chest("bls:copper_chest_public", "Copper Public Chest", "technic:copper_chest",12, 5)
    make_public_chest("bls:gold_chest_public", "Gold Public Chest", "technic:gold_chest",15, 6)
    if minetest.get_modpath("moreores") then
        make_public_chest("bls:silver_chest_public", "Silver Public Chest", "technic:silver_chest",12, 6)
        make_public_chest("bls:mithril_chest_public", "Mithril Public Chest", "technic:mithril_chest",15, 6)
    end
end
