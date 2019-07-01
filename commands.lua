local function pairsByKeys(t, f)
    local a = {}
    for n in pairs(t) do
        table.insert(a, n)
    end
    table.sort(a, f)
    local i = 0
    return function()
        i = i + 1
        if a[i] == nil then
            return nil
        else
            return a[i], t[a[i]]
        end
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
    for name, _ in pairsByKeys(inv:get_lists()) do
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
    for k, v in pairsByKeys(totals) do
        minetest.chat_send_player(tell, (' %s %s'):format(k, v))
    end
end

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

function bls_overrides.register_chatcommand(def)
    assert(type(def.name) == 'string' and def.name:sub(1, 1) ~= ':')
    def.params = def.params or ''
    assert(type(def.params) == 'string')
    assert(def.func)

    if def.sender_last then
        local func = def.func
        function def.func(name, ...) return func(..., name) end
        def.sender_last = nil
    end

    if def.pcall then
        local func = def.func
        function def.func(...)
            local good, msg, msg2 = func(...)
            if not good then
                return false, tostring(msg)
            elseif msg2 then
                return msg, msg2
            else
                return true, tostring(msg)
            end
        end
        def.pcall = nil
    end

    commands[def.name] = def
    if minetest.get_current_modname() == bls_overrides.modname then
        bls_overrides[def.name] = def.func
    end

    if created then create_commands() end
end

-- Only create /hax after mods are loaded.
minetest.register_on_mods_loaded(create_commands)

-- Create chatcommands
bls_overrides.register_chatcommand({
    name = 'snoop_areas',
    description = 'Find items in chests a player owns.',
    params = ':name:username',
    sender_last = true,
    pcall = true,
    func = snoop_areas,
})

bls_overrides.register_chatcommand({
    name = 'ping',
    func = function(name)
        return true, 'Pong'
    end
})
