-- PLEASE KEEP MOD SECTIONS IN ALPHABETICAL ORDER
-- ORGANIZE LOGIC BY THE OVERRIDDEN ITEM

if minetest.get_modpath('caverealms') then
    -- make thin ice slippery
    minetest.override_item('caverealms:thin_ice', {
        groups={cracky=3, slippery=5},
    })
    minetest.override_item('caverealms:hanging_thin_ice', {
        groups={cracky=3, slippery=5},
    })
end

if minetest.global_exists('maptools') then
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
    minetest.override_item('maptools:superapple', {
        on_place = function(itemstack, placer, pointed_thing)
            local name = placer:get_player_name()
            minetest.chat_send_player(name, "[maptools] You can't place this!")
            return itemstack
        end,

        node_placement_prediction = '',
    })
end

if minetest.global_exists('xdecor') then
    minetest.override_item('xdecor:mailbox', {
        description='Mailbox (xdecor)',
    })
end

