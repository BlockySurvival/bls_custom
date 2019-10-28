--[[

default:wood
* default:wood_nanoslab       -> moreblocks:micro_wood_1
* default:wood_micropanel     -> moreblocks:wood_panel_1
* default:wood_microslab      -> moreblocks:wood_slab_1
* default:wood_thinstair      -> moreblocks:stair_wood_alt_1
* default:wood_cube           -> moreblocks:micro_wood
* default:wood_panel          -> moreblocks:panel_wood
* moreblocks:slab_wood        -> moreblocks:slab_wood
* default:wood_doublepanel    -> moreblocks:stair_wood_alt
* default:wood_halfstair      -> moreblocks:stair_wood_half
* moreblocks:stair_wood_outer -> moreblocks:stair_wood_outer
* moreblocks:stair_wood       -> moreblocks:stair_wood
* moreblocks:stair_wood_inner -> moreblocks:stair_wood_inner

bakedclay:white_doublepanel
default:diamondblock_cube
default:obsidianbrick_thinstair
default:steelblock_panel
default:stonebrick_microslab
quartz:block_doublepanel

realchess:chessboard

stairs:slab_birch_planks  -- default
stairs:slab_iron_stone_bricks  --
stairs:slab_grey
stairs:slab_oak_planks
stairs:slab_stone_tile
stairs:slab_white

stairs:stair_block
stairs:stair_cactus_brick
stairs:stair_rack

xdecor:workbench


]]--

local target_nodes = {}

local variants = {
    "nanoslab",
    "micropanel",
    "microslab",
    "thinstair",
    "cube",
    "panel",
    "slab",
    "doublepanel",
    "halfstair",
    "stair_outer",
    "stair",
    "stair_inner",
}

for node_name, def in pairs(minetest.registered_nodes) do
    if xdecor.stairs_valid_def(def) then
        for _, variant in ipairs(variants) do
            table.insert(target_nodes, ("%s_%s"):format(node_name, variant))
        end
    end
end

minetest.register_lbm({
    label = "microblocks cleanup",
    name = "bls:test_microblocks_cleanup_3",
    nodenames = target_nodes,
    run_at_every_load = false,
    action = function(pos, node)
        bls.log("action", "test 1: pos %q node %q", minetest.pos_to_string(pos, 0), node.name)
    end
})
