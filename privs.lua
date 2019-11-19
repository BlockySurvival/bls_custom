minetest.register_privilege("caps", "Allows a player to use capital letters in chat")

minetest.register_on_chat_message(function(name, message)
    message = message:gsub("%%", "%%%%")
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

if minetest.global_exists("irc") and irc.playerMessage then
    local old_irc_playerMessage = irc.playerMessage
    function irc.playerMessage(name, message)
        if not minetest.check_player_privs(name, {caps=true}) then
            message = message:lower()
        end
        return old_irc_playerMessage(name, message)
    end
end

if minetest.global_exists("irc2") and irc2.playerMessage then
    local old_irc2_playerMessage = irc2.playerMessage
    function irc2.playerMessage(name, message)
        if not minetest.check_player_privs(name, {caps=true}) then
            message = message:lower()
        end
        return old_irc2_playerMessage(name, message)
    end
end
