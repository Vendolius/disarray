local v_u_1 = game:GetService("ReplicatedStorage")
local v_u_2 = game:GetService("RunService")
local v3 = require(script.Parent.bufferWriter)
local v_u_4 = require(script.Parent.read)
require(script.Parent.Parent.types)
local v_u_5 = v3.writePacket
local v_u_6 = buffer.create
local function v_u_9(p7, p8)
    v_u_4(p7, p8)
end
local function v10()
    return {
        ["cursor"] = 0,
        ["size"] = 256,
        ["references"] = {},
        ["buff"] = v_u_6(256)
    }
end
local v_u_11 = v10()
local v_u_12 = v10()
return {
    ["sendReliable"] = function(p13, p14, p15)
        v_u_11 = v_u_5(v_u_11, p13, p14, p15)
    end,
    ["sendUnreliable"] = function(p16, p17, p18)
        v_u_12 = v_u_5(v_u_12, p16, p17, p18)
    end,
    ["start"] = function()
        local v_u_19 = v_u_1:WaitForChild("ByteNetReliable")
        v_u_19.OnClientEvent:Connect(v_u_9)
        local v_u_20 = v_u_1:WaitForChild("ByteNetUnreliable")
        v_u_20.OnClientEvent:Connect(v_u_9)
        v_u_2.PostSimulation:Connect(function()
            if v_u_11.cursor > 0 then
                local v21 = v_u_11
                local v22 = v21.cursor
                local v23 = v_u_6(v22)
                buffer.copy(v23, 0, v21.buff, 0, v22)
                local v24
                if #v21.references > 0 then
                    v24 = v21.references
                else
                    v24 = nil
                end
                v_u_19:FireServer(v23, v24)
                v_u_11.cursor = 0
                table.clear(v_u_11.references)
            end
            if v_u_12.cursor > 0 then
                local v25 = v_u_12
                local v26 = v25.cursor
                local v27 = v_u_6(v26)
                buffer.copy(v27, 0, v25.buff, 0, v26)
                local v28
                if #v25.references > 0 then
                    v28 = v25.references
                else
                    v28 = nil
                end
                v_u_20:FireServer(v27, v28)
                v_u_12.cursor = 0
                table.clear(v_u_12.references)
            end
        end)
    end
}