-- if not minetest.global_exists("dispenser") then return end



minetest.register_craft({
	output = "dispenser:dispenser",
	recipe = {
		{"group:wood", "group:wood",      "default:mese_crystal"},
		{"group:wood", "default:diamond", "default:mese_crystal"},
		{"group:wood", "group:wood",      "default:mese_crystal"},
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

minetest.register_on_mods_loaded(function ()
	local eddibles = {}
	local mobs = {}
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
	for mob,_ in pairs(mobs) do
		local actions = "place"
		if eddibles[mob] then
			actions = {"rightclick_entity", "place"}
		end
		dispenser.register_dispensable(mob, actions)
	end
	for food,_ in pairs(eddibles) do
		if not mobs[food] then
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

local plant_seed = function (item_stack, dispenser_data, player, node, entity)
	if not minetest.registered_items[item_name]
	or not minetest.registered_items[item_name].on_place then
		return nil, "cannot place"
	end
	if not player then return item_stack, "player not logged in" end
	local item_name = item_stack:get_name()
	local result = minetest.registered_items[item_name].on_place(item_stack, player, {
		type="node",
		under=dispenser_data.front,
		above=vector.add(dispenser_data.front, {x=0,y=1,z=0})
	})
	return result
end
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
	"farming:seed_hemp",
	"farming:seed_mint",
	"farming:seed_oat",
	"farming:seed_rice",
	"farming:seed_rye",
}
for _,seed in ipairs(seeds) do
	dispenser.register_dispensable(seed, plant_seed)
end

