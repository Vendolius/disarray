local v1 = {}
local v2 = game:GetService("ReplicatedStorage")
local v_u_3 = game:GetService("TweenService")
local v_u_4 = game:GetService("Players")
require(v2.Database.Custom.Types)
local v_u_5 = v_u_4.LocalPlayer
local v_u_6 = require(v2.Controllers.InventoryController)
local v_u_7 = require(v2.Controllers.DataController)
local v_u_8 = require(v2.Controllers.SpectateController)
local v9 = require(v2.Components.Common.GetUserPlatform)
local v_u_10 = require(v2.Components.Common.GetPreferenceColor)
local v_u_11 = require(v2.Database.Security.Remotes)
local v_u_12 = require(v2.Database.Components.Libraries.Skins)
local v_u_13 = require(v2.Database.Custom.GameStats.Rarities)
local v_u_14 = nil
local v_u_15 = 0
local v_u_16 = {}
local v_u_17 = nil
local v_u_18 = table.find(v9(), "Console")
if v_u_18 then
    v_u_18 = #v9() <= 1
end
local v_u_19 = {
    {
        ["type"] = "Primary",
        ["space"] = 1
    },
    {
        ["type"] = "Secondary",
        ["space"] = 1
    },
    {
        ["type"] = "Melee",
        ["space"] = 1
    },
    {
        ["type"] = "Grenade",
        ["space"] = 4
    },
    {
        ["type"] = "C4",
        ["space"] = 1
    }
}
local v_u_20 = nil
local function v_u_26()
    if v_u_17 then
        task.cancel(v_u_17)
        v_u_17 = nil
    end
    for _, v21 in pairs(v_u_16) do
        v21:Cancel()
    end
    table.clear(v_u_16)
    local v22 = v_u_20 and { v_u_20.Primary, v_u_20.Secondary, v_u_20.Melee } or nil
    if v22 then
        for _, v23 in ipairs(v22) do
            if v23:IsA("Frame") then
                local v24 = v23:FindFirstChild("Equip")
                if v24 and v24:IsA("Frame") then
                    v24.BackgroundTransparency = 0
                end
                for _, v25 in ipairs(v23:GetDescendants()) do
                    if v25:IsA("ImageLabel") then
                        v25.ImageTransparency = 0
                    elseif v25:IsA("TextLabel") then
                        v25.TextTransparency = 0
                    end
                end
            end
        end
    end
end
local function v_u_34()
    if v_u_7.Get(v_u_5, "Settings.Game.Item.Always Show Inventory") ~= false then
        v_u_26()
        return
    end
    v_u_26()
    local v27 = v_u_20 and { v_u_20.Primary, v_u_20.Secondary, v_u_20.Melee } or nil
    if not v27 then
        return
    end
    for _, v28 in ipairs(v27) do
        if v28:IsA("Frame") then
            local v29 = v28:FindFirstChild("Equip")
            if v29 and v29:IsA("Frame") then
                local v30 = v_u_3:Create(v29, TweenInfo.new(5, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
                    ["BackgroundTransparency"] = 1
                })
                v_u_16[v28.Name .. "_Equip"] = v30
                v30:Play()
            end
            for _, v31 in ipairs(v28:GetDescendants()) do
                local v32
                if v31:IsA("ImageLabel") then
                    v32 = {
                        ["ImageTransparency"] = 1
                    }
                    ::l21::
                    local v33 = v_u_3:Create(v31, TweenInfo.new(5, Enum.EasingStyle.Linear, Enum.EasingDirection.In), v32)
                    v_u_16[v28.Name .. "_" .. v31:GetFullName()] = v33
                    v33:Play()
                elseif v31:IsA("TextLabel") then
                    v32 = {
                        ["TextTransparency"] = 1
                    }
                    goto l21
                end
            end
        end
    end
    v_u_17 = task.delay(5, function()
        v_u_17 = nil
    end)
end
local function v_u_38(p35)
    if p35 then
        if v_u_7.Get(v_u_5, "Settings.Game.HUD.Glow Weapon with Rarity Color") == true then
            local v36 = v_u_12.GetSkinInformation(p35.Name, p35.Skin)
            if v36 and v36.rarity then
                local v37 = v_u_13[v36.rarity]
                if v37 then
                    return v37.Color
                else
                    return v_u_10()
                end
            else
                return v_u_10()
            end
        else
            return v_u_10()
        end
    else
        return v_u_10()
    end
end
local function v_u_51(p39, p40)
    if v_u_14 then
        if v_u_14.Name == "Grenade" then
            local v41 = v_u_15
            local v42 = v_u_14:WaitForChild("Grenades"):FindFirstChild((tostring(v41)))
            if v42 then
                local v43 = v42:FindFirstChild("Grenade")
                v_u_3:Create(v43, TweenInfo.new(0.1), {
                    ["Size"] = v43:GetAttribute("DefaultSize")
                }):Play()
            end
        else
            local v44 = v_u_14.Weapon:FindFirstChildOfClass("ImageLabel")
            v_u_14.Weapon.WeaponName.Visible = false
            v_u_14.Equip.Visible = false
            v_u_3:Create(v44, TweenInfo.new(0.1), {
                ["Size"] = v44:GetAttribute("DefaultSize")
            }):Play()
        end
    end
    local v45 = v_u_20
    local v46 = p40.Properties.Slot
    local v47 = v45:FindFirstChild((tostring(v46)))
    v_u_14 = v47
    if v47 then
        if v47.Name == "Grenade" then
            local v48 = v47.Grenades:FindFirstChild((tostring(p39)))
            v_u_15 = p39
            if v48 then
                local v49 = v48:FindFirstChild("Grenade")
                v49.ImageColor3 = v_u_10()
                v_u_3:Create(v49, TweenInfo.new(0.1), {
                    ["Size"] = v49:GetAttribute("DefaultSize") + UDim2.fromScale(0.1, 0.1)
                }):Play()
            end
        else
            local v50 = v47.Weapon:FindFirstChildOfClass("ImageLabel")
            v50.ImageColor3 = v_u_38(p40)
            v47.Weapon.WeaponName.Visible = true
            v47.Equip.Visible = true
            v_u_3:Create(v50, TweenInfo.new(0.1), {
                ["Size"] = v50:GetAttribute("DefaultSize") + UDim2.fromScale(0.1, 0.1)
            }):Play()
        end
    end
    if v47 then
        v47 = v47:FindFirstChild("CycleWeaponsIcons")
    end
    if v_u_18 then
        if v47 then
            v47.Visible = v_u_18
        end
    else
        return
    end
end
local function v_u_60(p52)
    local v53 = {}
    if not p52 or #p52 == 0 then
        return nil
    end
    for v54 = 1, 5 do
        local v55 = p52[v54]
        if v55 then
            local v56 = {
                ["_items"] = {},
                ["_settings"] = {
                    ["_strict_slot_space"] = v55._settings._strict_slot_space,
                    ["_strict_type"] = v55._settings._strict_type
                }
            }
            v53[v54] = v56
            for _, v57 in ipairs(v55._items) do
                local v58 = v53[v54]._items
                table.insert(v58, v57)
            end
        else
            local v59 = {
                ["_items"] = {},
                ["_settings"] = {
                    ["_strict_slot_space"] = v_u_19[v54].space,
                    ["_strict_type"] = v_u_19[v54].type
                }
            }
            v53[v54] = v59
        end
    end
    return v53
end
local function v_u_78(p61)
    local v62 = v_u_10()
    v_u_20.Grenade.DefuseKit.ImageColor3 = v62
    v_u_20.Grenade.Bomb.ImageColor3 = v62
    if workspace:GetAttribute("Gamemode") == "Hostage Rescue" then
        v_u_20.Grenade.Bomb.Visible = false
    end
    for _, v63 in ipairs(p61) do
        if v63._settings._strict_slot_space == 1 then
            local v64 = v_u_20:FindFirstChild(v63._settings._strict_type)
            if v64 then
                local v65 = v63._items[1]
                if v65 then
                    local v66 = v64:FindFirstChild("Weapon")
                    v64:SetAttribute("Slot", v65.Slot)
                    v64.Keybind.Text = v65.Slot
                    if v66 then
                        local v67 = v64.Weapon:FindFirstChild(v65.Properties.Class)
                        local v68 = (v63._settings._strict_type == "Melee" and "\226\152\133 " or "") .. v65.Name
                        if v65.Skin then
                            local v69 = v65.Skin
                            v68 = v68 .. (v69 == "Vanilla" and "" or (" | " .. v69 or ""))
                        end
                        local v70 = (v65.Name == "T Knife" or v65.Name == "CT Knife") and "Knife" or v68
                        if v65.NameTag then
                            v70 = ("\"%*\""):format(v65.NameTag)
                        end
                        local v71 = v65.OriginalOwner
                        if v71 and (v71 ~= "" and v71 ~= v_u_5.Name) then
                            v70 = ("\"%*\'s %*\""):format(v71, v70)
                        end
                        v64.Weapon.WeaponName.TextColor3 = v_u_38(v65)
                        v64.Weapon.WeaponName.Text = v70
                        if v67 then
                            v67.Image = v65.Properties.Icon
                            v67.ImageColor3 = v_u_38(v65)
                        end
                    end
                end
            elseif v63._settings._strict_type == "C4" then
                v_u_20.Grenade.Bomb.Visible = v63._items[1]
            end
        elseif v63._settings._strict_type == "Grenade" then
            for v72 = 1, 4 do
                local v73 = v_u_20.Grenade.Grenades:FindFirstChild((tostring(v72)))
                if v73 then
                    local v74 = v63._items[v72]
                    if v74 then
                        v73.Grenade.ImageColor3 = v62
                        v73.Grenade.Visible = true
                        v73.Dot.Visible = false
                        if v74.Properties and v74.Properties.Icon then
                            v73.Grenade.Image = v74.Properties.Icon
                        end
                    else
                        v73.Grenade.Visible = false
                        v73.Dot.Visible = true
                    end
                end
            end
        end
    end
    for _, v75 in ipairs(v_u_20:GetChildren()) do
        if v75:IsA("Frame") then
            local v76 = v75.Name == "Grenade" and true or v75.Name == "Melee"
            for _, v77 in ipairs(p61) do
                if #v77._items > 0 and v77._settings._strict_type == v75.Name then
                    v76 = true
                    break
                end
            end
            v75.Visible = v76
        end
    end
end
function v1.Initialize(_, p79)
    v_u_20 = p79
    if v_u_20.Active then
        v_u_20.Active = false
    end
    for _, v80 in ipairs(v_u_20:GetDescendants()) do
        if v80:IsA("GuiObject") then
            v80.Active = false
        end
    end
    for _, v81 in ipairs(v_u_20:GetDescendants()) do
        if v81:IsA("ImageLabel") and (v81.Parent.Name == "Weapon" or v81.Name == "Grenade") then
            v81:SetAttribute("DefaultSize", v81.Size)
        end
    end
    for _, v_u_82 in ipairs(v_u_20:GetChildren()) do
        if v_u_82:IsA("Frame") and v_u_82:FindFirstChild("Button") then
            v_u_82.Button.MouseButton1Click:Connect(function()
                local v83 = v_u_82:GetAttribute("Slot")
                v_u_6.equip(v83, 1)
            end)
        end
    end
    for _, v_u_84 in ipairs(v_u_20.Grenade.Grenades:GetChildren()) do
        if v_u_84:IsA("Frame") then
            v_u_84:FindFirstChild("Button").MouseButton1Click:Connect(function()
                local v85 = v_u_6.equip
                local v86 = v_u_84.Name
                v85(4, (tonumber(v86)))
            end)
        end
    end
    local v_u_87 = v_u_20.Grenade.Bomb
    if v_u_87:IsA("ImageButton") then
        v_u_87.MouseButton1Click:Connect(function()
            if v_u_87.Visible then
                v_u_6.equip(5, 1)
            end
        end)
    end
end
function v1.Start()
    v_u_6.OnInventoryChanged:Connect(function(p88)
        if not v_u_5:GetAttribute("IsSpectating") then
            v_u_78(p88)
        end
    end)
    v_u_6.OnInventoryItemEquipped:Connect(function(p89, p90)
        v_u_51(p89, p90)
        if v_u_7.Get(v_u_5, "Settings.Game.Item.Always Show Inventory") == false then
            local v91 = p90.Properties.Slot
            if v91 == "Primary" or (v91 == "Secondary" or (v91 == "Melee" or v91 == "Grenade")) then
                v_u_26()
                v_u_34()
            end
        end
    end)
    v_u_7.CreateListener(v_u_5, "Settings.Game.HUD.Glow Weapon with Rarity Color", function()
        local v92 = v_u_6.getCurrentInventory()
        if v92 then
            v_u_78(v92)
        end
        local v93 = v_u_6.getCurrentEquipped()
        if v93 then
            local v94 = v_u_20
            local v95 = v93.Properties.Slot
            local v96 = v94:FindFirstChild((tostring(v95)))
            if v96 and v96.Name ~= "Grenade" then
                local v97 = v_u_38(v93)
                local v98 = v96.Weapon:FindFirstChildOfClass("ImageLabel")
                if v98 then
                    v98.ImageColor3 = v97
                end
                if v96.Weapon.WeaponName then
                    v96.Weapon.WeaponName.TextColor3 = v97
                end
            end
        end
    end)
    v_u_7.CreateListener(v_u_5, "Settings.Game.HUD.Color", function()
        if v_u_5:GetAttribute("IsSpectating") == true then
            local v99 = v_u_8.GetPlayer()
            if v99 then
                v_u_11.Inventory.RequestSpectatedPlayerInventory.Send(v99)
                return
            end
        else
            local v100 = v_u_6.getCurrentInventory()
            if v100 then
                v_u_78(v100)
            end
        end
    end)
    v_u_5:GetAttributeChangedSignal("HasDefuseKit"):Connect(function()
        if v_u_5:GetAttribute("IsSpectating") then
            return
        else
            local v101 = v_u_5:GetAttribute("Team")
            if v_u_5:GetAttribute("HasDefuseKit") and v101 == "Counter-Terrorists" then
                v_u_20.Grenade.DefuseKit.Visible = true
            else
                v_u_20.Grenade.DefuseKit.Visible = false
            end
        end
    end)
    v_u_11.Inventory.SpectatedPlayerInventory.Listen(function(p102)
        if v_u_5:GetAttribute("IsSpectating") == true then
            local v103 = v_u_8.GetPlayer()
            local v104 = v103 and (p102.Player == v103 and v_u_60(p102.Inventory))
            if v104 then
                v_u_78(v104)
                local v105 = p102.EquippedSlot or 0
                local v106 = p102.EquippedSlotSpace or 0
                if v105 > 0 and v106 > 0 then
                    local v107 = v104[v105]
                    if v107 and (v107._items and v107._items[v106]) then
                        v_u_51(v106, v107._items[v106])
                    end
                end
            end
        end
    end)
    v_u_8.ListenToSpectate:Connect(function(p108)
        if p108 then
            v_u_11.Inventory.RequestSpectatedPlayerInventory.Send(p108)
            local v109 = p108:GetAttribute("Team")
            if p108:GetAttribute("HasDefuseKit") and v109 == "Counter-Terrorists" then
                v_u_20.Grenade.DefuseKit.Visible = true
            else
                v_u_20.Grenade.DefuseKit.Visible = false
            end
        end
        local v110 = v_u_6.getCurrentInventory()
        if v110 then
            v_u_78(v110)
        end
        local v111 = v_u_6.getCurrentEquipped()
        if v110 and (v111 and v111.Identifier) then
            local v112 = false
            for v113 = 1, 5 do
                if v112 then
                    break
                end
                local v114 = v110[v113]
                if v114 and v114._items then
                    for v115, v116 in ipairs(v114._items) do
                        if v116.Identifier == v111.Identifier then
                            v_u_51(v115, v116)
                            v112 = true
                            break
                        end
                    end
                end
            end
        end
        local v117 = v_u_5:GetAttribute("Team")
        if v_u_5:GetAttribute("HasDefuseKit") and v117 == "Counter-Terrorists" then
            v_u_20.Grenade.DefuseKit.Visible = true
        else
            v_u_20.Grenade.DefuseKit.Visible = false
        end
    end)
    local function v_u_120()
        local v118 = v_u_5:GetAttribute("IsSpectating") == true and v_u_8.GetPlayer()
        if v118 then
            local v119 = v118:GetAttribute("Team")
            if v118:GetAttribute("HasDefuseKit") and v119 == "Counter-Terrorists" then
                v_u_20.Grenade.DefuseKit.Visible = true
                return
            end
            v_u_20.Grenade.DefuseKit.Visible = false
        end
    end
    for _, v121 in ipairs(v_u_4:GetPlayers()) do
        if v121 ~= v_u_5 then
            v121:GetAttributeChangedSignal("HasDefuseKit"):Connect(v_u_120)
        end
    end
    v_u_4.PlayerAdded:Connect(function(p122)
        if p122 ~= v_u_5 then
            p122:GetAttributeChangedSignal("HasDefuseKit"):Connect(v_u_120)
        end
    end)
    v_u_11.Inventory.NewInventoryItem.Listen(function(_)
        local v123 = v_u_5:GetAttribute("IsSpectating") == true and v_u_8.GetPlayer()
        if v123 then
            v_u_11.Inventory.RequestSpectatedPlayerInventory.Send(v123)
        end
    end)
    v_u_11.Inventory.RemoveInventoryItem.Listen(function(_)
        local v124 = v_u_5:GetAttribute("IsSpectating") == true and v_u_8.GetPlayer()
        if v124 then
            v_u_11.Inventory.RequestSpectatedPlayerInventory.Send(v124)
        end
    end)
    v_u_7.CreateListener(v_u_5, "Settings.Game.Item.Always Show Inventory", function()
        local v125 = v_u_7.Get(v_u_5, "Settings.Game.Item.Always Show Inventory") ~= false
        v_u_26()
        if not v125 then
            v_u_34()
        end
    end)
    task.wait(0.1)
    if v_u_7.Get(v_u_5, "Settings.Game.Item.Always Show Inventory") == false then
        v_u_34()
    end
end
return v1