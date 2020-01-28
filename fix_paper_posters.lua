-- due to a bug in display_modpack, posters receive a second, node-metadata-based formspec when punched.
-- for some players, this formspec displays instead of the normal one, where you can actually read the contents.

minetest.register_lbm({
    name = "bls:fix_posters",
    label = "remove node metadata formspecs from posters",
    nodenames = {"signs:paper_poster"},
    run_at_every_load = true,
    action = function(pos)
        minetest.get_meta(pos):set_string("formspec", "")
    end,
})
