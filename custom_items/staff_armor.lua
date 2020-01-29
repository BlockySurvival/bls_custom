if not (minetest.get_modpath("3d_armor") and minetest.global_exists("armor")) then
    return
end

armor:register_armor("bls:shield_bls", {
    description = "BlS Shield",
    inventory_image = "bls_inv_shield_bls.png",
    groups = {armor_shield=1000, armor_heal=100, armor_use=0, not_in_creative_inventory=1},
})

armor:register_armor("bls:shield_staff", {
    -- staff shield: doesn"t protect the player, but doesn"t break either
    description = "BlS Shield",
    inventory_image = "bls_inv_shield_bls.png",
    groups = {armor_shield=0, armor_heal=0, armor_use=0, not_in_creative_inventory=1},
})

if minetest.global_exists("armor") then
    -- don"t damage other armor if player is wearing admin armor
    local admin_armor_list = {
        ["3d_armor:helmet_admin"]=true,
        ["3d_armor:chestplate_admin"]=true,
        ["3d_armor:leggings_admin"]=true,
        ["3d_armor:boots_admin"]=true,
        ["shields:shield_admin"]=true,
        ["bls:shield_bls"]=true,
    }
    local armor_punch = armor.punch
    armor.punch = function(self, player, hitter, time_from_last_punch, tool_capabilities)
        -- when wearing admin armor, don"t damage other armor :\
        local name, armor_inv = self:get_valid_player(player, "[punch]")
        if not name then
            return
        end
        for _, stack in pairs(armor_inv:get_list("armor")) do
            local stack_name = stack:get_name()
            if admin_armor_list[stack_name] then
                return
            end
        end
        return armor_punch(self, player, hitter, time_from_last_punch, tool_capabilities)
    end
end
