--
-- bls_overrides
--

if minetest.get_modpath('doors') and doors.door_toggle then
    -- Load doors.lua if minetest_game 5.0.0 or later is installed
    dofile(minetest.get_modpath('bls_overrides') .. '/doors.lua')
end

dofile(minetest.get_modpath('bls_overrides') .. '/aliases.lua')
dofile(minetest.get_modpath('bls_overrides') .. '/crafting.lua')
dofile(minetest.get_modpath('bls_overrides') .. '/item_overrides.lua')
dofile(minetest.get_modpath('bls_overrides') .. '/monkey_patching.lua')
