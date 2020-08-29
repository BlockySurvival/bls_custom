-- remove dig prediction from any node that isn't doing something custom
-- prevents some forms of glitching-through-walls
-- might be annoying w/ lag though; need to test.
local function add_no_prediction()
	for itemstring, def in pairs(minetest.registered_nodes) do
		if def.node_dig_prediction == "air" or not def.node_dig_prediction then
			minetest.override_item(itemstring, {
				node_dig_prediction = ""
			})
		end
	end
end

minetest.register_on_mods_loaded(add_no_prediction)
