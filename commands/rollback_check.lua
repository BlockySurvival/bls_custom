minetest.register_privilege("rollback_check", "Allows use of /rollback_check")

minetest.override_chatcommand("rollback_check", {
    privs = {rollback_check=true}
})

-- allow regular players access to limited rollback checking
minetest.register_chatcommand("grief_check", {
    description = "Check who last touched a node or a node near it",
    func = function(name)
        return minetest.registered_chatcommands["rollback_check"].func(
            name,
            "1 1209600 10"
        )
    end
})
