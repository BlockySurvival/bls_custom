
minetest.register_on_punchnode(function(pos, node, puncher, pointed_thing)
    local item = puncher:get_wielded_item()
    if item:get_wear() > 60135 then
        local puncher_name = puncher:get_player_name()
        minetest.chat_send_player(puncher_name, "Your tool is about to break!")
        minetest.sound_play("default_tool_breaks", {
            to_player = puncher_name,
            gain = 2.0,
        })
    end
end)
