if minetest.global_exists("flowers") then
    -- old flower spread
    function flowers.flower_spread(pos, node)
        pos.y = pos.y - 1
        local under = minetest.get_node(pos)
        pos.y = pos.y + 1
        -- Replace flora with dry shrub in desert sand and silver sand,
        -- as this is the only way to generate them.
        -- However, preserve grasses in sand dune biomes.
        if minetest.get_item_group(under.name, "sand") == 1 and
                under.name ~= "default:sand" then
            minetest.set_node(pos, {name = "default:dry_shrub"})
            return
        end

        if minetest.get_item_group(under.name, "soil") == 0 then
            return
        end

        local light = minetest.get_node_light(pos)
        if not light or light < 13 then
            return
        end

        local pos0 = vector.subtract(pos, 4)
        local pos1 = vector.add(pos, 4)
        -- Testing shows that a threshold of 3 results in an appropriate maximum
        -- density of approximately 7 flora per 9x9 area.
        if #minetest.find_nodes_in_area(pos0, pos1, "group:flora") > 7 then
            return
        end

        local soils = minetest.find_nodes_in_area_under_air(
            pos0, pos1, "group:soil")
        local num_soils = #soils
        if num_soils >= 1 then
            for si = 1, math.min(3, num_soils) do
                local soil = soils[math.random(num_soils)]
                local soil_name = minetest.get_node(soil).name
                local soil_above = {x = soil.x, y = soil.y + 1, z = soil.z}
                light = minetest.get_node_light(soil_above)
                if light and light >= 13 and
                        -- Only spread to same surface node
                        soil_name == under.name and
                        -- Desert sand is in the soil group
                        soil_name ~= "default:desert_sand" then
                    minetest.set_node(soil_above, {name = node.name})
                end
            end
        end
    end
end
