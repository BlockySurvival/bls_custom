if not minetest.global_exists("dispenser") then return end

minetest.clear_craft({
	output = "dispenser:dispenser",
})

minetest.register_craft({
	output = "dispenser:dispenser",
	recipe = {
		{"group:wood",    "basic_materials:ic",        "basic_materials:brass_ingot"},
		{"tubelib:tubeS", "basic_materials:gold_wire", "hook:slingshot"},
		{"group:wood",    "basic_materials:motor",     "basic_materials:brass_ingot"},
	},
})

dispenser.set_default_action("shoot")
dispenser.set_overflow_behaviour("spit")
dispenser.set_choice_strategy("first")

-- Mob Automation
dispenser.register_dispensable("mobs:hairball", "use", function (item_stack, dispenser_data, default)
	return function (key)
		if key == "get_pos" then
			return function ()
				return vector.add(dispenser_data.pos, {x=0,y=-1.5,z=0})
			end
		end
		return default(item_stack, dispenser_data)(key)
	end
end)


local plant_seed = function (item_stack, dispenser_data, player, node, entity)
	local item_name = item_stack:get_name()
	if not minetest.registered_items[item_name]
	or not minetest.registered_items[item_name].on_place then
		return nil, "cannot place"
	end
	if not player then return item_stack, "player not logged in" end
	local result = minetest.registered_items[item_name].on_place(item_stack, player, {
		type="node",
		under=dispenser_data.front,
		above=vector.add(dispenser_data.front, {x=0,y=1,z=0})
	})
	return result
end

local feed_or_plant_seed = function (item_stack, dispenser_data, player, node, entity)
	local feed_result, feed_reason, feed_failure = dispenser.actions.attempt_rightclick_entity(item_stack, dispenser_data, player, node, entity)

	if not feed_failure then
		return feed_result, feed_reason
	end
	return plant_seed(item_stack, dispenser_data, player, node, entity)
end

minetest.register_on_mods_loaded(function ()
	local eddibles = {}
	local mobs = {}
	local seeds = {
		"cucina_vegana:asparagus_seed",
		"cucina_vegana:chives_seed",
		"cucina_vegana:flax_seed",
		"cucina_vegana:kohlrabi_seed",
		"cucina_vegana:lettuce_seed",
		"cucina_vegana:parsley_seed",
		"cucina_vegana:peanut_seed",
		"cucina_vegana:rice_seed",
		"cucina_vegana:rosemary_seed",
		"cucina_vegana:soy_seed",
		"cucina_vegana:sunflower_seed",
		"aqua_farming:alga_seed",
		"aqua_farming:sea_grass_seed",
		"aqua_farming:sea_strawberry_seed",
		"aqua_farming:sea_anemone_seed",
		"aqua_farming:sea_cucumber_seed",
		"farming:seed_barley",
		"farming:seed_cotton",
		"farming:seed_hemp",
		"farming:seed_mint",
		"farming:seed_oat",
		"farming:seed_rice",
		"farming:seed_rye",
		"farming:seed_wheat",
	}

	for _,entity in pairs(minetest.registered_entities) do
		if entity.type == "animal" then
			mobs[entity.name] = true
		end
		if entity.follow then
			if type(entity.follow) == "table" then
				for _,food in pairs(entity.follow) do
					eddibles[food] = true
				end
			end
		end
	end

	-- Register mobs as placable, some are eddible by other mobs
	for mob,_ in pairs(mobs) do
		local actions = "place"
		if eddibles[mob] then
			actions = {"rightclick_entity", "place"}
		end
		dispenser.register_dispensable(mob, actions)
	end
	-- Register seeds as plantable, some are eddible by mobs
	for _,seed in ipairs(seeds) do
		local action = plant_seed
		if eddibles[seed] then
			action = feed_or_plant_seed
			seeds[seed] = true
		end
		dispenser.register_dispensable(seed, action)
	end
	-- Register all other foods as eddible by mobs only
	for food,_ in pairs(eddibles) do
		if not mobs[food] and not seeds[food] then
			dispenser.register_dispensable(food, "rightclick_entity")
		end
	end
end)

dispenser.register_dispensable("mobs:nametag", "rightclick_entity")
dispenser.register_dispensable("mobs:lasso", "use")
dispenser.register_dispensable("mobs:net", "use")

dispenser.register_dispensable("mobs:shears", {"rightclick_entity"})
dispenser.register_dispensable("bucket:bucket_empty", {"use", "rightclick_entity"})

-- Place Liquids
dispenser.register_dispensable("bucket:bucket_water", "place")
dispenser.register_dispensable("bucket:bucket_river_water", "place")
dispenser.register_dispensable("bucket:bucket_lava", "place")

-- Detonate TNT
dispenser.register_dispensable("default:torch", {"punch_node", "place"})
dispenser.register_dispensable("tnt:tnt", "place")

-- Magix
dispenser.register_dispensable("screwdriver:screwdriver", "use")
dispenser.register_dispensable("tubelib:repairkit", "use")
dispenser.register_dispensable("hook:pchest", "place")
dispenser.register_dispensable("default:cobble", "place")

-- Extra Farming Automation
dispenser.register_dispensable("bonemeal:bonemeal", "use")
dispenser.register_dispensable("bonemeal:fertiliser", "use")

dispenser.register_dispensable("moreores:hoe_silver", "use")
dispenser.register_dispensable("moreores:hoe_mithril", "use")
dispenser.register_dispensable("farming:hoe_bronze", "use")
dispenser.register_dispensable("farming:hoe_diamond", "use")
dispenser.register_dispensable("farming:hoe_mese", "use")
dispenser.register_dispensable("farming:hoe_steel", "use")
dispenser.register_dispensable("farming:hoe_stone", "use")
dispenser.register_dispensable("farming:hoe_wood", "use")
dispenser.register_dispensable("farming:scythe_mithril", "use")