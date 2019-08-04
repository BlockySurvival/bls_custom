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
        ['bls:shield_bls']=true,
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

minetest.register_privilege("lava", {description = "Allows a player to place lava anywhere", give_to_singleplayer = false})

local oldplace = minetest.item_place
minetest.item_place = function (itemstack, placer, pointed_thing, param2)
	if not pointed_thing.above then
		return
	end
	local player_name = placer:get_player_name()
	if pointed_thing.above.y > -5 and not minetest.check_player_privs(player_name, {lava = true}) then
		if itemstack:get_name() == "default:lava_source" then
			minetest.chat_send_player(player_name, "You cannot place lava over -5m", true)
			return itemstack
		elseif itemstack:get_name() == "terumet:mach_lavam" then
			minetest.chat_send_player(player_name, "You cannot place a Lava Melter above -5m", true)
			return itemstack
		end
	end
	return oldplace(itemstack, placer, pointed_thing, param2)
end


if global_exists('flowers') then
    -- old flower spread
    function flowers.flower_spread(pos, node)
        pos.y = pos.y - 1
        local under = minetest.get_node(pos)
        pos.y = pos.y + 1
        -- Replace flora with dry shrub in desert sand and silver sand,
        -- as this is the only way to generate them.
        -- However, preserve grasses in sand dune biomes.
        if minetest.get_item_group(under.name, "sand") == 1 and
                under.name ~= "default:sand" then
            minetest.set_node(pos, {name = "default:dry_shrub"})
            return
        end

        if minetest.get_item_group(under.name, "soil") == 0 then
            return
        end

        local light = minetest.get_node_light(pos)
        if not light or light < 13 then
            return
        end

        local pos0 = vector.subtract(pos, 4)
        local pos1 = vector.add(pos, 4)
        -- Testing shows that a threshold of 3 results in an appropriate maximum
        -- density of approximately 7 flora per 9x9 area.
        if #minetest.find_nodes_in_area(pos0, pos1, "group:flora") > 7 then
            return
        end

        local soils = minetest.find_nodes_in_area_under_air(
            pos0, pos1, "group:soil")
        local num_soils = #soils
        if num_soils >= 1 then
            for si = 1, math.min(3, num_soils) do
                local soil = soils[math.random(num_soils)]
                local soil_name = minetest.get_node(soil).name
                local soil_above = {x = soil.x, y = soil.y + 1, z = soil.z}
                light = minetest.get_node_light(soil_above)
                if light and light >= 13 and
                        -- Only spread to same surface node
                        soil_name == under.name and
                        -- Desert sand is in the soil group
                        soil_name ~= "default:desert_sand" then
                    minetest.set_node(soil_above, {name = node.name})
                end
            end
        end
    end
end
