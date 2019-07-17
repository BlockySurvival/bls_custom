-- PLEASE KEEP MOD SECTIONS IN ALPHABETICAL ORDER
-- ORGANIZE LOGIC BY THE OVERRIDDEN ITEM

local chat_send_player = minetest.chat_send_player
local check_player_privs = minetest.check_player_privs
local get_modpath = minetest.get_modpath
local global_exists = minetest.global_exists
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

if global_exists('maptools') then
    -- let admin pick up coreglass stuff
    -- TODO: push this upstream
    override_item('maptools:pick_admin', {
        max_drop_level=4,
        groupcaps = {
            unbreakable = {times = {0,0,0}, uses = 0, maxlevel = 4},
            fleshy = {times = {0,0,0}, uses = 0, maxlevel = 4},
            choppy = {times = {0,0,0}, uses = 0, maxlevel = 4},
            bendy = {times = {0,0,0}, uses = 0, maxlevel = 4},
            cracky = {times = {0,0,0}, uses = 0, maxlevel = 4},
            crumbly = {times = {0,0,0}, uses = 0, maxlevel = 4},
            snappy = {times = {0,0,0}, uses = 0, maxlevel = 4},
        },
    })

    override_item('maptools:pick_admin_with_drops', {
        max_drop_level=4,
        groupcaps = {
            unbreakable = {times = {0,0,0}, uses = 0, maxlevel = 4},
            fleshy = {times = {0,0,0}, uses = 0, maxlevel = 4},
            choppy = {times = {0,0,0}, uses = 0, maxlevel = 4},
            bendy = {times = {0,0,0}, uses = 0, maxlevel = 4},
            cracky = {times = {0,0,0}, uses = 0, maxlevel = 4},
            crumbly = {times = {0,0,0}, uses = 0, maxlevel = 4},
            snappy = {times = {0,0,0}, uses = 0, maxlevel = 4},
        },
    })
    -- Temporarily disable pushers because rats in the trampoline
    for pusher_num = 1, 10 do
        minetest.override_item('maptools:pusher_' .. pusher_num, {
            groups = {
                unbreakable = 1,
                not_in_creative_inventory = maptools.creative,
            },
        })
    end

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

if global_exists('xdecor') then
    override_item('xdecor:mailbox', {
        description='Mailbox (xdecor)',
    })
end

-- Make default:chests regard protection
local function allowTakeWithProtection(pos, listname, index, stack, player)
    local name = player:get_player_name()
    if minetest.is_protected(pos, name) then
        bls.log('action', "Denied %s taking %s from chest at %s", name, stack:get_name(), minetest.pos_to_string(pos))
        return 0
    end
    return stack:get_count()
end

local function allowPutWithProtection(pos, listname, index, stack, player)
    local name = player:get_player_name()
    if minetest.is_protected(pos, name) then
        bls.log('action', "Denied %s putting %s in chest at %s", name, stack:get_name(), minetest.pos_to_string(pos))
        return 0
    end
    return stack:get_count()
end

local function allowMoveWithProtection(pos, from_list, from_index, to_list, to_index, count, player)
    local name = player:get_player_name()
    if minetest.is_protected(pos, name) then
        bls.log('action', "Denied %s moving items in chest at %s", name, minetest.pos_to_string(pos))
        return 0
    end
    return count
end

minetest.override_item("default:chest", {allow_metadata_inventory_take = allowTakeWithProtection, allow_metadata_inventory_put = allowPutWithProtection, allow_metadata_inventory_move = allowMoveWithProtection})
minetest.override_item("default:chest_open", {allow_metadata_inventory_take = allowTakeWithProtection, allow_metadata_inventory_put = allowPutWithProtection, allow_metadata_inventory_move = allowMoveWithProtection})
