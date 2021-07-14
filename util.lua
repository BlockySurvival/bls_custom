bls.util = {}

function bls.util.pairs_by_keys(t, f)
    -- iterate a table, sorted on keys
    local a = {}
    for n in pairs(t) do
        table.insert(a, n)
    end
    table.sort(a, f)
    local i = 0
    return function()
        i = i + 1
        if a[i] == nil then
            return nil
        else
            return a[i], t[a[i]]
        end
    end
end

function bls.util.most_common_in_table(t)
    -- find the mode
    local counts = {}
    for _, item in ipairs(t) do
        counts[item] = (counts[item] or 0) + 1
    end
    local most_common
    local count = 0
    for item, item_count in pairs(counts) do
        if item_count > count then
            most_common = item
            count = item_count
        end
    end
    return most_common
end

function bls.util.safe(func, rv_on_fail)
    -- wrap a function w/ logic to avoid crashing the game
    return function(...)
        local rvs = {xpcall(func, debug.traceback, ...)}
        if rvs[1] then
            table.remove(rvs, 1)
            return unpack(rvs)
        else
            bls.log("error", "Caught error: %s", rvs[2])
            return rv_on_fail
        end
    end
end

function bls.util.nformat(s, tab)
    --[[
    format a string w/ named parameters

    e.g. nformat("%(foo)s %(bar)s", {bar="dogs", foo="cats"}) == "cats dogs"
    ]]--
    return (
        s:gsub(
            "%%%(([%a%w_]+)%)([-0-9%.]*[cdeEfgGiouxXsq])",
            function(k, fmt)
                return tab[k] and ("%" .. fmt):format(tab[k]) or
                        "%(" .. k .. ")" .. fmt
            end
        )
    )
end

function bls.util.tables_equal(t1, t2, ignore_mt)
    local ty1 = type(t1)
    local ty2 = type(t2)
    if ty1 ~= ty2 then
        return false
    end
    -- non-table types can be directly compared
    if ty1 ~= 'table' and ty2 ~= 'table' then
        return t1 == t2
    end
    -- as well as tables which have the metamethod __eq
    local mt = getmetatable(t1)
    if not ignore_mt and mt and mt.__eq then
        return t1 == t2
    end
    for k1, v1 in pairs(t1) do
        local v2 = t2[k1]
        if v2 == nil or not bls.util.tables_equal(v1, v2) then
            return false
        end
    end
    for k2, v2 in pairs(t2) do
        local v1 = t1[k2]
        if v1 == nil or not bls.util.tables_equal(v1, v2) then
            return false
        end
    end
    return true
end

-- Get player by name, case insensitive, cleans whitespace
function bls.util.get_player_by_name(given_player_name)
    local found_player = minetest.get_player_by_name(given_player_name)
    if found_player then return found_player end

    local clean_player_name = given_player_name:gsub("%s+", "")
    if clean_player_name == "" then
        return
    end

    local lower_player_name = clean_player_name:lower()
    for _, connected_player in ipairs(minetest.get_connected_players()) do
        if connected_player:get_player_name():lower() == lower_player_name then
            return connected_player
        end
    end
end