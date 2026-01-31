local v_u_1 = {}
local v2 = game:GetService("ReplicatedStorage")
local v_u_3 = game:GetService("TweenService")
local v_u_4 = game:GetService("Players")
require(script:WaitForChild("Types"))
local v_u_5 = require(v2.Controllers.CameraController)
local v_u_6 = require(v2.Components.Common.GetBadgeIcon)
local v_u_7 = require(v2.Components.Common.GetBadgeName)
local v_u_8 = require(v2.Database.Security.Remotes)
local v_u_9 = workspace:WaitForChild("Debris")
local v_u_10 = workspace.CurrentCamera
local v_u_11 = v_u_4.LocalPlayer
local v_u_12 = nil
local v_u_13 = nil
local v_u_14 = nil
local function v_u_17()
    for _, v15 in ipairs(v_u_9:GetChildren()) do
        if v15:HasTag("Ragdoll") and v15.Name == v_u_11.Name then
            local v16 = v15:FindFirstChildOfClass("Humanoid")
            if v16 then
                return v16
            end
        end
    end
    return nil
end
function v_u_1.updateFrame(p18)
    local v19 = v_u_4
    local v20 = p18.Killer
    local v21 = v19:GetPlayerByUserId((tonumber(v20)))
    if v21 and v21:IsDescendantOf(v_u_4) then
        v_u_14.Killed.Text = ("<font color=\"rgb(255,34,16)\">Killed you with their</font> <b>%* | %*</b>"):format(p18.Weapon, p18.Skin)
        v_u_14.BadgeFrame.TextLabel.Text = v_u_7(v21, (v21:GetAttribute("Team")))
        v_u_14.BadgeIcon.Image = v_u_6(v21, (v21:GetAttribute("Team")))
        v_u_14.Profile.Avatar.Image = ("rbxthumb://type=AvatarHeadShot&id=%*&w=150&h=150"):format(v21.UserId)
        v_u_14.Username.Text = v21.DisplayName
    end
end
function v_u_1.openFrame()
    v_u_10.CameraSubject = v_u_17()
    v_u_10.CameraType = Enum.CameraType.Follow
    v_u_5.setPerspective(false, false)
    task.wait(0.15)
    v_u_12.ImageLabel.ImageTransparency = 1
    v_u_12.BackgroundTransparency = 1
    v_u_12.Visible = true
    v_u_14.Position = UDim2.fromScale(0.5, -v_u_14.Size.Y.Scale)
    v_u_14.Visible = true
    v_u_13.BackgroundTransparency = 1
    v_u_13.Visible = true
    v_u_3:Create(v_u_12, TweenInfo.new(0.75, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        ["BackgroundTransparency"] = 0.75
    }):Play()
    v_u_3:Create(v_u_12.ImageLabel, TweenInfo.new(0.75, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        ["ImageTransparency"] = 0
    }):Play()
    task.wait(0.25)
    v_u_3:Create(v_u_14, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        ["Position"] = UDim2.fromScale(0.5, 0.7)
    }):Play()
    task.wait(0.35)
    v_u_3:Create(v_u_13, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        ["BackgroundTransparency"] = 0
    }):Play()
    v_u_3:Create(v_u_12, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        ["BackgroundTransparency"] = 1
    }):Play()
    v_u_3:Create(v_u_12.ImageLabel, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        ["ImageTransparency"] = 1
    }):Play()
    if workspace:GetAttribute("Gamemode") ~= "Deathmatch" then
        task.delay(2, function()
            v_u_1.closeFrame()
        end)
    end
end
function v_u_1.closeFrame()
    v_u_12.ImageLabel.ImageTransparency = 1
    v_u_12.BackgroundTransparency = 1
    v_u_12.Visible = false
    v_u_14.Position = UDim2.fromScale(0.5, -v_u_14.Size.Y.Scale)
    v_u_14.Visible = false
    local v22 = v_u_3:Create(v_u_13, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        ["BackgroundTransparency"] = 1
    })
    v22:Play()
    v22.Completed:Connect(function()
        v_u_13.BackgroundTransparency = 1
        v_u_13.Visible = false
    end)
end
function v_u_1.Initialize(p23, p24)
    v_u_12 = p23.Gameplay.Middle.BloodScreen
    v_u_13 = p23.Gameplay.Middle.Transition
    v_u_14 = p24
    v_u_11.CharacterAdded:Connect(function()
        if v_u_14.Visible then
            v_u_1.closeFrame()
        end
    end)
end
function v_u_1.Start()
    v_u_8.UI.UIPlayerKilled.Listen(function(p25)
        local v26 = v_u_11.UserId
        local v27 = p25.Victim
        if v26 == tonumber(v27) then
            v_u_1.updateFrame(p25)
            v_u_1.openFrame()
        end
    end)
    v_u_8.UI.ShowDeathCard.Listen(function(p28)
        local v29 = v_u_11.UserId
        local v30 = p28.Victim
        if v29 == tonumber(v30) then
            v_u_1.updateFrame(p28)
        end
    end)
end
return v_u_1