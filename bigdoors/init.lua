if not (
        minetest.get_modpath("bigdoors")
    and minetest.global_exists("bigdoors")
) then return end

dofile(bls.modpath .. "/bigdoors/default-doors.lua")
