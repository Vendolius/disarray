local v1 = {}
local v2 = game:GetService("ReplicatedStorage")
local v_u_3 = game:GetService("UserInputService")
local v_u_4 = game:GetService("RunService")
local v_u_5 = tick()
local v_u_6 = require(v2.Components.Common.GetUserPlatform)
local v_u_7 = require(v2.Database.Security.Remotes)
function v1.Initialize()
    v_u_3.InputBegan:Connect(function()
        v_u_5 = tick()
    end)
    v_u_3.InputChanged:Connect(function()
        v_u_5 = tick()
    end)
    v_u_7.Player.BlankRequest.Listen(function(p8)
        local v9 = v_u_7.Player.ReportPlayerConnect.Send
        local v10 = (tick() - p8) * 1000
        local v11 = math.floor(v10)
        v9((tostring(v11)))
    end)
end
function v1.Start()
    local v_u_12 = 0
    task.delay(5, function()
        local v13 = v_u_6()
        if v13 and #v13 > 0 then
            local v14 = v13[1]
            v_u_7.Player.SubmitUserPlatformAnalytics.Send(v14)
        end
    end)
    v_u_4.Heartbeat:Connect(function(p15)
        v_u_12 = v_u_12 + p15
        if v_u_12 >= 5 then
            v_u_12 = v_u_12 - 5
            local v16 = tick()
            v_u_7.Player.BlankRequest.Send(v16)
            if v16 - v_u_5 >= 900 then
                v_u_7.Player.AFKTeleport.Send()
                v_u_5 = v16
                return
            end
        end
    end)
end
return v1