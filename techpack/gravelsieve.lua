if not minetest.get_modpath("gravelsieve") or not gravelsieve.api then
    return
end

local gs_api = gravelsieve.api



local function tempered_junk_outputs(raw_outputs, base_useful_rate)

    local normalised_outputs = gs_api.scale_probabilities_to_fill(raw_outputs, 1)

    local tempered_output = function (dat, output_name)
        if not dat.sieve_count then -- always return junk if old sieve (no player registered) OR player not logged in
            return normalised_outputs[output_name]
        end
        -- the graph of the total effectiveness of x sieves peaks around 50 at 18 times base effectiveness, then descends
        -- https://www.wolframalpha.com/input/?i=graph+y%3D%281%2F40%29*%280.98%5Ex%29*x+between+x%3D0+and+x%3D100
        local junk_rate = 1-(base_useful_rate*(0.98^(dat.sieve_count-1)))
        return normalised_outputs[output_name] * junk_rate
    end

    local dynamic_outputs = {}
    for output_name,_ in pairs(raw_outputs) do
        dynamic_outputs[output_name] = tempered_output
    end

    return dynamic_outputs
end

-------------------
--- let's do gravel
-------------------

local gravel_junk_outputs = {
    ["default:silver_sand"] = 1,
    ["default:sand"] = 1 / 2,
    ["default:desert_sand"] = 1 / 4,
    ["default:gravel"] = 1 / 8,
    ["default:flint"] = 1 / 8,
}
if minetest.get_modpath("cavestuff") then
    gravel_junk_outputs["cavestuff:pebble_1"] = 1 / 8
    gravel_junk_outputs["cavestuff:desert_pebble_1"] = 1 / 8
end

gs_api.after_ores_calculated(function (ore_probabilities)
    gs_api.override_input("default:gravel", {dynamic=tempered_junk_outputs(gravel_junk_outputs, 1/40)})


    gs_api.register_output("default:gravel", "default:clay_lump", 1 / 5)
    gs_api.register_output("default:gravel", "default:mese_crystal_fragment", 1 / 15)
    gs_api.register_output("default:gravel", "default:obsidian_shard", 1 / 15)
    gs_api.register_output("default:gravel", "default:coal_lump", 1 / 10)
    gs_api.register_output("default:gravel", "default:iron_lump", 1 / 12)
    gs_api.register_output("default:gravel", "default:copper_lump", 1 / 25)
    gs_api.register_output("default:gravel", "default:tin_lump", 1 / 50)

    if minetest.get_modpath("moreores") then
        gs_api.register_output("default:gravel", "moreores:silver_lump", 1 / 1000)
    end

    if minetest.get_modpath("quartz") then
        gs_api.register_output("default:gravel", "quartz:quartz_crystal", 1 / 30)
        gs_api.register_output("default:gravel", "quartz:quartz_crystal_piece", 1 / 4)
    end

    if minetest.get_modpath("technic") then
        gs_api.register_output("default:gravel", "technic:lead_lump", 1 / 30)
        gs_api.register_output("default:gravel", "technic:zinc_lump", 1 / 40)
        gs_api.register_output("default:gravel", "technic:chromium_lump", 1 / 200)
        gs_api.register_output("default:gravel", "technic:sulfur_lump", 1 / 100)
    end

    if minetest.get_modpath("terumet") then
        gs_api.register_output("default:gravel", "terumet:lump_raw", 1 / 30)
    end

end)

--------------------------
--- compressed_gravel: the good stuff
--------------------------

local compressed_junk_outputs = {
    ["default:gravel"] = 1,
    ["default:flint"] = 1 / 4,
    ["default:gravel 2"] = 1/2,
    ["default:gravel 3"] = 1/4,
    ["default:gravel 4"] = 1/8,
    ["default:gravel 5"] = 1/16,
    ["default:gravel 6"] = 1/32,
}

gs_api.register_input("gravelsieve:compressed_gravel", {dynamic=tempered_junk_outputs(compressed_junk_outputs, 1/10)})

gs_api.register_output("gravelsieve:compressed_gravel", "default:mese_crystal_fragment", 1 / 5)
gs_api.register_output("gravelsieve:compressed_gravel", "default:coal_lump", 1 / 3)
gs_api.register_output("gravelsieve:compressed_gravel", "default:iron_lump", 1 / 3)
gs_api.register_output("gravelsieve:compressed_gravel", "default:copper_lump", 1 / 4)
gs_api.register_output("gravelsieve:compressed_gravel", "default:tin_lump", 1 / 5)
gs_api.register_output("gravelsieve:compressed_gravel", "default:gold_lump", 1 / 40)
gs_api.register_output("gravelsieve:compressed_gravel", "default:mese_crystal", 1 / 160)
gs_api.register_output("gravelsieve:compressed_gravel", "default:diamond", 1 / 512)

if minetest.get_modpath("moreores") then
    gs_api.register_output("gravelsieve:compressed_gravel", "moreores:silver_lump", 1 / 20)
    gs_api.register_output("gravelsieve:compressed_gravel", "moreores:mithril_lump", 1 / 400)
end

if minetest.get_modpath("other_worlds") then
    gs_api.register_output("gravelsieve:compressed_gravel", "crystals:ghost_crystal_1", 1 / 50000)
    gs_api.register_output("gravelsieve:compressed_gravel", "crystals:ghost_crystal_2", 1 / 50000)
    gs_api.register_output("gravelsieve:compressed_gravel", "crystals:red_crystal_1", 1 / 50000)
    gs_api.register_output("gravelsieve:compressed_gravel", "crystals:red_crystal_2", 1 / 50000)
    gs_api.register_output("gravelsieve:compressed_gravel", "crystals:rose_quartz_1", 1 / 50000)
    gs_api.register_output("gravelsieve:compressed_gravel", "crystals:rose_quartz_2", 1 / 50000)
end

if minetest.get_modpath("quartz") then
    gs_api.register_output("gravelsieve:compressed_gravel", "quartz:quartz_crystal", 1 / 4)
end

if minetest.get_modpath("technic") then
    gs_api.register_output("gravelsieve:compressed_gravel", "technic:lead_lump", 1 / 8)
    gs_api.register_output("gravelsieve:compressed_gravel", "technic:zinc_lump", 1 / 10)
    gs_api.register_output("gravelsieve:compressed_gravel", "technic:chromium_lump", 1 / 100)
    gs_api.register_output("gravelsieve:compressed_gravel", "technic:uranium_lump", 1 / 300)
    gs_api.register_output("gravelsieve:compressed_gravel", "technic:sulfur_lump", 1 / 6)
end

if minetest.get_modpath("terumet") then
    gs_api.register_output("gravelsieve:compressed_gravel", "terumet:lump_raw 4", 1 / 20)
end

if minetest.get_modpath("titanium") then
    gs_api.register_output("gravelsieve:compressed_gravel", "titanium:titanium", 1 / 5000)
end

--------------------------
-- dirt --
--------------------------

if minetest.get_modpath("cavestuff") then
    gs_api.register_input("default:dirt", {fixed=gs_api.scale_probabilities_to_fill({
        ["default:silver_sand"] = 1,
        ["default:sand"] = 1 / 2,
        ["default:desert_sand"] = 1 / 4,
        ["cavestuff:pebble_1"] = 1 / 8,
        ["cavestuff:desert_pebble_1"] = 1 / 8,
    }, 1 - (1 / 5))})

else
    gs_api.register_input("default:dirt", {fixed=gs_api.scale_probabilities_to_fill({
        ["default:silver_sand"] = 1,
        ["default:sand"] = 1 / 2,
        ["default:desert_sand"] = 1 / 4,
    }, 1 - (1 / 5))})
end

gs_api.register_output("default:dirt", "default:stick", 1)
gs_api.register_output("default:dirt", "default:clay_lump", 1)

if minetest.get_modpath("bonemeal") then
    gs_api.register_output("default:dirt", "bonemeal:bone", 1 / 10)
end

if minetest.get_modpath("chestnuttree") then
    gs_api.register_output("default:dirt", "chestnuttree:bur", 1 / 10)
end

if minetest.get_modpath("cucina_vegana") then
    gs_api.register_output("default:dirt", "cucina_vegana:asparagus_seed", 1 / 2)
    gs_api.register_output("default:dirt", "cucina_vegana:chives_seed", 1 / 2)
    gs_api.register_output("default:dirt", "cucina_vegana:flax_seed", 1 / 2)
    gs_api.register_output("default:dirt", "cucina_vegana:kohlrabi_seed", 1 / 2)
    gs_api.register_output("default:dirt", "cucina_vegana:lettuce_seed", 1 / 2)
    gs_api.register_output("default:dirt", "cucina_vegana:parsley_seed", 1 / 2)
    gs_api.register_output("default:dirt", "cucina_vegana:peanut_seed", 1 / 2)
    gs_api.register_output("default:dirt", "cucina_vegana:rice_seed", 1 / 2)
    gs_api.register_output("default:dirt", "cucina_vegana:rosemary_seed", 1 / 2)
    gs_api.register_output("default:dirt", "cucina_vegana:soy_seed", 1 / 2)
    gs_api.register_output("default:dirt", "cucina_vegana:sunflower_seed", 1 / 2)
end

if minetest.get_modpath("farming") then
    gs_api.register_output("default:dirt", "farming:seed_wheat", 1 / 2)
    gs_api.register_output("default:dirt", "farming:seed_cotton", 1 / 2)
    if farming.mod == "redo" then
        gs_api.register_output("default:dirt", "farming:beans", 1 / 2)
        gs_api.register_output("default:dirt", "farming:beetroot", 1 / 2)
        gs_api.register_output("default:dirt", "farming:carrot", 1 / 2)
        gs_api.register_output("default:dirt", "farming:cocoa_beans", 1 / 2)
        gs_api.register_output("default:dirt", "farming:coffee_beans", 1 / 2)
        gs_api.register_output("default:dirt", "farming:corn", 1 / 2)
        gs_api.register_output("default:dirt", "farming:garlic", 1 / 2)
        gs_api.register_output("default:dirt", "farming:onion", 1 / 2)
        gs_api.register_output("default:dirt", "farming:peas", 1 / 2)
        gs_api.register_output("default:dirt", "farming:peppercorn", 1 / 2)
        gs_api.register_output("default:dirt", "farming:potato", 1 / 2)
        gs_api.register_output("default:dirt", "farming:seed_barley", 1 / 2)
        gs_api.register_output("default:dirt", "farming:seed_hemp", 1 / 2)
        gs_api.register_output("default:dirt", "farming:seed_mint", 1 / 2)
        gs_api.register_output("default:dirt", "farming:seed_oat", 1 / 2)
        gs_api.register_output("default:dirt", "farming:seed_rye", 1 / 2)
        gs_api.register_output("default:dirt", "farming:soy_beans", 1 / 2)
    end
end

if minetest.get_modpath("ferns") then
    gs_api.register_output("default:dirt", "ferns:ferntuber", 1 / 2)
end

if minetest.get_modpath("flowers") then
    gs_api.register_output("default:dirt", "flowers:mushroom_brown", 1 / 2)
    gs_api.register_output("default:dirt", "flowers:mushroom_red", 1 / 2)
end

if minetest.get_modpath("maptools") then
    gs_api.register_output("default:dirt", "maptools:copper_coin", 1 / 100)
    gs_api.register_output("default:dirt", "maptools:silver_coin", 1 / 500)
    gs_api.register_output("default:dirt", "maptools:gold_coin", 1 / 1000)
end

if minetest.get_modpath("molehills") then
    gs_api.register_output("default:dirt", "molehills:molehill", 1 / 2)
end

if minetest.get_modpath("moretrees") then
    gs_api.register_output("default:dirt", "moretrees:acorn", 1 / 2)
    gs_api.register_output("default:dirt", "moretrees:cedar_cone", 1 / 2)
    gs_api.register_output("default:dirt", "moretrees:fir_cone", 1 / 2)
    gs_api.register_output("default:dirt", "moretrees:spruce_cone", 1 / 2)
end

if minetest.get_modpath("nsspf") then
    gs_api.register_output("default:dirt", "nsspf:amanita_muscaria", 1 / 10)
    gs_api.register_output("default:dirt", "nsspf:amanita_phalloides", 1 / 10)
    gs_api.register_output("default:dirt", "nsspf:boletus_edulis", 1 / 10)
    gs_api.register_output("default:dirt", "nsspf:boletus_pinophilus", 1 / 10)
    gs_api.register_output("default:dirt", "nsspf:boletus_satanas", 1 / 10)
    gs_api.register_output("default:dirt", "nsspf:cantharellus_cibarius", 1 / 10)
    gs_api.register_output("default:dirt", "nsspf:clitocybe_glacialis", 1 / 10)
    gs_api.register_output("default:dirt", "nsspf:coprinus_atramentarius", 1 / 10)
    gs_api.register_output("default:dirt", "nsspf:gyromitra_esculenta", 1 / 10)
    gs_api.register_output("default:dirt", "nsspf:hygrophorus_goetzii", 1 / 10)
    gs_api.register_output("default:dirt", "nsspf:lentinus_strigosus", 1 / 10)
    gs_api.register_output("default:dirt", "nsspf:lycoperdon_pyriforme", 1 / 10)
    gs_api.register_output("default:dirt", "nsspf:macrolepiota_procera", 1 / 10)
    gs_api.register_output("default:dirt", "nsspf:marasmius_haematocephalus", 1 / 10)
    gs_api.register_output("default:dirt", "nsspf:morchella_conica", 1 / 10)
    gs_api.register_output("default:dirt", "nsspf:psilocybe_cubensis", 1 / 10)
    gs_api.register_output("default:dirt", "nsspf:russula_xerampelina", 1 / 10)
    gs_api.register_output("default:dirt", "nsspf:suillus_grevillei", 1 / 10)
    gs_api.register_output("default:dirt", "nsspf:terfezia_arenaria", 1 / 10)
    gs_api.register_output("default:dirt", "nsspf:tuber_borchii", 1 / 10)
    gs_api.register_output("default:dirt", "nsspf:tuber_magnatum_pico", 1 / 10)
    gs_api.register_output("default:dirt", "nsspf:tuber_melanosporum", 1 / 10)
end

if minetest.get_modpath("oak") then
    gs_api.register_output("default:dirt", "oak:acorn", 1 / 2)
end

if minetest.get_modpath("rainf") then
    gs_api.register_output("default:dirt", "rainf:champignon", 1 / 2)
end

if minetest.get_modpath("vines") then
    gs_api.register_output("default:dirt", "vines:root_end", 1 / 2)
    gs_api.register_output("default:dirt", "vines:root_middle", 1 / 2)
end

---------------
-- dirt_with_grass
---------------

gs_api.register_input("default:dirt_with_grass", {fixed=gs_api.scale_probabilities_to_fill({
    ["default:silver_sand"] = 1,
    ["default:sand"] = 1 / 2,
    ["default:desert_sand"] = 1 / 4,
    ["default:dirt"] = 1 / 8,
}, 1 - (1 / 5))})

gs_api.register_output("default:dirt_with_grass", "default:apple", 1 / 2)
gs_api.register_output("default:dirt_with_grass", "default:dry_grass_1", 1 / 2)
gs_api.register_output("default:dirt_with_grass", "default:dry_shrub", 1 / 2)
gs_api.register_output("default:dirt_with_grass", "default:fern_1", 1 / 2)
gs_api.register_output("default:dirt_with_grass", "default:grass_1", 1 / 2)
gs_api.register_output("default:dirt_with_grass", "default:junglegrass", 1 / 2)
gs_api.register_output("default:dirt_with_grass", "default:marram_grass_1", 1 / 2)
gs_api.register_output("default:dirt_with_grass", "default:papyrus", 1 / 2)


if minetest.get_modpath("bakedclay") then
    gs_api.register_output("default:dirt_with_grass", "bakedclay:delphinium", 1 / 2)
    gs_api.register_output("default:dirt_with_grass", "bakedclay:lazarus", 1 / 2)
    gs_api.register_output("default:dirt_with_grass", "bakedclay:mannagrass", 1 / 2)
    gs_api.register_output("default:dirt_with_grass", "bakedclay:thistle", 1 / 2)
end

if minetest.get_modpath("baldcypress") then
    gs_api.register_output("default:dirt_with_grass", "baldcypress:dry_branches", 1 / 2)
end

if minetest.get_modpath("bonemeal") then
    gs_api.register_output("default:dirt_with_grass", "bonemeal:bone", 1 / 10)
end


if minetest.get_modpath("bbq") then
    gs_api.register_output("default:dirt_with_grass", "bbq:yeast", 1 / 2)
end

if minetest.get_modpath("butterflies") then
    gs_api.register_output("default:dirt_with_grass", "butterflies:butterfly_red", 1 / 20)
    gs_api.register_output("default:dirt_with_grass", "butterflies:butterfly_violet", 1 / 20)
    gs_api.register_output("default:dirt_with_grass", "butterflies:butterfly_white", 1 / 20)
end

if minetest.get_modpath("cherrytree") then
    gs_api.register_output("default:dirt_with_grass", "cherrytree:cherries", 1 / 2)
end

if minetest.get_modpath("clementinetree") then
    gs_api.register_output("default:dirt_with_grass", "clementinetree:clementine", 1 / 2)
end

if minetest.get_modpath("cottages") then
    gs_api.register_output("default:dirt_with_grass", "cottages:hay_mat", 1 / 2)
end

if minetest.get_modpath("ebony") then
    gs_api.register_output("default:dirt_with_grass", "ebony:creeper", 1 / 2)
    gs_api.register_output("default:dirt_with_grass", "ebony:creeper_leaves", 1 / 2)
    gs_api.register_output("default:dirt_with_grass", "ebony:liana", 1 / 2)
    gs_api.register_output("default:dirt_with_grass", "ebony:persimmon", 1 / 2)
end

if minetest.get_modpath("farming") then
    gs_api.register_output("default:dirt_with_grass", "farming:cotton", 1 / 2)
    if farming.mod == "redo" then
        gs_api.register_output("default:dirt_with_grass", "farming:barley", 1 / 2)
        gs_api.register_output("default:dirt_with_grass", "farming:blackberry", 1 / 2)
        gs_api.register_output("default:dirt_with_grass", "farming:blueberries", 1 / 2)
        gs_api.register_output("default:dirt_with_grass", "farming:cabbage", 1 / 2)
        gs_api.register_output("default:dirt_with_grass", "farming:chili_pepper", 1 / 2)
        gs_api.register_output("default:dirt_with_grass", "farming:cucumber", 1 / 2)
        gs_api.register_output("default:dirt_with_grass", "farming:grapes", 1 / 2)
        gs_api.register_output("default:dirt_with_grass", "farming:hemp_leaf", 1 / 2)
        gs_api.register_output("default:dirt_with_grass", "farming:lettuce", 1 / 2)
        gs_api.register_output("default:dirt_with_grass", "farming:mint_leaf", 1 / 2)
        gs_api.register_output("default:dirt_with_grass", "farming:oat", 1 / 2)
        gs_api.register_output("default:dirt_with_grass", "farming:pepper", 1 / 2)
        gs_api.register_output("default:dirt_with_grass", "farming:pepper_red", 1 / 2)
        gs_api.register_output("default:dirt_with_grass", "farming:pepper_yellow", 1 / 2)
        gs_api.register_output("default:dirt_with_grass", "farming:pineapple", 1 / 2)
        gs_api.register_output("default:dirt_with_grass", "farming:raspberries", 1 / 2)
        gs_api.register_output("default:dirt_with_grass", "farming:rhubarb", 1 / 2)
        gs_api.register_output("default:dirt_with_grass", "farming:rye", 1 / 2)
        gs_api.register_output("default:dirt_with_grass", "farming:tomato", 1 / 2)
    end
end

if minetest.get_modpath("ferns") then
    gs_api.register_output("default:dirt_with_grass", "ferns:fiddlehead", 1 / 2)
    gs_api.register_output("default:dirt_with_grass", "ferns:horsetail_01", 1 / 2)
end

if minetest.get_modpath("fireflies") then
    gs_api.register_output("default:dirt_with_grass", "fireflies:firefly", 1 / 40)
end

if minetest.get_modpath("flowers") then
    gs_api.register_output("default:dirt_with_grass", "flowers:chrysanthemum_green", 1 / 2)
    gs_api.register_output("default:dirt_with_grass", "flowers:dandelion_white", 1 / 2)
    gs_api.register_output("default:dirt_with_grass", "flowers:dandelion_yellow", 1 / 2)
    gs_api.register_output("default:dirt_with_grass", "flowers:geranium", 1 / 2)
    gs_api.register_output("default:dirt_with_grass", "flowers:rose", 1 / 2)
    gs_api.register_output("default:dirt_with_grass", "flowers:tulip", 1 / 2)
    gs_api.register_output("default:dirt_with_grass", "flowers:tulip_black", 1 / 2)
    gs_api.register_output("default:dirt_with_grass", "flowers:viola", 1 / 2)
end

if minetest.get_modpath("lemontree") then
    gs_api.register_output("default:dirt_with_grass", "lemontree:lemon", 1 / 2)
end

if minetest.get_modpath("mahogany") then
    gs_api.register_output("default:dirt_with_grass", "mahogany:creeper", 1 / 2)
    gs_api.register_output("default:dirt_with_grass", "mahogany:flower_creeper", 1 / 2)
    gs_api.register_output("default:dirt_with_grass", "mahogany:hanging_creeper", 1 / 2)
end

if minetest.get_modpath("mobs_animal") then
    gs_api.register_output("default:dirt_with_grass", "mobs_animal:bee", 1 / 20)
end

if minetest.get_modpath("mobs_bugslive") then
    gs_api.register_output("default:dirt_with_grass", "mobs_bugslive:bug", 1 / 20)
end

if minetest.get_modpath("moreplants") then
    gs_api.register_output("default:dirt_with_grass", "moreplants:bigfern", 1 / 2)
    gs_api.register_output("default:dirt_with_grass", "moreplants:bigflower", 1 / 2)
    gs_api.register_output("default:dirt_with_grass", "moreplants:blueflower", 1 / 2)
    gs_api.register_output("default:dirt_with_grass", "moreplants:bluespike", 1 / 2)
    gs_api.register_output("default:dirt_with_grass", "moreplants:bulrush", 1 / 2)
    gs_api.register_output("default:dirt_with_grass", "moreplants:bush", 1 / 2)
    gs_api.register_output("default:dirt_with_grass", "moreplants:clover", 1 / 2)
    gs_api.register_output("default:dirt_with_grass", "moreplants:curlyfruit", 1 / 2)
    gs_api.register_output("default:dirt_with_grass", "moreplants:deadweed", 1 / 2)
    gs_api.register_output("default:dirt_with_grass", "moreplants:fern", 1 / 2)
    gs_api.register_output("default:dirt_with_grass", "moreplants:groundfung", 1 / 2)
    gs_api.register_output("default:dirt_with_grass", "moreplants:jungleflower", 1 / 2)
    gs_api.register_output("default:dirt_with_grass", "moreplants:medflower", 1 / 2)
    gs_api.register_output("default:dirt_with_grass", "moreplants:moonflower", 1 / 2)
    gs_api.register_output("default:dirt_with_grass", "moreplants:spikefern", 1 / 2)
    gs_api.register_output("default:dirt_with_grass", "moreplants:tallgrass", 1 / 2)
    gs_api.register_output("default:dirt_with_grass", "moreplants:weed", 1 / 2)
end

if minetest.get_modpath("plumtree") then
    gs_api.register_output("default:dirt_with_grass", "plumtree:plum", 1 / 2)
end

if minetest.get_modpath("pomegranate") then
    gs_api.register_output("default:dirt_with_grass", "pomegranate:pomegranate", 1 / 2)
end

if minetest.get_modpath("rainf") then
    gs_api.register_output("default:dirt_with_grass", "rainf:camomille", 1 / 2)
    gs_api.register_output("default:dirt_with_grass", "rainf:dahlia", 1 / 2)
    gs_api.register_output("default:dirt_with_grass", "rainf:grapes", 1 / 2)
    gs_api.register_output("default:dirt_with_grass", "rainf:grass", 1 / 2)
    gs_api.register_output("default:dirt_with_grass", "rainf:hyacinth", 1 / 2)
    gs_api.register_output("default:dirt_with_grass", "rainf:pansy", 1 / 2)
    gs_api.register_output("default:dirt_with_grass", "rainf:red_daisy", 1 / 2)
    gs_api.register_output("default:dirt_with_grass", "rainf:weed", 1 / 2)
end

if minetest.get_modpath("sakuragi") then
    gs_api.register_output("default:dirt_with_grass", "sakuragi:cherry", 1 / 2)
end

if minetest.get_modpath("swaz") then
    gs_api.register_output("default:dirt_with_grass", "swaz:barberries", 1 / 2)
    gs_api.register_output("default:dirt_with_grass", "swaz:iris", 1 / 2)
    gs_api.register_output("default:dirt_with_grass", "swaz:lavender", 1 / 2)
    gs_api.register_output("default:dirt_with_grass", "swaz:pampas_grass", 1 / 2)
    gs_api.register_output("default:dirt_with_grass", "swaz:reed", 1 / 2)
    gs_api.register_output("default:dirt_with_grass", "swaz:swamp_grass", 1 / 2)
end

----------------------
-- saplings
----------------------

local function register_sapling(leaf, sapling)
    gs_api.register_input(leaf, {fixed=gs_api.scale_probabilities_to_fill({
        ["default:stick"] = 1,
    }, 1 - (1 / 5))})
    gs_api.register_output(leaf, sapling, 1)
end

register_sapling("default:acacia_bush_leaves", "default:acacia_bush_sapling")
register_sapling("default:acacia_leaves", "default:acacia_sapling")
register_sapling("default:aspen_leaves", "default:aspen_sapling")
register_sapling("default:blueberry_bush_leaves", "default:blueberry_bush_sapling")
register_sapling("default:bush_leaves", "default:bush_sapling")
register_sapling("default:jungleleaves", "default:junglesapling")
register_sapling("default:leaves", "default:sapling")
register_sapling("default:pine_bush_needles", "default:pine_bush_sapling")
register_sapling("default:pine_needles", "default:pine_sapling")

if minetest.get_modpath("baldcypress") then
    register_sapling("baldcypress:leaves", "baldcypress:sapling")
end

if minetest.get_modpath("bamboo") then
    register_sapling("bamboo:leaves", "bamboo:sprout")
end

if minetest.get_modpath("birch") then
    register_sapling("birch:leaves", "birch:sapling")
end

if minetest.get_modpath("cherrytree") then
    register_sapling("cherrytree:leaves", "cherrytree:sapling")
end

if minetest.get_modpath("chestnuttree") then
    register_sapling("chestnuttree:leaves", "chestnuttree:sapling")
end

if minetest.get_modpath("clementinetree") then
    register_sapling("clementinetree:leaves", "clementinetree:sapling")
end

if minetest.get_modpath("ebony") then
    register_sapling("ebony:leaves", "ebony:sapling")
end

if minetest.get_modpath("hollytree") then
    register_sapling("hollytree:leaves", "hollytree:sapling")
end

if minetest.get_modpath("jacaranda") then
    register_sapling("jacaranda:blossom_leaves", "jacaranda:sapling")
end

if minetest.get_modpath("larch") then
    register_sapling("larch:leaves", "larch:sapling")
    gs_api.register_output("larch:leaves", "larch:moss", 1 / 10)
end

if minetest.get_modpath("lemontree") then
    register_sapling("lemontree:leaves", "lemontree:sapling")
end

if minetest.get_modpath("mahogany") then
    register_sapling("mahogany:leaves", "mahogany:sapling")
end

if minetest.get_modpath("maple") then
    register_sapling("maple:leaves", "maple:sapling")
end

if minetest.get_modpath("moretrees") then
    register_sapling("moretrees:apple_tree_leaves", "moretrees:apple_tree_sapling")
    register_sapling("moretrees:beech_leaves", "moretrees:beech_sapling")
    register_sapling("moretrees:birch_leaves", "moretrees:birch_sapling")
    register_sapling("moretrees:cedar_leaves", "moretrees:cedar_sapling")
    register_sapling("moretrees:date_palm_leaves", "moretrees:date_palm_sapling")
    register_sapling("moretrees:fir_leaves", "moretrees:fir_sapling")
    register_sapling("moretrees:fir_leaves_bright", "moretrees:fir_sapling")
    register_sapling("moretrees:jungletree_leaves_red", "default:junglesapling")
    register_sapling("moretrees:jungletree_leaves_yellow", "default:junglesapling")
    register_sapling("moretrees:oak_leaves", "moretrees:oak_sapling")
    register_sapling("moretrees:palm_leaves", "moretrees:palm_sapling")
    register_sapling("moretrees:poplar_leaves", "moretrees:poplar_sapling")
    register_sapling("moretrees:rubber_tree_leaves", "moretrees:rubber_tree_sapling")
    register_sapling("moretrees:sequoia_leaves", "moretrees:sequoia_sapling")
    register_sapling("moretrees:spruce_leaves", "moretrees:spruce_sapling")
    register_sapling("moretrees:willow_leaves", "moretrees:willow_sapling")
end

if minetest.get_modpath("oak") then
    register_sapling("oak:leaves", "oak:sapling")
end

if minetest.get_modpath("palm") then
    register_sapling("palm:leaves", "palm:sapling")
end

if minetest.get_modpath("plumtree") then
    register_sapling("plumtree:leaves", "plumtree:sapling")
end

if minetest.get_modpath("pomegranate") then
    register_sapling("pomegranate:leaves", "pomegranate:sapling")
end

if minetest.get_modpath("redtrees") then
    register_sapling("redtrees:rleaves", "redtrees:rsapling")
end

if minetest.get_modpath("sakuragi") then
    register_sapling("sakuragi:sleaves", "sakuragi:ssapling")
end
