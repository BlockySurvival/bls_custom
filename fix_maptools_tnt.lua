if not minetest.get_modpath("maptools") or not minetest.get_modpath("tnt") then return end

for nodeid, _ in pairs(minetest.registered_nodes) do
    if string.sub(nodeid, 1, 9) == "maptools:" then
        minetest.override_item(nodeid, {
            on_blast = function (pos, intensity) end
        })
    end
end
