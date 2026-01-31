local v_u_1 = {}
local v_u_2 = game:GetService("ReplicatedStorage")
local v3 = game:GetService("Players")
local v_u_4 = game:GetService("Workspace")
require(script:WaitForChild("Types"))
local v_u_5 = v3.LocalPlayer
local v_u_6 = require(v_u_2.Controllers.SpectateController)
local v_u_7 = require(v_u_2.Components.Common.GetBadgeIcon)
local v_u_8 = require(v_u_2.Packages.Observers)
local v9 = require(v_u_2.Shared.Janitor)
local v_u_10 = require(v_u_2.Database.Custom.GameStats.Settings.Colors)
local v_u_11 = nil
local v_u_12 = nil
local v_u_13 = v9.new()
local function v_u_26(p14, p15)
    local v16 = p14:GetAttribute("Team")
    if v16 then
        local v17 = v_u_10["Team Color"][v16]
        local v18 = (p15 or (p14:GetAttribute("ADR") or 0)) * 10
        local v19 = math.floor(v18) / 10
        local v20 = v17.R * 255
        local v21 = math.floor(v20)
        local v22 = v17.G * 255
        local v23 = math.floor(v22)
        local v24 = v17.B * 255
        local v25 = math.floor(v24)
        v_u_11.ADR.Text = ("<font color=\"rgb(%*, %*, %*)\">ADR:</font> %*"):format(v21, v23, v25, v19)
    end
end
function v_u_1.UpdateFrame(p_u_27)
    local v28 = v_u_6.GetCurrentSpectateInstance()
    v_u_11.Player.Player.Avatar.Image = ("rbxthumb://type=AvatarHeadShot&id=%*&w=150&h=150"):format(p_u_27.UserId)
    v_u_11.Username.Text = p_u_27.Name
    local v29 = p_u_27:GetAttribute("Team")
    if v29 then
        local v30 = v_u_10["Team Color"][v29]
        v_u_11.Username.TextColor3 = v30
        v_u_11.Badge.Image = v_u_7(p_u_27, v29)
        v_u_11.Frame1.BackgroundColor3 = v30
        v_u_11.Frame2.BackgroundColor3 = v30
        v_u_11.Player.Outline.ImageColor3 = v30
    end
    v_u_13:Cleanup()
    v_u_13:Add(v_u_8.observeAttribute(p_u_27, "ADR", function(p31)
        if typeof(p31) == "number" then
            v_u_26(p_u_27, p31)
        end
    end))
    v_u_26(p_u_27)
    if v28 and v28.CurrentEquipped then
        local v32 = v28.CurrentEquipped
        v_u_11.Weapon.Text = v32.Name
        v_u_11.Skin.Text = v32.Skin
    end
    if v28 then
        v_u_13:Add(v28.CurrentEquippedChanged:Connect(function(p33)
            if p33 then
                v_u_11.Weapon.Text = p33.Name
                v_u_11.Skin.Text = p33.Skin
            end
        end))
    end
end
function v_u_1.OpenFrame()
    v_u_12.Gameplay.Bottom.Middle.Team.Visible = false
    v_u_11.Visible = true
end
function v_u_1.CloseFrame()
    v_u_11.Visible = false
    v_u_13:Cleanup()
    local v34 = v_u_5.Character
    local v35 = v_u_5:GetAttribute("Team")
    if v34 and (v34:IsDescendantOf(v_u_4) and (v35 and v35 ~= "Spectators")) then
        require(v_u_2.Interface.Screens.Gameplay.Bottom.Middle.Team).OpenFrame()
    end
end
function v_u_1.Initialize(p36, p37)
    v_u_12 = p36
    v_u_11 = p37
end
function v_u_1.Start()
    v_u_6.ListenToSpectate:Connect(function(p38)
        if p38 then
            v_u_1.UpdateFrame(p38)
            v_u_1.OpenFrame()
        else
            v_u_1.CloseFrame()
        end
    end)
end
return v_u_1