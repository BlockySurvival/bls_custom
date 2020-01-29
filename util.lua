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
