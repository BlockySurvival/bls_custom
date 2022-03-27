--[[

Frame:
digiterms:cathodic_beige_monitor
technic:silver_chest
tubelib:tubeS
terumet:frame_cgls

Controller:
mesecons_luacontroller:luacontroller0000
digilines_memory:memory_7
moremesecons_timegate:timegate_off
basic_materials:energy_crystal_simple

Actor:
tubelib:distributor
tubelib_addons1:liquidsampler
digistuff:piston
terumet:block_entropy

Interface:
digistuff:touchscreen
digistuff:noteblock
tubelib_addons2:sequencer
mesecons_switch:mesecon_switch_off


"robot:norm_robot"
{ "mesecons_luacontroller:luacontroller0000", "digistuff:touchscreen",                 "scifi_nodes:block_lights"  },
{ "digiterms:cathodic_beige_monitor",         "terumet:frame_cgls",                    "digilines_memory:memory_7" },
{ "tubelib_addons3:distributor",              "basic_materials:energy_crystal_simple", "technic:silver_chest"      },


"robot:norm_robot_body"
{ "mesecons_luacontroller:luacontroller0000", "digistuff:touchscreen",       "scifi_nodes:block_lights"      },
{ "unified_inventory:bag_small",              "terumet:frame_cgls",          "technic:stainless_steel_block" },
{ "tubelib_addons3:distributor",              "unified_inventory:bag_small", "technic:silver_chest"          },


"robot:norm_robot_legs"
{ "mesecons_luacontroller:luacontroller0000", "digistuff:touchscreen", "scifi_nodes:block_lights" },
{ "rhotator:screwdriver",                     "terumet:frame_cgls",    "bike:wheel"               },
{ "tubelib_addons3:distributor",              "carts:cart",            "technic:silver_chest"     },


"robot:dark_robot*"
{ "digistuff:touchscreen", "terumet:block_entropy",  "scifi_nodes:blink"      },
{ "digistuff:touchscreen", "robot:norm_robot*",      "terumet:block_entropy"  },
{ "digistuff:touchscreen", "terumet:block_entropy",  "scifi_nodes:blackplate" },

"robot:light_robot*"
{ "scifi_nodes:glassscreen", "quartz:block",      "morelights_extras:f_block" },
{ "scifi_nodes:glassscreen", "robot:dark_robot*", "quartz:block"              },
{ "scifi_nodes:glassscreen", "quartz:block",      "scifi_nodes:ultra_white"   },



]]
if not minetest.get_modpath("robot") then return end

minetest.register_craft({
	output="robot:norm_robot",
	recipe={
		{ "mesecons_luacontroller:luacontroller0000", "digistuff:touchscreen",                 "scifi_nodes:black_lights"  },
		{ "digiterms:cathodic_beige_monitor",         "terumet:frame_cgls",                    "digilines_memory:memory_7" },
		{ "tubelib_addons3:distributor",              "basic_materials:energy_crystal_simple", "technic:silver_chest"      },
	},
})


minetest.register_craft({
	output="robot:norm_robot_body",
	recipe={
		{ "mesecons_luacontroller:luacontroller0000", "digistuff:touchscreen",       "scifi_nodes:black_lights"      },
		{ "unified_inventory:bag_small",              "terumet:frame_cgls",          "technic:stainless_steel_block" },
		{ "tubelib_addons3:distributor",              "unified_inventory:bag_large", "technic:silver_chest"          },
	}
})


minetest.register_craft({
	output="robot:norm_robot_legs",
	recipe={
		{ "mesecons_luacontroller:luacontroller0000", "digistuff:touchscreen", "scifi_nodes:black_lights" },
		{ "rhotator:screwdriver",                     "terumet:frame_cgls",    "bike:wheel"               },
		{ "tubelib_addons3:distributor",              "carts:cart",            "technic:silver_chest"     },
	}
})

local parts = {"", "_body", "_legs"}
for _,part in ipairs(parts) do
	minetest.register_craft({
		output="robot:dark_robot"..part,
		recipe={
			{ "digistuff:touchscreen", "terumet:block_entropy",  "scifi_nodes:blink"      },
			{ "digistuff:touchscreen", "robot:norm_robot"..part, "terumet:block_entropy"  },
			{ "digistuff:touchscreen", "terumet:block_entropy",  "scifi_nodes:blackplate" },
		}
	})
	minetest.register_craft({
		output="robot:light_robot"..part,
		recipe={
			{ "scifi_nodes:glassscreen", "quartz:block",           "morelights_extras:f_block" },
			{ "scifi_nodes:glassscreen", "robot:dark_robot"..part, "quartz:block"              },
			{ "scifi_nodes:glassscreen", "quartz:block",           "scifi_nodes:ultra_white"   },
		}
	})
end
