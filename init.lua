if minetest.get_modpath("gravelsieve") then
    minetest.clear_craft({output="gravelsieve:sieve"})
    minetest.register_craft({
        output = "gravelsieve:sieve",
        recipe = {
            {"group:wood", "",                      "group:wood"},
            {"group:wood", "default:diamondblock",  "group:wood"},
            {"group:wood", "",                      "group:wood"},
        },
    })
    minetest.clear_craft({output="gravelsieve:auto_sieve"})
    minetest.register_craft({
        output = "gravelsieve:auto_sieve",
        recipe = {
            {"default:diamondblock", "default:diamondblock", "default:diamondblock"},
            {"default:mese",         "gravelsieve:sieve",    "default:mese"},
            {"default:diamondblock", "default:mese",         "default:diamondblock"},
        },
    })

    minetest.register_alias_force("gravelsieve:sieved_gravel", "default:sand")
    minetest.register_alias_force("gravelsieve:compressed_gravel", "default:cobble")
    minetest.clear_craft({output="gravelsieve:compressed_gravel"})
end

if minetest.get_modpath("travelnet") and minetest.get_modpath("titanium") then
    minetest.clear_craft({output="travelnet:elevator"})
    minetest.register_craft({
        output = "travelnet:elevator",
        recipe = {
            {"default:steel_ingot", "default:glass",  "default:steel_ingot", },
            {"default:steel_ingot", "titanium:block", "default:steel_ingot", },
            {"default:steel_ingot", "default:glass",  "default:steel_ingot", }
        },
    })

    minetest.clear_craft({output="travelnet:travelnet"})
    minetest.register_craft({
        output = "travelnet:travelnet",
        recipe = {
            {"default:glass", "titanium:block", "default:glass", },
            {"default:mese",  "default:mese",   "default:mese", },
            {"default:glass", "titanium:block", "default:glass", }
        },
    })
end

if minetest.get_modpath("currency") then
    earn_income = function(player)
        if not player or player.is_fake_player then return end
        local name = player:get_player_name()
        if players_income[name] == nil then
            players_income[name] = 0
        end
        if players_income[name] > 0 then
            local count = players_income[name]
            local inv = player:get_inventory()
            inv:add_item("main", {name="currency:minegeld_5", count=count})
            players_income[name] = 0
            minetest.log("info", "[Currency] "..S("added basic income for @1 to inventory", name))
        end
    end
end
