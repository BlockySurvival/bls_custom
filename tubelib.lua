if minetest.global_exists('tubelib') then
    if minetest.global_exists('tubelib_addons1') then
        local function register_tree(sapling, trunk, leaves)
            tubelib_addons1.register_tree_node(trunk, trunk, sapling)
            tubelib_addons1.register_farming_node(leaves)
            tubelib.add_grinder_recipe({input=trunk, output=leaves .. ' 8'})
        end

        register_tree('redtrees:rsapling', 'redtrees:rtree', 'redtrees:rleaves')
        register_tree('sakuragi:ssapling', 'sakuragi:stree', 'sakuragi:sleaves')
    end
end
