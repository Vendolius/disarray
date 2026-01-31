local v_u_1 = game:GetService("ReplicatedStorage")
local v2 = game:GetService("RunService")
local v_u_3 = require(script.Parent.replicatedValue)
local v_u_4 = v2:IsServer() and "server" or "client"
local v_u_5 = nil
local v_u_6 = {}
return {
    ["start"] = function()
        if v_u_4 == "server" then
            local v7 = Instance.new("Folder")
            v7.Name = "BytenetStorage"
            v7.Parent = v_u_1
            v_u_5 = v7
        elseif v_u_4 == "client" then
            v_u_5 = v_u_1:WaitForChild("BytenetStorage")
        end
    end,
    ["access"] = function(p8)
        if v_u_6[p8] then
            return v_u_6[p8]
        end
        if v_u_4 == "client" then
            local v9 = v_u_5:FindFirstChild(p8)
            if v9 and v9:IsA("StringValue") then
                local v10 = v_u_3(v9)
                v_u_6[p8] = v10
                return v10
            end
        elseif v_u_4 == "server" then
            local v11 = Instance.new("StringValue")
            v11.Name = p8
            v11.Parent = v_u_5
            local v12 = v_u_3(v11)
            v_u_6[p8] = v12
            return v12
        end
        return v_u_6[p8]
    end
}