local v_u_1 = require(script.Parent.copy)
return function(p2)
    local v3 = Random.new(os.time() * #p2)
    local v4 = v_u_1(p2)
    for v5 = #v4, 1, -1 do
        local v6 = v3:NextInteger(1, v5)
        local v7 = v4[v5]
        v4[v5] = v4[v6]
        v4[v6] = v7
    end
    return v4
end