-- PLEASE KEEP MOD SECTIONS IN ALPHABETICAL ORDER
-- ORGANIZE LOGIC BY THE TARGET ITEM

local get_modpath = minetest.get_modpath
local override_item = minetest.override_item
local registered_items = minetest.registered_items

local function set_food_group(name, value)
    local def = registered_items[name]
    if not def then
        bls_overrides.log('error', 'could not find %s to set food group', name)
        return
    end
    value = value or 1
    local groups = table.copy(def.groups or {})
    groups.food = value
    override_item(name, {groups=groups})
end

local function set_eat(name, food_value, ...)
    if food_value == 0 then
        override_item(name, {on_use=function() end})
    else
        local def = registered_items[name]
        if not def then
            bls_overrides.log('error', 'could not find %s to set eat', name)
            return
        end
        local groups = table.copy(def.groups or {})
        groups.food = food_value
        override_item(name, {groups=groups, on_use=minetest.item_eat(food_value, ...)})
    end
end

local function set_eat_or_poison(name, food_value, damage_value, chance, replace_with_item)
    local def = registered_items[name]
    if not def then
        bls_overrides.log('error', 'could not find %s to set eat or poison', name)
        return
    end
    local groups = table.copy(def.groups or {})
    groups.food = food_value
    if not damage_value then
        damage_value = 0
    elseif damage_value > 0 then
        damage_value = -damage_value
    end
    if not chance then
        chance = 3
    end
    override_item(name, {
        groups=groups,
        on_use=function(itemstack, user, pointed_thing)
            if user then
                if math.random(1, chance) == 1 then
                    return minetest.do_item_eat(damage_value, replace_with_item, itemstack, user, pointed_thing)
                else
                    return minetest.do_item_eat(food_value, replace_with_item, itemstack, user, pointed_thing)
                end
            end
        end
    })
end

local bowl = 'farming:bowl'
local glass = 'vessels:drinking_glass'
local bottle = 'vessels:glass_bottle'
local bucket = 'bucket:bucket_empty'

if get_modpath('default') then
    set_eat('default:apple', 1)
    -- blueberries are aliased
    set_eat('flowers:mushroom_red', -5)
    set_eat('flowers:mushroom_brown', 1)
end

if get_modpath('extra') then
    set_eat('extra:blooming_onion', 4)
    set_eat('extra:cheeseburger', 6)
    set_eat('extra:cheese_pizza', 3)
    set_eat('extra:cornbread', 2)
    set_eat('extra:corn_dog', 3)
    set_eat('extra:deluxe_pizza', 6)
    set_eat('extra:fish_sticks', 4)
    set_eat('extra:flour_tortilla', 1)
    set_eat('extra:french_fries', 3)
    set_eat('extra:garlic_bread', 2)
    set_eat('extra:grilled_patty', 2)
    set_eat_or_poison('extra:ground_meat', 1, -2)
    set_eat('extra:hamburger', 4)
    set_eat('extra:lasagna', 4)
    set_eat('extra:marinara', 2)
    set_eat('extra:meatloaf', 4)
    set_eat_or_poison('extra:meatloaf_raw', 3, -2)
    set_eat_or_poison('extra:meat_patty', 1, -2)
    set_eat('extra:onion_rings', 3)
    set_eat('extra:onion_slice', 0)
    set_eat('extra:pasta', 0)
    set_eat('extra:pepperoni', 5)
    set_eat('extra:pepperoni_pizza', 4)
    set_eat('extra:pineapple_pizza', 4)
    set_eat('extra:potato_crisps', 1)
    set_eat('extra:potato_slice', 0)
    set_eat('extra:quesadilla', 3)
    set_eat_or_poison('extra:rum', 2, -2, 2, bottle)
    set_eat('extra:salsa', 2)
    set_eat('extra:spaghetti', 3)
    set_eat('extra:super_taco', 4)
    set_eat('extra:taco', 3)
    set_eat_or_poison('extra:tequila', 2, -2, 2, bottle)
    set_eat('extra:tomato_slice', 0)
end

if get_modpath('farming') then
    set_eat('farming:baked_potato', 2)
    set_eat('farming:beans', 1)
    set_eat('farming:beetroot', 1)
    set_eat('farming:beetroot_soup', 6, bowl) -- TODO make this not just a beet concentrate?
    set_eat('farming:blueberries', 1)
    set_eat('farming:blueberry_pie', 4)
    set_eat('farming:bread', 2)
    set_eat('farming:bread_multigrain', 4)
    set_eat('farming:bread_slice', 1)
    set_eat('farming:carrot', 1)
    set_eat('farming:carrot_gold', 6)
    set_eat('farming:carrot_juice', 1, glass)
    set_eat('farming:chili_bowl', 4, bowl)
    set_eat('farming:chili_pepper', 1)
    set_eat('farming:chocolate_dark', 2)
    set_eat('farming:coffee_cup', 1, glass)
    set_eat('farming:cookie', 1)
    set_eat('farming:corn', 1)
    set_eat('farming:corn_cob', 2)
    set_eat('farming:cucumber', 1)
    set_eat('farming:donut', 1)
    set_eat('farming:donut_apple', 2)
    set_eat('farming:donut_chocolate', 2)
    set_eat('farming:garlic', 1)
    set_eat('farming:garlic_bread', 3)
    set_eat('farming:grapes', 1)
    set_eat('farming:jaffa_cake', 6)
    set_eat('farming:melon_slice', 1)
    set_eat('farming:muffin_blueberry', 2)
    set_eat('farming:onion', 1)
    set_eat('farming:peas', 1)
    set_eat('farming:pea_soup', 2)
    set_eat('farming:pepper', 1)
    set_eat('farming:pineapple_juice', 3, glass)
    set_eat('farming:pineapple_ring', 1)
    set_eat('farming:porridge', 4, bowl)
    -- set_eat('farming:potato', 1) -- nevermind, fancy special logic
    set_food_group('farming:potato', 1)
    set_eat('farming:potato_salad', 2, bowl)
    set_eat('farming:pumpkin_bread', 4)
    set_eat('farming:pumpkin_slice', 1)
    set_eat('farming:raspberries', 1)
    set_eat('farming:rhubarb', 1)
    set_eat('farming:rhubarb_pie', 6)
    set_eat('farming:rice_bread', 4)
    set_eat('farming:smoothie_raspberry', 2, glass)
    set_eat('farming:toast', 1)
    set_eat('farming:toast_sandwich', 3)
    set_eat('farming:tomato', 1)
    set_eat('farming:turkish_delight', 6)
end

if get_modpath('homedecor_gastronomy') then
    set_eat('homedecor:soda_can', 1)
end

if get_modpath('main') then
    set_eat('main:honey_bottle', 4)
end

if get_modpath('mobs') then
    set_eat_or_poison('mobs:meat_raw', 2, -1)
    set_eat('mobs:meat', 4)
end

if get_modpath('mobs_animal') then
    set_eat('mobs:bucket_milk', 4, bucket)
    set_eat('mobs:butter', 1)
    set_eat('mobs:cheese', 2)
    set_eat('mobs:chicken_cooked', 3)
    set_eat('mobs:chicken_egg_fried', 2)
    set_eat_or_poison('mobs:chicken_raw', 2, -2)
    set_eat('mobs:glass_milk', 1, glass)
    set_eat('mobs:honey', 1)
    set_eat('mobs:mutton_cooked', 4)
    set_eat_or_poison('mobs:mutton_raw', 2, -1)
    set_eat('mobs:pork_cooked', 4)
    set_eat_or_poison('mobs:pork_raw', 2, -2)
    set_eat('mobs:rabbit_cooked', 3)
    set_eat_or_poison('mobs:rabbit_raw', 2, -1)
    set_eat('mobs:rat_cooked', 6)
end

if get_modpath('moreplants') then
    set_eat('moreplants:bluemush', 1)
    set_eat('moreplants:curlyfruit', 1)
    set_eat('moreplants:medflower', 1)
end

if get_modpath('moretrees') then
    set_eat('moretrees:acorn_muffin', 3)
    set_eat('moretrees:cedar_nuts', 1)
    set_eat('moretrees:coconut_milk', 1)
    set_eat('moretrees:date', 1)
    set_eat('moretrees:date_nut_bar', 4)
    set_eat('moretrees:date_nut_cake', 20)
    set_eat('moretrees:date_nut_snack', 4)
    set_eat('moretrees:fir_nuts', 1)
    set_eat('moretrees:raw_coconut', 2)
    set_eat('moretrees:spruce_nuts', 1)
end

if get_modpath('xdecor') then
    set_eat('xdecor:honey', 1)
    set_food_group('xdecor:bowl_soup', 20)
end

-- THIS MUST GO LAST HERE
if get_modpath('terumet') then
    for item_id, def in pairs(minetest.registered_items) do
        local mod, item = item_id:match('terumet:vacf_([^_]+)_(.+)')
        if mod and item then
            local base_def = minetest.registered_items[('%s:%s'):format(mod, item)]
            if base_def then
                local groups = table.copy(def.groups or {})
                groups.food = 1
                override_item(item_id, {
                    groups=groups,
                    on_use=base_def.on_use
                })
            else
                bls_overrides.log('error', 'could not base food for vacuumed food %', item_id)
            end
        end
    end
end

