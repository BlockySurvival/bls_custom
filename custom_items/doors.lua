--
-- bls - Doors
--

if minetest.global_exists("doors") and doors.door_toggle then
    -- Load doors.lua if minetest_game 5.0.0 or later is installed
    local protected_doors = {}
    local def_overrides = {
        can_dig = function(pos, digger)
            local name = digger:get_player_name()
            if minetest.is_protected(pos, name) then
                minetest.record_protection_violation(pos, name)
                return false
            end
            return true
        end,

        on_skeleton_key_use = function(pos, player, newsecret)
            local pname = player:get_player_name()

            -- Verify placer has access to the area.
            if minetest.is_protected(pos, pname) then
                minetest.record_protection_violation(pos, pname)
                minetest.chat_send_player(pname,
                                          "You are not added to the protection of this door.")
                return nil
            end

            local meta = minetest.get_meta(pos)
            local secret = meta:get_string("key_lock_secret")
            if secret == "" then
                secret = newsecret
                meta:set_string("key_lock_secret", secret)
            end

            return secret, "a protected door", pname
        end,
    }

    -- Register protected doors
    local function register_protected_door(name, def)
        if not name:find(":") then
            name = "bls:" .. name
        end
        protected_doors[name .. "_a"] = true
        protected_doors[name .. "_b"] = true
        def.protected = true

        -- Add the door
        doors.register(name, def)

        -- Change callbacks
        def = minetest.registered_items[name .. "_a"]

        -- The doors mod is lazy and uses the same table for both door nodes.
        def.name = name .. "_a"
        def.mesh = "door_a.obj"

        minetest.override_item(name .. "_a", {
            can_dig = def_overrides.can_dig,
            on_skeleton_key_use = def_overrides.on_skeleton_key_use
        })

        def.name = name .. "_b"
        def.mesh = "door_b.obj"

        minetest.override_item(name .. "_b", {
            can_dig = def_overrides.can_dig,
            on_skeleton_key_use = def_overrides.on_skeleton_key_use
        })
        return name
    end

    -- Hijack on_place
    minetest.register_on_placenode(function(pos, newnode, placer, oldnode,
                                            itemstack, pointed_thing)
        if protected_doors[newnode.name] then
            local meta = minetest.get_meta(pos)
            meta:set_string("owner", ".")
            meta:set_string("infotext", "Protected Door")
        end
    end)

    -- Hijack doors.door_toggle
    local door_toggle = assert(doors.door_toggle, "minetest_game 5.0+ required.")
    function doors.door_toggle(pos, node, clicker)
        node = node or minetest.get_node(pos)

        -- Handle protected doors
        if protected_doors[node.name] and clicker then
            local name = clicker
            if minetest.is_player(name) then name = name:get_player_name() end
            if minetest.is_protected(pos, name) then
                minetest.record_protection_violation(pos, name)
                return false
            end
            clicker = nil
        end

        return door_toggle(pos, node, clicker)
    end

    local name = register_protected_door("door_steel_protected", {
        tiles = {{name = "doors_door_steel.png^[combine:7x10:6,19=doors_protector.png", backface_culling = true}},
        description = "Protected Door",
        inventory_image = "doors_item_steel.png^[combine:7x10:0,0=doors_protector.png",
        groups = {cracky = 1, level = 2},
        sounds = default.node_sound_metal_defaults(),
        sound_open = "doors_steel_door_open",
        sound_close = "doors_steel_door_close",
        recipe = {
            {"default:steel_ingot", "default:steel_ingot"},
            {"default:steel_ingot", "default:copper_ingot"},
            {"default:steel_ingot", "default:steel_ingot"},
        }
    })

    -- Alias the old door nodes
    minetest.register_alias("doors:door_steel_protected", name)
    minetest.register_alias("doors:door_steel_protected_a", name .. "_a")
    minetest.register_alias("doors:door_steel_protected_b", name .. "_b")
end
