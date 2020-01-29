if minetest.global_exists("tnt") then
    -- Hacks for the TNT mod
    local old_boom = tnt.boom
    function tnt.boom(pos, def, ...)
        -- It's impossible to override entity_physics directly, so render it
        --  useless instead.
        if def and def.disable_entity_effects then
            local f = minetest.get_objects_inside_radius
            minetest.get_objects_inside_radius = function()
                return {}
            end
            local res = old_boom(pos, def, ...)
            minetest.get_objects_inside_radius = f
            return res
        else
            return old_boom(pos, def, ...)
        end
    end
end
