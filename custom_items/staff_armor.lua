if not (minetest.get_modpath("3d_armor") and minetest.global_exists("armor")) then
    return
end

minetest.register_privilege("invincible", "Makes a player invincible")

armor:register_armor("bls:shield_bls", {
    description = "BlS Shield",
    inventory_image = "bls_shield_bls_inv.png",
    groups = {armor_shield=2.2250738585072014e-308, armor_heal=0, armor_use=0, not_in_creative_inventory=1},
    drop = {},
    on_drop = function(itemstack, dropper, pos) end
})

armor:register_armor("bls:shield_staff", {
    -- staff shield: doesn't protect the player, but doesn't break either
    description = "BlS Shield",
    inventory_image = "bls_shield_bls_inv.png",
    texture = "bls_shield_bls.png",
    preview = "bls_shield_bls_preview.png",
    groups = {armor_shield=2.2250738585072014e-308, armor_heal=0, armor_use=0, not_in_creative_inventory=1},
    drop = {},
    on_drop = function(itemstack, dropper, pos) end
})

local admin_armor_list = {
    ["3d_armor:helmet_admin"]=true,
    ["3d_armor:chestplate_admin"]=true,
    ["3d_armor:leggings_admin"]=true,
    ["3d_armor:boots_admin"]=true,
    ["shields:shield_admin"]=true,
    ["bls:shield_bls"]=true,
    ["bls:infinity_bracer"]=true,
    ["bls:flux_bracer"]=true,
}

local function is_wearing_admin_armor(player)
    local name, armor_inv = armor:get_valid_player(player, "[bls_is_wearing_admin_armor]]")
    if not name or not armor_inv then
        return false
    end

    local privs = minetest.get_player_privs(name) or {}
    if privs.invincible then
        return true
    end

    for _, stack in pairs(armor_inv:get_list("armor")) do
        local stack_name = stack:get_name()
        if admin_armor_list[stack_name] then
            return true
        end
    end
    return false
end

-- prevent all damage if player is wearing admin armor
local old_registered_on_player_hpchange = minetest.registered_on_player_hpchange
function minetest.registered_on_player_hpchange(player, hp_change, reason)
    if is_wearing_admin_armor(player) then
        return 0
    else
        return old_registered_on_player_hpchange(player, hp_change, reason)
    end
end

-- don't damage other armor if player is wearing admin armor
local old_armor_punch = armor.punch
armor.punch = function(self, player, hitter, time_from_last_punch, tool_capabilities)
    if is_wearing_admin_armor(player) then
        return
    else
        return old_armor_punch(self, player, hitter, time_from_last_punch, tool_capabilities)
    end
end

-- keep admin armor from dropping if the player still somehow dies
local old_armor_drop = armor.drop_armor
function armor.drop_armor(pos, stack)
    local item_stack = ItemStack(stack)  -- ensure it's a proper ItemStack in case of string
    local stack_name = item_stack and item_stack:get_name()
    if stack_name and admin_armor_list[stack_name] then
        return
    else
        return old_armor_drop(pos, stack)
    end
end

-- make sure players w/out creative (or give) aren't wearing admin armor
local period = 10.3
local elapsed = 0
minetest.register_globalstep(function(dtime)
    elapsed = elapsed + dtime
    if elapsed >= period then
        elapsed = 0
        for _, player in ipairs(minetest.get_connected_players()) do
            local name, armor_inv = armor:get_valid_player(player, "[bls_armor_globalstep]]")
            if not name then name = player:get_player_name() end
            local privs = minetest.get_player_privs(name) or {}
            if armor_inv and not (privs.creative or privs.give) then
                for i=1, armor_inv:get_size("armor") do
                    local stack = armor_inv:get_stack("armor", i)
                    local stack_name = stack:get_name()
                    if admin_armor_list[stack_name] then
                        armor:run_callbacks("on_unequip", player, i, stack)
                        armor_inv:set_stack("armor", i, nil)
                    end
                end
            end
        end
    end
end)
