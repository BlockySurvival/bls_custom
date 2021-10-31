local orig_chat_send_player = minetest.chat_send_player
local orig_chat_send_all = minetest.chat_send_all
local orig_chat_message = function (sender, reciever, message)
	minetest.log("error", dump(sender)..dump(reciever)..dump(message))
	orig_chat_send_player(reciever, minetest.format_chat_message(sender, message))
end

local function merge_table(a, b)
	local ret = {}
	for k,v in pairs(a) do
		if b[k] == nil then
			ret[k] = v
		else
			if type(v) == 'table' and type(b[k]) == 'table' then
				ret[k] = merge_table(v, b[k])
			else
				ret[k] = v
			end
		end
	end
	for k,v in pairs(b) do
		if a[k] == nil then
			ret[k] = v
		end
	end
	return ret
end

local ignores = {}
local default_ignores = {
	players = {
		global = {},
		player = {}, -- Players who ignore indexed by players who are ignored
		player_msg = {}
	},
	messages = {
		global = {},
		player = {},
		player_msg = {}
	}
}

local mod_storage = bls.mod_storage

local stored_ignores = mod_storage:get_string('ignore')
if stored_ignores ~= "" then
	ignores = minetest.deserialize(stored_ignores)
end
ignores = merge_table(ignores, default_ignores)

local function save_ignores()
	mod_storage:set_string('ignore', minetest.serialize(ignores))
end

minetest.register_privilege('ignore', 'allows players to ignore certain messages from chat')
minetest.register_privilege('ignore_admin', 'allows players to set globally ignored messages and administer ignores')

minetest.register_chatcommand("ignore_player", {
	params = "<player name>",
	description = "Ignore the messages a player sends",
	privs = {ignore=true},
	func = function (player, player_name)
		if string.find(player_name, " ") then
			return false, ('"%s" is not a valid player name'):format(player_name)
		end
		if player_name == "" then
			return false, "Player name is empty, see /help ignore_player"
		end
		ignores.players.player[player_name] = ignores.players.player[player_name] or {}
		if ignores.players.player[player_name][player] then
			return false, ("You are already ignoring %s"):format(player_name)
		end
		ignores.players.player[player_name][player] = true
		save_ignores()
		return true, ("You are now ignoring %s"):format(player_name)
	end,
})

minetest.register_chatcommand("ignore_message", {
	params = "<message text>",
	description = "Ignore messages by their contents",
	privs = {ignore=true},
	func = function (player, message_text)
		if message_text == "" then
			return false, "Message text is empty, see /help ignore_message"
		end
		ignores.messages.player[message_text] = ignores.messages.player[message_text] or {}
		if ignores.messages.player[message_text][player] then
			return false, ('You are already ignoring messages that equal "%s"'):format(message_text)
		end
		ignores.messages.player[message_text][player] = true
		save_ignores()
		return true, ('You are now ignoring messages that equal "%s"'):format(message_text)
	end,
})

minetest.register_chatcommand("ignore_player_msg", {
	params = "<player name>",
	description = "Ignore the direct messages a player sends",
	privs = {ignore=true},
	func = function (player, player_name)
		if string.find(player_name, " ") then
			return false, ('"%s" is not a valid player name'):format(player_name)
		end
		if player_name == "" then
			return false, "Player name is empty, see /help ignore_player_msg"
		end
		ignores.players.player_msg[player_name] = ignores.players.player_msg[player_name] or {}
		if ignores.players.player_msg[player_name][player] then
			return false, ("You are already ignoring DMs from %s"):format(player_name)
		end
		ignores.players.player_msg[player_name][player] = true
		save_ignores()
		return true, ("You are now ignoring DMs from %s"):format(player_name)
	end,
})

minetest.register_chatcommand("ignore_message_msg", {
	params = "<message text>",
	description = "Ignore direct messages by their contents",
	privs = {ignore=true},
	func = function (player, message_text)
		if message_text == "" then
			return false, "Message text is empty, see /help ignore_message_msg"
		end
		ignores.messages.player_msg[message_text] = ignores.messages.player_msg[message_text] or {}
		if ignores.messages.player_msg[message_text][player] then
			return false, ('You are already ignoring DMs that equal "%s"'):format(message_text)
		end
		ignores.messages.player_msg[message_text][player] = true
		save_ignores()
		return true, ('You are now ignoring DMs that equal "%s"'):format(message_text)
	end,
})

minetest.register_chatcommand("ignore_player_gloabl", {
	params = "<player name>",
	description = "Globally gnore the messages a player sends",
	privs = {ignore=true,ignore_admin=true},
	func = function (player, player_name)
		if string.find(player_name, " ") then
			return false, ('"%s" is not a valid player name'):format(player_name)
		end
		if player_name == "" then
			return false, "Player name is empty, see /help ignore_player_global"
		end
		if ignores.players.gloabl[player_name] then
			return false, ("%s is already being ignored"):format(player_name)
		end
		ignores.players.gloabl[player_name] = true
		save_ignores()
		return true, ("%s is now being ignored"):format(player_name)
	end,
})

minetest.register_chatcommand("ignore_message_gloabl", {
	params = "<message text>",
	description = "Globally ignore messages by their contents",
	privs = {ignore=true,ignore_admin=true},
	func = function (player, message_text)
		if message_text == "" then
			return false, "Message text is empty, see /help ignore_message_global"
		end
		if ignores.messages.gloabl[message_text] then
			return false, ('Messages that equal "%s" are already being ignored'):format(message_text)
		end
		ignores.messages.gloabl[message_text] = true
		save_ignores()
		return true, ('Messages that equal "%s" are now being ignored'):format(message_text)
	end,
})

minetest.register_chatcommand("unignore_player", {
	params = "<player name>",
	description = "Ignore the messages a player sends",
	privs = {ignore=true},
	func = function (player, player_name)
		if string.find(player_name, " ") then
			return false, ('"%s" is not a valid player name'):format(player_name)
		end
		if player_name == "" then
			return false, "Player name is empty, see /help unignore_player"
		end
		if not (ignores.players.player[player_name] and ignores.players.player[player_name][player]) then
			return false, ("You are not ignoring %s already"):format(player_name)
		end
		ignores.players.player[player_name][player] = nil
		save_ignores()
		return true, ("You are now not ignoring %s"):format(player_name)
	end,
})

minetest.register_chatcommand("unignore_message", {
	params = "<message text>",
	description = "Ignore messages by their contents",
	privs = {ignore=true},
	func = function (player, message_text)
		if message_text == "" then
			return false, "Message text is empty, see /help unignore_message"
		end
		if not (ignores.messages.player[message_text] and ignores.messages.player[message_text][player]) then
			return false, ('You are not ignoring messages that equal "%s" already'):format(message_text)
		end
		ignores.messages.player[message_text][player] = nil
		save_ignores()
		return true, ('You are now not ignoring messages that equal "%s"'):format(message_text)
	end,
})

minetest.register_chatcommand("unignore_player_msg", {
	params = "<player name>",
	description = "Ignore the direct messages a player sends",
	privs = {ignore=true},
	func = function (player, player_name)
		if string.find(player_name, " ") then
			return false, ('"%s" is not a valid player name'):format(player_name)
		end
		if player_name == "" then
			return false, "Player name is empty, see /help unignore_player_msg"
		end
		if not (ignores.players.player_msg[player_name] and ignores.players.player_msg[player_name][player]) then
			return false, ("You are not ignoring DMs from %s already"):format(player_name)
		end
		ignores.players.player_msg[player_name][player] = nil
		save_ignores()
		return true, ("You are now not ignoring DMs from %s"):format(player_name)
	end,
})

minetest.register_chatcommand("unignore_message_msg", {
	params = "<message text>",
	description = "Ignore direct messages by their contents",
	privs = {ignore=true},
	func = function (player, message_text)
		if message_text == "" then
			return false, "Message text is empty, see /help unignore_message_msg"
		end
		if not (ignores.messages.player_msg[message_text] and ignores.messages.player_msg[message_text][player]) then
			return false, ('You are not ignoring DMs that equal "%s" already'):format(message_text)
		end
		ignores.messages.player_msg[message_text][player] = nil
		save_ignores()
		return true, ('You are now not ignoring DMs that equal "%s"'):format(message_text)
	end,
})

minetest.register_chatcommand("unignore_player_gloabl", {
	params = "<player name>",
	description = "Globally gnore the messages a player sends",
	privs = {ignore=true,ignore_admin=true},
	func = function (player, player_name)
		if string.find(player_name, " ") then
			return false, ('"%s" is not a valid player name'):format(player_name)
		end
		if player_name == "" then
			return false, "Player name is empty, see /help unignore_player_global"
		end
		if not ignores.players.gloabl[player_name] then
			return false, ("%s is not being ignored already"):format(player_name)
		end
		ignores.players.gloabl[player_name] = nil
		save_ignores()
		return true, ("%s is now not being ignored"):format(player_name)
	end,
})

minetest.register_chatcommand("unignore_message_gloabl", {
	params = "<message text>",
	description = "Globally ignore messages by their contents",
	privs = {ignore=true,ignore_admin=true},
	func = function (player, message_text)
		if message_text == "" then
			return false, "Message text is empty, see /help unignore_message_global"
		end
		if not ignores.messages.gloabl[message_text] then
			return false, ('Messages that equal "%s" are not being ignored already'):format(message_text)
		end
		ignores.messages.gloabl[message_text] = nil
		save_ignores()
		return true, ('Messages that equal "%s" are now not being ignored'):format(message_text)
	end,
})


-- Ignore general chat messages
local function ignore_chat (player, message)
	if 
		ignores.players.global[player] or
		ignores.messages.global[message]
	then
		orig_chat_message(player, player, message)
		return true
	end
	if ignores.players.player[player] or ignores.messages.player[message] then
		local players = minetest.get_connected_players()
		for _, player_obj in ipairs(players) do
			local player_name = player_obj:get_player_name()
			if player_name == player
				or not (
					(ignores.players.player[player] and ignores.players.player[player][player_name]) or
					(ignores.messages.player[message] and ignores.messages.player[message][player_name])
				)
			then
				orig_chat_message(player, player_name, message)
			end
		end
		return true
	end
end
minetest.register_on_chat_message(ignore_chat)

-- Ignore direct messages (/msg)
local function msg (name, param)
	local sendto, message = param:match("^(%S+)%s(.+)$")
	if not sendto then
		return false, "Invalid usage, see /help msg."
	end
	if not minetest.get_player_by_name(sendto) then
		return false, "The player " .. sendto
				.. " is not online."
	end
	minetest.log("action", "DM from " .. name .. " to " .. sendto
			.. ": " .. message)

	if 
		ignores.players.global[name] or
		ignores.messages.global[message]
	then
		return true, minetest.colorize("#ffffbb", "Message sent to "..sendto..": "..message)
	end
	if sendto ~= player
		and (
			(ignores.players.player[name] and ignores.players.player[name][sendto]) or
			(ignores.messages.player[message] and ignores.messages.player[message][sendto])
		)
	then
		return true, minetest.colorize("#ffffbb", "Message sent to "..sendto..": "..message)
	end

	minetest.chat_send_player(sendto, minetest.colorize("#bbffbb", "DM from " .. name .. ": "
			.. message))
	return true, minetest.colorize("#ffffbb", "Message sent to "..sendto..": "..message)
end

if minetest.registered_chatcommands["msg"] then
	minetest.unregister_chatcommand("msg")
end

minetest.register_chatcommand("msg", {
	params = "<name> <message>",
	description = "Send a direct message to a player",
	privs = {shout=true},
	func = msg,
})

-- Ignore system messages
minetest.chat_send_player = function (player, message)
	if ignores.messages.global[message] then
		return
	end
	if ignores.messages.player[message] and ignores.messages.player[message][player] then
		return
	end

	return orig_chat_send_player(player, message)
end

minetest.chat_send_all = function (message)
	if ignores.messages.global[message] then
		return
	end
	return orig_chat_send_all(message)
end