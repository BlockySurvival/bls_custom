if not minetest.get_modpath("digilines") or not minetest.get_modpath("epic") then return end -- epic needed for the textures

minetest.register_node("bls:digilines_message_block", {
	tiles={"msb3.jpg"},
	description="Digilines message block\nWARNING: ALWAYS SENDS AS YOU, DO NOT LET OTHERS ACCESS",
	paramtype="none",
	paramtype2="none",
	is_ground_content=false,

	on_construct = function(pos)
		local meta = minetest.get_meta(pos)
		meta:set_string("owner", "")
		meta:set_string("formspec", "size[9,3;]")
	end,

	after_place_node = function(pos, placer)
		if not placer then return end
		local meta = minetest.get_meta(pos)
		local owner = placer:get_player_name()
		meta:set_string("owner", owner)
		meta:set_string("channel", "")
		meta:set_string("formspec", "size[9,2;]field[0.75,1;8,1;channel;"..minetest.formspec_escape("Channel:")..";]")
	end,

	on_receive_fields = function(pos, formname, fields, sender)
		local meta = minetest.get_meta(pos)
		local owner = meta:get_string("owner")
		if owner ~= sender:get_player_name() then return end
		if not fields.channel then return end
		meta:set_string("channel", fields.channel)
		meta:set_string("formspec", "size[9,2;]field[0.75,1;8,1;channel;"..minetest.formspec_escape("Channel:")..";"..minetest.formspec_escape(fields.channel).."]")
	end,

	_digistuff_channelcopier_fieldname = "channel",

	digiline = {
		effector = {
			action = function(pos, node, channel, msg)
				local meta = minetest.get_meta(pos)
				local owner = meta:get_string("owner")
				if channel ~= meta:get_string("channel") then return end
				if type(msg) ~= "table" or type(msg.name) ~= "string" or type(msg.msg) ~= "string" then return end
				if not minetest.check_player_privs(owner, {shout=true}) then return end
				local param = (msg.name.." "..msg.msg):gsub("[\r\n]", " ")
				minetest.registered_chatcommands.msg.func(owner, param)
			end,
		},
	},

	groups={oddly_breakable_by_hand=3},
})

if minetest.get_modpath("digistuff") then

	minetest.register_craft({
		output="bls:digilines_message_block 1",
		recipe={
			{'digistuff:noteblock', 'mesecons_luacontroller:luacontroller0000', 'digilines:lcd'}
		}
	})

else -- backup recipe

	minetest.register_craft({
		output="bls:digilines_message_block 1",
		recipe={
			{'mesecons_noteblock:noteblock', 'mesecons_luacontroller:luacontroller0000', 'digilines:lcd'}
		}
	})
end
