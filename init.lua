bls = {}
local modname = minetest.get_current_modname()
bls.modname = modname
bls.modpath = minetest.get_modpath(modname)
bls.mod_storage = minetest.get_mod_storage()

function bls.log(level, message, ...)
    minetest.log(level, ('[%s] %s'):format(modname, message:format(...)))
end

dofile(bls.modpath .. '/util.lua')

if minetest.global_exists('doors') and doors.door_toggle then
    -- Load doors.lua if minetest_game 5.0.0 or later is installed
    dofile(bls.modpath .. '/doors.lua')
end

dofile(bls.modpath .. '/nodes.lua')

dofile(bls.modpath .. '/aliases.lua')
dofile(bls.modpath .. '/armor.lua')
dofile(bls.modpath .. '/antitroll.lua')
dofile(bls.modpath .. '/bad_piston_no_biscuit.lua')
dofile(bls.modpath .. '/commands.lua')
dofile(bls.modpath .. '/crafting.lua')
dofile(bls.modpath .. '/fix_privs.lua')
dofile(bls.modpath .. '/item_overrides.lua')
dofile(bls.modpath .. '/microblocks.lua')
dofile(bls.modpath .. '/monkey_patching.lua')
dofile(bls.modpath .. '/no_guests.lua')

dofile(bls.modpath .. '/hunger_overrides.lua') -- overrides stuff in this mod even...

bls.mod_storage = nil
