local get_modpath = minetest.get_modpath

if get_modpath('lurkcoin') and get_modpath('default') and get_modpath('dye') then
    minetest.register_node('lurkcoin:dummy_atm', {
        description = 'Dummy ATM',
        groups = {cracky = 1},
        tiles = {'lurkcoin_atm_side.png', 'lurkcoin_atm_side.png',
            'lurkcoin_atm_side.png', 'lurkcoin_atm_side.png',
            'lurkcoin_atm_side.png', 'lurkcoin_atm_side.png^lurkcoin_atm_top.png'},
        paramtype2 = 'facedir',
    })
    register_craft({
        output = "lurkcoin:dummy_atm",
        type = "shapeless",
            recipe = {'default:steelblock', 'dye:blue'},
    })
end
