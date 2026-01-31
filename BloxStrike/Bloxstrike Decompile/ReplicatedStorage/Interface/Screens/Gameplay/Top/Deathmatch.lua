local v_u_1 = {}
local v_u_2 = game:GetService("ReplicatedStorage")
local v_u_3 = game:GetService("RunService")
local v_u_4 = game:GetService("Players")
require(script:WaitForChild("Types"))
local v_u_5 = v_u_4.LocalPlayer
local v_u_6 = require(v_u_2.Components.Common.GetTimerFormat)
local v_u_7 = require(v_u_2.Controllers.DataController)
local v_u_8 = require(v_u_2.Classes.Sound)
local v_u_9 = require(v_u_2.Packages.Observers)
local v_u_10 = require(v_u_2.Shared.Janitor)
local v_u_11 = require(v_u_2.Database.Custom.GameStats.Settings.Colors)
local v_u_12 = nil
local v_u_13 = nil
local v_u_14 = {}
local function v_u_18(p15)
    local v16 = p15:GetChildren()
    for _, v17 in ipairs(v16) do
        if v17.ClassName == "Frame" then
            v17:Destroy()
        end
    end
end
function v_u_1.createTemplate(p_u_19, _)
    local v20 = workspace:GetAttribute("Gamemode")
    local v21 = p_u_19:GetAttribute("Team")
    v_u_1.cleanupPlayerTemplate(p_u_19)
    if v20 == "Deathmatch" and (v21 == "Terrorists" or v21 == "Counter-Terrorists") then
        local v22 = v_u_10.new()
        v_u_14[p_u_19] = v22
        local v_u_23 = v_u_2.Assets.UI.Deathmatch.PlayerTemplate:Clone()
        v_u_23.Player.Image = ("rbxthumb://type=AvatarHeadShot&id=%*&w=420&h=420"):format(p_u_19.UserId)
        v_u_23.Info.UIStroke.Color = v_u_11["Team Color"][v21]
        v_u_23.UIStroke.Color = v_u_11["Team Color"][v21]
        v_u_23.Parent = v_u_12.Players
        v_u_23.Info.Amount.Text = "0"
        v22:Add(function()
            v_u_23:Destroy()
        end)
        v22:Add(v_u_9.observeAttribute(p_u_19, "Score", function(p24)
            v_u_23.Info.Amount.Text = tostring(p24)
            v_u_23.LayoutOrder = -p24
        end))
        v22:Add(v_u_9.observeAttribute(p_u_19, "Team", function(p25)
            if p25 ~= "Counter-Terrorists" and p25 ~= "Terrorists" then
                v_u_1.cleanupPlayerTemplate(p_u_19)
            end
            return function()
                v_u_1.cleanupPlayerTemplate(p_u_19)
            end
        end))
    end
end
function v_u_1.cleanupPlayerTemplate(p26)
    local v27 = v_u_14[p26]
    v_u_14[p26] = nil
    if v27 then
        v27:Destroy()
    end
end
function v_u_1.playerAdded(p_u_28)
    if p_u_28.Character then
        v_u_1.createTemplate(p_u_28, p_u_28.Character)
    end
    p_u_28.CharacterAdded:Connect(function(p29)
        v_u_1.createTemplate(p_u_28, p29)
    end)
end
function v_u_1.Initialize(p30, p31)
    v_u_13 = p30
    v_u_12 = p31
    v_u_9.observeAttribute(workspace, "Timer", function(p32)
        local v33 = workspace:GetAttribute("Gamemode")
        v_u_12.Time.Timer.TextColor3 = Color3.fromRGB(255, 255, 255)
        v_u_12.Time.Timer.Text = v_u_6(p32)
        if v33 == "Deathmatch" and p32 <= 10 then
            local v34 = (v_u_7.Get(v_u_5, "Settings.Audio.Music.Main Menu Volume") or 100) / 100
            v_u_12.Time.Timer.TextColor3 = Color3.fromRGB(165, 20, 20)
            if v34 > 0 then
                v_u_8.new("Interface"):playOneTime({
                    ["Parent"] = v_u_5.PlayerGui,
                    ["Name"] = "Countdown Timer"
                }, v34)
            end
        end
    end)
    v_u_3.Heartbeat:Connect(function()
        local v35 = v_u_12
        local v36
        if workspace:GetAttribute("Gamemode") == "Deathmatch" then
            v36 = not v_u_13.Gameplay.Middle.TeamSelection.Visible
        else
            v36 = false
        end
        v35.Visible = v36
    end)
end
function v_u_1.Start()
    v_u_18(v_u_12.Players)
    for _, v37 in ipairs(v_u_4:GetPlayers()) do
        v_u_1.playerAdded(v37)
    end
    v_u_4.PlayerAdded:Connect(function(p38)
        v_u_1.playerAdded(p38)
    end)
    v_u_4.PlayerRemoving:Connect(function(p39)
        v_u_1.cleanupPlayerTemplate(p39)
    end)
end
return v_u_1