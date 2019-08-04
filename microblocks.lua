local get_modpath = minetest.get_modpath
local global_exists = minetest.global_exists
local registered_nodes = minetest.registered_nodes

local function most_common_in_table(t)
    local counts = {}
    for _, item in ipairs(t) do
        counts[item] = (counts[item] or 0) + 1
    end
    local most_common
    local count = 0
    for item, item_count in pairs(counts) do
        if item_count > count then
            most_common = item
            count = item_count
        end
    end
    return most_common
end

local function register_letters(recipe_item)
    local modname, subname = recipe_item:match('^([^:]+):([^:]+)$')
    local def = registered_nodes[recipe_item]
    if not def then
        bls.log('warning', 'microblocks: No def for %s', recipe_item)
        return
    end
    if def.drawtype == 'normal' and not registered_nodes[('%s:%s_letter_au'):format(modname, subname)] then
        local tiles
        if type(def.tiles) == 'string' then
            tiles = def.tiles
        elseif type(def.tiles) == 'table' and #def.tiles > 0 then
            tiles = most_common_in_table(def.tiles)
        end
        if tiles then
            letters.register_letters(modname, subname, recipe_item, def.description, tiles)
        end
    end
end

local function register(recipe_item)
    local modname, subname = recipe_item:match('^([^:]+):([^:]+)$')
    if not (modname or subname) then
        bls.log('warning', 'microblocks: %s is not a valid name', recipe_item)
        return
    end
    local def = registered_nodes[recipe_item]
    if not def then
        bls.log('warning', 'microblocks: No def for %s', recipe_item)
        return
    end
    if global_exists('stairsplus') then
        -- TODO: figure out a check to see if these are already registered?
        stairsplus:register_all(modname, subname, recipe_item, def)
    end
    if global_exists('facade') then
        if def.drawtype == 'normal' and not registered_nodes[('facade:%s_bannerstone'):format(subname)] then
            -- facade mod needs an update to prefix the modname w/ ':'
            -- facade mod needs an update to make facades in group not_in_creative_inventory
            -- facade.register_facade_nodes(modname, subname, recipe_item, def.description or subname)
        end
    end
    -- letter cutter: adding letters increases lag (and load time) hugely
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

if get_modpath('bakedclay') then
    for _, color in ipairs(COLORS) do
        register_letters('bakedclay:' .. color)
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

---------------------
local register_alias_force = minetest.register_alias_force
if get_modpath('default') then
    -- fix corner stairs from default
    local function fix_defualt_corner_stairs(node)
        register_alias_force('stairs:stair_outer_' .. node, 'moreblocks:stair_' .. node .. '_outer')
        register_alias_force('stairs:stair_inner_' .. node, 'moreblocks:stair_' .. node .. '_inner')

        register_alias_force('default:' .. node .. '_outerstair', 'moreblocks:stair_' .. node .. '_outer')
        register_alias_force('default:' .. node .. '_innerstair', 'moreblocks:stair_' .. node .. '_inner')
    end
    fix_defualt_corner_stairs('acacia_tree')
    fix_defualt_corner_stairs('acacia_wood')
    fix_defualt_corner_stairs('aspen_tree')
    fix_defualt_corner_stairs('aspen_wood')
    fix_defualt_corner_stairs('brick')
    fix_defualt_corner_stairs('bronzeblock')
    fix_defualt_corner_stairs('cactus')
    fix_defualt_corner_stairs('clay')
    fix_defualt_corner_stairs('coalblock')
    fix_defualt_corner_stairs('cobble')
    fix_defualt_corner_stairs('copperblock')
    fix_defualt_corner_stairs('coral_skeleton')
    fix_defualt_corner_stairs('desert_cobble')
    fix_defualt_corner_stairs('desert_sandstone')
    fix_defualt_corner_stairs('desert_sandstone_block')
    fix_defualt_corner_stairs('desert_sandstone_brick')
    fix_defualt_corner_stairs('desert_stone')
    fix_defualt_corner_stairs('desert_stone_block')
    fix_defualt_corner_stairs('desert_stonebrick')
    fix_defualt_corner_stairs('diamondblock')
    fix_defualt_corner_stairs('dirt')
    fix_defualt_corner_stairs('dirt_with_coniferous_litter')
    fix_defualt_corner_stairs('dirt_with_dry_grass')
    fix_defualt_corner_stairs('dirt_with_grass')
    fix_defualt_corner_stairs('dirt_with_rainforest_litter')
    fix_defualt_corner_stairs('dirt_with_snow')
    fix_defualt_corner_stairs('glass')
    fix_defualt_corner_stairs('goldblock')
    fix_defualt_corner_stairs('gravel')
    fix_defualt_corner_stairs('ice')
    fix_defualt_corner_stairs('jungletree')
    fix_defualt_corner_stairs('junglewood')
    fix_defualt_corner_stairs('mese')
    fix_defualt_corner_stairs('meselamp')
    fix_defualt_corner_stairs('mossycobble')
    fix_defualt_corner_stairs('obsidian')
    fix_defualt_corner_stairs('obsidian_block')
    fix_defualt_corner_stairs('obsidian_glass')
    fix_defualt_corner_stairs('obsidianbrick')
    fix_defualt_corner_stairs('permafrost')
    fix_defualt_corner_stairs('permafrost_with_moss')
    fix_defualt_corner_stairs('permafrost_with_stones')
    fix_defualt_corner_stairs('pine_tree')
    fix_defualt_corner_stairs('pine_wood')
    fix_defualt_corner_stairs('sandstone')
    fix_defualt_corner_stairs('sandstone_block')
    fix_defualt_corner_stairs('sandstonebrick')
    fix_defualt_corner_stairs('silver_sandstone')
    fix_defualt_corner_stairs('silver_sandstone_block')
    fix_defualt_corner_stairs('silver_sandstone_brick')
    fix_defualt_corner_stairs('snowblock')
    fix_defualt_corner_stairs('steelblock')
    fix_defualt_corner_stairs('stone')
    fix_defualt_corner_stairs('stone_block')
    fix_defualt_corner_stairs('stonebrick')
    fix_defualt_corner_stairs('tinblock')
    fix_defualt_corner_stairs('tree')
    fix_defualt_corner_stairs('wood')
end
