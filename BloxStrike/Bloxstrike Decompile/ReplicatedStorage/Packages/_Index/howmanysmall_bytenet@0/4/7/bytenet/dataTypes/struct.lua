local v1 = game:GetService("RunService")
local v_u_2 = require(script.Parent.Parent.namespaces.namespacesDependencies)
require(script.Parent.Parent.types)
local v_u_3 = require(script.Parent.Parent.replicated.values)
local v_u_4 = v1:IsServer() and "server" or "client"
return function(p_u_5)
    local v_u_6 = {}
    local v_u_7 = {}
    if v_u_4 == "server" then
        local v8 = 0
        local v9 = {}
        for v10 in p_u_5 do
            v8 = v8 + 1
            v9[v10] = v8
            v_u_6[v8] = p_u_5[v10]
            v_u_7[v8] = v10
        end
        v_u_2.add(v9)
    elseif v_u_4 == "client" then
        v_u_2.add(p_u_5)
        local v11 = v_u_2.currentName()
        for v12, v13 in v_u_3.access(v11):read().structs[v_u_2.currentLength()] do
            v_u_6[v13] = p_u_5[v12]
            v_u_7[v13] = v12
        end
    end
    return {
        ["Read"] = function(p14, p15)
            local v16 = table.clone(p_u_5)
            local v17 = p15
            for v18, v19 in v_u_6 do
                local v20, v21 = v19.Read(p14, p15)
                v16[v_u_7[v18]] = v20
                p15 = p15 + v21
            end
            return v16, p15 - v17
        end,
        ["Write"] = function(p22)
            for v23, v24 in v_u_6 do
                v24.Write(p22[v_u_7[v23]])
            end
        end
    }
end