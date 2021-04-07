
if not minetest.get_modpath("basic_materials") then return end
if not minetest.get_modpath("cucina_vegana") then return end
if not minetest.get_modpath("wool") then return end
if not minetest.get_modpath("mobs") then return end

local S = minetest.get_translator("bls")

minetest.register_craftitem("bls:artificial_leather", {
	description = S("Artificial Leather"),
	inventory_image = "bls_artificial_leather.png",
	groups = {flammable = 1,},
})

minetest.register_craft({
	output="bls:artificial_leather",
	recipe={
		{"group:wool",                 "group:wool",                 "group:wool"},
		{"basic_materials:paraffin",   "basic_materials:paraffin",   "basic_materials:paraffin"},
		{"cucina_vegana:flax_roasted", "cucina_vegana:flax_roasted", "cucina_vegana:flax_roasted"},
	}
})

minetest.register_craft({
	output="mobs:leather",
	recipe={
		{"bls:artificial_leather","bls:artificial_leather","bls:artificial_leather"},
		{"bls:artificial_leather","bls:artificial_leather","bls:artificial_leather"},
		{"bls:artificial_leather","bls:artificial_leather","bls:artificial_leather"},
	}
})

