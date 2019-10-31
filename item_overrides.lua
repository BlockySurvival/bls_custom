-- PLEASE KEEP MOD SECTIONS IN ALPHABETICAL ORDER
-- ORGANIZE LOGIC BY THE OVERRIDDEN ITEM

local function add_groups(itemstring, ...)
    local def = minetest.registered_items[itemstring]
    if not def then
        bls.log("warning", "trying to add groups to unknown item %q", itemstring)
    end
    local groups = table.copy(def.groups)
    for _, group in ipairs({...}) do
        local g, v = group:match("^([^=]+)=([^=]+)$")
        if g and v then
            group = g
            v = tonumber(v) or 1
        else
            v = 1
        end
        groups[group] = v
    end
    minetest.override_item(itemstring, {groups=groups})
end

if minetest.get_modpath("caverealms") then
    -- make thin ice slippery
    add_groups("caverealms:thin_ice", "cracky", "slippery=5")
    add_groups("caverealms:hanging_thin_ice", "cracky", "slippery=5")
end

if minetest.get_modpath("cucina_vegana") then
    local groups = table.copy(minetest.registered_items["cucina_vegana:imitation_meat"].groups)
    groups.food_meat = nil
    groups.food_meat_raw = 1
    minetest.override_item("cucina_vegana:imitation_meat", {groups=groups})

    local groups = table.copy(minetest.registered_items["cucina_vegana:imitation_poultry"].groups)
    groups.food_meat = nil
    groups.food_meat_raw = 1
    minetest.override_item("cucina_vegana:imitation_poultry", {groups=groups})
end

if minetest.get_modpath("cottages") then
    add_groups("cottages:rope", "vines")

    -- ANVIL STUFF --
    local anvil_whitelist = {}
    for _, tool in ipairs({"pick", "shovel", "axe", "sword", "hoe"}) do
        for _, material in ipairs({"bronze", "steel"}) do
            anvil_whitelist[("default:%s_%s"):format(tool, material)] = 1
        end

        for _, material in ipairs({"silver", "mithril"}) do
            anvil_whitelist[("moreores:%s_%s"):format(tool, material)] = 1
        end

        anvil_whitelist[("titanium:%s"):format(tool)] = 1
        anvil_whitelist[("goldtools:gold%s"):format(tool)] = 1
    end

    for _, tool in ipairs({"boots", "chestplate", "helmet", "leggings"}) do
        for _, material in ipairs({"bronze", "steel", "gold", "mithril"}) do
            anvil_whitelist[("3d_armor:%s_%s"):format(tool, material)] = 1
        end
    end
    for _, material in ipairs({"bronze", "steel", "gold", "mithril"}) do
        anvil_whitelist[("sheilds:shield_%s"):format(material)] = 1
    end

    anvil_whitelist["farming:hoe_steel"] = 1
    anvil_whitelist["farming:scythe_mithril"] = 1
    anvil_whitelist["fire:flint_and_steel"] = 1
    anvil_whitelist["mobs:shears"] = 1
    anvil_whitelist["screwdriver:screwdriver"] = 1

    local anvil_on_punch_orig = minetest.registered_nodes["cottages:anvil"].on_punch
    local anvil_allow_metadata_inventory_put_orig = minetest.registered_nodes["cottages:anvil"].allow_metadata_inventory_put
    minetest.override_item("cottages:anvil", {
        on_punch = function(pos, node, puncher)
            local meta = minetest.get_meta(pos);
            local inv  = meta:get_inventory();
            local input = inv:get_stack("input", 1);
            if anvil_whitelist[input:get_name()] then
                return anvil_on_punch_orig(pos, node, puncher)
            end
        end,
        allow_metadata_inventory_put = function(pos, listname, index, stack, player)
            if listname ~= "input" or anvil_whitelist[stack:get_name()] then
                return anvil_allow_metadata_inventory_put_orig(pos, listname, index, stack, player)
            end
            minetest.chat_send_player(player:get_player_name(), "Not repairable on the anvil")
            return 0
        end,
        drop = {},
    })
end

if minetest.get_modpath("extra") then
    add_groups("extra:cottonseed_oil", "food_oil", "food_vegan")
    add_groups("extra:fish_sticks", "food_fish")
end

if minetest.get_modpath("farming") and farming.mod == "redo" then
    add_groups("farming:hemp_rope", "vines")
end

if minetest.global_exists("maptools") then
    -- Temporarily disable pushers because rats in the trampoline
    for pusher_num = 1, 10 do
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

if minetest.get_modpath("moreblocks") then
    add_groups("moreblocks:rope", "vines")
end

if minetest.global_exists("xdecor") then
    minetest.override_item("xdecor:mailbox", {
        description="Mailbox (xdecor)",
    })

    add_groups("xdecor:rope", "vines")
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
