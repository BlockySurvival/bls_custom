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

local spread_delay = tonumber(minetest.settings:get("bls.pro_aid.spread_delay")) or 0.2
local spread_extent = tonumber(minetest.settings:get("bls.pro_aid.spread_extent")) or 5
local visible_time = tonumber(minetest.settings:get("bls.pro_aid.visible_time")) or 4

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

local function swap_neighbors(pos, count)
    return function()
        if count == 0 then
            return
        end

        local pos1 = vector.subtract(pos, vector.new(1, 1, 1))
        local pos2 = vector.add(pos, vector.new(1, 1, 1))
        local posses = minetest.find_nodes_in_area(pos1, pos2, {"bls:pro_aid_wall", "bls:pro_aid_air"})

        for _, next_pos in ipairs(posses) do
            local node = minetest.get_node(next_pos)
            node.name = node.name .. "_visible"
            minetest.swap_node(next_pos, node)
            local timer = minetest.get_node_timer(next_pos)
            if not timer:is_started() then
                timer:start(visible_time)
            end
            if count > 1 then
                minetest.after(spread_delay, swap_neighbors(next_pos, count - 1))
            end
        end
    end
end

minetest.register_tool("bls:pro_aid_remover", {
    description = "Protection aid remover",
    inventory_image = "bls_pro_aid_remover_item.png",
    range = 8,
    node_dig_prediction = "",
    on_use = function(itemstack, user, pointed_thing)
        if pointed_thing.type ~= "node" then
            return
        elseif not minetest.is_player(user) then
            return
        end

        local pos = pointed_thing.under
        local node = minetest.get_node(pos)

        if not (node.name == "bls:pro_aid_wall" or
                node.name == "bls:pro_aid_wall_visible" or
                node.name == "bls:pro_aid_air" or
                node.name == "bls:pro_aid_air_visible") then
            return
        end

        local username = user:get_player_name()

        if areas:canInteract(pos, username) then
            minetest.remove_node(pos)

            -- only give back item if it's in your area
            if is_owner(user, pos) then
                local privs = minetest.get_player_privs(username)
                local inv = user:get_inventory()
                -- don't give to creative if they already have it
                if not (privs.creative or privs.give) then
                    local to_give = node.name
                    if to_give == "bls:pro_aid_wall_visible" then
                        to_give = "bls:pro_aid_wall"
                    elseif to_give == "bls:pro_aid_air_visible" then
                        to_give = "bls:pro_aid_air"
                    end

                    local remaining = inv:add_item("main", to_give)

                    if not remaining:is_empty() then
                        minetest.item_drop(remaining, user, pos)
                    end
                end
            end

            minetest.sound_play("default_dug_node", {
                to_player = username,
            }, true)
        end
    end,
})

local function is_wielding_tool(player)
    local tool_name = player:get_wielded_item():get_name()
    return (
        tool_name == "bls:pro_aid_remover" or
        tool_name == "maptools:pick_admin" or
        tool_name == "maptools:pick_admin_with_drops"
    )
end

local image_name = "default_obsidian_glass.png"
local cube_spec = minetest.inventorycube(image_name, image_name, image_name)

local wall_def = {
    description = "Protection Aid (impassable)",
    inventory_image = cube_spec,
    wield_image = cube_spec,
    range = 8,

    drawtype = "airlike",
    paramtype = "light",

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
    node_placement_prediction = "bls:pro_aid_wall_visible",

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
        if is_wielding_tool(puncher) then
            return minetest.node_punch(pos, node, puncher, pointed_thing)
        end

        node.name = node.name .. "_visible"
        minetest.swap_node(pos, node)
        local timer = minetest.get_node_timer(pos)
        if not timer:is_started() then
            timer:start(visible_time)
        end
        minetest.after(spread_delay, swap_neighbors(pos, spread_extent))
    end,

    on_blast = function() end,
}

minetest.register_node("bls:pro_aid_wall", wall_def)

local air_def = table.copy(wall_def)
air_def.description = "Protection Aid (airlike)"
air_def.walkable = false
air_def.drowning = 0
air_def.damage_per_second = 0
air_def.node_placement_prediction = "bls:pro_aid_wall_visible"

minetest.register_node("bls:pro_aid_air", air_def)

local wall_visible_def = table.copy(wall_def)
wall_visible_def.groups = {not_in_creative_inventory = 1}
wall_visible_def.drawtype = "glasslike"
wall_visible_def.tiles = {{
    name = "bls_pro_aid_animated.png",
    animation = {
            type = "vertical_frames",
            aspect_w = 16,
            aspect_h = 16,
            length = 1.0,
    },
}}
wall_visible_def.use_texture_alpha = true
wall_visible_def.on_timer = function(pos, elapsed)
    local node = minetest.get_node(pos)
    node.name = "bls:pro_aid_wall"
    minetest.swap_node(pos, node)
end
wall_visible_def.on_punch = function(pos, node, puncher, pointed_thing)
    if is_wielding_tool(puncher) then
        return minetest.node_punch(pos, node, puncher, pointed_thing)
    end

    node.name = "bls:pro_aid_wall"
    minetest.swap_node(pos, node)
    local timer = minetest.get_node_timer(pos)
    if timer:is_started() then
        timer:stop()
    end
end

minetest.register_node("bls:pro_aid_wall_visible", wall_visible_def)

local air_visible_def = table.copy(air_def)
air_visible_def.groups = {not_in_creative_inventory = 1}
air_visible_def.drawtype = "glasslike"
air_visible_def.tiles = {{
    name = "bls_pro_aid_animated.png^[brighten",
    animation = {
            type = "vertical_frames",
            aspect_w = 16,
            aspect_h = 16,
            length = 1.0,
    },
}}
air_visible_def.use_texture_alpha = true
air_visible_def.on_timer = function(pos, elapsed)
    local node = minetest.get_node(pos)
    node.name = "bls:pro_aid_air"
    minetest.swap_node(pos, node)
end
air_visible_def.on_punch = function(pos, node, puncher, pointed_thing)
    if is_wielding_tool(puncher) then
        return minetest.node_punch(pos, node, puncher, pointed_thing)
    end

    node.name = "bls:pro_aid_air"
    minetest.swap_node(pos, node)
    local timer = minetest.get_node_timer(pos)
    if timer:is_started() then
        timer:stop()
    end
end

minetest.register_node("bls:pro_aid_air_visible", air_visible_def)

minetest.register_craft({
    output = "bls:pro_aid_remover",
    recipe = {
        {"",              "bls:pro_aid_wall"},
        {"default:stick", ""},
    }
})


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
    mesecon.register_mvps_stopper("bls:pro_aid_air")
    mesecon.register_mvps_stopper("bls:pro_aid_wall")
end


minetest.register_lbm({
    label = "ensure pro nodes are invisible in case of crash",
    name = "bls:make_pro_nodes_invisible",
    nodenames = {"bls:pro_aid_wall_visible", "bls:pro_aid_air_visible"},
    run_at_every_load = true,
    action = function(pos, node)
        if node.name == "bls:pro_aid_wall_visible" then
            node.name = "bls:pro_aid_wall"
        elseif node.name == "bls:pro_aid_air_visible" then
            node.name = "bls:pro_aid_air"
        end
        minetest.swap_node(pos, node)
        local timer = minetest.get_node_timer(pos)
        if timer:is_started() then
            timer:stop()
        end
    end,
})
