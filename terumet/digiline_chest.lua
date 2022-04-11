if not minetest.global_exists("terumet") then return end
if not minetest.global_exists("digilines") then return end
if not minetest.registered_nodes["digilines:chest"] then return end

local terumet_machines = {
	"terumet:mach_asmelt",
	"terumet:mach_asmelt_lit",
	"terumet:mach_crusher",
	"terumet:mach_crusher_lit",
	"terumet:mach_htfurn",
	"terumet:mach_htfurn_lit",
	"terumet:mach_htr_furnace",
	"terumet:mach_htr_furnace_lit",
	"terumet:mach_lavam",
	"terumet:mach_lavam_lit",
	"terumet:mach_repm",
	"terumet:mach_vcoven",
	"terumet:mach_vulcan",
}

local function inv_to_string(inv, list_name)
	local rep = ""
	local list = inv:get_list(list_name)
	if list then
		for _,stack in ipairs(list) do
			rep = rep..stack:to_string()..","
		end
	end
	return rep, list
end

local function send_message(pos, action, stack, from_slot, to_slot, side)
	local channel = minetest.get_meta(pos):get_string("channel")
	local msg = {
		action = action,
		stack = stack and stack:to_table(),
		from_slot = from_slot,
		to_slot = to_slot,
		-- Duplicate the vector in case the caller expects it not to change.
		side = side and vector.new(side)
	}
	digilines.receptor_send(pos, digilines.rules.default, channel, msg)
end


-- Checks if the inventory has become empty and, if so, sends an empty message.
local function check_empty(pos, inv)
	if inv:is_empty("main") then
		send_message(pos, "empty")
	end
end

-- Checks if the inventory has become full for a particular type of item and,
-- if so, sends a full message.
local function check_full(pos, inv, stack)
	local one_item_stack = ItemStack(stack)
	one_item_stack:set_count(1)
	if not inv:room_for_item("main", one_item_stack) then
		send_message(pos, "full", one_item_stack)
	end
end

local function send_inventory_updates(pos, inv, side, orig_list, new_list)
	for i,orig_stack in ipairs(orig_list) do
		local new_stack = new_list[i]
		if orig_stack:get_count() ~= new_stack:get_count()
		or orig_stack:get_name() ~= new_stack:get_name()
		then
			local taken, put
			if orig_stack:get_name() == new_stack:get_name() then
				local taken_count = orig_stack:get_count()-new_stack:get_count()
				if taken_count > 0 then
					orig_stack:set_count(taken_count)
					taken = orig_stack
				elseif taken_count < 0 then
					orig_stack:set_count(-taken_count)
					put = orig_stack
				end
			else
				if orig_stack:get_count() > 0 then
					taken = orig_stack
				end
				if new_stack:get_count() > 0 then
					put = new_stack
				end
			end
			if taken then
				send_message(pos, "ttake", taken, i, nil, side)
			end
			if put then
				send_message(pos, "tput", put, nil, i, side)
			end

			if taken and not put then
				check_empty(pos, inv)
			elseif put then
				check_full(pos, inv, put)
			end
		end
	end
end

local function timer_override(existing_on_timer, pos, dtime)
	local machine = terumet.machine.readonly_state(pos)
	local node = minetest.get_node(pos)
	machine.rot = terumet.util3d.param2_to_rotation(node.param2)

	local input_inv, input_inv_name = terumet.machine.get_input(machine)
	local input_pos = terumet.util3d.get_relative_pos(machine.rot, machine.pos, machine.input_side)
	local do_input_logic = input_inv_name == 'main' and minetest.get_node(input_pos).name == "digilines:chest"

	local output_inv, output_inv_name = terumet.machine.get_output(machine)
	local output_pos = terumet.util3d.get_relative_pos(machine.rot, machine.pos, machine.output_side)
	local do_output_logic = output_inv_name == 'main' and minetest.get_node(output_pos).name == "digilines:chest"

	local orig_input
	local orig_input_list
	if do_input_logic then
		orig_input, orig_input_list = inv_to_string(input_inv, input_inv_name)
	end

	local orig_output
	local orig_output_list
	if do_output_logic then
		orig_output, orig_output_list = inv_to_string(output_inv, output_inv_name)
	end

	local ret = existing_on_timer(pos, dtime)

	if do_input_logic then
		local new_input, new_input_list = inv_to_string(input_inv, input_inv_name)
		if new_input ~= orig_input then
			local input_side = vector.subtract(pos, input_pos)
			send_inventory_updates(input_pos, input_inv, input_side, orig_input_list, new_input_list)
		end
	end

	if do_output_logic then
		local new_output, new_output_list = inv_to_string(output_inv, output_inv_name)
		if new_output ~= orig_output then
			local output_side = vector.subtract(pos, output_pos)
			send_inventory_updates(output_pos, output_inv, output_side, orig_output_list, new_output_list)
		end
	end

	return ret
end

local function digiline_chest_compat(node_name)
	local existing_def = minetest.registered_nodes[node_name]
	if not existing_def then return end

	local existing_on_timer = existing_def.on_timer

	minetest.override_item(node_name, {
		on_timer = function (pos, dtime)
			return timer_override(existing_on_timer, pos, dtime)
		end
	})
end

for _,node_name in ipairs(terumet_machines) do
	digiline_chest_compat(node_name)
end
