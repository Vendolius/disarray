local v1 = game:GetService("RunService")
local v_u_2 = require(script.Parent.namespacesDependencies)
local v_u_3 = require(script.Parent.packetIDs)
require(script.Parent.Parent.types)
local v_u_4 = require(script.Parent.Parent.replicated.values)
local v_u_5 = v1:IsServer() and "server" or "client"
local v_u_6 = 0
return function(p7, p8)
    local v9 = v_u_4.access(p7)
    v_u_2.start(p7)
    local v10 = p8()
    local v11 = v_u_2.empty()
    local v12 = {}
    if v_u_5 ~= "server" then
        if v_u_5 == "client" then
            local v13 = v9:read()
            for v14, v15 in v10 do
                v12[v14] = v15(v13.packets[v14])
                v_u_3.set(v13.packets[v14], v12[v14])
            end
        end
        return v12
    end
    local v16 = {
        ["structs"] = {},
        ["packets"] = {}
    }
    for v17 in v10 do
        v_u_6 = v_u_6 + 1
        v16.packets[v17] = v_u_6
        v12[v17] = v10[v17](v_u_6)
        v_u_3.set(v_u_6, v12[v17])
    end
    for v18, v19 in v11 do
        v16.structs[v18] = v19
    end
    v9:write(v16)
    return v12
end