minetest.register_lbm({
    name="bls:remove_removed_1",
    label="Remove removed nodes #1",
    nodenames={
        "realchess:chessboard",
    },
    run_at_every_load=false,
    action = function(pos, node)
        minetest.set_node(pos, {name = "air"})
    end
})

minetest.register_lbm({
    name="bls:remove_removed_2",
    label="Remove removed nodes #2",
    nodenames={
        "compost:wood_barrel_empty",
    },
    run_at_every_load=false,
    action = function(pos, node)
        minetest.set_node(pos, {name = "xdecor:barrel"})
    end
})

minetest.register_lbm({
    name="bls:remove_removed_3",
    label="Remove removed nodes #3",
    nodenames={
        "crafting_bench:workbench",
        "xdecor:workbench",
    },
    run_at_every_load=false,
    action = function(pos, node)
        minetest.set_node(pos, {name = "moreblocks:circular_saw"})
    end
})
