local old_calc = minetest.calculate_knockback
function minetest.calculate_knockback(player, hitter, time_from_last_punch, tool_capabilities, dir, distance, damage)
   -- Mob knockback as usual
   if not hitter:is_player() then
      return old_calc(player, hitter, time_from_last_punch, tool_capabilities, dir, distance, damage)
   end
   -- Check if player is in an unprotected area (if so, knockback as normal)
   local inAreas = areas:getAreasAtPos(player:getpos())
   if next(inAreas) == nil then
      return old_calc(player, hitter, time_from_last_punch, tool_capabilities, dir, distance, damage)
   end
   -- Check if PvP is allowed in any of the areas
   for aId in pairs(inAreas) do
      local a = areas.areas[aId]
      if a.canPvP then
         return old_calc(player, hitter, time_from_last_punch, tool_capabilities, dir, distance, damage)
      end
   end
   -- Otherwise, no knockback
   return 0
end
