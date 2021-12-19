if not minetest.registered_chatcommands["msg"] then return end

local orig_chat_send_player = minetest.chat_send_player
local orig_msg_def = minetest.registered_chatcommands["msg"]
local orig_msg_func = minetest.registered_chatcommands["msg"].func

-- This works because everything is procedural and single threaded - however it is very gross
local chat_color = nil

local function msg (name, param)
	chat_color = "#bbffbb"
	local res, reason = orig_msg_func(name, param)
	chat_color = nil -- set to nill just in case `minetest.chat_send_player` was never called
	return res, reason
end

minetest.override_chatcommand("msg", {
	params = orig_msg_def.params,
	privs = orig_msg_def.privs,
	description = orig_msg_def.description,
	func = msg,
})

-- Ignore system messages
minetest.chat_send_player = function (player, message)
	if chat_color then
		local colored_message = minetest.colorize(chat_color, message)
		chat_color = nil
		return orig_chat_send_player(player, colored_message)
	end
	return orig_chat_send_player(player, message)
end