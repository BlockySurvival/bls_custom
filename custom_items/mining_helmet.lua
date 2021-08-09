if not (minetest.get_modpath("3d_armor") and minetest.global_exists("armor") and minetest.global_exists("wielded_light") and minetest.global_exists("terumet")) then
	return
end

local damage_amount = 1
local helmet_item = "bls:mining_helmet"

wielded_light.register_player_lightstep(function (player)
	local player_name = player:get_player_name()
	local armor_inv = minetest.get_inventory({ type="detached", name=player_name.."_armor" })
	local helmet_found = false
	for index = 1, 6 do
		local stack = armor_inv:get_stack("armor", index)
		if stack:get_name() == helmet_item then
			local wear = stack:get_wear()
			if (65535 - wear) > damage_amount then
				armor:damage(player, index, stack, damage_amount)
				helmet_found = true
			end
			break
		end
	end
	if helmet_found then
		wielded_light.track_user_entity(player, "mining_helmet", helmet_item)
	else
		wielded_light.track_user_entity(player, "mining_helmet", false)
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
		physics_speed = 0,
		physics_gravity = 0,
		physics_jump = 0,
	},
	armor_groups = {fleshy = 0},
	damage_groups = {}
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

terumet.register_repairable_item(helmet_item, 500)