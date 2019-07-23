local storage = bls.mod_storage
local YES_VALUE = 'y'

local function fix_tp_priv(name)
    local key = ('%s_fix_priv_1'):format(name)
    if storage:get_string(key) ~= YES_VALUE then
        local privs = minetest.get_player_privs(name) or {}
        if privs.interact and privs.shout and privs.home then
            privs.tp = true
            privs.instruments = true
            minetest.set_player_privs(name, privs)
        end
        storage:set_string(key, YES_VALUE)
    end
end

minetest.register_on_joinplayer(bls.util.safe(function(player)
    local name = player:get_player_name()
    minetest.after(0, fix_tp_priv, name)
end))
