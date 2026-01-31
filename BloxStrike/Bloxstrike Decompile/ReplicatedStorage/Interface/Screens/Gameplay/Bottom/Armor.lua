local v_u_1 = {}
local v2 = game:GetService("ReplicatedStorage")
local v_u_3 = game:GetService("HttpService")
local v4 = game:GetService("Players")
require(v2.Database.Custom.Types)
local v_u_5 = v4.LocalPlayer
local v_u_6 = require(v2.Components.Common.GetPreferenceColor)
local v_u_7 = require(v2.Controllers.DataController)
local v_u_8 = require(v2.Controllers.SpectateController)
local v_u_9 = require(v2.Database.Components.GameState)
local v_u_10 = require(v2.Packages.Observers)
local v11 = require(v2.Shared.Janitor)
local v_u_12 = nil
local v_u_13 = v11.new()
function v_u_1.updateFrame(p14)
    local v15 = v_u_6()
    v_u_12.Helmet.Visible = p14.Type == "Kevlar + Helmet"
    local v16 = v_u_12.Amount
    local v17 = p14.Health
    local v18 = math.round(v17)
    v16.Text = tostring(v18)
    v_u_12.Helmet.ImageColor3 = v15
    v_u_12.Amount.TextColor3 = v15
    v_u_12.Armor.ImageColor3 = v15
end
local function v_u_22(p19)
    v_u_13:Cleanup()
    v_u_13:Add(v_u_10.observeAttribute(p19, "Armor", function(p20)
        v_u_12.Visible = p20 and true
        if p20 then
            v_u_1.updateFrame(v_u_3:JSONDecode(p20))
        end
    end))
    local v21 = p19:GetAttribute("Armor")
    if v21 then
        v_u_12.Visible = true
        v_u_1.updateFrame(v_u_3:JSONDecode(v21))
    else
        v_u_12.Visible = false
    end
end
function v_u_1.Initialize(_, p23)
    v_u_12 = p23
    if v_u_12.Active then
        v_u_12.Active = false
    end
    for _, v24 in ipairs(v_u_12:GetDescendants()) do
        if v24:IsA("GuiObject") then
            v24.Active = false
        end
    end
    v_u_5.CharacterAdded:Connect(function()
        v_u_22(v_u_5)
    end)
    v_u_7.CreateListener(v_u_5, "Settings.Game.HUD.Color", function()
        local v25 = v_u_5:GetAttribute("Armor")
        if v25 then
            v_u_1.updateFrame(v_u_3:JSONDecode(v25))
        end
    end)
end
function v_u_1.Start()
    v_u_5.CharacterAdded:Connect(function()
        local v26 = v_u_5
        v_u_13:Cleanup()
        v_u_22(v26)
    end)
    v_u_8.ListenToSpectate:Connect(function(p27)
        if p27 then
            v_u_13:Cleanup()
            v_u_22(p27)
        elseif not v_u_5:GetAttribute("IsSpectating") then
            local v28 = v_u_5
            v_u_13:Cleanup()
            v_u_22(v28)
        end
    end)
    v_u_5:GetAttributeChangedSignal("IsSpectating"):Connect(function()
        if v_u_5:GetAttribute("IsSpectating") then
            local v29 = v_u_8.GetPlayer()
            if v29 then
                v_u_13:Cleanup()
                v_u_22(v29)
            end
        else
            local v30 = v_u_5
            v_u_13:Cleanup()
            v_u_22(v30)
        end
    end)
    if v_u_5:GetAttribute("IsSpectating") then
        local v31 = v_u_8.GetPlayer()
        if v31 then
            v_u_13:Cleanup()
            v_u_22(v31)
        end
    else
        local v32 = v_u_5
        v_u_13:Cleanup()
        v_u_22(v32)
    end
    v_u_9.ListenToState(function(_, p33)
        if p33 == "Buy Period" or p33 == "Round In Progress" then
            local v34 = v_u_5
            v_u_13:Cleanup()
            v_u_22(v34)
        end
    end)
end
return v_u_1