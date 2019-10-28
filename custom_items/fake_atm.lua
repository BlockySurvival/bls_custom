-- dummy ATM for decoration
if minetest.get_modpath("lurkcoin") and minetest.get_modpath("default") and minetest.get_modpath("dye") then
    minetest.register_node(":lurkcoin:dummy_atm", {
        description = "Dummy ATM",
        groups = {cracky = 1},
        tiles = {"lurkcoin_atm_side.png", "lurkcoin_atm_side.png",
            "lurkcoin_atm_side.png", "lurkcoin_atm_side.png",
            "lurkcoin_atm_side.png", "lurkcoin_atm_side.png^lurkcoin_atm_top.png"},
        paramtype2 = "facedir",
    })
    minetest.register_craft({
        output = "lurkcoin:dummy_atm",
        type = "shapeless",
            recipe = {"default:steelblock", "dye:blue"},
    })
end
