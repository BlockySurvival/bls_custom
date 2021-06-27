if not minetest.get_modpath("more_monoids") then return end

bls.afk = {}

local AFK_CHECK_INTERVAL = 15  -- seconds
local AFK_BOUND_PERIOD = 10 * 1 * 1000000 -- microseconds

local assertions_by_player = {}
local last_action_by_player = {}
local previous_keys_by_player = {}
local afk_check_elapsed = 0

local function time_since_last_action(player_name)
    local last_action = last_action_by_player[player_name]
    if last_action then
        return minetest.get_us_time() - last_action
    end
    return 0
end

local function is_afk(player, afk_us)
    local text = minetest.colorize("#FF0000", ("AFK for %im"):format(afk_us / (60 * 1000000)))
    more_monoids.player_tag:add_change(player, text, "afk")
end

local function is_not_afk(player)
    more_monoids.player_tag:del_change(player, "afk")
    assertions_by_player[player:get_player_name()] = nil
end

function bls.afk.set_afk(player, afk_us)
    if assertions_by_player[player:get_player_name()] or afk_us > AFK_BOUND_PERIOD then
        is_afk(player, afk_us)
    else
        is_not_afk(player)
    end
end

function bls.afk.note_action(player, name)
    name = name or player:get_player_name()
    last_action_by_player[name] = minetest.get_us_time()
    is_not_afk(player)
end

-- globalstep to update AFK tag
minetest.register_globalstep(function(delta)
    afk_check_elapsed = afk_check_elapsed + delta
    if afk_check_elapsed > AFK_CHECK_INTERVAL then
        afk_check_elapsed = 0
        local now = minetest.get_us_time()

        for _, player in ipairs(minetest.get_connected_players()) do
            local player_name = player:get_player_name()
            local last_action = last_action_by_player[player_name]
            if last_action then
                bls.afk.set_afk(player, now - last_action)
            else
                last_action_by_player[player_name] = now
            end
        end
    end
end)

minetest.register_globalstep(function(delta)
    for _, player in ipairs(minetest.get_connected_players()) do
        local player_name = player:get_player_name()
        local previous_keys = previous_keys_by_player[player_name]
        local current_keys = player:get_player_control()
        previous_keys_by_player[player_name] = current_keys
        if not bls.util.tables_equal(current_keys, previous_keys) then
            bls.afk.note_action(player, player_name)
        end
    end
end)

minetest.register_on_placenode(function(pos, newnode, player, oldnode, itemstack, pointed_thing)
    if player then bls.afk.note_action(player) end
end)

minetest.register_on_dignode(function(_, _, player)
    if player then bls.afk.note_action(player) end
end)

minetest.register_on_punchnode(function(_, _, player, _)
    if player then bls.afk.note_action(player) end
end)

minetest.register_on_punchplayer(function(player, hitter, time_from_last_punch, tool_capabilities, dir, damage)
    if player then bls.afk.note_action(player) end
end)

minetest.register_on_joinplayer(function(player, last_login)
    if player then bls.afk.note_action(player) end
end)

minetest.register_on_leaveplayer(function(player, timed_out)
    if player then
        local name = player:get_player_name()
        last_action_by_player[name] = nil
        assertions_by_player[name] = nil
    end
end)

minetest.register_on_chat_message(function(name, message)
    local player = minetest.get_player_by_name(name)
    if player then bls.afk.note_action(player, name) end
end)

minetest.register_on_player_receive_fields(function(player)
    if player then bls.afk.note_action(player) end
end)

minetest.register_on_craft(function(itemstack, player, old_craft_grid, craft_inv)
    if player then bls.afk.note_action(player) end
end)

minetest.register_allow_player_inventory_action(function(player, action, inventory, inventory_info)
    if player then bls.afk.note_action(player) end
end)

minetest.register_on_player_inventory_action(function(player, action, inventory, inventory_info)
    if player then bls.afk.note_action(player) end
end)

minetest.register_on_protection_violation(function(pos, name)
    local player = minetest.get_player_by_name(name)
    if player then bls.afk.note_action(player, name) end
end)

minetest.register_on_item_eat(function(hp_change, replace_with_item, itemstack, player, pointed_thing)
    if player then bls.afk.note_action(player) end
end)

minetest.register_chatcommand("afk", {
    description = "Mark yourself as AFK so other players will know you're not available",
    params = "(<reason>)",
    func = function(player, reason)
        is_afk(minetest.get_player_by_name(player), time_since_last_action(player))
        assertions_by_player[player] = reason
    end,
})

minetest.register_chatcommand("is_afk", {
    description = "Check if a player has the AFK flag",
    params = "<player>",
    func = function(player, given_player_name)

        local target_player = bls.util.get_player_by_name(given_player_name)
        if not target_player then
            minetest.chat_send_player(player, ('No player named "%s" is currently logged in'):format(given_player_name))
            return
        end

        local cannon_player_name = target_player:get_player_name()
        local afk_us = time_since_last_action(cannon_player_name)
        local reason = assertions_by_player[cannon_player_name]

        if reason or afk_us > AFK_BOUND_PERIOD then
            minetest.chat_send_player(player, ('Player "%s" has been AFK for %im%s'):format(
                cannon_player_name,
                afk_us / (60 * 1000000),
                reason and #reason > 0 and ": "..reason or ""
            ))
        else
            minetest.chat_send_player(player, ('Player "%s" does not seem to be AFK'):format(cannon_player_name))
        end
    end,
})