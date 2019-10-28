-- this script grants old players new default privileges

local storage = bls.mod_storage
local YES_VALUE = "y"

local function fix_priv_1(name)
    local key = ("%s_fix_priv_1"):format(name)
    if storage:get_string(key) ~= YES_VALUE then
        local privs = minetest.get_player_privs(name) or {}
        if privs.interact and privs.shout then
            privs.tp = true
            privs.instruments = true
            minetest.set_player_privs(name, privs)
        end
        storage:set_string(key, YES_VALUE)
    end
end

local function fix_priv_2(name)
    local key = ("%s_fix_priv_2"):format(name)
    if storage:get_string(key) ~= YES_VALUE then
        local privs = minetest.get_player_privs(name) or {}
        if privs.shout then
            privs.caps = true
            minetest.set_player_privs(name, privs)
        end
        storage:set_string(key, YES_VALUE)
    end
end

-- NOTE: if privileges change AGAIN then you have to create a new key and function like the above.
-- NOTE: you can reuse the same on_player_join though.

minetest.register_on_joinplayer(function(player)
    local name = player:get_player_name()
    minetest.after(0, fix_priv_1, name)
    minetest.after(0, fix_priv_2, name)
end)

