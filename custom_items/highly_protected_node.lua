-- unglitchable
-- mvps stopper
-- disable bang
-- murders intruders
-- invisible but pointable
-- not too expensive to make, but not for new players (e.g. made from titanium, but cheap)

-- only placable in protected areas
-- instantly breakable w/ no drop in unprotected areas
-- instantly breakable w/ drop by someone allowed to in protected areas

if not (minetest.get_modpath("areas") and areas) then return end

local image_name = "default_obsidian_glass.png"
local cube_spec = minetest.inventorycube(image_name, image_name, image_name)

local function is_owner(player, pos)
    if minetest.check_player_privs(player, "areas") then
        return true
    end
    local player_name = player:get_player_name()
    for _, owner_name in ipairs(areas:getNodeOwners(pos)) do
        if owner_name == player_name then
            return true
        end
    end
    return false
end

local node_def = {
    description = "Protection Aid (impassable)",
    inventory_image = cube_spec,
    wield_image = cube_spec,
    range = 8,

    drawtype = "airlike",

    is_ground_content = false,
    sunlight_propagates = true,
    walkable = true,
    pointable = true,
    diggable = false,
    climbable = false,
    buildable_to = false,
    floodable = false,
    drowning = 10,
    damage_per_second = 10,

    node_dig_prediction = "",
    node_placement_prediction = "",

    on_place = function(itemstack, placer, pointed_thing)
        local placer_name = placer:get_player_name()
        local pos = minetest.get_pointed_thing_position(pointed_thing, true)
        local owns_spot = is_owner(placer, pos)
        local players_inside = false
        if not minetest.check_player_privs(placer, "server") then
            for _, obj in ipairs(minetest.get_objects_inside_radius(pos, 0.75)) do
                if obj:is_player() then
                    players_inside = true
                    break
                end
            end
            if not players_inside then
                -- check position below (player's feet)
                local pos_below = vector.new(pos.x, pos.y - 1, pos.z)
                for _, obj in ipairs(minetest.get_objects_inside_radius(pos_below, 0.75)) do
                    if obj:is_player() then
                        players_inside = true
                        break
                    end
                end
            end
        end

        if owns_spot and not players_inside then
            return minetest.item_place(itemstack, placer, pointed_thing)
        else
            minetest.chat_send_player(placer_name, "can only be placed in your areas, and not on a player")
            return itemstack
        end
    end,

    on_punch = function(pos, node, puncher, pointed_thing)
        local puncher_name = puncher:get_player_name()
        if areas:canInteract(pos, puncher_name) then
            minetest.remove_node(pos)

            -- only give back item if it's in your area
            if is_owner(puncher, pos) then
                local privs = minetest.get_player_privs(puncher_name)
                local inv = puncher:get_inventory()
                -- don't give to creative if they already have it
                if not((privs.creative or privs.give) and inv:contains_item("main", node.name)) then
                    local remaining = inv:add_item("main", node.name)

                    if remaining and not remaining:is_empty() then
                        minetest.item_drop(remaining, puncher, pos)
                    end
                end
            end

            minetest.sound_play("default_dug_node", {
                to_player = puncher_name,
            }, true)
        end
    end,

    on_blast = function() end,
}

minetest.register_node("bls:pro_aid_wall", node_def)

node_def = table.copy(node_def)
node_def.description = "Protection Aid (airlike)"
node_def.walkable = false
node_def.drowning = 0
node_def.damage_per_second = 0

minetest.register_node("bls:pro_aid_air", node_def)

minetest.register_craft({
    output = "bls:pro_aid_wall 99",
    type = "shapeless",
    recipe = {"titanium:glass"},
})

minetest.register_craft({
    output = "bls:pro_aid_air",
    type = "shapeless",
    recipe = {"bls:pro_aid_wall"},
})

minetest.register_craft({
    output = "bls:pro_aid_wall",
    type = "shapeless",
    recipe = {"bls:pro_aid_air"},
})

if minetest.global_exists("mesecon") and mesecon.register_mvps_stopper then
    mesecon.register_mvps_stopper("bls:highly_protected")
end
