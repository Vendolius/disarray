local v_u_1 = game:GetService("Players")
local v_u_2 = game:GetService("ReplicatedStorage")
local v_u_3 = game:GetService("RunService")
local v4 = require(script.Parent.bufferWriter)
local v_u_5 = require(script.Parent.read)
require(script.Parent.Parent.types)
local v_u_6 = v4.writePacket
local v_u_7 = {}
local v_u_8 = {}
local v_u_9 = buffer.create
local function v_u_10()
    return {
        ["cursor"] = 0,
        ["size"] = 256,
        ["references"] = {},
        ["buff"] = v_u_9(256)
    }
end
local v_u_11 = v_u_10()
local v_u_12 = v_u_10()
local function v_u_16(p13, p14, p15)
    if type(p14) == "buffer" then
        v_u_5(p14, p15, p13)
    end
end
local function v_u_18(p17)
    if not v_u_7[p17] then
        v_u_7[p17] = v_u_10()
    end
    if not v_u_8[p17] then
        v_u_8[p17] = v_u_10()
    end
end
return {
    ["sendAllReliable"] = function(p19, p20, p21)
        v_u_11 = v_u_6(v_u_11, p19, p20, p21)
    end,
    ["sendAllUnreliable"] = function(p22, p23, p24)
        v_u_12 = v_u_6(v_u_12, p22, p23, p24)
    end,
    ["sendPlayerReliable"] = function(p25, p26, p27, p28)
        v_u_7[p25] = v_u_6(v_u_7[p25], p26, p27, p28)
    end,
    ["sendPlayerUnreliable"] = function(p29, p30, p31, p32)
        v_u_8[p29] = v_u_6(v_u_8[p29], p30, p31, p32)
    end,
    ["start"] = function()
        local v_u_33 = Instance.new("RemoteEvent")
        v_u_33.Name = "ByteNetReliable"
        v_u_33.OnServerEvent:Connect(v_u_16)
        v_u_33.Parent = v_u_2
        local v_u_34 = Instance.new("UnreliableRemoteEvent")
        v_u_34.Name = "ByteNetUnreliable"
        v_u_34.OnServerEvent:Connect(v_u_16)
        v_u_34.Parent = v_u_2
        for _, v35 in v_u_1:GetPlayers() do
            if not v_u_7[v35] then
                v_u_7[v35] = v_u_10()
            end
            if not v_u_8[v35] then
                v_u_8[v35] = v_u_10()
            end
        end
        v_u_1.PlayerAdded:Connect(v_u_18)
        v_u_3.PostSimulation:Connect(function()
            if v_u_11.cursor > 0 then
                local v36 = v_u_11
                local v37 = v36.cursor
                local v38 = v_u_9(v37)
                buffer.copy(v38, 0, v36.buff, 0, v37)
                local v39
                if #v36.references > 0 then
                    v39 = v36.references
                else
                    v39 = nil
                end
                v_u_33:FireAllClients(v38, v39)
                v_u_11.cursor = 0
                table.clear(v_u_11.references)
            end
            if v_u_12.cursor > 0 then
                local v40 = v_u_12
                local v41 = v40.cursor
                local v42 = v_u_9(v41)
                buffer.copy(v42, 0, v40.buff, 0, v41)
                local v43
                if #v40.references > 0 then
                    v43 = v40.references
                else
                    v43 = nil
                end
                v_u_34:FireAllClients(v42, v43)
                v_u_12.cursor = 0
                table.clear(v_u_12.references)
            end
            for _, v44 in v_u_1:GetPlayers() do
                if v_u_7[v44].cursor > 0 then
                    local v45 = v_u_7[v44]
                    local v46 = v45.cursor
                    local v47 = v_u_9(v46)
                    buffer.copy(v47, 0, v45.buff, 0, v46)
                    local v48
                    if #v45.references > 0 then
                        v48 = v45.references
                    else
                        v48 = nil
                    end
                    v_u_33:FireClient(v44, v47, v48)
                    v_u_7[v44].cursor = 0
                    table.clear(v_u_7[v44].references)
                end
                if v_u_8[v44].cursor > 0 then
                    local v49 = v_u_8[v44]
                    local v50 = v49.cursor
                    local v51 = v_u_9(v50)
                    buffer.copy(v51, 0, v49.buff, 0, v50)
                    local v52
                    if #v49.references > 0 then
                        v52 = v49.references
                    else
                        v52 = nil
                    end
                    v_u_34:FireClient(v44, v51, v52)
                    v_u_8[v44].cursor = 0
                    table.clear(v_u_8[v44].references)
                end
            end
        end)
    end
}