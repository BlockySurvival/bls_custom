if not (minetest.global_exists("mesecon") and mesecon.register_mvps_stopper) then return end

bls.log("info", "[bad_piston_no_biscuit] initializing")

local patterns = {
    "areasprotector:.*",
    "gravelsieve:.*",
    "locked_travelnet:.*",
    "maptools:.*",
    "mesecons_commandblock:.*",
    "nether:bedrock",
    "techpack_warehouse:.*",
    "terumet:mach_.*",
    "travelnet:.*",
    "tubelib.*:.*",
    "default:coral_cyan",  -- weird double node w/ weird logic on break
    "default:coral_green",  -- same
    "default:coral_pink",  -- same
}

local function do_it()
    for node_name, _ in bls.util.pairs_by_keys(minetest.registered_nodes) do
        for _, pattern in pairs(patterns) do
            local fullpattern = "^" .. pattern .. "$"
            if string.find(node_name, fullpattern) then
                bls.log("info", "[bad_piston_no_biscuit] registering " .. node_name)
                mesecon.register_mvps_stopper(node_name)
                break
            end
        end
    end
end

-- register after all mods have loaded
minetest.after(0, do_it)
