for i = 1, 2 do
    local def = minetest.chatcommands[("area_pos%s"):format(i)]
    if def then
        minetest.register_chatcommand(("a%s"):format(i), def)
    end
end
