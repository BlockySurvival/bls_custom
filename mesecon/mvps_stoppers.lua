if minetest.global_exists('mesecon') and mesecon.register_mvps_stopper then

    bls.log('info', '[bad_piston_no_biscuit] initializing')

    local patterns = {
        '3d_armor_stand:.*',
        'areasprotector:.*',
        'chesttools:shared_chest',
        'currency:.*',
        'default:chest.*',
        'doors:.*prison.*',
        'doors:.*steel.*',
        'gravelsieve:.*',
        'homedecor:.*_locked',
        'inbox:.*',
        'locked_travelnet:.*',
        'mailbox:.*',
        'maptools:.*',
        'mesecons_commandblock:.*',
        'my.*doors:.*_locked',
        'my_hidden_doors:.*',
        'nether:bedrock',
        'smartline:.*',
        'smartrenting:.*',
        'smartshop:.*',
        'technic:.*_locked_chest',
        'techpack_warehouse:.*',
        'terumet:mach_.*',
        'travelnet:.*',
        'tubelib.*:.*',
        'xdecor:mailbox',
    }

    for node_name, _ in bls.util.pairs_by_keys(minetest.registered_nodes) do
        for _, pattern in pairs(patterns) do
            local fullpattern = '^' .. pattern .. '$'
            if string.find(node_name, fullpattern) then
                bls.log('info', '[bad_piston_no_biscuit] registering ' .. node_name)
                mesecon.register_mvps_stopper(node_name)
                break
            end
        end
    end

end
