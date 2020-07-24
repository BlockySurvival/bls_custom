if not minetest.get_modpath("tnt") then return end

-- The NOTHING function does nothing.
local function do_nothing() end

if minetest.get_modpath("maptools") then
    for nodeid, _ in pairs(minetest.registered_nodes) do
        if string.sub(nodeid, 1, 9) == "maptools:" then
            minetest.override_item(nodeid, {
                on_blast = do_nothing
            })
        end
    end
end

if minetest.get_modpath("mesecons_commandblock") then
    minetest.override_item("mesecons_commandblock:commandblock_off", {
        on_blast = do_nothing
    })
    minetest.override_item("mesecons_commandblock:commandblock_on", {
        on_blast = do_nothing
    })
end
