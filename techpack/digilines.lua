if not minetest.global_exists("digiline") then return end
if not minetest.global_exists("tubelib") then return end


local digiline_conf = {
	receptor = {},
	effector = {
		action = function(pos, node, channel, msg)
			local tubelib_number = tubelib.get_node_number(pos)
			local request_channel = "tubelib_"..tubelib_number
			if request_channel ~= channel then return end

			if type(msg) == 'table' and msg.cmd then
				local success, result = pcall(tubelib.send_request, tubelib_number, string.lower(msg.prop), msg.val)
				if string.lower(msg.cmd) == 'get' then
					local response_channel = msg.response_channel or request_channel
					local response = {
						prop = msg.prop,
						val = (not success and "error") or result,
						request_id = msg.request_id
					}
					digiline:receptor_send(pos, digiline.rules.default, response_channel, response)
				end
			else
				local success, result = pcall(tubelib.send_request, tubelib_number, msg)
				digiline:receptor_send(pos, digiline.rules.default, request_channel, (not success and "error") or result)
			end
		end
	}
}

local function digiline_compat(node_name)
	if not minetest.registered_nodes[node_name] then return end
	minetest.override_item(node_name, {digiline=digiline_conf})
end


local tubelib_nodes = {
	"dispenser:dispenser", "dispenser:dispenser_active", "dispenser:dispenser_defect",
	"techpack_warehouse:box_copper", "techpack_warehouse:box_copper_active", "techpack_warehouse:box_copper_defect",
	"techpack_warehouse:box_gold", "techpack_warehouse:box_gold_active", "techpack_warehouse:box_gold_defect",
	"techpack_warehouse:box_steel", "techpack_warehouse:box_steel_active", "techpack_warehouse:box_steel_defect",
	"tubelib_addons1:autocrafter", "tubelib_addons1:autocrafter_active", "tubelib_addons1:autocrafter_defect",
	"tubelib_addons1:fermenter", "tubelib_addons1:fermenter_defect",
	"tubelib_addons1:grinder", "tubelib_addons1:grinder_active", "tubelib_addons1:grinder_defect",
	"tubelib_addons1:harvester_base", "tubelib_addons1:harvester_defect",
	"tubelib_addons1:liquidsampler", "tubelib_addons1:liquidsampler_active", "tubelib_addons1:liquidsampler_defect",
	"tubelib_addons1:pusher_fast", "tubelib_addons1:pusher_fast_active", "tubelib_addons1:pusher_fast_defect",
	"tubelib_addons1:quarry", "tubelib_addons1:quarry_active", "tubelib_addons1:quarry_defect",
	"tubelib_addons1:reformer", "tubelib_addons1:reformer_defect",
	"tubelib:distributor", "tubelib:distributor_active", "tubelib:distributor_defect",
	"tubelib_addons3:distributor", "tubelib_addons3:distributor_active", "tubelib_addons3:distributor_defect",
	"tubelib:pusher", "tubelib:pusher_active", "tubelib:pusher_defect",
	"tubelib_addons3:pusher", "tubelib_addons3:pusher_active", "tubelib_addons3:pusher_defect",
	"tubelib_addons3:pushing_chest", "tubelib_addons3:pushing_chest_defect",

	"tubelib_addons2:accesscontrol",
	"tubelib_addons2:logic_not",
	"tubelib_addons2:mesecons_converter",
	"tubelib_addons2:repeater",
	"tubelib_addons2:sequencer",
	-- "tubelib_addons3:chest_cart",
	"tubelib_addons1:chest",
	"tubelib_addons3:chest",
	"tubelib_addons1:funnel",
	"tubelib_addons3:funnel",
	"tubelib:blackhole",

	"tubelib_addons2:doorblock1",
	"tubelib_addons2:doorblock2",
	"tubelib_addons2:doorblock3",
	"tubelib_addons2:doorblock4",
	"tubelib_addons2:doorblock5",
	"tubelib_addons2:doorblock6",
	"tubelib_addons2:doorblock7",
	"tubelib_addons2:doorblock8",
	"tubelib_addons2:doorblock9",
	"tubelib_addons2:doorblock10",
	"tubelib_addons2:doorblock11",
	"tubelib_addons2:doorblock12",
	"tubelib_addons2:doorblock13",
	"tubelib_addons2:doorblock14",

	"tubelib_addons2:gateblock1",
	"tubelib_addons2:gateblock2",
	"tubelib_addons2:gateblock3",
	"tubelib_addons2:gateblock4",
	"tubelib_addons2:gateblock5",
	"tubelib_addons2:gateblock6",
	"tubelib_addons2:gateblock7",
	"tubelib_addons2:gateblock8",
	"tubelib_addons2:gateblock9",
	"tubelib_addons2:gateblock10",
	"tubelib_addons2:gateblock11",
	"tubelib_addons2:gateblock12",
	"tubelib_addons2:gateblock13",
	"tubelib_addons2:gateblock14",
	"tubelib_addons2:gateblock15",
	"tubelib_addons2:gateblock16",
	"tubelib_addons2:gateblock17",
	"tubelib_addons2:gateblock18",
	"tubelib_addons2:gateblock19",
	"tubelib_addons2:gateblock20",

	-- "tubelib_addons2:lamp",
	"tubelib_addons2:lamp1",
	"tubelib_addons2:lamp2",
	"tubelib_addons2:lamp3",
	"tubelib_addons2:lamp4",
	"tubelib_addons2:lamp5",
	"tubelib_addons2:lamp6",
	"tubelib_addons2:lamp7",
	"tubelib_addons2:lamp8",
	"tubelib_addons2:lamp9",
	"tubelib_addons2:lamp10",
	"tubelib_addons2:lamp11",
	"tubelib_addons2:lamp12",

	"tubelib:lamp", "tubelib:lamp_on",
	"tubelib_addons2:lamp_off", "tubelib_addons2:lamp_on",
	"tubelib_addons2:ceilinglamp", "tubelib_addons2:ceilinglamp_on",
	"tubelib_addons2:industriallamp1", "tubelib_addons2:industriallamp1_on",
	"tubelib_addons2:industriallamp2", "tubelib_addons2:industriallamp2_on",
	"tubelib_addons2:invisiblelamp", "tubelib_addons2:invisiblelamp_on",
	"tubelib_addons2:streetlamp", "tubelib_addons2:streetlamp_on",
	"tubelib_addons2:invisiblelamp", "tubelib_addons2:invisiblelamp_on",
}

for _,node_name in ipairs(tubelib_nodes) do
	digiline_compat(node_name)
end
