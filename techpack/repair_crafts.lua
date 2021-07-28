if not minetest.get_modpath("tubelib") then return end

local function repair_craft(original, defective)
	if not defective then
		defective = original .. "_defect"
	end
	minetest.register_craft({
		output = original,
		type   = "shapeless",
		recipe = { defective, "tubelib:repairkit" }
	})
end

repair_craft("tubelib:distributor")
repair_craft("tubelib:pusher")

if minetest.get_modpath("gravelsieve") then
	repair_craft("gravelsieve:auto_sieve", "gravelsieve:sieve_defect")
end

if minetest.get_modpath("techpack_warehouse") then
	repair_craft("techpack_warehouse:box_gold")
	repair_craft("techpack_warehouse:box_steel")
	repair_craft("techpack_warehouse:box_copper")
end

if minetest.get_modpath("tubelib_addons1") then
	repair_craft("tubelib_addons1:autocrafter")
	repair_craft("tubelib_addons1:fermenter")
	repair_craft("tubelib_addons1:grinder")
	repair_craft("tubelib_addons1:liquidsampler")
	repair_craft("tubelib_addons1:pusher_fast")
	repair_craft("tubelib_addons1:quarry")
	repair_craft("tubelib_addons1:reformer")
	repair_craft("tubelib_addons1:harvester_base", "tubelib_addons1:harvester_defect")
end

if minetest.get_modpath("tubelib_addons3") then
	repair_craft("tubelib_addons3:distributor")
	repair_craft("tubelib_addons3:pusher")
	repair_craft("tubelib_addons3:pushing_chest")
end


if minetest.get_modpath("dispenser") then
	repair_craft("dispenser:dispenser")
end