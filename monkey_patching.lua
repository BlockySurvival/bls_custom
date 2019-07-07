-- PLEASE KEEP MOD SECTIONS IN ALPHABETICAL ORDER

local check_player_privs = minetest.check_player_privs
local get_modpath = minetest.get_modpath
local global_exists = minetest.global_exists
local settings = minetest.settings

if global_exists("armor") then
    -- don't damage other armor if player is wearing admin armor
    local admin_armor_list = {
        ['3d_armor:helmet_admin']=true,
        ['3d_armor:chestplate_admin']=true,
        ['3d_armor:leggings_admin']=true,
        ['3d_armor:boots_admin']=true,
        ['shields:shield_admin']=true,
        ['bls_admin_flair:shield_bls']=true,
    }
    local armor_punch = armor.punch
    armor.punch = function(self, player, hitter, time_from_last_punch, tool_capabilities)
        -- when wearing admin armor, don't damage other armor :\
        local name, armor_inv = self:get_valid_player(player, "[punch]")
        if not name then
            return
        end
        for _, stack in pairs(armor_inv:get_list("armor")) do
            local name = stack:get_name()
            if admin_armor_list[name] then
                return
            end
        end
        return armor_punch(self, player, hitter, time_from_last_punch, tool_capabilities)
    end
end

if global_exists('tnt') then
    -- Hacks for the TNT mod
    local boom = tnt.boom
    function tnt.boom(pos, def, ...)
        -- It's impossible to override entity_physics directly, so render it
        --  useless instead.
        if def and def.disable_entity_effects then
            local f = minetest.get_objects_inside_radius
            minetest.get_objects_inside_radius = function(pos, radius)
                return {}
            end
            local res = boom(pos, def, ...)
            minetest.get_objects_inside_radius = f
            return res
        else
            return boom(pos, def, ...)
        end
    end
end
