minetest.register_privilege("caps", "Allows a player to use capital letters in chat")

minetest.register_on_chat_message(function(name, message)
    bls.log("action", "caps: register_on_chat_message")
    if not minetest.check_player_privs(name, {caps=true}) then
        local m
        if minetest.format_chat_message then
            m = minetest.format_chat_message(name, message:lower())
        else
            m = ("<%s> %s"):format(name, message:lower())
        end
        minetest.chat_send_all(m)
        return true
    end
end)
