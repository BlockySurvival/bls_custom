local function pairsByKeys(t, f)
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

local function find_invs(name, pos1, pos2, tell)
    local poss = {}
    local area = (pos2.x - pos1.x) * (pos2.y - pos1.y) * (pos2.z - pos1.z)
    if area > (128*64*64) then
        minetest.chat_send_player(tell, ('skipping "%s"; it is too large'):format(name));
        return poss
    end
    for x = pos1.x, pos2.x do
        for y = pos1.y, pos2.y do
            for z = pos1.z, pos2.z do
                local pos = {x=x,y=y,z=z}
                local inv = minetest.get_inventory({type='node', pos=pos})
                if inv then
                    poss[minetest.pos_to_string(pos)] = inv
                end
            end
        end
    end
    return poss
end

local function snoop_inv(pos, inv, tell)
    local counts = {}
    for name, _ in pairsByKeys(inv:get_lists()) do
        minetest.chat_send_player(tell, (' %s@%s'):format(name, pos))
        for i=1, inv:get_size(name) do
            local s = inv:get_stack(name, i);
            local n = s:get_name()
            if n ~= '' then
                counts[n] = (counts[n] or 0) + s:get_count()
            end
        end
    end
    return counts
end

local function snoop_areas(name, tell)
    local invs = {}
    for _, area in pairs(areas.areas) do
        if area.owner == name then
            for pos, inv in pairs(find_invs(area.name, area.pos1, area.pos2, tell)) do
                invs[pos] = inv
            end
        end
    end
    local totals = {}
    for pos, inv in pairs(invs) do
        for k, v in pairs(snoop_inv(pos, inv, tell)) do
            totals[k] = (totals[k] or 0) + v
        end
    end
    minetest.chat_send_player(tell, 'TOTALS:')
    for k, v in pairsByKeys(totals) do
        minetest.chat_send_player(tell, (' %s %s'):format(k, v))
    end
end
