-- Add a 20Mg note.

local S = minetest.get_translator("currency")

if not minetest.registered_items["currency:minegeld_20"] then
    minetest.register_craftitem(":currency:minegeld_20", {
        description = S("@1 Minegeld Note", "20"),
        inventory_image = "minegeld_20.png",
        stack_max = 65535,
        groups = {minegeld = 1},
    })

    minetest.register_craft({
        type = "shapeless",
        output = "currency:minegeld_20",
        recipe = {
            "currency:minegeld_10",
            "currency:minegeld_10"
        },
    })

    minetest.register_craft({
        type = "shapeless",
        output = "currency:minegeld_20 5",
        recipe = {
            "currency:minegeld_100"
        },
    })

    minetest.register_craft({
        type = "shapeless",
        output = "currency:minegeld_100",
        recipe = {
            "currency:minegeld_20",
            "currency:minegeld_20",
            "currency:minegeld_20",
            "currency:minegeld_20",
            "currency:minegeld_20"
        },
    })

    minetest.register_craft({
        type = "shapeless",
        output = "currency:minegeld_10 2",
        recipe = {
            "currency:minegeld_20"
        },
    })
end
