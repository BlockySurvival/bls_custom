minetest.register_lbm({
    label = "remove smartrenting",
    name = "bls:remove_smartrenting",
    nodenames = {
        "smartrenting:panel",
        "smartrenting:panel_able",
        "smartrenting:panel_rented",
        "smartrenting:panel_ending",
        "smartrenting:panel_error",
    },
    run_at_every_load = false,
    action = function(pos, node)
        minetest.set_node(pos, {name="air"})
    end,
})
