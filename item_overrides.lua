-- PLEASE KEEP MOD SECTIONS IN ALPHABETICAL ORDER
-- ORGANIZE LOGIC BY THE OVERRIDDEN ITEM

local chat_send_player = minetest.chat_send_player
local check_player_privs = minetest.check_player_privs
local get_modpath = minetest.get_modpath
local override_item = minetest.override_item
local registered_items = minetest.registered_items

if get_modpath('bucket') then
    -- Prevent lava being placed over -5m
    local on_place = registered_items['bucket:bucket_lava'].on_place
    override_item('bucket:bucket_lava', {
        on_place = function(itemstack, user, pointed_thing)
            local player_name = user:get_player_name()
            if pointed_thing.above.y > -5 and not check_player_privs(player_name, {lava = true}) then
                chat_send_player(player_name, "You cannot place lava over -5m.", true)
                return itemstack
            end
            return on_place(itemstack, user, pointed_thing)
        end
    })
end

if get_modpath('caverealms') then
    -- make thin ice slippery
    override_item('caverealms:thin_ice', {
        groups={cracky=3, slippery=5},
    })
    override_item('caverealms:hanging_thin_ice', {
        groups={cracky=3, slippery=5},
    })
end

if get_modpath('maptools') then
    -- let admin pick up coreglass stuff
    -- TODO: push this upstream
    override_item('maptools:pick_admin', {
        max_drop_level=4,
        groupcaps = {
            unbreakable = {times = {0,0,0,0}, uses = 0, maxlevel = 4},
            fleshy = {times = {0,0,0,0}, uses = 0, maxlevel = 4},
            choppy = {times = {0,0,0,0}, uses = 0, maxlevel = 4},
            bendy = {times = {0,0,0,0}, uses = 0, maxlevel = 4},
            cracky = {times = {0,0,0,0}, uses = 0, maxlevel = 4},
            crumbly = {times = {0,0,0,0}, uses = 0, maxlevel = 4},
            snappy = {times = {0,0,0,0}, uses = 0, maxlevel = 4},
        },
    })

    -- Prevent super apples from being placed.
    override_item('maptools:superapple', {
        on_place = function(itemstack, placer, pointed_thing)
            local name = placer:get_player_name()
            minetest.chat_send_player(name, "[maptools] You can't place this!")
            return itemstack
        end,

        node_placement_prediction = '',
    })
end
