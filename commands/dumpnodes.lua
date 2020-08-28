local function nd_get_tiles(nd)
	return nd.tiles or nd.tile_images
end

local function nd_get_tile(nd, n)
	local tile = nd_get_tiles(nd)[n]
	if type(tile) == 'table' then
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

minetest.register_chatcommand("dumpnodes", {
	params = "",
	description = "",
	func = function(player, param)
		local n = 0
		local ntbl = {}
		for _, nn in pairs_s(minetest.registered_nodes) do
			local prefix, name = nn:match('(.*):(.*)')
			if prefix == nil or name == nil then
				print("ignored(1): " .. nn)
			else
				if ntbl[prefix] == nil then
					ntbl[prefix] = {}
				end
				ntbl[prefix][name] = true
			end
		end
		local out, err = io.open('nodes.txt', 'wb')
		if not out then
			return true, "io.open(): " .. err
		end
		for _, prefix in pairs_s(ntbl) do
			out:write('# ' .. prefix .. '\n')
			for _, name in pairs_s(ntbl[prefix]) do
				local nn = prefix .. ":" .. name
				local nd = minetest.registered_nodes[nn]
				if nd.drawtype == 'airlike' or nd_get_tiles(nd) == nil then
					print("ignored(2): " .. nn)
				else
					local tl = nd_get_tile(nd, 1)
					tl = (tl .. '^'):match('(.-)^') -- strip modifiers
					out:write(nn .. ' ' .. tl .. '\n')
					n = n + 1
				end
			end
			out:write('\n')
		end
		out:close()
		return true, n .. " nodes dumped."
	end,
})
