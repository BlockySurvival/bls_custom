
-- ======= DATA STORAGE =======

local ignores = {
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
local ignores_by_player = {}

local mod_storage = bls.mod_storage

local stored_ignores = mod_storage:get_string('ignore_global')
if stored_ignores ~= "" then
	local deserialized_ignores = minetest.deserialize(stored_ignores)
	ignores.players.global = deserialized_ignores.players
	ignores.messages.global = deserialized_ignores.messages
end

local function set_table(tab, path, on_off)
	-- Set the value to 1/nil for on/off or true/false at the path in the table
	-- returns false if the value is already set correctly
	local t = tab
	for i,p in ipairs(path) do
		if i == #path then
			local v = on_off and 1 or nil
			if v == t[p] then
				return false
			end
			t[p] = v
			return true
		else
			if not on_off and not t[p] then
				return false
			end
			t[p] = t[p] or {}
			t = t[p]
		end
	end
	return false
end

local function set_ignore(path, player, on_off)
	local set_worked

	local ignore_path = table.copy(path)
	table.insert(ignore_path, player)
	set_worked = set_table(ignores, ignore_path, on_off)
	if not set_worked then return false end

	if player then
		local player_path = table.copy(path)
		table.insert(player_path, 1, player)
		set_worked = set_table(ignores_by_player, player_path, on_off)
		if not set_worked then return false end
	end

	return true
end

local function save_ignores(player_name)
	if player_name then
		local player = minetest.get_player_by_name(player_name)
		if not player then return end
		player:get_meta():set_string("ignore_config", minetest.serialize(ignores_by_player[player_name]))
	else
		mod_storage:set_string('ignore_global', minetest.serialize({
			players = ignores.players.global,
			messages = ignores.messages.global
		}))
	end
end

minetest.register_on_joinplayer(function(player)
	local player_name = player:get_player_name()
	ignores_by_player[player_name] = {}

	local stored_player_ingores = player:get_meta():get_string("ignore_config")
	if stored_player_ingores ~= "" then
		local deserialized_player_ignores = minetest.deserialize(stored_player_ingores)
		for ignore_type, ignore_conf in pairs(deserialized_player_ignores) do
			for ignore_scope, ignore_list in pairs(ignore_conf) do
				if ignore_scope ~= "global" then
					for player_or_message in pairs(ignore_list) do
						set_ignore({ignore_type, ignore_scope, player_or_message}, player_name, true)
					end
				end
			end
		end
	end
end)




-- ======= COMMANDS =======

minetest.register_privilege('ignore', 'allows players to ignore certain messages from chat')
minetest.register_privilege('ignore_admin', 'allows players to set globally ignored messages and administer ignores')

local output_map = {
	players = "from %s",
	messages = 'that equal "%s"',
	player = "messages",
	player_msg = "DMs",
	global = "messages globally"
}
local params_map = {
	players = "<player name>",
	messages = "<message text>",
}

local function output_message(start, action_path)
	return start.." "..output_map[action_path[2]].." "..output_map[action_path[1]]:format(action_path[3])
end

local function perform_action(command, player, action_path, param, on_off)
	if action_path[1] == "players" then
		local player_name = param
		if string.find(player_name, " ") then
			return false, ('"%s" is not a valid player name'):format(player_name)
		end
		if player_name == "" then
			return false, "Player name is empty, see /help "..command
		end
		if player_name == player then
			return false, "You cannot ignore yourself"
		end
	elseif action_path[1] == "messages" then
		local message_text = param
		if message_text == "" then
			return false, "Message text is empty, see /help "..command
		end
	end

	local ac = table.copy(action_path)
	table.insert(ac, param)

	local set_worked = set_ignore(ac, player, on_off)
	if not set_worked then
		return false, output_message("You are already "..(on_off and "" or "not ").."ignoring", ac)
	end

	save_ignores(player)
	return true, output_message("You "..(on_off and "are now" or "have stopped").." ignoring", ac)
end

local commands = {
	ignore_player = {
		action_path = {'players', 'player'},
		description = "%s the messages a player sends",
	},
	ignore_message = {
		action_path = {'messages', 'player'},
		description = "%s messages by their contents",
	},
	ignore_player_msg = {
		action_path = {'players', 'player_msg'},
		description = "%s the direct messages a player sends",
	},
	ignore_message_msg = {
		action_path = {'messages', 'player_msg'},
		description = "%s direct messages by their contents",
	},
	ignore_player_global = {
		action_path = {'players', 'global'},
		description = "%s the messages a player sends globally",
	},
	ignore_message_global = {
		action_path = {'messages', 'global'},
		description = "%s messages by their contents globally",
	},
}

local command_funcs = {
	ignore_list = function (player)
		local player_ignores = ignores_by_player[player]
		if not player_ignores then
			if not minetest.get_player_by_name(player) then
				return false, "That player is not logged in right now and their data is not present"
			end
			return false, "You are not ignoring anything right now"
		end
		local output = ""
		for ignore_type, ignore_conf in pairs(player_ignores) do
			for ignore_scope, ignore_list in pairs(ignore_conf) do
				if ignore_scope ~= "global" then
					for player_or_message in pairs(ignore_list) do
						output = output .. output_message("Ignoring", {ignore_type, ignore_scope, player_or_message}).."\n"
					end
				end
			end
		end
		if output == "" then
			return false, "You are not ignoring anything right now"
		end

		return true, output
	end,
}

local function add_command(cmd, config)
	local privs = {ignore=true}
	local is_global = config.action_path[2] == "global"
	if is_global then
		privs.ignore_admin = true
	end
	local uncmd = 'un'..cmd
	command_funcs[cmd] = function (player, param)
		return perform_action(cmd, (not is_global) and player, config.action_path, param, true)
	end
	minetest.register_chatcommand(cmd, {
		description = config.description:format("Ignore"),
		params = params_map[config.action_path[1]],
		privs = privs,
		func = command_funcs[cmd]
	})
	command_funcs[uncmd] = function (player, param)
		return perform_action(uncmd, (not is_global) and player, config.action_path, param, false)
	end
	minetest.register_chatcommand(uncmd, {
		description = config.description,
		params = params_map[config.action_path[1]]:format("Stop ignoring"),
		privs = privs,
		func = command_funcs[uncmd]
	})
end

for cmd, config in pairs(commands) do
	add_command(cmd, config)
end

minetest.register_chatcommand("ignore_list", {
	description = "List the things you are ignoring",
	privs = {ignore=true},
	func = command_funcs.ignore_list
})

minetest.register_chatcommand("ignore_admin", {
	params = "<player name> <command> <arguments>",
	description = "Run an ignore command in the name of another player",
	privs = {ignore=true,ignore_admin=true},
	func = function (player, param)
		local other_player, command, forward_param = param:match("^(%S+)%s+(%S+)(.*)$")
		if not other_player or not command then
			return false, "Invalid usage, see /help ignore_admin"
		end
		if command ~= 'ignore_list' and not minetest.get_player_by_name(other_player) then
			return false, "The target player is not currently logged on so their data cannot be saved"
		end
		local func = command_funcs[command]
		if not func then
			return false, ('The command "%s" does not exist'):format(command)
		end
		return func(other_player, string.trim(forward_param))
	end,
})



-- ======= INTERCEPTING MESSAGES =======

-- Keep original calls before we overwrite them
local orig_chat_send_player = minetest.chat_send_player
local orig_chat_send_all = minetest.chat_send_all
local orig_chat_message = function (sender, reciever, message)
	orig_chat_send_player(reciever, minetest.format_chat_message(sender, message))
end

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
	if sendto ~= name
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