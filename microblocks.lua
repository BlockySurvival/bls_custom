local get_modpath = minetest.get_modpath
local registered_nodes = minetest.registered_nodes

local function register(name)
    local mod, item = name:match('^([^:]+):([^:]+)$')
    if not (mod or item) then
        bls_overrides.log('warning', 'microblocks: %s is not a valid name', name)
        return
    end
    local def = registered_nodes[name]
    if not def then
        bls_overrides.log('warning', 'microblocks: No def for %s', name)
        return
    end
    if get_modpath('moreblocks') and stairsplus then
        stairsplus:register_all(mod, item, name, def)
    end
end

local COLORS = {
    'black', 'blue', 'brown', 'cyan', 'dark_green', 'dark_grey', 'green', 'grey',
    'magenta', 'orange', 'pink', 'red', 'violet', 'white', 'yellow'
}
local function register_colors(name_pattern)
    for _, color in ipairs(COLORS) do
        register(name_pattern:format(color))
    end
end

if get_modpath('other_worlds') then
    register('asteroid:cobble')
    register('asteroid:dust')
    register('asteroid:gravel')
    register('asteroid:redcobble')
    register('asteroid:reddust')
    register('asteroid:redgravel')
end

if get_modpath('caverealms') then
    register('caverealms:coal_dust')
    register('caverealms:glow_amethyst')
    register('caverealms:glow_amethyst_ore')
    register('caverealms:glow_crystal')
    register('caverealms:glow_emerald')
    register('caverealms:glow_emerald_ore')
    register('caverealms:glow_mese')
    register('caverealms:glow_obsidian')
    register('caverealms:glow_obsidian_2')
    register('caverealms:glow_ore')
    register('caverealms:glow_ruby')
    register('caverealms:glow_ruby_ore')
    register('caverealms:hot_cobble')
    register('caverealms:mushroom_cap')
    register('caverealms:mushroom_stem')
    register('caverealms:salt_crystal')
    register('caverealms:stone_with_salt')
    register('caverealms:thin_ice')
end

if get_modpath('cblocks') then
    register_colors('cblocks:glass_%s')
end

if get_modpath('cottages') then
    register('cottages:hay')
    register('cottages:loam')
    register('cottages:reet')
    register('cottages:slate_vertical')
end

if get_modpath('extra') then
    register('extra:cobble_condensed')
end

if get_modpath('farming') then
    register('farming:chocolate_block')
    register('farming:hemp_block')
end

if get_modpath('mobs_animal') then
    register('mobs:cheeseblock')
    register('mobs:honey_block')
end

if get_modpath('moreores') then
    register('moreores:mithril_block')
    register('moreores:silver_block')
end

if get_modpath('nether') then
    register('nether:glowstone')
    register('nether:obsidian_enchanted')
    register('nether:rack')
end

if get_modpath('terumet') then
    register('terumet:block_asphalt')
    register('terumet:block_ceramic')
    register('terumet:block_cgls')
    register('terumet:block_coke')
    register_colors('terumet:block_con_%s')
    register('terumet:block_dust_bio')
    register('terumet:block_entropy')
    register('terumet:block_pwood')
    register('terumet:block_raw')
    register('terumet:block_tar')
    register('terumet:block_tcha')
    register('terumet:block_tcop')
    register('terumet:block_tglass')
    register('terumet:block_tglassglow')
    register('terumet:block_tgol')
    register('terumet:block_thermese')
    register('terumet:block_tste')
    register('terumet:block_ttin')
end

if get_modpath('titanium') then
    register('titanium:block')
    register('titanium:glass')
    register('titanium:titanium_plate')
end

if get_modpath('xdecor') then
    register('xdecor:cactusbrick')
    register('xdecor:coalstone_tile')
    register('xdecor:desertstone_tile')
    register('xdecor:hard_clay')
    register('xdecor:moonbrick')
    register('xdecor:packed_ice')
    register('xdecor:iron_lightbox')
    register('xdecor:stone_rune')
    register('xdecor:stone_tile')
    register('xdecor:wooden_lightbox')
    register('xdecor:woodframed_glass')
    register('xdecor:wood_tile')
end
