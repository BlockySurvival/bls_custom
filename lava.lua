minetest.register_privilege("lava", {
    description = "Allows a player to place lava anywhere",
    give_to_singleplayer = false
})

local lava_max_elevation = -5

local function can_place_lava(player_name, pointed_thing)
    return (
        pointed_thing.above.y <= lava_max_elevation or
        minetest.check_player_privs(player_name, {lava = true})
    )
end

if minetest.get_modpath("bucket") then
    -- Prevent lava being placed over -5m
    local old_on_place = minetest.registered_items["bucket:bucket_lava"].on_place
    minetest.override_item("bucket:bucket_lava", {
        on_place = function(itemstack, placer, pointed_thing)
            if not pointed_thing.above then
                return itemstack
            end
            local player_name = placer:get_player_name()
            if not can_place_lava(player_name, pointed_thing) then
                minetest.chat_send_player(player_name, "You cannot place lava over " .. lava_max_elevation, true)
                return itemstack
            end
            return old_on_place(itemstack, placer, pointed_thing)
        end
    })
end

local old_item_place = minetest.item_place
function minetest.item_place(itemstack, placer, pointed_thing, param2)
	if not pointed_thing.above then
		return
	end
	local player_name = placer:get_player_name()
	if not can_place_lava(player_name, pointed_thing) then
		if itemstack:get_name() == "default:lava_source" then
			minetest.chat_send_player(player_name, "You cannot place lava over " .. lava_max_elevation, true)
			return itemstack
		elseif itemstack:get_name() == "terumet:mach_lavam" then
			minetest.chat_send_player(player_name, "You cannot place a Lava Melter above " .. lava_max_elevation, true)
			return itemstack
		end
	end
	return old_item_place(itemstack, placer, pointed_thing, param2)
end
