-- PLEASE KEEP MOD SECTIONS IN ALPHABETICAL ORDER
-- ORGANIZE LOGIC BY THE TARGET ITEM

local function set_food_group(name, value)
    local def = minetest.registered_items[name]
    if not def then
        bls.log('error', 'could not find %s to set food group', name)
        return
    end
    value = value or 1
    local groups = table.copy(def.groups or {})
    groups.food = value
    minetest.override_item(name, {groups=groups})
end

local function set_eat(name, food_value, ...)
    if food_value == 0 then
        minetest.override_item(name, {on_use=function() end})
    else
        local def = minetest.registered_items[name]
        if not def then
            bls.log('error', 'could not find %s to set eat', name)
            return
        end
        local groups = table.copy(def.groups or {})
        groups.food = food_value
        minetest.override_item(name, {groups=groups, on_use=minetest.item_eat(food_value, ...)})
    end
end

local function set_eat_or_poison(name, food_value, damage_value, chance, replace_with_item)
    local def = minetest.registered_items[name]
    if not def then
        bls.log('error', 'could not find %s to set eat or poison', name)
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
    minetest.override_item(name, {
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

if minetest.get_modpath('default') then
    set_eat('default:apple', 2)
    -- blueberries are aliased
    set_eat_or_poison('flowers:mushroom_red', 2, -10)
    set_eat('flowers:mushroom_brown', 2)
end

if minetest.get_modpath('extra') then
    set_eat('extra:blooming_onion', 8)
    set_eat('extra:cheeseburger', 12)
    set_eat('extra:cheese_pizza', 6)
    set_eat('extra:cornbread', 4)
    set_eat('extra:corn_dog', 6)
    set_eat('extra:deluxe_pizza', 12)
    set_eat('extra:fish_sticks', 8)
    set_eat('extra:flour_tortilla', 2)
    set_eat('extra:french_fries', 6)
    set_eat('extra:garlic_bread', 4)
    set_eat('extra:grilled_patty', 4)
    set_eat_or_poison('extra:ground_meat', 2, -4)
    set_eat('extra:hamburger', 8)
    set_eat('extra:lasagna', 8)
    set_eat('extra:marinara', 4)
    set_eat('extra:meatloaf', 8)
    set_eat_or_poison('extra:meatloaf_raw', 6, -4)
    set_eat_or_poison('extra:meat_patty', 2, -4)
    set_eat('extra:onion_rings', 6)
    set_eat('extra:onion_slice', 0)
    set_eat('extra:pasta', 0)
    set_eat('extra:pepperoni', 10)
    set_eat('extra:pepperoni_pizza', 8)
    set_eat('extra:pineapple_pizza', 8)
    set_eat('extra:potato_crisps', 2)
    set_eat('extra:potato_slice', 0)
    set_eat('extra:quesadilla', 6)
    set_eat_or_poison('extra:rum', 4, -4, 2, bottle)
    set_eat('extra:salsa', 4)
    set_eat('extra:spaghetti', 6)
    set_eat('extra:super_taco', 8)
    set_eat('extra:taco', 6)
    set_eat_or_poison('extra:tequila', 4, -4, 2, bottle)
    set_eat('extra:tomato_slice', 0)
end

if minetest.get_modpath('farming') then
    set_eat('farming:baked_potato', 4)
    set_eat('farming:beans', 2)
    set_eat('farming:beetroot', 2)
    set_eat('farming:beetroot_soup', 12, bowl) -- TODO make this not just a beet concentrate?
    set_eat('farming:blueberries', 2)
    set_eat('farming:blueberry_pie', 8)
    set_eat('farming:bread', 4)
    set_eat('farming:bread_multigrain', 8)
    set_eat('farming:bread_slice', 2)
    set_eat('farming:carrot', 2)
    set_eat('farming:carrot_gold', 12)
    set_eat('farming:carrot_juice', 2, glass)
    set_eat('farming:chili_bowl', 8, bowl)
    set_eat('farming:chili_pepper', 2)
    set_eat('farming:chocolate_dark', 4)
    set_eat('farming:coffee_cup', 2, glass)
    set_eat('farming:cookie', 2)
    set_eat('farming:corn', 2)
    set_eat('farming:corn_cob', 4)
    set_eat('farming:cucumber', 2)
    set_eat('farming:donut', 2)
    set_eat('farming:donut_apple', 4)
    set_eat('farming:donut_chocolate', 4)
    set_eat('farming:garlic', 2)
    set_eat('farming:garlic_bread', 6)
    set_eat('farming:grapes', 2)
    set_eat('farming:jaffa_cake', 12)
    set_eat('farming:melon_slice', 2)
    set_eat('farming:muffin_blueberry', 4)
    set_eat('farming:onion', 2)
    set_eat('farming:peas', 2)
    set_eat('farming:pea_soup', 4)
    set_eat('farming:pepper', 2)
    set_eat('farming:pineapple_juice', 6, glass)
    set_eat('farming:pineapple_ring', 2)
    set_eat('farming:porridge', 8, bowl)
    -- set_eat('farming:potato', 1) -- nevermind, fancy special logic
    set_food_group('farming:potato', 2)
    set_eat('farming:potato_salad', 4, bowl)
    set_eat('farming:pumpkin_bread', 8)
    set_eat('farming:pumpkin_slice', 2)
    set_eat('farming:raspberries', 2)
    set_eat('farming:rhubarb', 2)
    set_eat('farming:rhubarb_pie', 12)
    set_eat('farming:rice_bread', 8)
    set_eat('farming:smoothie_raspberry', 4, glass)
    set_eat('farming:toast', 2)
    set_eat('farming:toast_sandwich', 6)
    set_eat('farming:tomato', 2)
    set_eat('farming:turkish_delight', 12)
end

if minetest.get_modpath('homedecor_gastronomy') then
    set_eat('homedecor:soda_can', 2)
end

set_eat('bls:honey_bottle', 8)

if minetest.get_modpath('mobs') then
    set_eat_or_poison('mobs:meat_raw', 4, -2)
    set_eat('mobs:meat', 8)
end

if minetest.get_modpath('mobs_animal') then
    set_eat('mobs:bucket_milk', 8, bucket)
    set_eat('mobs:butter', 2)
    set_eat('mobs:cheese', 4)
    set_eat('mobs:chicken_cooked', 6)
    set_eat('mobs:chicken_egg_fried', 4)
    set_eat_or_poison('mobs:chicken_raw', 4, -4)
    set_eat('mobs:glass_milk', 2, glass)
    set_eat('mobs:honey', 2)
    set_eat('mobs:mutton_cooked', 8)
    set_eat_or_poison('mobs:mutton_raw', 4, -2)
    set_eat('mobs:pork_cooked', 8)
    set_eat_or_poison('mobs:pork_raw', 4, -4)
    set_eat('mobs:rabbit_cooked', 6)
    set_eat_or_poison('mobs:rabbit_raw', 4, -2)
    set_eat('mobs:rat_cooked', 12)
end

if minetest.get_modpath('moreplants') then
    set_eat('moreplants:bluemush', 2)
    set_eat('moreplants:curlyfruit', 2)
    set_eat('moreplants:medflower', 2)
end

if minetest.get_modpath('moretrees') then
    set_eat('moretrees:acorn_muffin', 6)
    set_eat('moretrees:cedar_nuts', 2)
    set_eat('moretrees:coconut_milk', 2)
    set_eat('moretrees:date', 2)
    set_eat('moretrees:date_nut_bar', 8)
    set_eat('moretrees:date_nut_cake', 20)
    set_eat('moretrees:date_nut_snack', 8)
    set_eat('moretrees:fir_nuts', 2)
    set_eat('moretrees:raw_coconut', 4)
    set_eat('moretrees:spruce_nuts', 2)
end

if minetest.get_modpath('xdecor') then
    set_eat('xdecor:honey', 2)
    set_food_group('xdecor:bowl_soup', 20)
end

-- THIS MUST GO LAST HERE
if minetest.global_exists('terumet') then
    for item_id, def in pairs(minetest.registered_items) do
        local mod, item = item_id:match('terumet:vacf_([^_]+)_(.+)')
        if mod and item then
            local base_def = minetest.registered_items[('%s:%s'):format(mod, item)]
            if base_def then
                local groups = table.copy(def.groups or {})
                groups.food = 1
                minetest.override_item(item_id, {
                    groups=groups,
                    on_use=base_def.on_use
                })
            else
                bls.log('error', 'could not find base food for vacuumed food %', item_id)
            end
        end
    end
end

