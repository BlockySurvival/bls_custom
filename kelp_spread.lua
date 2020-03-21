local spread_radius = 4
local spread_density = 12
local max_poss_to_consider = 5
local required_water_column = 6

local function check_column(base_pos)
    for i = 1, required_water_column do
        local pos = vector.add(base_pos, vector.new(0, i, 0))
        local node_info = minetest.get_node(pos)
        local node_light = minetest.get_node_light(pos)
        if node_info.name ~= "default:water_source" then return false end
        if node_light == 0 then return false end
    end
    return true
end

minetest.register_abm({
    label = "kelp spread",
    nodenames = {"default:sand_with_kelp"},
    interval = 37,
    chance = 100,
    action = function(pos, node, active_object_count, active_object_count_wider)
        -- y between -5 and -10 w/ offset -1 (so y = -6 to y = -10)
        local pos0 = vector.subtract(pos, spread_radius)
        local pos1 = vector.add(pos, spread_radius)
        if #minetest.find_nodes_in_area(pos0, pos1, "default:sand_with_kelp") > spread_density then
            return
        end
        local potential_poss = minetest.find_nodes_in_area(pos0, pos1, "default:sand")
        local poss_considered = 0
        while #potential_poss > 0 and poss_considered < max_poss_to_consider do
            local i = math.random(#potential_poss)
            local ppos = table.remove(potential_poss, i)
            if check_column(ppos) then
                local param2 = math.random(48, 96)
                minetest.set_node(ppos, {name = "default:sand_with_kelp", param2 = param2})
            end
            poss_considered = poss_considered + 1
        end
    end,
})

local function distance_to_air(pos)
    for i = 0, 10 do
        local npos = vector.add(pos, vector.new(0, i, 0))
        local node_info = minetest.get_node(npos)
        if node_info.name == "air" then return i end
    end
    return 11
end

local function distance_to_sand(pos)
    for i = 0, 10 do
        local npos = vector.subtract(pos, vector.new(0, i, 0))
        local node_info = minetest.get_node(npos)
        if node_info.name == "default:sand" then return i end
    end
    return 11
end

minetest.register_abm({
    label = "coral spread",
    nodenames = {"default:water_source", "default:coral_skeleton"},
    neighbors = {"default:coral_brown", "default:coral_orange"},
    interval = 47,
    chance = 80,
    action = function(pos, node, active_object_count, active_object_count_wider)
        if minetest.get_node_light(pos) == 0 then return end
        local dta = distance_to_air(pos)
        local dts = distance_to_sand(pos)
        if 1 >= dta or dta > 8 or dts > 5 then return end

        local pos0 = vector.subtract(pos, 1)
        local pos1 = vector.add(pos, 1)
        local num_neighbors = #minetest.find_nodes_in_area(pos0, pos1,
                {
                    "default:coral_brown",
                    "default:coral_orange",
                    "default:coral_skeleton",
                    "default:coral_cyan",
                    "default:coral_pink",
                    "default:coral_green",
                }
        )
        if num_neighbors >= 4 then
            local pos_below = vector.subtract(pos, vector.new(0, 1, 0))
            local name_below = minetest.get_node(pos_below).name
            if name_below == "default:sand" or name_below == "default:coral_skeleton" then
                local rv = math.random(3)
                if rv == 1 then
                    minetest.set_node(pos, {name = "default:coral_cyan"})
                elseif rv == 2 then
                    minetest.set_node(pos, {name = "default:coral_pink"})
                elseif rv == 3 then
                    minetest.set_node(pos, {name = "default:coral_green"})
                end
            else
                if minetest.get_node(pos).name == "default:coral_skeleton" then
                    minetest.set_node(pos, {name = "default:coral_brown"})
                else
                    minetest.set_node(pos, {name = "default:coral_orange"})
                end
            end
        end
    end,
})

minetest.register_abm({
    label = "coral blobbing",
    nodenames = {"default:coral_green", "default:coral_cyan", "default:coral_pink"},
    neighbors = {"default:water_source", "default:water_flowing"},
    interval = 49,
    chance = 40,
    action = function(pos, node, active_object_count, active_object_count_wider)
        local pos_above = vector.add(pos, vector.new(0, 1, 0))
        local name_above = minetest.get_node(pos_above).name
        if name_above == "default:coral_green" or name_above == "default:coral_cyan" or name_above == "default:coral_pink" or name_above == "default:coral_brown" or name_above == "default:coral_orange" or name_above == "default:coral_skeleton" then
            minetest.set_node(pos, {name = "default:coral_orange"})
            return
        end
        local pos_below = vector.subtract(pos, vector.new(0, 1, 0))
        local name_below = minetest.get_node(pos_below).name
        if name_below == "default:water_source" then
            minetest.set_node(pos, {name = "default:water_source"})
            return
        end
    end,
})

minetest.register_abm({
    label = "coral death",
    nodenames = {"default:coral_brown", "default:coral_orange"},
    interval = 51,
    chance = 40,
    action = function(pos, node, active_object_count, active_object_count_wider)
        local dta = distance_to_air(pos)
        local dts = distance_to_sand(pos)
        if 1 >= dta or dta > 8 or dts > 5 then
            minetest.set_node(pos, {name = "default:water_source"})
            return
        end
        local pos0 = vector.subtract(pos, 2)
        local pos1 = vector.add(pos, 2)
        local num_neighbors = #minetest.find_nodes_in_area(pos0, pos1,
                {
                    "default:coral_brown",
                    "default:coral_orange",
                    "default:coral_skeleton",
                    "default:coral_cyan",
                    "default:coral_pink",
                    "default:coral_green",
                }
        )
        local node_name = minetest.get_node(pos).name
        if 2 >= num_neighbors or num_neighbors >= 27 then
            minetest.set_node(pos, {name = "default:water_source"})
        elseif node_name == "default:coral_orange" then
            minetest.set_node(pos, {name = "default:coral_brown"})
        elseif node_name == "default:coral_brown" then
            if math.random(10) == 1 then
                minetest.set_node(pos, {name = "default:coral_skeleton"})
            end
        end
    end,
})

minetest.register_abm({
    label = "coral skeleton erosion",
    nodenames = {"default:coral_skeleton"},
    neighbors = {"default:water_source", "default:water_flowing"},
    interval = 53,
    chance = 100,
    action = function(pos, node, active_object_count, active_object_count_wider)
        minetest.set_node(pos, {name = "default:water_source"})
    end,
})
