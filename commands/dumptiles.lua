-- this code is based on https://github.com/minetest/minetestmapper/blob/master/autogenerating-colors.txt

local function nd_get_tiles(nd)
	return nd.tiles or nd.tile_images
end

local function nd_get_tile(nd, n)
	local tiles = nd_get_tiles(nd)
	if not tiles then return end
	local tile = tiles[n]
	if type(tile) == "table" then
		tile = tile.name
	end
	return tile
end

local function pairs_s(dict)
	local keys = {}
	for k in pairs(dict) do
		table.insert(keys, k)
	end
	table.sort(keys)
	return ipairs(keys)
end

minetest.register_chatcommand("dumptiles", {
	params = "min max",
	description = "save itemstring/tile path combinations to $WORLDPATH/tiles*.txt",
	privs = {server = true},
	func = function(player, param)
		local min, max = unpack(param:split(" "))
		min = tonumber(min)
		max = tonumber(max)
		if not (min and max) then
			return false, "please specify both min and max (too large a range will OOM LuaJIT)"
		end

		local n = 0
		local total = 0
		local counted = 0
		local content = ""
		for itemstring, def in bls.util.pairs_by_keys(minetest.registered_nodes) do
			if min <= total and total < max then
				local prefix, name = unpack(itemstring:split(":"))
				local modpath = minetest.get_modpath(prefix or "")
				local tile = nd_get_tile(def, 1)
				if def.drawtype == "airlike" or not tile then
					bls.log("warning", "dumpnodes can't get tiles for " .. itemstring)
				elseif prefix and name and modpath then
					local tl = tile
					tl = (tl .. "^"):match("(.-)^") -- strip modifiers
					content = content .. (itemstring .. " " .. modpath .. "/textures/" .. tl .. "\n")
					n = n + 1
				else
					bls.log("warning", "dumpnodes can't get modpath for " .. itemstring)
				end
				counted = counted + 1
			end
			total = total + 1
		end
		minetest.safe_file_write(minetest.get_worldpath() .. "/tiles" .. min .. ".txt", content)

		return true, "dumped " .. n .. " tiles out of " .. counted .. "."
	end,
})
