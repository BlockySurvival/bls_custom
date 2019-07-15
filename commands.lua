local function snoop_player_inv(inv, name, tell)
    minetest.chat_send_player(tell, 'contents of "'..name..'"')
    for i=1, inv:get_size(name) do
        local s = inv:get_stack(name, i);
        local n = s:get_name();
        if n ~= '' then
            minetest.chat_send_player(tell, '  '..n..' '..s:get_count())
        end
    end
end

local function snoop_player_invs(name, tell)
    local inv = minetest.get_inventory({type='player', name=name})
    if not inv then
        minetest.chat_send_player(tell, '"'..name..'" is not connected.');
        return
    else
        minetest.chat_send_player(tell, 'inspecting "'..name..'"s stuff...')
    end
    for lname, _ in bls.util.pairs_by_keys(inv:get_lists()) do
        snoop_player_inv(inv, lname, tell)
    end
end

local function clear_player_invs(name, tell)
    local inv = minetest.get_inventory({type='player', name=name})
    if not inv then
        minetest.chat_send_player(tell, '"'..name..'" is not connected.');
        return
    else
        minetest.chat_send_player(tell, 'clearing "'..name..'"s stuff...')
    end
    for lname, _ in bls.util.pairs_by_keys(inv:get_lists()) do
        inv:set_list(lname, {})
    end
end

local function find_invs(name, pos1, pos2, tell)
    local poss = {}
    local area = (pos2.x - pos1.x) * (pos2.y - pos1.y) * (pos2.z - pos1.z)
    if area > (128*64*64) then
        minetest.chat_send_player(tell, ('skipping "%s"; it is too large'):format(name));
        return poss
    end
    for x = pos1.x, pos2.x do
        for y = pos1.y, pos2.y do
            for z = pos1.z, pos2.z do
                local pos = {x=x,y=y,z=z}
                local inv = minetest.get_inventory({type='node', pos=pos})
                if inv then
                    poss[minetest.pos_to_string(pos)] = inv
                end
            end
        end
    end
    return poss
end

local function snoop_inv(pos, inv, tell)
    local counts = {}
    for name, _ in bls.util.pairs_by_keys(inv:get_lists()) do
        minetest.chat_send_player(tell, (' %s@%s'):format(name, pos))
        for i=1, inv:get_size(name) do
            local s = inv:get_stack(name, i);
            local n = s:get_name()
            if n ~= '' then
                counts[n] = (counts[n] or 0) + s:get_count()
            end
        end
    end
    return counts
end

local function snoop_areas(name, tell)
    local invs = {}
    for _, area in pairs(areas.areas) do
        if area.owner == name then
            for pos, inv in pairs(find_invs(area.name, area.pos1, area.pos2, tell)) do
                invs[pos] = inv
            end
        end
    end
    local totals = {}
    for pos, inv in pairs(invs) do
        for k, v in pairs(snoop_inv(pos, inv, tell)) do
            totals[k] = (totals[k] or 0) + v
        end
    end
    minetest.chat_send_player(tell, 'TOTALS:')
    for k, v in bls.util.pairs_by_keys(totals) do
        minetest.chat_send_player(tell, (' %s %s'):format(k, v))
    end
end

minetest.register_chatcommand("sunlight", {
    -- Give players with "settime" priv the ability to override their day-night ratio
    params = "<ratio>",
    description = "Override one's day night ratio. (1 = always day, 0 = always night)",
    privs = {settime = true},
    func = function(name, param)
        local ratio = tonumber(param)
        minetest.get_player_by_name(name):override_day_night_ratio(ratio)
    end
})

minetest.register_chatcommand("whatisthis", {
	params = "",
	description = "Get itemstring of wielded item",
	func = function(player_name, param)
		local player = minetest.get_player_by_name(player_name)
		minetest.chat_send_player(player_name, player:get_wielded_item():to_string())
		return
	end
})

minetest.register_chatcommand('grant_fake', {
	params = "<player> <fake_priv>",
    description = "Give a player a fake privilege",
    privs = {server=true},
    func = function(caller, param)
        local player_name, priv = param:match('^(%S+)%s+(%S+)')
        if not player_name then
            return false, 'Invalid arguments'
        elseif minetest.player_exists(player_name) then
            local privs = minetest.get_player_privs(player_name)
            privs[priv] = true
            minetest.set_player_privs(player_name, privs)
            return true, ('Privs of %s: %s'):format(player_name, minetest.privs_to_string(privs))
        else
            return false, 'No such player'
        end
    end
})

-- PUNISHMENTS
local invalid_player = "Invalid player"
local invalid_punishment = "Invalid punishment"

local function ownsAreaAt(name, pos)
    local owners = areas:getNodeOwners(pos)
    for _, p in pairs(owners) do
        if p == name then
            return true
        end
    end
    return false
end

bls.punishments = {
    hotfoot = {
        func = function(pname)
            local p = minetest.get_player_by_name(pname)
            if p then
                local pos = p:get_pos()
                if minetest.get_node(pos).name == "air" then
                    minetest.set_node(pos, {name = "fire:basic_flame"})
                end
            end
        end,
        every = 0
    },
    tnt_rain = {
        func = function(pname)
            local p = minetest.get_player_by_name(pname)
            if p then
                local pos = p:get_pos()
                local above = {x = pos.x, y = pos.y + 10, z = pos.z}
                if ownsAreaAt(pname, pos) then
                    minetest.set_node(above, {name = "tnt:tnt_burning"})
                end
            end
        end,
        every = 5
    },
    butterfingers = {
        func = function(pname)
            local p = minetest.get_player_by_name(pname)
            if p then
                local inv = p:get_inventory()
                local stacks = inv:get_list("main")
                local stackIndex = math.random(#stacks)
                local take = stacks[stackIndex]
                inv:remove_item("main", take)
                minetest.add_item(p:get_pos(), take)
            end
        end,
        every = 3
    }
}

bls.punished = {}

minetest.register_globalstep(function(dtime)
    for name, punishment in pairs(bls.punished) do
        punishment.time = punishment.time - dtime
        punishment.timer = punishment.timer + dtime
        if punishment.time < 0 then
            bls.punished[name] = nil
            return
        end
        if punishment.timer >= punishment.every then
            punishment.timer = 0
            punishment.func(name)
        end
    end
end)

minetest.register_privilege("punish", "Allows a player to invoke creative punishments on other players")

function bls.punish(name, p_name, punishment, tStr)
    -- Verify input
    if minetest.get_player_by_name(p_name) == nil then
        return false, invalid_player
    end
    if bls.punishments[punishment] == nil then
        return false, invalid_punishment
    end
    if not tStr then tStr = '5m' end
    -- Is there a letter on the end of tStr?
    local mult = 1
    local multStr = tStr:sub(-1)
    local tInt
    if multStr:lower() ~= multStr:upper() then -- Not a number
        multStr = multStr:lower()
        if multStr == "s" then mult = 1
        elseif multStr == "m" then mult = 60
        elseif multStr == "h" then mult = 3600
        elseif multStr == "d" then mult = 86400
        else minetest.chat_send_player(name, "Invaild time multiplier, assuming seconds") end
        tInt = tonumber(tStr:sub(1, -2))
    else
        tInt = tonumber(tStr)
    end
    if tInt then
        tInt = tInt * mult
    else
        return false, "Invalid time"
    end
    bls.punished[p_name] = {
                            ["time"] = tInt,
                            ["timer"] = 0,
                            ["func"] = bls.punishments[punishment].func,
                            ["every"] = bls.punishments[punishment].every
                            }
    return true, "Done!"
end

ChatCmdBuilder.new("punish", function(cmd)
    -- TODO: make this part of the following framework
    cmd:sub(":pname :punishment :time", function(name, p_name, punishment, tStr)
        return bls.punish(name, p_name, punishment, tStr)
    end)
    cmd:sub(":pname :punishment", function(name, p_name, punishment, tStr)
        return bls.punish(name, p_name, punishment, "5m")
    end)
end, {
    description = "Invokes creative punishments on a player",
    privs = {punish = true},
})

-- Chatcommands

local commands = {}
local created = false
local function create_commands()
    if minetest.registered_chatcommands['hax'] then
        minetest.unregister_chatcommand('hax')
    end

    ChatCmdBuilder.new('hax', function(cmd)
        for name, def in pairs(commands) do
            if def.params == '' then
                cmd:sub(name, def.func)
            else
                cmd:sub(name .. ' ' .. def.params, def.func)
            end
        end

        -- Get the commands list
        local help_msg = minetest.colorize('#00ffff', 'Available commands: ')
        do
            cmds = {}
            for k, v in pairs(commands) do
                cmds[#cmds + 1] = k
            end
            table.sort(cmds)
            help_msg = help_msg .. table.concat(cmds, ', ')
        end

        cmd:sub('help', function(name)
            return true, help_msg
        end)

        cmd:sub('help :command', function(name, command)
            if not commands[command] then
                return false, 'Command not available: ' .. command
            end
            local def = commands[command]
            local msg = minetest.colorize('#00ffff', '/hax ' .. def.name) ..
                ' ' .. def.params
            if def.description then
                msg = msg .. ': ' .. def.description
            end
            return true, msg
        end)
    end, {
        description = 'Do /hax help or /hax help <subcommand>.',
        privs = {server=true},
    })

    created = true
end

function bls.register_chatcommand(def)
    assert(type(def.name) == 'string' and def.name:sub(1, 1) ~= ':')
    def.params = def.params or ''
    assert(type(def.params) == 'string')
    assert(def.func)

    if def.sender_last then
        local func = def.func
        function def.func(name, ...)
            local args = {...}
            args[#args + 1] = name
            return func((table.unpack or unpack)(args))
        end
        def.sender_last = nil
    end

    if def.pcall then
        local func = def.func
        function def.func(...)
            local good, msg, msg2 = pcall(func, ...)
            if not good then
                return false, tostring(msg or 'Unknown error!')
            elseif msg2 then
                return msg, msg2
            elseif type(msg) == 'table' then
                return true, dump(msg)
            else
                return true, tostring(msg or 'Done!')
            end
        end
        def.pcall = nil
    end

    commands[def.name] = def
    if minetest.get_current_modname() == bls.modname then
        bls[def.name] = def.func
    end

    if created then create_commands() end
end

-- Only create /hax after mods are loaded.
minetest.register_on_mods_loaded(create_commands)

-- Create chatcommands
bls.register_chatcommand({
    name = 'snoop_areas',
    description = 'Find items in chests a player owns.',
    params = ':name:username',
    sender_last = true,
    pcall = true,
    func = snoop_areas,
})

bls.register_chatcommand({
    name = 'ping',
    func = function(name)
        return true, 'Pong'
    end
})

bls.register_chatcommand({
    name = 'find_invs',
    description = 'Find inventories between pos1 and pos2.',
    params = ':name :pos1:pos :pos2:pos',
    sender_last = true,
    pcall = true,
    func = find_invs,
})

bls.register_chatcommand({
    name = 'snoop_player_invs',
    description = 'Snoop the player inventories of a player.',
    params = ':name:username',
    sender_last = true,
    pcall = true,
    func = snoop_player_invs,
})

bls.register_chatcommand({
    name = 'clear_player_invs',
    description = 'Clear the player inventories of a player.',
    params = ':name:username',
    sender_last = true,
    pcall = true,
    func = clear_player_invs,
})
