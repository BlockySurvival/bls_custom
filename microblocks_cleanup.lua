--[[

NOTE: this file is mostly to deal w/ the aftermath of a snafu involving microblock node IDs after upgrading to 5.1.

We have/had multiple mods adding various kinds of microblocks

1. stairs
2. moreblocks/stairsplus
3. xdecor workbench

Each of these registers some nodes on its own. Other mods use the above to register some
nodes as well. Most of the above have changed naming schemes at some point in time, resulting in a
big pile of aliases. the load order of some things changed, resulting in aliases loading in a
different order, causing some nodes w/ old IDs to no longer be properly aliased.

Solution: remove the xdecor workbench, and replace all the relevant node names w/ moreblocks/stairsplus names

---------------------------
:: translation from xdecor workbench names to moreblocks/stairsplus names ::

sample material: default:wood

* default:wood_nanoslab       -> moreblocks:micro_wood_1
* default:wood_micropanel     -> moreblocks:panel_wood_1
* default:wood_microslab      -> moreblocks:slab_wood_1
* default:wood_thinstair      -> moreblocks:stair_wood_alt_1
* default:wood_cube           -> moreblocks:micro_wood
* default:wood_panel          -> moreblocks:panel_wood
* default:wood_doublepanel    -> moreblocks:stair_wood_alt
* default:wood_halfstair      -> moreblocks:stair_wood_half

* moreblocks:slab_wood        -> moreblocks:slab_wood
* moreblocks:stair_wood_outer -> moreblocks:stair_wood_outer
* moreblocks:stair_wood       -> moreblocks:stair_wood
* moreblocks:stair_wood_inner -> moreblocks:stair_wood_inner

:: stuff outside default/moreblocks typically uses its own mod name ::

------------------------------
LIST OF KNOWN UNKNOWN NODES

bakedclay:orange_microslab
bakedclay:white_doublepanel
bakedclay:white_microslab

building_blocks:smoothglass_microslab

default:cobble_thinstair
default:diamondblock_cube
default:glass_microslab
default:ice_microslab
default:obsidianbrick_thinstair
default:pine_wood_doublepanel
default:pine_wood_thinstair
default:steelblock_panel
default:stonebrick_microslab

pkarcs:cobble_arc
pkarcs:sandstone_arc

quartz:block_doublepanel
quartz:block_microslab

xdecor:woodframed_glass_microslab

-- bakedclay
stairs:slab_black
stairs:slab_blue
stairs:slab_dark_green
stairs:slab_green
stairs:slab_grey
stairs:slab_orange
stairs:slab_red
stairs:slab_white
stairs:slab_yellow
stairs:stair_black
stairs:stair_green
stairs:stair_white
stairs:stair_yellow

-- bls
stairs:slab_Marble
stairs:stair_Marble

-- building_blocks
stairs:slab_grate
stairs:stair_hardwood

-- default
stairs:slab_oak_planks
stairs:slab_birch_planks

-- moreblocks
stairs:slab_coal_stone_bricks
stairs:slab_cobble_compressed
stairs:slab_iron_stone_bricks
stairs:slab_stone_tile
stairs:slab_wood_tile
stairs:stair_cactus_brick
stairs:stair_grey_bricks
stairs:stair_split_stone_tile

-- moretrees
stairs:stair_date_palm_planks
stairs:stair_willow_planks
stairs:stair_poplar_planks

-- nether
stairs:stair_rack

-- quartz
stairs:stair_block
stairs:slab_block

-- xdecor
stairs:slab_stone_rune

]]--

local nformat = bls.util.nformat

local affected_mods = {
    bakedclay=1,
    basic_materials=1,
    bls=1,
    bridger=1,
    building_blocks=1,
    caverealms=1,
    cblocks=1,
    default=1,
    gravelsieve=1,
    moreblocks=1,
    moreores=1,
    moretrees=1,
    nether=1,
    quartz=1,
    redtrees=1,
    sakuragi=1,
    streets=1,
    xdecor=1,
}

-- predicates for filtering
local function is(...)
    local mods = {...}
    return function(mod_name, node_name)
        for _, mod in ipairs(mods) do
            if mod_name == mod then
                return true
            end
        end
        return false
    end
end
local function not_(fun) return function(...) return not fun(...) end end
local is_default = is("default", "moreblocks")
local function is_any() return true end

-- param2 tweaks for replacements w/ different meshes
local function rot_180(param2)
    local axis = math.floor(param2 / 4)
    local rotv = param2 % 4
    local new_rotv = (rotv + 2) % 4
    return (4 * axis) + new_rotv
end

local function rot_270(param2)
    local axis = math.floor(param2 / 4)
    local rotv = param2 % 4
    local new_rotv = (rotv + 3) % 4
    return (4 * axis) + new_rotv
end

local variants = {
    -- {predicate, source_pattern, target_pattern, param2 tweak}

    -- nanoslab
    {is_default,       "%(mod_name)s:%(node_name)s_nanoslab", "moreblocks:micro_%(node_name)s_1",   rot_270},
    {not_(is_default), "%(mod_name)s:%(node_name)s_nanoslab", "%(mod_name)s:micro_%(node_name)s_1", rot_270},

    -- micropanel
    {is_default,       "%(mod_name)s:%(node_name)s_micropanel", "moreblocks:panel_%(node_name)s_1",   rot_180},
    {not_(is_default), "%(mod_name)s:%(node_name)s_micropanel", "%(mod_name)s:panel_%(node_name)s_1", rot_180},

    -- "microslab",
    {is_default,       "%(mod_name)s:%(node_name)s_microslab", "moreblocks:slab_%(node_name)s_1"},
    {not_(is_default), "%(mod_name)s:%(node_name)s_microslab", "%(mod_name)s:slab_%(node_name)s_1"},

    --"thinstair",
    {is_default,       "%(mod_name)s:%(node_name)s_thinstair", "moreblocks:stair_%(node_name)s_alt_1"},
    {not_(is_default), "%(mod_name)s:%(node_name)s_thinstair", "%(mod_name)s:stair_%(node_name)s_alt_1"},

    --"cube",
    {is_default,       "%(mod_name)s:%(node_name)s_cube", "moreblocks:micro_%(node_name)s",   rot_270},
    {not_(is_default), "%(mod_name)s:%(node_name)s_cube", "%(mod_name)s:micro_%(node_name)s", rot_270},

    --"panel",
    {is_default,       "%(mod_name)s:%(node_name)s_panel", "moreblocks:panel_%(node_name)s",   rot_180},
    {not_(is_default), "%(mod_name)s:%(node_name)s_panel", "%(mod_name)s:panel_%(node_name)s", rot_180},

    --"doublepanel",
    {is_default,       "%(mod_name)s:%(node_name)s_doublepanel", "moreblocks:stair_%(node_name)s_alt"},
    {not_(is_default), "%(mod_name)s:%(node_name)s_doublepanel", "%(mod_name)s:stair_%(node_name)s_alt"},

    --"halfstair",
    {is_default,       "%(mod_name)s:%(node_name)s_halfstair", "moreblocks:stair_%(node_name)s_half"},
    {not_(is_default), "%(mod_name)s:%(node_name)s_halfstair", "%(mod_name)s:stair_%(node_name)s_half"},

    -- pkarcs
    {is_default, "pkarcs:%(node_name)s_arc",       "moreblocks:stair_%(node_name)s"},
    {is_default, "pkarcs:%(node_name)s_outer_arc", "moreblocks:stair_%(node_name)s_outer"},
    {is_default, "pkarcs:%(node_name)s_inner_arc", "moreblocks:stair_%(node_name)s_inner"},

    -- stairs
    {is_any, "stairs:slab_%(node_name)s",  "%(mod_name)s:slab_%(node_name)s"},
    {is_any, "stairs:stair_%(node_name)s", "%(mod_name)s:stair_%(node_name)s"},
    {not_(is("bakedclay")), "stairs:stair_outer_%(node_name)s", "%(mod_name)s:stair_%(node_name)s_outer"},
    {is("bakedclay"), "stairs:stair_outer_%(node_name)s", "%(mod_name)s:stair_baked_clay_%(node_name)s_outer"},
    {not_(is("bakedclay")), "stairs:stair_inner_%(node_name)s", "%(mod_name)s:stair_%(node_name)s_inner"},
    {is("bakedclay"), "stairs:stair_inner_%(node_name)s", "%(mod_name)s:stair_baked_clay_%(node_name)s_inner"},
}

local source_ids = {}
local target_by_source = {}

bls.log("action", "registering microblock cleanup")

for node_id, def in pairs(minetest.registered_nodes) do
    local mod_name, node_name = node_id:match("^([^:]+):([^:]+)$")
    if mod_name and node_name and affected_mods[mod_name] and xdecor.stairs_valid_def(def) then
        for _, variant in ipairs(variants) do
            local predicate, src_fmt, tgt_fmt, rot_func = unpack(variant)
            if predicate(mod_name, node_name) then
                local src = nformat(src_fmt, {mod_name=mod_name, node_name=node_name})
                local tgt = nformat(tgt_fmt, {mod_name=mod_name, node_name=node_name})

                if minetest.registered_aliases[tgt] then
                    tgt = minetest.registered_aliases[tgt]
                end

                if tgt and minetest.registered_nodes[tgt] then
                    bls.log("action", "registering alias: %q -> %q", src, tgt)
                    table.insert(source_ids, src)
                    target_by_source[src] = {tgt, rot_func}
                    --minetest.register_alias_force(src, tgt)
                else
                    bls.log("warning", "FAILED alias: %q -> %q", src, tgt)
                end
            end
        end
    end
end

minetest.register_lbm({
    label = "microblocks cleanup 117",
    name = "bls:microblocks_cleanup_117",
    nodenames = source_ids,
    -- for some reason, this won't work if run_at_every_load = false
    run_at_every_load = true,
    action = function(pos, node)
        local spos = minetest.pos_to_string(pos, 0)
        local src = node.name
        local target = target_by_source[src]
        if not target then
            bls.log("error", "no target for src %q (node %q) @ %s", src, node.name, spos)
            return
        end
        local tgt, rot = unpack(target)
        bls.log("action", "microblocks cleanup: replacing @ %q; %q -> %q", spos, src, tgt)
        local param2 = node.param2
        if rot then
            local old_param2 = param2
            param2 = rot(param2)
            bls.log("action", "microblocks cleanup: rotating @ %q %q -> %q", spos, old_param2, param2)
        end
        minetest.swap_node(pos, {name=tgt, param1=node.param1, param2=param2})
    end
})
