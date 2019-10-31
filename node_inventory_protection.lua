-- Make default:chests respect protection
local protected_nodes = {}

local function check(player, pos, item_name, action, node_name)
    local name = player:get_player_name()
    if minetest.is_protected(pos, name) then
        bls.log("action",
                "Denied %s %s %s from %s at %s",
                name,
                action,
                item_name,
                node_name,
                minetest.pos_to_string(pos))
        return false
    end
    return true
end

local default_can_interact_with_node = default.can_interact_with_node
function default.can_interact_with_node(player, pos)
    if default_can_interact_with_node(player, pos) then
        local node_name = minetest.get_node(pos).name
        if protected_nodes[node_name] then
            return check(player, pos, "", "interacting", node_name)
        else
            return true
        end
    else
        return false
    end
end

local function augment_with_protection(node_name)
    local old_def = minetest.registered_nodes[node_name]
    if not old_def then
        bls.log("warning", "can\"t augment %s with protection; no definition", node_name)
        return
    end
    protected_nodes[node_name] = true

    local old_allow_take = old_def.allow_metadata_inventory_take
    local old_allow_put = old_def.allow_metadata_inventory_put
    local old_allow_move = old_def.allow_metadata_inventory_move
    local function new_allow_take(pos, listname, index, stack, player)
        if not check(player, pos, stack:get_name(), "taking", node_name) then
            return 0
        elseif old_allow_take then
            return old_allow_take(pos, listname, index, stack, player)
        else
            return stack:get_count()
        end
    end
    local function new_allow_put(pos, listname, index, stack, player)
        if not check(player, pos, stack:get_name(), "putting", node_name) then
            return 0
        elseif old_allow_put then
            return old_allow_put(pos, listname, index, stack, player)
        else
            return stack:get_count()
        end
    end
    local function new_allow_move(pos, from_list, from_index, to_list, to_index, count, player)
        local meta  = minetest.get_meta(pos)
        local inv   = meta:get_inventory()
        local stack = inv:get_stack(from_list, from_index)

        if not check(player, pos, stack:get_name(), "moving", node_name) then
            return 0
        elseif old_allow_move then
            return old_allow_move(pos, from_list, from_index, to_list, to_index, count, player)
        else
            return count
        end
    end

    local def_override = {
        allow_metadata_inventory_take = new_allow_take,
        allow_metadata_inventory_put = new_allow_put,
        allow_metadata_inventory_move = new_allow_move
    }

    minetest.override_item(node_name, def_override)
end

augment_with_protection("default:chest")
augment_with_protection("default:chest_open")
augment_with_protection("default:bookshelf")

if minetest.get_modpath("technic_chests") then
    local COLORS = {
        "black", "blue", "brown", "cyan", "dark_green", "dark_grey", "green", "grey",
        "magenta", "orange", "pink", "red", "violet", "white", "yellow"
    }

    augment_with_protection("technic:iron_chest")
    augment_with_protection("technic:copper_chest")
    augment_with_protection("technic:silver_chest")
    augment_with_protection("technic:gold_chest")
    augment_with_protection("technic:mithril_chest")

    for _, color in pairs(COLORS) do
        augment_with_protection("technic:gold_chest_" .. color)
    end
end

if minetest.get_modpath("3d_armor_stand") then
    augment_with_protection("3d_armor_stand:armor_stand")
end

if minetest.get_modpath("cottages") then
    augment_with_protection("cottages:shelf")
end

if minetest.get_modpath("homedecor_bedroom") then
    augment_with_protection("homedecor:nightstand_mahogany_one_drawer")
    augment_with_protection("homedecor:nightstand_mahogany_two_drawers")
    augment_with_protection("homedecor:nightstand_oak_one_drawer")
    augment_with_protection("homedecor:nightstand_oak_two_drawers")
end
if minetest.get_modpath("homedecor_kitchen") then
    augment_with_protection("homedecor:kitchen_cabinet_granite")
    augment_with_protection("homedecor:kitchen_cabinet_half")
    augment_with_protection("homedecor:kitchen_cabinet")
    augment_with_protection("homedecor:kitchen_cabinet_marble")
    augment_with_protection("homedecor:kitchen_cabinet_steel")
    augment_with_protection("homedecor:kitchen_cabinet_with_sink")
    augment_with_protection("homedecor:microwave_oven")
    augment_with_protection("homedecor:microwave_oven_active")
    augment_with_protection("homedecor:oven")
    augment_with_protection("homedecor:oven_active")
    augment_with_protection("homedecor:oven_steel")
    augment_with_protection("homedecor:oven_steel_active")
    augment_with_protection("homedecor:refrigerator_steel")
    augment_with_protection("homedecor:refrigerator_white")
end
if minetest.get_modpath("homedecor_misc") then
    augment_with_protection("homedecor:cardboard_box")
    augment_with_protection("homedecor:cardboard_box_big")
    augment_with_protection("homedecor:tool_cabinet")
end
if minetest.get_modpath("homedecor_office") then
    augment_with_protection("homedecor:desk")
    augment_with_protection("homedecor:filing_cabinet")
end

if minetest.get_modpath("moremesecons_mesechest") then
    augment_with_protection("default:mesechest")
end

if minetest.get_modpath("scifi_nodes") then
    augment_with_protection("scifi_nodes:box")
end

if minetest.get_modpath("vessels") then
    augment_with_protection("vessels:shelf")
end

if minetest.get_modpath("xdecor") then
    augment_with_protection("xdecor:cabinet")
    augment_with_protection("xdecor:cabinet_half")
    augment_with_protection("xdecor:multishelf")
    augment_with_protection("xdecor:workbench")
end
