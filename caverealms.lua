if not minetest.get_modpath("caverealms") then return end

-- Copied and modified from https://github.com/Ezhh/caverealms_lite/blob/master/plants.lua
-- spread moss/lichen/algae to nearby cobblestone
minetest.register_abm({
	label = "Caverealms stone spread",
	nodenames = {
		"caverealms:stone_with_moss",
		"caverealms:stone_with_lichen",
		"caverealms:stone_with_algae",
	},
	neighbors = {"air"},
	interval = 60,
	chance = 10,
	catch_up = false,
	action = function(pos, node)
		-- Only spread in moderate light levels, copied and modified from minetest_game/flowers: flowers.mushroom_spread
		local light = minetest.get_node_light({x = pos.x, y = pos.y + 1, z = pos.z})
		if not light or light < 3 or light > 9 then
			return
		end
		local num = minetest.find_nodes_in_area_under_air(
			{x = pos.x - 1, y = pos.y - 2, z = pos.z - 1},
			{x = pos.x + 1, y = pos.y + 1, z = pos.z + 1},
			"default:cobble")
		if #num > 0 then
			minetest.set_node(num[math.random(#num)], {name = node.name})
		end
	end,
})
