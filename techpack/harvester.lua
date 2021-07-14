if not minetest.get_modpath("tubelib_addons1") then return end
local tn = tubelib_addons1.register_tree_node  -- (name, drop, plant)
local fn = tubelib_addons1.register_farming_node  -- (name, drop, plant)

if minetest.get_modpath("baldcypress") then
    tn("baldcypress:trunk", "baldcypress:trunk", "baldcypress:sapling")
    fn("baldcypress:dry_branches")
    fn("baldcypress:leaves")
    fn("baldcypress:liana")
end

if minetest.get_modpath("bamboo") then
    tn("bamboo:trunk", "bamboo:trunk", "bamboo:sprout")
    fn("bamboo:leaves")
end

if minetest.get_modpath("birch") then
    tn("birch:trunk", "birch:trunk", "birch:sapling")
    fn("birch:leaves")
end

if minetest.get_modpath("cherrytree") then
    tn("cherrytree:trunk", "cherrytree:trunk", "cherrytree:sapling")
    fn("cherrytree:leaves")
    fn("cherrytree:blossom_leaves")
    fn("cherrytree:cherries")
end

if minetest.get_modpath("chestnuttree") then
    tn("chestnuttree:trunk", "chestnuttree:trunk", "chestnuttree:sapling")
    fn("chestnuttree:leaves")
    fn("chestnuttree:bur")
end

if minetest.get_modpath("clementinetree") then
    tn("clementinetree:trunk", "clementinetree:trunk", "clementinetree:sapling")
    fn("clementinetree:leaves")
    fn("clementinetree:clementine")
end

if minetest.get_modpath("cucina_vegana") then
    fn("cucina_vegana:parsley_5", "cucina_vegana:parsley 2", "cucina_vegana:parsley_1")
    fn("cucina_vegana:rosemary_6", "cucina_vegana:rosemary 2", "cucina_vegana:rosemary_1")
    fn("cucina_vegana:chives_5", "cucina_vegana:chives 2", "cucina_vegana:chives_1")
    fn("cucina_vegana:flax_6", "cucina_vegana:flax_raw 2", "cucina_vegana:flax_1")
    fn("cucina_vegana:kohlrabi_6", "cucina_vegana:kohlrabi 4", "cucina_vegana:kohlrabi_1")
    fn("cucina_vegana:asparagus_6", "cucina_vegana:asparagus 2", "cucina_vegana:asparagus_1")
    fn("cucina_vegana:lettuce_5", "cucina_vegana:lettuce 2", "cucina_vegana:lettuce_1")
    fn("cucina_vegana:soy_8", "cucina_vegana:soy 6", "cucina_vegana:soy_1")
    fn("cucina_vegana:peanut_7", "cucina_vegana:peanut_seed 6", "cucina_vegana:peanut_1")
    fn("cucina_vegana:rice_6", "cucina_vegana:rice 6", "cucina_vegana:rice_1")
    fn("cucina_vegana:sunflower_5", "cucina_vegana:sunflower 4", "cucina_vegana:sunflower_1")
end

if minetest.get_modpath("default") then
    tn("default:bush_stem", "default:bush_stem", "default:bush_sapling")
    tn("default:acacia_bush_stem", "default:acacia_bush_stem", "default:acacia_bush_sapling")
    tn("default:pine_bush_stem", "default:pine_bush_stem", "default:pine_bush_sapling")
    fn("default:pine_bush_needles")
end

if minetest.get_modpath("ebony") then
    tn("ebony:trunk", "ebony:trunk", "ebony:sapling")
    fn("ebony:leaves")
    fn("ebony:creeper")
    fn("ebony:creeper_leaves")
    fn("ebony:liana")
    fn("ebony:persimmon")
end

if minetest.get_modpath("farming") then
    fn("farming:cabbage_6", "farming:cabbage 2", "farming:cabbage_1")
    fn("farming:mint_4", "farming:mint_leaf 4", "farming:mint_1")
end

if minetest.get_modpath("hollytree") then
    tn("hollytree:trunk", "hollytree:trunk", "hollytree:sapling")
    fn("hollytree:leaves")
end

if minetest.get_modpath("jacaranda") then
    tn("jacaranda:trunk", "jacaranda:trunk", "jacaranda:sapling")
    fn("jacaranda:leaves")
    fn("jacaranda:blossom_leaves")
end

if minetest.get_modpath("larch") then
    tn("larch:trunk", "larch:trunk", "larch:sapling")
    fn("larch:leaves")
    fn("larch:moss")
end

if minetest.get_modpath("lemontree") then
    tn("lemontree:trunk", "lemontree:trunk", "lemontree:sapling")
    fn("lemontree:leaves")
    fn("lemontree:lemon")
end

if minetest.get_modpath("mahogany") then
    tn("mahogany:trunk", "mahogany:trunk", "mahogany:sapling")
    fn("mahogany:leaves")
    fn("mahogany:creeper")
    fn("mahogany:flower_creeper")
    fn("mahogany:hanging_creeper")
end

if minetest.get_modpath("maple") then
    tn("maple:trunk", "maple:trunk", "maple:sapling")
    fn("maple:leaves")
end

if minetest.get_modpath("oak") then
    tn("oak:trunk", "oak:trunk", "oak:sapling")
    fn("oak:leaves")
    fn("oak:acorn")
end

if minetest.get_modpath("pomegranate") then
    tn("pomegranate:trunk", "pomegranate:trunk", "pomegranate:sapling")
    fn("pomegranate:leaves")
    fn("pomegranate:pomegranate")
end

if minetest.get_modpath("palm") then
    tn("palm:trunk", "palm:trunk", "palm:sapling")
    fn("palm:leaves")
    fn("palm:coconut")
end

if minetest.get_modpath("redtrees") then
    tn("redtrees:rtree", "redtrees:rtree", "redtrees:rsapling")
    fn("redtrees:rleaves")
end

if minetest.get_modpath("sakuragi") then
    tn("sakuragi:stree", "sakuragi:stree", "sakuragi:ssapling")
    fn("sakuragi:sleaves")
end

if minetest.get_modpath("willow") then
    tn("willow:trunk", "willow:trunk", "willow:sapling")
    fn("willow:leaves")
end

if minetest.get_modpath("plumtree") then
    tn("plumtree:trunk", "plumtree:trunk", "plumtree:sapling")
    fn("plumtree:leaves")
    fn("plumtree:plum")
end

if minetest.get_modpath("vines") then
    fn("vines:jungle_end", "vines:vines")
    fn("vines:jungle_middle", "vines:vines")
    fn("vines:root_end", "vines:vines")
    fn("vines:root_middle", "vines:vines")
    fn("vines:side_end", "vines:vines")
    fn("vines:side_middle", "vines:vines")
    fn("vines:vine_end", "vines:vines")
    fn("vines:vine_middle", "vines:vines")
    fn("vines:willow_end", "vines:vines")
    fn("vines:willow_middle", "vines:vines")
end