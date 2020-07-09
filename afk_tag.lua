if not minetest.get_modpath("more_monoids") then return end

bls.afk = {}

local AFK_CHECK_INTERVAL = 15  -- seconds
local AFK_BOUND_PERIOD = 10 * 60 * 1000000 -- microseconds

local last_action_by_player = {}
local previous_keys_by_player = {}
local afk_check_elapsed = 0

function bls.afk.set_afk(player, afk_us)
    if afk_us > AFK_BOUND_PERIOD then
        local text = minetest.colorize("#FF0000", ("AFK for %im"):format(afk_us / (60 * 1000000)))
        more_monoids.player_tag:add_change(player, text, "afk")
    else
        more_monoids.player_tag:del_change(player, "afk")
    end
end

function bls.afk.note_action(name)
    last_action_by_player[name] = minetest.get_us_time()
    more_monoids.player_tag:del_change(minetest.get_player_by_name(name), "afk")
end

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
            bls.afk.note_action(player_name)
        end
    end
end)

minetest.register_on_dignode(function(_, _, player)
    bls.afk.note_action(player:get_player_name())
end)

minetest.register_on_punchnode(function(_, _, player, _)
    bls.afk.note_action(player:get_player_name())
end)

minetest.register_on_punchplayer(function(player, hitter, time_from_last_punch, tool_capabilities, dir, damage)
    bls.afk.note_action(player:get_player_name())
end)

minetest.register_on_joinplayer(function(player, last_login)
    bls.afk.note_action(player:get_player_name())
end)

minetest.register_on_leaveplayer(function(player, timed_out)
    last_action_by_player[player:get_player_name()] = nil
end)

minetest.register_on_chat_message(function(name, message)
    bls.afk.note_action(name)
end)

minetest.register_on_player_receive_fields(function(player)
    bls.afk.note_action(player:get_player_name())
end)

minetest.register_on_craft(function(itemstack, player, old_craft_grid, craft_inv)
    bls.afk.note_action(player:get_player_name())
end)

minetest.register_allow_player_inventory_action(function(player, action, inventory, inventory_info)
    bls.afk.note_action(player:get_player_name())
end)

minetest.register_on_player_inventory_action(function(player, action, inventory, inventory_info)
    bls.afk.note_action(player:get_player_name())
end)

minetest.register_on_protection_violation(function(pos, name)
    bls.afk.note_action(name)
end)

minetest.register_on_item_eat(function(hp_change, replace_with_item, itemstack, player, pointed_thing)
    bls.afk.note_action(player:get_player_name())
end)

