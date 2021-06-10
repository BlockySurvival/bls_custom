if not (minetest.get_modpath("3d_armor") and minetest.global_exists("armor") and minetest.global_exists("wielded_light")) then
	return
end

local update_interval = 0.2
local damage_amount = 50
local helmet_item = "bls:mining_helmet"

local timer = 0
minetest.register_globalstep(function(dtime)
	timer = timer + dtime;
	if timer < update_interval then
		return
	end
	timer = 0

	for _, player in pairs(minetest.get_connected_players()) do
		local player_name = player:get_player_name()
		local armor_inv = minetest.get_inventory({ type="detached", name=player_name.."_armor" })
		for index = 1, 6 do
			local stack = armor_inv:get_stack("armor", index)
			if stack:get_name() == helmet_item then
				local pos = vector.add (
					vector.add({x = 0, y = 1, z = 0}, vector.round(player:get_pos())),
					vector.round(vector.multiply(player:get_player_velocity(), update_interval * 1.5))
				)
				local wear = stack:get_wear()
				if (65535 - wear) > damage_amount then
					armor:damage(player, index, stack, damage_amount)
					wielded_light.update_light_by_item(helmet_item, pos)
				end
			end
		end
	end
end)

armor:register_armor(helmet_item, {
	description = "Mining Helmet",
	inventory_image = "bls_mining_helmet_inv.png",
	texture = "bls_mining_helmet_armor.png",
	preview = "bls_mining_helmet_preview.png",
	groups = {
		armor_head = 1,
		armor_use = 0,
		armor_heal = 0,
		physics_speed = 1,
		physics_jump = 1,
		physics_gravity = 1,
	},
	armor_groups = {fleshy = 0},
	damage_groups = {cracky=3, snappy=3, choppy=3, crumbly=3, level=1}
})

wielded_light.register_item_light(helmet_item, 12)

local metal = "default:gold_ingot"
if minetest.get_modpath("terumet") then
	metal = "terumet:ingot_tgol"
end
local light = "default:mese_post_light"
if minetest.get_modpath("homedecor_lighting") then
	light = "homedecor:lattice_lantern_large_14"
end
minetest.register_craft({
	output = helmet_item,
	recipe = {
		{metal, metal, metal},
		{metal, light, metal},
	}
})