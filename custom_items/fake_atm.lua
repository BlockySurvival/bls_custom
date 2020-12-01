-- dummy ATM for decoration
if minetest.get_modpath("lurkcoin") and minetest.get_modpath("default") and
        minetest.get_modpath("dye") then
    minetest.register_alias("lurkcoin:dummy_atm", "lurkcoin:atm")
    minetest.register_craft({
        output = "lurkcoin:atm",
        type = "shapeless",
            recipe = {"default:steelblock", "dye:blue"},
    })
end
