local v_u_1 = {}
local v2 = game:GetService("ReplicatedStorage")
local v_u_3 = game:GetService("CollectionService")
local v_u_4 = game:GetService("RunService")
local v_u_5 = game:GetService("Players").LocalPlayer
local v_u_6 = require(v2.Database.Components.Libraries.Skins)
local v_u_7 = require(v2.Database.Custom.GameStats.Rarities)
local v_u_8 = nil
local function v_u_16(p9, p10)
    local v11 = v_u_5.Character
    if v11 and v11.PrimaryPart then
        local v12 = p9:GetAttribute("HoveringState")
        local v13 = p10:GetAttribute("HoveringState")
        if v12 == "Hovering" then
            return true
        elseif v13 == "Hovering" then
            return false
        else
            local v14 = p9:GetAttribute("CanPickup")
            local v15 = p10:GetAttribute("CanPickup")
            if v14 == false then
                return false
            elseif v15 == false then
                return true
            elseif p9.PrimaryPart and p10.PrimaryPart then
                return (v11.PrimaryPart.Position - p9.PrimaryPart.Position).Magnitude < (v11.PrimaryPart.Position - p10.PrimaryPart.Position).Magnitude
            else
                return false
            end
        end
    else
        return false
    end
end
function v_u_1.Render(_)
    local v17 = v_u_3:GetTagged("IsHoveringInteractable")
    table.sort(v17, v_u_16)
    local v18 = v17[1]
    if v18 then
        local v19 = v18:GetAttribute("Weapon")
        local v20 = v18:GetAttribute("Skin")
        local v21 = v_u_6.GetSkinInformation(v19, v20)
        local v22 = "Skin data not found for weapon: " .. v19 .. " and skin: " .. v20
        assert(v21, v22)
        local v23 = v_u_7[v21.rarity]
        local v24 = v23.Color.R * 255
        local v25 = math.floor(v24)
        local v26 = v23.Color.G * 255
        local v27 = math.floor(v26)
        local v28 = v23.Color.B * 255
        local v29 = math.floor(v28)
        v_u_8.TextLabel.Text = ("[E] Swap for <font color = \"rgb(%*, %*, %*)\"><b>%* | %*</b></font>"):format(v25, v27, v29, v19, v20)
        v_u_8.Visible = true
    else
        v_u_8.Visible = false
    end
end
function v_u_1.Initialize(_, p30)
    v_u_8 = p30
    v_u_4.Heartbeat:Connect(function(p31)
        if v_u_5.Character then
            v_u_1.Render(p31)
        else
            v_u_8.Visible = false
        end
    end)
end
return v_u_1