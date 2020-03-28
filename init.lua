bls = {}
local modname = minetest.get_current_modname()
bls.modname = modname
bls.modpath = minetest.get_modpath(modname)
bls.mod_storage = minetest.get_mod_storage()

function bls.log(level, message, ...)
    minetest.log(level, ("[%s] %s"):format(modname, message:format(...)))
end

dofile(bls.modpath .. "/util.lua")

dofile(bls.modpath .. "/aliases.lua")
dofile(bls.modpath .. "/crafting_overrides.lua")
dofile(bls.modpath .. "/item_overrides.lua")

dofile(bls.modpath .. "/custom_items/currency.lua")
dofile(bls.modpath .. "/custom_items/doors.lua")
dofile(bls.modpath .. "/custom_items/fake_atm.lua")
dofile(bls.modpath .. "/custom_items/fake_nodes.lua")
dofile(bls.modpath .. "/custom_items/food.lua")
dofile(bls.modpath .. "/custom_items/maptools.lua")
dofile(bls.modpath .. "/custom_items/marble.lua")
dofile(bls.modpath .. "/custom_items/old_signs.lua")
dofile(bls.modpath .. "/custom_items/public_chests.lua")
dofile(bls.modpath .. "/custom_items/staff_armor.lua")
dofile(bls.modpath .. "/custom_items/water2.lua")

dofile(bls.modpath .. "/commands/antitroll.lua")
dofile(bls.modpath .. "/commands/hax.lua")
dofile(bls.modpath .. "/commands/other.lua")
dofile(bls.modpath .. "/commands/punishments.lua")
dofile(bls.modpath .. "/commands/rollback_check.lua")
dofile(bls.modpath .. "/commands/snoop_cheats.lua")

dofile(bls.modpath .. "/fix_dead_on_login.lua")
dofile(bls.modpath .. "/fix_paper_posters.lua")
dofile(bls.modpath .. "/fix_luacontroller_crash.lua")
dofile(bls.modpath .. "/flowers.lua")
dofile(bls.modpath .. "/kelp_spread.lua")
dofile(bls.modpath .. "/lava.lua")
dofile(bls.modpath .. "/login_handling.lua")
dofile(bls.modpath .. "/mesecon/mvps_stoppers.lua")
dofile(bls.modpath .. "/microblocks.lua")
dofile(bls.modpath .. "/node_inventory_protection.lua")
dofile(bls.modpath .. "/old_mod_cleanup.lua")
dofile(bls.modpath .. "/text_entry_logging.lua")
dofile(bls.modpath .. "/tnt.lua")
dofile(bls.modpath .. "/oregen.lua")
dofile(bls.modpath .. "/orienteering.lua")
dofile(bls.modpath .. "/privs.lua")
dofile(bls.modpath .. "/techpack/grinder.lua")
dofile(bls.modpath .. "/techpack/harvester.lua")
dofile(bls.modpath .. "/techpack/quarry.lua")
dofile(bls.modpath .. "/terumet/alloy_smelter.lua")
dofile(bls.modpath .. "/terumet/ore_saw.lua")
dofile(bls.modpath .. "/terumet/reformer.lua")
dofile(bls.modpath .. "/terumet/vulcanizer.lua")
dofile(bls.modpath .. "/tool_damage_alert.lua")
dofile(bls.modpath .. "/update_initial_privs.lua")

--
if minetest.global_exists("xdecor") then
    dofile(bls.modpath .. "/microblocks_cleanup.lua")
end

-- last, because it overrides stuff in this mod even...
dofile(bls.modpath .. "/hunger_overrides.lua")

bls.mod_storage = nil
