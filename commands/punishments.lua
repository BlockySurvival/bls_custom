--[[
ideas for more punishments:

1. gravity randomly changes for a player
2. player bounces, sometimes very high
3. player can"t eat
4. player rubber-bands randomly (teleports back to an old position)
5. plague: piles of rats spawn on the player
6. annoying noises that only that player can hear
]]--


if minetest.global_exists("ChatCmdBuilder") and minetest.global_exists("areas") then
    bls.punished = {}

    minetest.register_privilege("punish", "Allows a player to invoke creative punishments on other players")

    local invalid_player = "Invalid player"
    local invalid_punishment = "Invalid punishment"

    local function owns_area_at(name, pos)
        local owners = areas:getNodeOwners(pos)
        for _, p in pairs(owners) do
            if p == name then
                return true
            end
        end
        return false
    end

    bls.punishments = {
        hotfoot = {
            func = function(pname)
                local p = minetest.get_player_by_name(pname)
                if p then
                    local pos = p:get_pos()
                    if minetest.get_node(pos).name == "air" then
                        minetest.set_node(pos, {name = "fire:basic_flame"})
                    end
                end
            end,
            every = 0
        },
        tnt_rain = {
            func = function(pname)
                local p = minetest.get_player_by_name(pname)
                if p then
                    local pos = p:get_pos()
                    local above = {x = pos.x, y = pos.y + 10, z = pos.z}
                    if owns_area_at(pname, pos) then
                        minetest.set_node(above, {name = "tnt:tnt_burning"})
                    end
                end
            end,
            every = 5
        },
        butterfingers = {
            func = function(pname)
                local p = minetest.get_player_by_name(pname)
                if p then
                    local inv = p:get_inventory()
                    local stacks = inv:get_list("main")
                    local stackIndex = math.random(#stacks)
                    local take = stacks[stackIndex]
                    inv:remove_item("main", take)
                    minetest.add_item(p:get_pos(), take)
                end
            end,
            every = 3
        }
    }

    minetest.register_globalstep(function(dtime)
        for name, punishment in pairs(bls.punished) do
            punishment.time = punishment.time - dtime
            punishment.timer = punishment.timer + dtime
            if punishment.time < 0 then
                bls.punished[name] = nil
                return
            end
            if punishment.timer >= punishment.every then
                punishment.timer = 0
                punishment.func(name)
            end
        end
    end)

    function bls.punish(name, p_name, punishment, tStr)
        -- Verify input
        if minetest.get_player_by_name(p_name) == nil then
            return false, invalid_player
        end
        if bls.punishments[punishment] == nil then
            return false, invalid_punishment
        end
        if not tStr then tStr = "5m" end
        -- Is there a letter on the end of tStr?
        local mult = 1
        local multStr = tStr:sub(-1)
        local tInt
        if multStr:lower() ~= multStr:upper() then -- Not a number
            multStr = multStr:lower()
            if multStr == "s" then mult = 1
            elseif multStr == "m" then mult = 60
            elseif multStr == "h" then mult = 3600
            elseif multStr == "d" then mult = 86400
            else minetest.chat_send_player(name, "Invaild time multiplier, assuming seconds") end
            tInt = tonumber(tStr:sub(1, -2))
        else
            tInt = tonumber(tStr)
        end
        if tInt then
            tInt = tInt * mult
        else
            return false, "Invalid time"
        end
        bls.punished[p_name] = {
            ["time"] = tInt,
            ["timer"] = 0,
            ["func"] = bls.punishments[punishment].func,
            ["every"] = bls.punishments[punishment].every
        }
        return true, "Done!"
    end

    ChatCmdBuilder.new("punish", function(cmd)
        -- TODO: make this part of the following framework
        cmd:sub(":pname :punishment :time", function(name, p_name, punishment, tStr)
            return bls.punish(name, p_name, punishment, tStr)
        end)
        cmd:sub(":pname :punishment", function(name, p_name, punishment, tStr)
            return bls.punish(name, p_name, punishment, "5m")
        end)
    end,
    {
       description = "Invokes creative punishments on a player",
       privs = {punish = true},
    })
end
