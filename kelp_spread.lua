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
