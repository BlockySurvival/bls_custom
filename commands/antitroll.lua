--
-- Antitroll things
--

local antitroll = {}
bls.antitroll = antitroll

-- "Kicks" players
function antitroll.kick_player(name)
    minetest.show_formspec(name, "formspeclib:ignore",
        "list[___die;haxxor;0,0;0,0]")
    minetest.after(0.25, minetest.kick_player, name, "You appear to be a bot.")
end

minetest.register_chatcommand("crash", {
    params = "<name>",
    description = "Kicks players and crashes their client.",
    privs = {kick=true},
    func = function(name, param)
        if not minetest.get_player_by_name(param) then
            return false, "Player \"" .. param .. "\" doesn\'t exist!"
        end
        minetest.log("action", name .. " crash-kicks " .. param)
        antitroll.kick_player(param)
        return true, "Crash-kicked " .. param .. "."
    end,
})
