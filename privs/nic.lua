minetest.register_privilege("nic", "Allows player to use digilines NICs")

if minetest.registered_nodes["digistuff:nic"] then
    local old_on_place = minetest.registered_nodes["digistuff:nic"].on_place or minetest.item_place
    minetest.override_item("digistuff:nic", {
        on_place = function(itemstack, placer, ...)
            if not minetest.check_player_privs(placer, "nic") then
                minetest.chat_send_player(placer:get_player_name(),
                    "You need the \"nic\" privilege to be able to place digilines NICs!")
                return
            end
            return old_on_place(itemstack, placer, ...)
        end
    })
end
