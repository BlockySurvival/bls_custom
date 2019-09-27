if not minetest.get_modpath("tubelib_addons1") then return end
local dn = tubelib_addons1.register_default_farming_node

if minetest.get_modpath("cucina_vegana") then
    dn("cucina_vegana:parsley_5", "cucina_vegana:parsley", "cucina_vegana:parsley_1")
    dn("cucina_vegana:rosemary_6", "cucina_vegana:rosemary", "cucina_vegana:rosemary_1")
    dn("cucina_vegana:chives_5", "cucina_vegana:chives", "cucina_vegana:chives_1")
    dn("cucina_vegana:flax_6", "cucina_vegana:flax_raw", "cucina_vegana:flax_1")
    dn("cucina_vegana:kohlrabi_6", "cucina_vegana:kohlrabi", "cucina_vegana:kohlrabi_1")
    dn("cucina_vegana:asparagus_6", "cucina_vegana:asparagus", "cucina_vegana:asparagus_1")
    dn("cucina_vegana:lettuce_5", "cucina_vegana:lettuce", "cucina_vegana:lettuce_1")
    dn("cucina_vegana:soy_8", "cucina_vegana:soy", "cucina_vegana:soy_1")
    dn("cucina_vegana:peanut_7", "cucina_vegana:peanut", "cucina_vegana:peanut_1")
    dn("cucina_vegana:rice_6", "cucina_vegana:rice", "cucina_vegana:rice_1")
    dn("cucina_vegana:sunflower_5", "cucina_vegana:sunflower", "cucina_vegana:sunflower_1")
end
