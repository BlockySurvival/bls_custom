if not (minetest.global_exists("mesecon") and mesecon.register_mvps_stopper) then return end

bls.log("info", "[bad_piston_no_biscuit] initializing")

local patterns = {
    "areasprotector:.*",
    "gravelsieve:.*",
    "locked_travelnet:.*",
    "maptools:.*",
    "mesecons_commandblock:.*",
    "nether:.*",
    "techpack_warehouse:.*",
    "terumet:mach_.*",
    "travelnet:.*",
    "tubelib.*:.*",
    "default:coral_cyan",  -- weird double node w/ weird logic on break
    "default:coral_green",  -- same
    "default:coral_pink",  -- same
    "doors:.*", -- double node isn't handled well
    "artdeco:estatedoor.*", -- double node isn't handled well
    "bls:door_steel_protected.*", -- double node isn't handled well
    "homedecor:door_.*", -- double node isn't handled well
    "my_.*_doors:.*", -- double node isn't handled well
    "terumet:door_.*", -- double node isn't handled well
    "xpanes:door_.*", -- double node isn't handled well
    "scifi_nodes:.*_door_.*", -- double node isn't handled well
    "beds:bed_bottom",
    "beds:bed_top",
    "beds:fancy_bed_bottom",
    "beds:fancy_bed_top",
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
minetest.register_on_mods_loaded(do_it)
