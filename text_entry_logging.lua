minetest.register_on_player_receive_fields(function(player, formname, fields)
    if formname ~= "default:book" then return end
    if fields.save and fields.title and fields.text and fields.title ~= "" and fields.text ~= "" then
        bls.log('action', 'player %s wrote book %q containing %q', player:get_player_name(), fields.title, fields.text)
    end
end)
