bls_overrides = {}
local modname = minetest.get_current_modname()
bls_overrides.modname = modname
bls_overrides.modpath = minetest.get_modpath(modname)

function bls_overrides.log(level, message, ...)
    minetest.log(level, ('[%s] %s'):format(modname, message:format(...)))
end

if minetest.get_modpath('doors') and doors.door_toggle then
    -- Load doors.lua if minetest_game 5.0.0 or later is installed
    dofile(minetest.get_modpath('bls_overrides') .. '/doors.lua')
end

dofile(minetest.get_modpath('bls_overrides') .. '/aliases.lua')
if minetest.global_exists('ChatCmdBuilder') then
    dofile(minetest.get_modpath('bls_overrides') .. '/commands.lua')
end
dofile(minetest.get_modpath('bls_overrides') .. '/crafting.lua')
dofile(minetest.get_modpath('bls_overrides') .. '/item_overrides.lua')
dofile(minetest.get_modpath('bls_overrides') .. '/hunger_overrides.lua')
dofile(minetest.get_modpath('bls_overrides') .. '/monkey_patching.lua')
dofile(minetest.get_modpath('bls_overrides') .. '/new_nodes.lua')
