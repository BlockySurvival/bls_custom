bls = {}
local modname = minetest.get_current_modname()
bls.modname = modname
bls.modpath = minetest.get_modpath(modname)
bls.mod_storage = minetest.get_mod_storage()

function bls.log(level, message, ...)
    minetest.log(level, ('[%s] %s'):format(modname, message:format(...)))
end

dofile(bls.modpath .. '/util.lua')

dofile(bls.modpath .. '/nodes.lua')  -- new nodes we define

dofile(bls.modpath .. '/aliases.lua')
dofile(bls.modpath .. '/armor.lua')
dofile(bls.modpath .. '/commands/antitroll.lua')
dofile(bls.modpath .. '/commands/hax.lua')
dofile(bls.modpath .. '/commands/other.lua')
dofile(bls.modpath .. '/commands/punishments.lua')
dofile(bls.modpath .. '/crafting_overrides.lua')
dofile(bls.modpath .. '/doors.lua')
dofile(bls.modpath .. '/flowers.lua')
dofile(bls.modpath .. '/item_overrides.lua')
dofile(bls.modpath .. '/lava.lua')
dofile(bls.modpath .. '/login_handling.lua')
dofile(bls.modpath .. '/mesecon/mvps_stoppers.lua')
dofile(bls.modpath .. '/microblocks.lua')
dofile(bls.modpath .. '/node_inventory_protection.lua')
dofile(bls.modpath .. '/text_entry_logging.lua')
dofile(bls.modpath .. '/tnt.lua')
dofile(bls.modpath .. '/oregen.lua')
dofile(bls.modpath .. '/terumet/reformer.lua')
dofile(bls.modpath .. '/tubelib.lua')
dofile(bls.modpath .. '/update_initial_privs.lua')

-- last, because it overrides stuff in this mod even...
dofile(bls.modpath .. '/hunger_overrides.lua')

bls.mod_storage = nil
