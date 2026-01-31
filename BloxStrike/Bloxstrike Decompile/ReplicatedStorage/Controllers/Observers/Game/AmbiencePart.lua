local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = game:GetService("SoundService")
local v_u_3 = game:GetService("RunService")
local v_u_4 = game:GetService("Workspace")
local v5 = require(v1.Packages.Observers)
local v_u_6 = require(v1.Shared.Janitor)
return v5.observeTag("AmbiencePart", function(p_u_7)
    if not p_u_7:IsDescendantOf(workspace) then
        return function() end
    end
    local v8 = {}
    for _, v9 in p_u_7:GetChildren() do
        if v9:IsA("Sound") then
            table.insert(v8, v9)
        end
    end
    if #v8 <= 0 then
        return function() end
    end
    local v_u_10 = v_u_6.new()
    local v_u_11 = {}
    for _, v12 in v8 do
        local v13 = v_u_10:Add(v12:Clone())
        v13.RollOffMode = Enum.RollOffMode.Inverse
        v13.RollOffMaxDistance = 10000
        v13.RollOffMinDistance = 10000
        v13.Parent = v_u_2
        v13.PlayOnRemove = false
        v13.Volume = 0
        v13:Play()
        local v14 = {
            ["MaximumVolume"] = v12.Volume > 0 and v12.Volume or 1,
            ["GlobalSound"] = v13,
            ["CurrentVolume"] = 0
        }
        table.insert(v_u_11, v14)
    end
    v_u_10:Add(v_u_3.Heartbeat:Connect(function(p15)
        local v16 = v_u_4.CurrentCamera
        if v16 then
            local v17 = v16.CFrame.Position
            local v18 = p_u_7
            local v19 = v18.CFrame:PointToObjectSpace(v17)
            local v20 = v18.Size / 2
            local v21 = v19.X
            local v22
            if math.abs(v21) <= v20.X then
                local v23 = v19.Y
                if math.abs(v23) <= v20.Y then
                    local v24 = v19.Z
                    v22 = math.abs(v24) <= v20.Z
                else
                    v22 = false
                end
            else
                v22 = false
            end
            for _, v25 in ipairs(v_u_11) do
                local v26 = v22 and (v25.MaximumVolume or 0) or 0
                local v27 = v25.CurrentVolume
                local v28 = v26 - v25.CurrentVolume
                local v29 = p15 * 3
                v25.CurrentVolume = v27 + v28 * math.min(1, v29)
                v25.GlobalSound.Volume = v25.CurrentVolume
            end
        end
    end))
    return function()
        v_u_10:Cleanup()
    end
end)