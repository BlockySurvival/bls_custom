if not minetest.get_modpath("replacer") then
    return
end

local orig_def = minetest.registered_items["replacer:replacer"]
local copy_def = table.copy(orig_def)
copy_def.range = 16
copy_def.groups = table.copy(orig_def.groups)
copy_def.groups.not_in_creative_inventory = 1

minetest.register_tool("bls:replacer", copy_def)
