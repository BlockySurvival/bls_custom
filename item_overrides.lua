-- PLEASE KEEP MOD SECTIONS IN ALPHABETICAL ORDER
-- ORGANIZE LOGIC BY THE OVERRIDDEN ITEM

local function add_groups(itemstring, ...)
    local groups = table.copy(minetest.registered_items[itemstring].groups)
    for group in ipairs(...) do
        groups[group] = 1
    end
    minetest.override_item(itemstring, {groups=groups})
end

if minetest.get_modpath("caverealms") then
    -- make thin ice slippery
    add_groups("caverealms:thin_ice", "cracky", "slippery")
    add_groups("caverealms:hanging_thin_ice", "cracky", "slippery")
end

if minetest.get_modpath("cucina_vegana") then
end

if minetest.get_modpath("extra") then
    add_groups("extra:cottonseed_oil", "food_oil", "food_vegan")
    add_groups("extra:fish_sticks", "food_fish")
end
if minetest.get_modpath("mobs_animal") then
    add_groups("mobs:rat_cooked", "food_meat")
end
if minetest.get_modpath("mobs_fish") then
    add_groups("mobs_fish:clownfish", "food_fish")
    add_groups("mobs_fish:tropical", "food_fish")
end
if minetest.get_modpath("mobs_jellyfish") then
    add_groups("mobs_jellyfish:jellyfish", "food_fish")
end

if minetest.global_exists("maptools") then
    -- Temporarily disable pushers because rats in the trampoline
    for pusher_num = 1, 10 do
        add_groups("extra:cottonseed_oil", "food_oil", "food_vegan")
        minetest.override_item("maptools:pusher_" .. pusher_num, {
            groups = {
                unbreakable = 1,
                not_in_creative_inventory = maptools.creative,
            },
        })
    end

    -- Prevent super apples from being placed.
    minetest.override_item("maptools:superapple", {
        on_place = function(itemstack, placer, pointed_thing)
            local name = placer:get_player_name()
            minetest.chat_send_player(name, "[maptools] You can't place this!")
            return itemstack
        end,

        node_placement_prediction = "",
    })
end

if minetest.global_exists("xdecor") then
    minetest.override_item("xdecor:mailbox", {
        description="Mailbox (xdecor)",
    })
end

if minetest.get_modpath("youngtrees") then
    minetest.override_item("youngtrees:bamboo", {
        drop = {
            max_items = 1,
            items = {
                {rarity = 2, items = {"youngtrees:bamboo"}},
                {rarity = 2, items = {"default:stick"}},
            }
        }
    })
    minetest.override_item("youngtrees:youngtree2_middle", {
        drop = {
            max_items = 1,
            items = {
                {rarity = 2, items = {"youngtrees:youngtree2_middle"}},
                {rarity = 2, items = {"default:stick"}},
            }
        }
    })
    minetest.override_item("youngtrees:youngtree_top", {
        drop = {
            max_items = 1,
            items = {
                {rarity = 2, items = {"youngtrees:youngtree_top"}},
                {rarity = 2, items = {"default:stick"}},
            }
        }
    })
    minetest.override_item("youngtrees:youngtree_middle", {
        drop = {
            max_items = 1,
            items = {
                {rarity = 2, items = {"youngtrees:youngtree_middle"}},
                {rarity = 2, items = {"default:stick"}},
            }
        }
    })
    minetest.override_item("youngtrees:youngtree_bottom", {
        drop = {
            max_items = 1,
            items = {
                {rarity = 2, items = {"youngtrees:youngtree_bottom"}},
                {rarity = 2, items = {"default:stick"}},
            }
        }
    })
end
