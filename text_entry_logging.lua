minetest.register_on_player_receive_fields(function(player, formname, fields)
    if formname ~= "default:book" then return end
    if fields.save and fields.title and fields.text and fields.title ~= "" and fields.text ~= "" then
        bls.log("action", "player %s wrote book %q containing %q", player:get_player_name(), fields.title, fields.text)
    end
end)

minetest.register_on_player_receive_fields(function(player, formname, fields)
    bls.log(
        "action",
        "%s received fields for %q: %s",
        player:get_player_name(),
        formname,
        minetest.serialize(fields)
    )
end)

if minetest.get_modpath("mesecons_luacontroller") then
    local basename = "mesecons_luacontroller:luacontroller"
    for a = 0, 1 do
        for b = 0, 1 do
            for c = 0, 1 do
                for d = 0, 1 do
                    local cid = tostring(d)..tostring(c)..tostring(b)..tostring(a)
                    local node_name = basename..cid
                    local node_def = minetest.registered_nodes[node_name]
                    local old_on_receive_fields = node_def.on_receive_fields
                    local function new_on_receive_fields(pos, form_name, fields, sender)
                        if fields.code then
                            local codestr = minetest.encode_base64(minetest.compress(fields.code))
                            bls.log(
                                "action",
                                "%s programmed lua controller @ %s with %s",
                                sender:get_player_name(),
                                minetest.pos_to_string(pos),
                                codestr
                            )
                        end
                        return old_on_receive_fields(pos, form_name, fields, sender)
                    end
                    minetest.override_item(node_name, {
                        on_receive_fields = new_on_receive_fields
                    })
                end
            end
        end
    end

    local node_name = basename .. "_burnt"
    local node_def = minetest.registered_nodes[node_name]
    local old_on_receive_fields = node_def.on_receive_fields
    local function new_on_receive_fields(pos, form_name, fields, sender)
        if fields.code then
            local codestr = minetest.encode_base64(minetest.compress(fields.code))
            bls.log(
                "action",
                "%s programmed lua controller @ %s with %s",
                sender:get_player_name(),
                minetest.pos_to_string(pos),
                codestr
            )
        end
        return old_on_receive_fields(pos, form_name, fields, sender)
    end
    minetest.override_item(node_name, {
        on_receive_fields = new_on_receive_fields
    })
end
