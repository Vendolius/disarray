local v_u_1 = {}
local v_u_2 = game:GetService("ReplicatedStorage")
local v_u_3 = game:GetService("TweenService")
local v4 = game:GetService("Players")
local v_u_5 = game:GetService("Debris")
require(script:WaitForChild("Types"))
local v_u_6 = require(v_u_2.Database.Components.GameState)
local v_u_7 = require(v_u_2.Components.Common.GetPreferenceColor)
local v_u_8 = require(v_u_2.Controllers.DataController)
local v_u_9 = require(v_u_2.Database.Security.Remotes)
local v_u_10 = require(v_u_2.Database.Security.Router)
local v_u_11 = v4.LocalPlayer
local v_u_12 = nil
local function v_u_14(p13)
    v_u_3:Create(p13, TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
        ["Size"] = UDim2.fromScale(0, 0.12)
    }):Play()
    v_u_5:AddItem(p13, 0.35)
end
function v_u_1.createNotification(p15, p16, p17)
    local v18 = v_u_12:FindFirstChild(p15)
    if v_u_11:GetAttribute("Team") then
        if not v18 then
            v18 = v_u_2.Assets.UI.Notification.Template:Clone()
            v18.LayoutOrder = p17 or 0
            v18.Parent = v_u_12
            v18.Name = p15
            v18.Size = UDim2.fromScale(0, 0.12)
            v_u_3:Create(v18, TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
                ["Size"] = UDim2.fromScale(0.9, 0.12)
            }):Play()
        end
        v18:SetAttribute("Timestamp", tick())
        v18.Right.BackgroundColor3 = v_u_7()
        v18.Left.BackgroundColor3 = v_u_7()
        v18.TextLabel.Text = p16
        return v18
    end
end
function v_u_1.Initialize(_, p19)
    v_u_12 = p19
    v_u_11.CharacterAdded:Connect(function(_)
        if workspace:GetAttribute("GameState") == "Warmup" then
            v_u_1.createNotification("GameState", "Warmup", 1)
        else
            local v20 = v_u_12:FindFirstChild("GameState")
            if v20 then
                v20:Destroy()
            end
        end
    end)
    v_u_6.ListenToState(function(p21, _)
        local v22 = p21 == "Warmup" and v_u_12:FindFirstChild("GameState")
        if v22 then
            v22:Destroy()
        end
    end)
    v_u_8.CreateListener(v_u_11, "Settings.Game.HUD.Color", function()
        for _, v23 in ipairs(v_u_12:GetChildren()) do
            if v23:IsA("Frame") then
                v23.Right.BackgroundColor3 = v_u_7()
                v23.Left.BackgroundColor3 = v_u_7()
            end
        end
    end)
end
function v_u_1.Start()
    v_u_9.UI.ShowNotification.Listen(function(p_u_24, _)
        local v_u_25 = v_u_1.createNotification(p_u_24.header, p_u_24.message, 0)
        task.delay(p_u_24.timeLength, function()
            if v_u_25 and v_u_25.Parent then
                local v26 = v_u_25
                if p_u_24.timeLength <= tick() - v26:GetAttribute("Timestamp") then
                    v_u_14(v26)
                    return
                end
            end
        end)
    end)
    v_u_10.observerRouter("CreateNotification", function(p27, p28, p_u_29)
        local v_u_30 = v_u_1.createNotification(p27, p28, 0)
        task.delay(p_u_29, function()
            if v_u_30 and v_u_30.Parent then
                local v31 = v_u_30
                if p_u_29 <= tick() - v31:GetAttribute("Timestamp") then
                    v_u_14(v31)
                    return
                end
            end
        end)
    end)
end
return v_u_1