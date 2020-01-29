if not minetest.global_exists("ChatCmdBuilder") then return end
local storage = bls.mod_storage

local commands = {}
local created = false

local function create_commands()
    if minetest.registered_chatcommands["hax"] then
        minetest.unregister_chatcommand("hax")
    end

    ChatCmdBuilder.new("hax", function(cmd)
        for name, def in pairs(commands) do
            if def.params == "" then
                cmd:sub(name, def.func)
            else
                cmd:sub(name .. " " .. def.params, def.func)
            end
        end

        -- Get the commands list
        local help_msg = minetest.colorize("#00ffff", "Available commands: ")
        do
            local cmds = {}
            for k, v in pairs(commands) do
                cmds[#cmds + 1] = k
            end
            table.sort(cmds)
            help_msg = help_msg .. table.concat(cmds, ", ")
        end

        cmd:sub("help", function(name)
            return true, help_msg
        end)

        cmd:sub("help :command", function(name, command)
            if not commands[command] then
                return false, "Command not available: " .. command
            end
            local def = commands[command]
            local msg = minetest.colorize("#00ffff", "/hax " .. def.name) ..
                    " " .. def.params
            if def.description then
                msg = msg .. ": " .. def.description
            end
            return true, msg
        end)
    end, {
        description = "Do /hax help or /hax help <subcommand>.",
        privs = {server=true},
    })

    created = true
end

function bls.register_chatcommand(def)
    assert(type(def.name) == "string" and def.name:sub(1, 1) ~= ":")
    def.params = def.params or ""
    assert(type(def.params) == "string")
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
                return false, tostring(msg or "Unknown error!")
            elseif msg2 then
                return msg, msg2
            elseif type(msg) == "table" then
                return true, dump(msg)
            else
                return true, tostring(msg or "Done!")
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

bls.register_chatcommand({
     name = "ping",
     func = function(name)
         return true, "Pong"
     end
 })

local function find_invs(name, pos1, pos2, tell)
    local poss = {}
    local area = (pos2.x - pos1.x) * (pos2.y - pos1.y) * (pos2.z - pos1.z)
    if area > (128*64*64) then
        minetest.chat_send_player(tell, ("skipping %q; it is too large"):format(name));
        return poss
    end
    for x = pos1.x, pos2.x do
        for y = pos1.y, pos2.y do
            for z = pos1.z, pos2.z do
                local pos = {x=x,y=y,z=z}
                local inv = minetest.get_inventory({type="node", pos=pos})
                if inv then
                    poss[minetest.pos_to_string(pos)] = inv
                end
            end
        end
    end
    return poss
end

bls.register_chatcommand({
     name = "find_invs",
     description = "Find inventories between pos1 and pos2.",
     params = ":name :pos1:pos :pos2:pos",
     sender_last = true,
     pcall = true,
     func = find_invs,
 })

local function snoop_inv(pos, inv, tell)
    local counts = {}
    for name, _ in bls.util.pairs_by_keys(inv:get_lists()) do
        minetest.chat_send_player(tell, (" %s@%s"):format(name, pos))
        for i=1, inv:get_size(name) do
            local s = inv:get_stack(name, i);
            local n = s:get_name()
            if n ~= "" then
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
    minetest.chat_send_player(tell, "TOTALS:")
    for k, v in bls.util.pairs_by_keys(totals) do
        minetest.chat_send_player(tell, (" %s %s"):format(k, v))
    end
end

-- Create chatcommands
bls.register_chatcommand({
     name = "snoop_areas",
     description = "Find items in chests a player owns.",
     params = ":name:username",
     sender_last = true,
     pcall = true,
     func = snoop_areas,
 })

local function snoop_player_inv(inv, name, tell)
    minetest.chat_send_player(tell, "contents of \""..name.."\"")
    for i=1, inv:get_size(name) do
        local s = inv:get_stack(name, i);
        local n = s:get_name();
        if n ~= "" then
            minetest.chat_send_player(tell, "  "..n.." "..s:get_count())
        end
    end
end

local function snoop_player_invs(name, tell)
    local inv = minetest.get_inventory({type="player", name=name})
    if not inv then
        minetest.chat_send_player(tell, "\""..name.."\" is not connected.");
        return
    else
        minetest.chat_send_player(tell, "inspecting \""..name.."\"s stuff...")
    end
    for lname, _ in bls.util.pairs_by_keys(inv:get_lists()) do
        snoop_player_inv(inv, lname, tell)
    end
end

bls.register_chatcommand({
     name = "snoop_player_invs",
     description = "Snoop the player inventories of a player.",
     params = ":name:username",
     sender_last = true,
     pcall = true,
     func = snoop_player_invs,
 })

local function clear_player_invs(name, tell)
    local inv = minetest.get_inventory({type="player", name=name})
    if not inv then
        minetest.chat_send_player(tell, "\""..name.."\" is not connected.");
        return
    else
        minetest.chat_send_player(tell, "clearing \""..name.."\"s stuff...")
    end
    for lname, _ in bls.util.pairs_by_keys(inv:get_lists()) do
        inv:set_list(lname, {})
    end
end

bls.register_chatcommand({
     name = "clear_player_invs",
     description = "Clear the player inventories of a player.",
     params = ":name:username",
     sender_last = true,
     pcall = true,
     func = clear_player_invs,
 })

bls.register_chatcommand({
     name = "grant_fake",
     description = "Give a player a fake privilege",
     params = ":name:username :priv:word",
     pcall = true,
     func = function(caller, name, priv)
         if minetest.player_exists(name) then
             local privs = minetest.get_player_privs(name)
             privs[priv] = true
             minetest.set_player_privs(name, privs)
             return true, ("Privs of %s: %s"):format(name, minetest.privs_to_string(privs))
         else
             return false, "No such player"
         end
     end,
 })

bls.register_chatcommand({
     name = "blind",
     description = "Blind a player",
     params = ":name:username",
     pcall = true,
     func = function(caller, name)
         local player = minetest.get_player_by_name(name)
         if player then
             player:override_day_night_ratio(0)
             return true, "blinded"
         else
             return false, "No such player"
         end
     end,
 })

local function set_title(name, title)
    local player = minetest.get_player_by_name(name)
    if not player then return false end
    if title and title ~= "" then
        player:set_nametag_attributes({
                                          text = minetest.colorize("#FF0000", title).."\n"..name,
                                      })
    else
        player:set_nametag_attributes({text = name})
    end
    return true
end

minetest.register_on_joinplayer(function(player)
    local name = player:get_player_name()
    local title = storage:get_string(("%s_title"):format(name))
    if title and title ~= "" then
        minetest.after(0, set_title, name, title)
    end
end)

bls.register_chatcommand({
     name = "title",
     description = "Give a player a \"title\" above their name",
     params = ":name:username :title:word",
     pcall = true,
     func = function(caller, name, title)
         if minetest.player_exists(name) then
             storage:set_string(("%s_title"):format(name), title)
             set_title(name, title)
             return true, "Title set"
         else
             return false, "No such player"
         end
     end,
 })

bls.register_chatcommand({
     name = "untitle",
     description = "Remove a title from a player.",
     params = ":name:username",
     pcall = true,
     func = function(caller, name)
         if minetest.player_exists(name) then
             storage:set_string(("%s_title"):format(name), "")
             set_title(name, "")
             return true, "Title set"
         else
             return false, "No such player"
         end
     end,
 })

-- Only create /hax after mods are loaded.
minetest.register_on_mods_loaded(create_commands)
