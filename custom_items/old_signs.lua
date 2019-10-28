local function register_sign(material, desc, def)
        minetest.register_node("bls:sign_wall_" .. material, {
                description = desc,
                drawtype = "nodebox",
                tiles = {"default_sign_wall_" .. material .. ".png"},
                inventory_image = "default_sign_" .. material .. ".png",
                wield_image = "default_sign_" .. material .. ".png",
                paramtype = "light",
                paramtype2 = "wallmounted",
                sunlight_propagates = true,
                is_ground_content = false,
                walkable = false,
                node_box = {
                        type = "wallmounted",
                        wall_top    = {-0.4375, 0.4375, -0.3125, 0.4375, 0.5, 0.3125},
                        wall_bottom = {-0.4375, -0.5, -0.3125, 0.4375, -0.4375, 0.3125},
                        wall_side   = {-0.5, -0.3125, -0.4375, -0.4375, 0.3125, 0.4375},
                },
                groups = def.groups,
                legacy_wallmounted = true,
                sounds = def.sounds,

                on_construct = function(pos)
                        --local n = minetest.get_node(pos)
                        local meta = minetest.get_meta(pos)
                        meta:set_string("formspec", "field[text;;${text}]")
                end,
                on_receive_fields = function(pos, formname, fields, sender)
                        --print("Sign at "..minetest.pos_to_string(pos).." got "..dump(fields))
                        local player_name = sender:get_player_name()
                        if minetest.is_protected(pos, player_name) then
                                minetest.record_protection_violation(pos, player_name)
                                return
                        end
                        local text = fields.text
                        if not text then
                                return
                        end
                        if string.len(text) > 512 then
                                minetest.chat_send_player(player_name, "Text too long")
                                return
                        end
                        minetest.log("action", (player_name or "") .. " wrote \"" ..
                                text .. "\" to sign at " .. minetest.pos_to_string(pos))
                        local meta = minetest.get_meta(pos)
                        meta:set_string("text", text)

                        if #text > 0 then
                                meta:set_string("infotext", "\"" .. text .. "\"")
                        else
                                meta:set_string("infotext", "")
                        end
                end,
        })
end

register_sign("wood", "Old Wooden Sign", {
        sounds = default.node_sound_wood_defaults(),
        groups = {choppy = 2, attached_node = 1, flammable = 2, oddly_breakable_by_hand = 3}
})

register_sign("steel", "Old Steel Sign", {
        sounds = default.node_sound_metal_defaults(),
        groups = {cracky = 2, attached_node = 1}
})

minetest.register_craft({
    output = "bls:sign_wall_wood",
    type = "shapeless",
    recipe = {"default:sign_wall_wood"}
})

minetest.register_craft({
    output = "default:sign_wall_wood",
    type = "shapeless",
    recipe = {"bls:sign_wall_wood"}
})

minetest.register_craft({
    output = "bls:sign_wall_steel",
    type = "shapeless",
    recipe = {"default:sign_wall_steel"}
})

minetest.register_craft({
    output = "default:sign_wall_steel",
    type = "shapeless",
    recipe = {"bls:sign_wall_steel"}
})
