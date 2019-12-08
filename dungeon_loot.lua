if not minetest.get_modpath("dungeon_loot") then return end
--[[
name = "item:name",
chance = 0.5,
-- ^ chance value from 0.0 to 1.0 that the item will appear in the chest when chosen
--   Due to an extra step in the selection process, 0.5 does not(!) mean that
--   on average every second chest will have this item
count = {1, 4},
-- ^ table with minimum and maximum amounts of this item
--   optional, defaults to always single item
y = {-32768, -512},
-- ^ table with minimum and maximum heights this item can be found at
--   optional, defaults to no height restrictions
types = {"desert"},
-- ^ table with types of dungeons this item can be found in
--   supported types: "normal" (the cobble/mossycobble one), "sandstone"
--   "desert" and "ice"
--   optional, defaults to no type restrictions
]]--
local rloot = dungeon_loot.register

rloot{name=""}
