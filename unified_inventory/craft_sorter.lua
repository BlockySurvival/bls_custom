if not minetest.global_exists("unified_inventory") then return end

-- Check for new API methods, this is more thorough than it probably needs to be
if not unified_inventory.register_on_initialized then return end
if not unified_inventory.register_on_craft_registered then return end
if not unified_inventory.get_recipe_list then return end
if not unified_inventory.get_registered_outputs then return end



local sort_indexes = {}

local function is_slopey(item)
	return
	   string.find(item, "micro_")
	or string.find(item, "slab_")
	or string.find(item, "slope_")
	or string.find(item, "panel_")
	or string.find(item, "stair_")
end

local function is_group(item)
	return string.sub(item,1,6) == "group:"
end

local function calculate_sort_index(recipe)
	if sort_indexes[recipe] then
		return sort_indexes[recipe]
	end
	local sort_index = 0
	local result_itemstack = ItemStack(recipe.output)
	local result_item = result_itemstack:get_name()

	-- Normal crafts should be favoured slighly
	if not (recipe.type == "normal" or recipe.type == "shapeless") then
		sort_index = sort_index+1
	end

	-- Prefer smelting recipes for ingots and blocks
	if (recipe.type == "cooking" or recipe.type == "terumet_alloy")
	and (string.find(result_item, "ingot", 1, 1) or string.find(result_item, "block", 1, 1)) then
		sort_index = sort_index-10
	end

	for _,item in pairs(recipe.items) do
		-- Crafts using slopes / microblocks should be pushed to the back
		if is_slopey(item) then
			sort_index = sort_index+2
		end

		-- Prioritise crafts with groups
		if is_group(item) then
			sort_index = sort_index-10
		end

		-- Send repair crafts to the back
		if item == "tubelib:repairkit" then
			sort_index = sort_index+10
		end

		-- Don't prefer crafts that contain the item itself (dying crafts)
		if item == result_item then
			sort_index = sort_index+10
		end
	end

	-- Crafts using more common items should come first
	local usage_count = 0
	local item_count = 0
	for _, spec in pairs(recipe.items) do
		item_count = item_count+1
		local ingredient_items = {}
		local matches_spec = unified_inventory.canonical_item_spec_matcher(spec)
		for _, item in ipairs(unified_inventory.items_list) do
			if matches_spec(item) then
				ingredient_items[item] = true
			end
		end
		local uc = 0
		local ingredient_count = 0
		for item, _ in pairs(ingredient_items) do
			ingredient_count = ingredient_count+1
			local usages = unified_inventory.crafts_for.usage[item]
			if usages then
				uc = uc + #usages
			else
				uc = uc + 1
			end
		end
		if ingredient_count == 0 then
			usage_count = usage_count + 1
		else
			usage_count = usage_count + (uc / ingredient_count)
		end
	end
	sort_index = sort_index - math.log(usage_count/item_count)

	-- Prefer crafts with more items - they are usually the primary craft
	sort_index = sort_index - item_count

	sort_indexes[recipe] = sort_index
	return sort_index
end

local function craft_sorter(a, b)
	return calculate_sort_index(a) < calculate_sort_index(b)
end

local function sort_crafts(item_name)
	local recipes = unified_inventory.get_recipe_list(item_name)
	table.sort(recipes, craft_sorter)
end


local initialised = false

unified_inventory.register_on_initialized(function ()
	local outputs = unified_inventory.get_registered_outputs()
	for _, item_name in ipairs(outputs) do
		sort_crafts(item_name)
	end
	initialised = true
end)

unified_inventory.register_on_craft_registered(function (item_name)
	if not initialised then return end

	sort_crafts(item_name)
end)
