
if not minetest.get_modpath("cavestuff") then return end

minetest.register_craft({
	output="cavestuff:stalactite_1",
	recipe={
		{"","cavestuff:pebble_1",""},
		{"","default:stone",""},
		{"default:stone","default:stone","default:stone"},
	}
})
