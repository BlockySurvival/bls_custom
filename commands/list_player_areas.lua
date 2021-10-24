local S = minetest.get_translator("areas")


-- Overriding this command so it will also list other player's areas if you have the areas priv
-- Usage `/list_areas OtherPlayer`
if minetest.registered_chatcommands["list_areas"] then
	minetest.unregister_chatcommand("list_areas")
end
minetest.register_chatcommand("list_areas", {
	description = S("List your areas."),
	func = function(name, param)
		local found_areas = false

		local search_name = name

		if #param ~= 0 and minetest.check_player_privs(name, {areas=true}) then
			search_name = param
		end

		for id, area in pairs(areas.areas) do
			if areas:isAreaOwner(id, search_name, true) then
				found_areas = true
				minetest.chat_send_player(name, areas:toString(id))
			end
		end

		if not found_areas then
			return true, S("No visible areas.")
		end
		return true
	end
})