local v_u_1 = {}
local v_u_2 = game:GetService("ReplicatedStorage")
local v_u_3 = game:GetService("TweenService")
local v_u_4 = game:GetService("RunService")
local v5 = game:GetService("Players")
require(script:WaitForChild("Types"))
local v_u_6 = v5.LocalPlayer
local v_u_7 = require(v_u_2.Controllers.InventoryController)
local v_u_8 = require(v_u_2.Controllers.EndScreenController)
local v_u_9 = require(v_u_2.Controllers.CameraController)
local v_u_10 = require(v_u_2.Controllers.DataController)
local v_u_11 = require(v_u_2.Database.Components.Common.RemoveFromArray)
local v_u_12 = require(v_u_2.Components.Common.GetWeaponProperties)
local v_u_13 = require(v_u_2.Components.Common.GetPreferenceColor)
local v_u_14 = require(v_u_2.Database.Components.Common.IsInBuyArea)
local v_u_15 = require(v_u_2.Components.Common.GetTimerFormat)
local v_u_16 = require(v_u_2.Database.Components.GameState)
local v_u_17 = require(v_u_2.Packages.Observers)
local v18 = require(v_u_2.Shared.Janitor)
local v19 = require(v_u_2.Shared.Spring)
local v_u_20 = require(v_u_2.Database.Security.Remotes)
local v_u_21 = require(v_u_2.Database.Security.Router)
local v_u_22 = require(v_u_2.Database.Custom.GameStats.Grenades)
local v_u_23 = v_u_2.Assets.Characters
local v_u_24 = require(v_u_2.Database.Custom.GameStats.NumberSlots)
local v_u_25 = require(v_u_2.Database.Custom.GameStats.Character.Attachments)
local v_u_26 = require(v_u_2.Database.Custom.GameStats.Character.Viewport)
local v_u_27 = require(v_u_2.Shared.ViewportModel)
local v_u_28 = v18.new()
local v_u_29 = v18.new()
local v_u_30 = v19.new(1, 8, 0)
local v_u_31 = nil
local v_u_32 = nil
local v_u_33 = nil
local v_u_34 = nil
local v_u_35 = nil
local v_u_36 = nil
local v_u_37 = nil
local v_u_38 = {}
local v_u_39 = nil
local v_u_40 = nil
local function v_u_45()
    for _, v41 in ipairs(v_u_39.Menu.Container:GetDescendants()) do
        if v41:IsA("TextButton") and v41.Parent.Name ~= "Equipment" then
            local v42 = v_u_1.setupTemplate
            local v43 = v41.Parent.Name
            local v44 = v41.Name
            v42(v41, (("Loadout.%*.Options.%*"):format(v43, (tonumber(v44)))))
        end
    end
end
local function v_u_50(p46, p47)
    for _, v48 in ipairs(p46) do
        for _, v49 in ipairs(v48._items) do
            if v49.Name == p47 then
                return v49
            end
        end
    end
    return false
end
local function v_u_55(p51, p52)
    for _, v53 in ipairs(p51) do
        for _, v54 in ipairs(v53._items) do
            if v54.Name == p52 and table.find(v_u_38, v54.Identifier) then
                return v54
            end
        end
    end
    return v_u_50(p51, p52)
end
local function v_u_61(p56, p57)
    local v58 = 0
    for _, v59 in ipairs(p56) do
        for _, v60 in ipairs(v59._items) do
            if v60.Name == p57 then
                v58 = v58 + 1
            end
        end
    end
    return v58
end
local function v_u_65(p62, p63)
    local v64 = p62:GetAttribute(p63)
    while not v64 do
        v64 = p62:GetAttribute(p63)
        task.wait()
    end
    return v64
end
function v_u_1.purchase(p66, p67, p68, p69)
    local v70 = v_u_6:GetAttribute("Money")
    if v_u_14(v_u_6) then
        local v71 = not p69
        if v71 then
            v71 = v_u_22[p66] ~= nil
        end
        local v72 = v71 and v_u_7.getCurrentInventory()
        if v72 then
            local v73 = v72[v_u_24.Grenade]
            if v73 and #v73._items >= v73._settings._strict_slot_space then
                return
            end
        end
        if not p69 then
            local v74 = workspace:GetAttribute("Gamemode")
            if v_u_6:GetAttribute("BuyMenu") and (v74 == "Hostage Rescue" or v74 == "Bomb Defusal") then
                local v75 = v_u_7.getCurrentInventory()
                local v76 = v_u_2.Database.Custom.Weapons:FindFirstChild(p66) or v_u_2.Database.Custom.GameStats.Equipment:FindFirstChild(p66)
                local v77
                if v76 then
                    v77 = require(v76)
                else
                    v77 = nil
                end
                local v78 = v_u_24[v77.Slot]
                if v75 and v77 then
                    local v79 = v75[v78]
                    if v79 and #v79._items > 0 then
                        local v80 = v79._items[1]
                        if table.find(v_u_38, v80.Identifier) then
                            local v81 = v80.Name
                            local v82 = v_u_2.Database.Custom.Weapons:FindFirstChild(v81) or v_u_2.Database.Custom.GameStats.Equipment:FindFirstChild(v81)
                            local v83
                            if v82 then
                                v83 = require(v82)
                            else
                                v83 = nil
                            end
                            if v83 then
                                local v84 = v83.Cost
                                p68 = p68 - (v80.Name == "Molotov" and v_u_6:GetAttribute("Team") == "Counter-Terrorists" and 500 or v84)
                            end
                        end
                    end
                end
            end
        end
        if v70 and p68 <= v70 then
            v_u_21.broadcastRouter("RunInterfaceSound", "Successful Buy Menu Purchase")
            v_u_20.Inventory.BuyMenuPurchase.Send({
                ["Equipment"] = p69,
                ["Name"] = p66,
                ["Path"] = p67 or ""
            })
        end
    end
end
function v_u_1.createTemplate(p_u_85, p_u_86, p_u_87, p_u_88)
    local v89 = p_u_86.Name
    local v90 = v_u_2.Database.Custom.Weapons:FindFirstChild(v89) or v_u_2.Database.Custom.GameStats.Equipment:FindFirstChild(v89)
    local v91
    if v90 then
        v91 = require(v90)
    else
        v91 = nil
    end
    if p_u_87 or not v91 then
        p_u_85.Visible = false
    else
        local v92 = workspace:GetAttribute("Gamemode")
        local v93 = v91.Cost
        local v_u_94 = p_u_86.Name == "Molotov" and v_u_6:GetAttribute("Team") == "Counter-Terrorists" and 500 or v93
        p_u_85.Icon.Image = v91.ReverseIcon or v91.Icon
        p_u_85.Cost.Text = "$" .. tostring(v_u_94):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "")
        local v95 = p_u_85.Keybind
        local v96 = p_u_85.Name
        local v97 = tonumber(v96)
        v95.Text = tostring(v97)
        p_u_85.Cost.Visible = v92 ~= "Deathmatch"
        local v98 = p_u_85.Name
        p_u_85.LayoutOrder = tonumber(v98)
        p_u_85.ItemName.Text = p_u_86.Name
        p_u_85.Teammates.Visible = false
        p_u_85.Visible = true
        local v99 = v_u_6:GetAttribute("Money") < v_u_94 and Color3.fromRGB(149, 149, 149) or v_u_13()
        p_u_85.ItemName.TextColor3 = v99
        p_u_85.Keybind.TextColor3 = v99
        p_u_85.Icon.ImageColor3 = v99
        p_u_85.Cost.TextColor3 = v99
        p_u_85:SetAttribute("Weapon", p_u_86.Name)
        p_u_85:SetAttribute("IsEquipment", p_u_87)
        p_u_85:SetAttribute("InventoryItemId", p_u_86._id)
        local v100 = v_u_7.getCurrentInventory()
        local v101, v102
        if v100 then
            v101 = v_u_61(v100, p_u_86.Name) > 0
            local v103 = p_u_86.Name
            local v104 = v_u_61(v100, v103)
            local v105 = v_u_22[v103]
            if v105 then
                v102 = v104 < v105
            else
                v102 = v104 == 0
            end
        else
            v101 = false
            v102 = true
        end
        local v106 = p_u_85.Return
        local v107
        if v101 then
            if v_u_16.GetState() == "Warmup" or v92 == "Deathmatch" then
                v107 = false
            else
                local v108
                if p_u_85.Parent.Name == "Pistols" then
                    v108 = p_u_85.Name == "1"
                else
                    v108 = false
                end
                v107 = not v108
            end
        else
            v107 = v101
        end
        v106.Visible = v107
        p_u_85.Hover.Visible = v101
        p_u_85.Hover.UIStroke.Transparency = v101 and not v102 and 0 or 1
        v_u_28:Add(p_u_85.MouseEnter:Connect(function()
            local v109 = v_u_7.getCurrentInventory()
            v_u_21.broadcastRouter("RunInterfaceSound", "UI Highlight")
            if v109 then
                if not v_u_50(v109, p_u_86.Name) then
                    p_u_85.Hover.UIStroke.Transparency = 1
                    p_u_85.Hover.Visible = true
                    v_u_3:Create(p_u_85.Hover.UIStroke, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                        ["Transparency"] = 0.8
                    }):Play()
                end
                v_u_3:Create(p_u_85.Icon, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                    ["Size"] = UDim2.fromScale(0.7, 0.7)
                }):Play()
                if not p_u_87 then
                    v_u_33 = p_u_86._id
                end
            end
        end))
        v_u_28:Add(p_u_85.MouseLeave:Connect(function()
            local v110 = v_u_7.getCurrentInventory()
            if v110 then
                if not v_u_50(v110, p_u_86.Name) then
                    p_u_85.Hover.UIStroke.Transparency = 1
                    p_u_85.Hover.Visible = false
                end
                v_u_3:Create(p_u_85.Icon, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                    ["Size"] = UDim2.fromScale(0.75, 0.75)
                }):Play()
                if not p_u_87 and v_u_33 == p_u_86._id then
                    v_u_33 = nil
                end
            end
        end))
        v_u_28:Add(p_u_85.MouseButton1Down:Connect(function()
            v_u_3:Create(p_u_85.Icon, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                ["Size"] = UDim2.fromScale(0.65, 0.65)
            }):Play()
        end))
        v_u_28:Add(p_u_85.MouseButton1Up:Connect(function()
            v_u_3:Create(p_u_85.Icon, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                ["Size"] = UDim2.fromScale(0.7, 0.7)
            }):Play()
        end))
        v_u_28:Add(p_u_85.MouseButton1Click:Connect(function()
            v_u_1.purchase(p_u_86.Name, p_u_88, v_u_94, p_u_87)
        end))
        v_u_28:Add(p_u_85.Return.MouseButton1Click:Connect(function()
            local v111 = v_u_7.getCurrentInventory()
            if v111 then
                local v112 = v_u_55(v111, p_u_86.Name)
                if v112 and v_u_14(v_u_6) then
                    v_u_20.Inventory.ReturnBuyMenuPurchase.Send({
                        ["Identifier"] = v112.Identifier,
                        ["Equipment"] = p_u_87
                    })
                end
            end
        end))
    end
end
function v_u_1.setupTemplate(p113, p114)
    local v115 = v_u_21.broadcastRouter("GetEquippedInventoryItem", v_u_6, p114)
    if v115 and v115.Name then
        v_u_1.createTemplate(p113, v115, false, p114)
    else
        p113:SetAttribute("IsEquipment", nil)
        p113:SetAttribute("Weapon", nil)
        p113.Visible = false
    end
end
function v_u_1.updateBuyMenuTemplate(p116, p117)
    local v118 = p117:GetAttribute("IsEquipment")
    local v119 = p117:GetAttribute("Weapon")
    if v118 or not v119 then
        return
    else
        local v120 = v_u_2.Database.Custom.Weapons:FindFirstChild(v119) or v_u_2.Database.Custom.GameStats.Equipment:FindFirstChild(v119)
        local v121
        if v120 then
            v121 = require(v120)
        else
            v121 = nil
        end
        if v121 then
            local v122 = v121.Cost
            local v123 = v119 == "Molotov" and v_u_6:GetAttribute("Team") == "Counter-Terrorists" and 500 or v122
            p117.Cost.Text = "$" .. tostring(v123):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "")
            local v124 = v_u_6:GetAttribute("Money")
            if v124 then
                local v125 = v124 < v123 and Color3.fromRGB(149, 149, 149) or v_u_13()
                p117.ItemName.TextColor3 = v125
                p117.Keybind.TextColor3 = v125
                p117.Icon.ImageColor3 = v125
                p117.Cost.TextColor3 = v125
            end
        end
        if p117.Visible then
            local v126 = v_u_61(p116, v119) > 0
            local v127 = v_u_61(p116, v119)
            local v128 = v_u_22[v119]
            local v129
            if v128 then
                v129 = v127 < v128
            else
                v129 = v127 == 0
            end
            local v130 = workspace:GetAttribute("Gamemode")
            local v131 = p117.Return
            local v132
            if v126 then
                if v130 == "Deathmatch" or v_u_16.GetState() == "Warmup" then
                    v132 = false
                else
                    local v133
                    if p117.Parent.Name == "Pistols" then
                        v133 = p117.Name == "1"
                    else
                        v133 = false
                    end
                    v132 = not v133
                end
            else
                v132 = v126
            end
            v131.Visible = v132
            p117.Hover.Visible = v126
            if v126 then
                v_u_3:Create(p117.Hover.UIStroke, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                    ["Transparency"] = v129 and 1 or 0
                }):Play()
            else
                p117.Hover.UIStroke.Transparency = 1
            end
        else
            return
        end
    end
end
local function v_u_194(p134)
    local v135 = v_u_35
    if v135 then
        if p134 and v_u_32 == p134._id then
            local v136 = v_u_31
            if not (v136 and v136.IsPlaying) then
                local v137 = v135:FindFirstChildOfClass("Humanoid")
                local v138 = v137 and v137:FindFirstChildOfClass("Animator")
                if v138 then
                    local v139 = nil
                    if p134.Type == "Melee" then
                        v139 = "Melee"
                    else
                        local v140, v141 = pcall(v_u_12, p134.Name)
                        if v140 and v141 then
                            local v142 = v141.Type
                            local v143 = v141.AimingOptions
                            local v144 = v141.MuzzleType
                            if v142 == nil then
                                v139 = nil
                            elseif v143 == "SniperScope" then
                                v139 = "Sniper"
                            elseif v142 == "Heavy" then
                                v139 = v144 == "MachineGun" and "LMG" or "Heavy"
                            else
                                v139 = ({
                                    ["Pistol"] = "Pistol",
                                    ["Rifle"] = "Rifle",
                                    ["SMG"] = "SMG"
                                })[v142]
                            end
                        end
                    end
                    if v139 then
                        local v145 = p134.Name
                        local v146
                        if v139 and v_u_26.ANIMATION_MAPPING[v139] then
                            local v147 = v_u_26.ANIMATION_MAPPING[v139]
                            if v145 and v147[v145] then
                                v146 = v147[v145]
                            else
                                v146 = v147.Default
                            end
                        else
                            v146 = nil
                        end
                        if v146 then
                            local v148 = v138:LoadAnimation(v146)
                            v148.Looped = true
                            v148.Priority = Enum.AnimationPriority.Action
                            v148:Play()
                            v_u_31 = v148
                        end
                    end
                end
            end
            return
        else
            if v_u_31 then
                v_u_31:Stop()
                v_u_31 = nil
            end
            if v_u_34 then
                v_u_34:Destroy()
                v_u_34 = nil
            end
            v_u_32 = nil
            for _, v149 in pairs({ v_u_25.DEFAULT_JOINT_PART, "UpperTorso", "LeftHand" }) do
                local v150 = v135:FindFirstChild(v149)
                if v150 then
                    for _, v151 in ipairs(v150:GetChildren()) do
                        if v151:IsA("Motor6D") and (v151.Name == "WeaponAttachment" or (v151.Name == "WeaponAttachmentHandleR" or v151.Name == "WeaponAttachmentHandleL")) then
                            v151:Destroy()
                        end
                    end
                end
            end
            local v152 = { v135, v_u_36 }
            for _, v153 in ipairs(v152) do
                if v153 then
                    for _, v154 in ipairs(v153:GetChildren()) do
                        if v154:IsA("Model") and (v154 ~= v135 and v154.Name ~= "CharacterArmor") and (v154:FindFirstChild("Insert", true) or v154:FindFirstChild("Weapon", true)) then
                            v154:Destroy()
                        end
                    end
                end
            end
            if p134 then
                local v155 = require(v_u_2.Database.Components.Libraries.Skins).GetCharacterModel(p134.Name, p134.Skin, p134.Float, p134.StatTrack, p134.NameTag)
                if v155 then
                    v155.Name = p134.Name
                    local v156 = v135:FindFirstChild(v_u_25.WEAPON_JOINT_PARTS[p134.Name] or v_u_25.DEFAULT_JOINT_PART)
                    if v156 then
                        if not v155.PrimaryPart then
                            local v157 = v155:FindFirstChild("Weapon")
                            if v157 then
                                v157 = v157:FindFirstChild("Insert")
                            end
                            if v157 then
                                v155.PrimaryPart = v157
                            else
                                local v158 = v155:FindFirstChild("Insert", true)
                                if v158 then
                                    v155.PrimaryPart = v158
                                end
                            end
                        end
                        if v155.PrimaryPart then
                            for _, v159 in ipairs(v155:GetDescendants()) do
                                if v159:IsA("BasePart") then
                                    v159.CanCollide = false
                                    v159.CanQuery = false
                                    v159.CanTouch = false
                                    v159.Anchored = false
                                    v159.Massless = true
                                end
                            end
                            v155.Parent = v_u_36
                            local v160, v161 = pcall(v_u_12, p134.Name)
                            local v162
                            if v160 and v161 then
                                v162 = v161.ShootingOptions == "Dual"
                            else
                                v162 = false
                            end
                            local v163 = v155:FindFirstChild("Properties")
                            if not v163 then
                                local v164 = v155:FindFirstChild("Weapon")
                                if v164 then
                                    v163 = v164:FindFirstChild("Properties")
                                end
                            end
                            local v165 = v163 or v155:FindFirstChild("Properties", true)
                            if v162 then
                                local v166 = v135:FindFirstChild("RightHand")
                                local v167 = v135:FindFirstChild("LeftHand")
                                if v166 and v167 then
                                    local v168 = v155:FindFirstChild("HandleR", true)
                                    if v168 then
                                        local v169 = Instance.new("Motor6D")
                                        v169.Name = "WeaponAttachmentHandleR"
                                        v169.Part0 = v166
                                        v169.Part1 = v168
                                        v169.Parent = v166
                                        if v165 then
                                            local v170 = v165:FindFirstChild("C0RIGHT")
                                            if v170 then
                                                v169.C0 = v170.Value
                                            end
                                            local v171 = v165:FindFirstChild("C1RIGHT")
                                            if v171 then
                                                v169.C1 = v171.Value
                                            end
                                        end
                                    end
                                    local v172 = v155:FindFirstChild("HandleL", true)
                                    if v172 then
                                        local v173 = Instance.new("Motor6D")
                                        v173.Name = "WeaponAttachmentHandleL"
                                        v173.Part0 = v167
                                        v173.Part1 = v172
                                        v173.Parent = v167
                                        if v165 then
                                            local v174 = v165:FindFirstChild("C0LEFT")
                                            if v174 then
                                                v173.C0 = v174.Value
                                            end
                                            local v175 = v165:FindFirstChild("C1LEFT")
                                            if v175 then
                                                v173.C1 = v175.Value
                                            end
                                        end
                                    end
                                end
                            else
                                local v176 = Instance.new("Motor6D")
                                v176.Name = "WeaponAttachment"
                                v176.Part0 = v156
                                v176.Part1 = v155.PrimaryPart
                                v176.Parent = v156
                                if v165 then
                                    local v177 = v165:FindFirstChild("C0")
                                    if v177 then
                                        v176.C0 = v177.Value
                                    end
                                    local v178 = v165:FindFirstChild("C1")
                                    if v178 then
                                        v176.C1 = v178.Value
                                    end
                                end
                            end
                            v_u_34 = v155
                            v_u_32 = p134._id
                            local v179 = v135:FindFirstChildOfClass("Humanoid")
                            if v179 then
                                local v180 = v179:FindFirstChildOfClass("Animator")
                                if v180 then
                                    local v181 = nil
                                    if p134.Type == "Melee" then
                                        v181 = "Melee"
                                    elseif v161 then
                                        local v182 = v161.Type
                                        local v183 = v161.AimingOptions
                                        local v184 = v161.MuzzleType
                                        if v182 == nil then
                                            v181 = nil
                                        elseif v183 == "SniperScope" then
                                            v181 = "Sniper"
                                        elseif v182 == "Heavy" then
                                            v181 = v184 == "MachineGun" and "LMG" or "Heavy"
                                        else
                                            v181 = ({
                                                ["Pistol"] = "Pistol",
                                                ["Rifle"] = "Rifle",
                                                ["SMG"] = "SMG"
                                            })[v182]
                                        end
                                    else
                                        local v185, v186 = pcall(v_u_12, p134.Name)
                                        if v185 and v186 then
                                            local v187 = v186.Type
                                            local v188 = v186.AimingOptions
                                            local v189 = v186.MuzzleType
                                            if v187 == nil then
                                                v181 = nil
                                            elseif v188 == "SniperScope" then
                                                v181 = "Sniper"
                                            elseif v187 == "Heavy" then
                                                v181 = v189 == "MachineGun" and "LMG" or "Heavy"
                                            else
                                                v181 = ({
                                                    ["Pistol"] = "Pistol",
                                                    ["Rifle"] = "Rifle",
                                                    ["SMG"] = "SMG"
                                                })[v187]
                                            end
                                        end
                                    end
                                    if v181 then
                                        local v190 = p134.Name
                                        local v191
                                        if v181 and v_u_26.ANIMATION_MAPPING[v181] then
                                            local v192 = v_u_26.ANIMATION_MAPPING[v181]
                                            if v190 and v192[v190] then
                                                v191 = v192[v190]
                                            else
                                                v191 = v192.Default
                                            end
                                        else
                                            v191 = nil
                                        end
                                        if v191 then
                                            local v193 = v180:LoadAnimation(v191)
                                            v193.Looped = true
                                            v193.Priority = Enum.AnimationPriority.Action
                                            v193:Play()
                                            v_u_31 = v193
                                        end
                                    end
                                end
                            else
                                return
                            end
                        else
                            v155:Destroy()
                            return
                        end
                    else
                        v155:Destroy()
                        return
                    end
                else
                    return
                end
            else
                return
            end
        end
    else
        return
    end
end
local function v_u_214()
    local v195 = v_u_35
    if not v195 then
        return
    end
    local v196 = v_u_6:GetAttribute("Team")
    if not v196 or v196 ~= "Counter-Terrorists" and v196 ~= "Terrorists" then
        return
    end
    local v197 = (v196 == "Counter-Terrorists" and "CT" or "T") == "CT" and "Counter-Terrorists" or "Terrorists"
    local v198 = v_u_10.Get(v_u_6, "Loadout")
    if not (v198 and v198[v197]) then
        return
    end
    local v199 = v198[v197].Equipped
    if v199 then
        v199 = v198[v197].Equipped["Equipped Gloves"]
    end
    if not v199 then
        return
    end
    local v200 = v_u_10.Get(v_u_6, "Inventory")
    local v201 = nil
    if v200 and type(v200) == "table" then
        for _, v202 in ipairs(v200) do
            if v202 and v202._id == v199 then
                v201 = v202
                break
            end
        end
    end
    if v201 then
        local v203 = require(v_u_2.Database.Components.Libraries.Skins).GetGloves(v201.Name, v201.Skin, v201.Float)
        if v203 then
            local v204 = {
                ["Right Arm"] = "RightHand",
                ["Left Arm"] = "LeftHand"
            }
            local v205 = {
                ["Right Arm"] = "RightGlove",
                ["Left Arm"] = "LeftGlove"
            }
            for _, v206 in ipairs(v203:GetChildren()) do
                if v206:IsA("BasePart") then
                    local v207 = v204[v206.Name]
                    if v207 then
                        local v208 = v195:FindFirstChild(v207)
                        if v208 then
                            local v209 = v206:Clone()
                            v209.Name = v205[v206.Name] or v206.Name
                            v209.CastShadow = false
                            v209.CanCollide = false
                            v209.CanTouch = false
                            v209.Anchored = false
                            v209.CanQuery = false
                            v209.CFrame = v208.CFrame * CFrame.Angles(-1.5707963267948966, 0, 0)
                            local v210 = v208.Size.X * 1.1
                            local v211 = v208.Size.Z
                            local v212 = v208.Size.Y
                            v209.Size = Vector3.new(v210, v211, v212) * 1.1
                            v209.Parent = v195
                            local v213 = Instance.new("Motor6D")
                            v213.Name = "GloveAttachment"
                            v213.Part0 = v208
                            v213.Part1 = v209
                            v213.C0 = CFrame.new(0, 0, -0.025)
                            v213.C1 = v209.PivotOffset * CFrame.Angles(1.5707963267948966, 0, 0)
                            v213.Parent = v209
                        end
                    end
                end
            end
            v203:Destroy()
        end
    else
        return
    end
end
local function v_u_228()
    v_u_10.WaitForDataLoaded(v_u_6)
    if v_u_33 then
        local v215 = v_u_10.Get(v_u_6, "Inventory")
        if v215 and type(v215) == "table" then
            for _, v216 in ipairs(v215) do
                if v216 and v216._id == v_u_33 then
                    v_u_194(v216)
                    return
                end
            end
        end
        return
    end
    local v217 = v_u_7.getCurrentInventory()
    local v218 = v_u_10.Get(v_u_6, "Inventory")
    if not v217 or (not v218 or type(v218) ~= "table") then
        return
    end
    local v227 = nil
    local v220 = v217[1]
    if v220 and (v220._items and #v220._items > 0) then
        local v221 = v220._items[1]
        if not (v221 and v221._id) then
            goto l16
        end
        local v222 = v221._id
        for _, v227 in ipairs(v218) do
            if v227._id == v222 then
                goto l16
            end
        end
        v227 = nil
        goto l16
    else
        ::l16::
        if v227 then
            ::l26::
            if v227 then
                v_u_194(v227)
            end
            return
        else
            local v224 = v217[2]
            if not v224 or (not v224._items or #v224._items <= 0) then
                goto l26
            end
            local v225 = v224._items[1]
            if not (v225 and v225._id) then
                goto l26
            end
            local v226 = v225._id
            for _, v227 in ipairs(v218) do
                if v227._id == v226 then
                    goto l26
                end
            end
            v227 = nil
            goto l26
        end
    end
end
local function v_u_246()
    local v229 = v_u_39.Player
    if v229 then
        local v230 = v_u_6:GetAttribute("Team")
        if v230 and (v230 == "Counter-Terrorists" or v230 == "Terrorists") then
            local v231 = v230 == "Counter-Terrorists" and "CT" or "T"
            local v232 = v_u_26.VIEWPORT_CHARACTER_CONFIG[v231]
            if v232 then
                if v_u_35 and v_u_35.Parent then
                    return
                else
                    if v_u_36 then
                        v_u_36:Destroy()
                        v_u_36 = nil
                    end
                    if v_u_37 then
                        v_u_37:Destroy()
                        v_u_37 = nil
                    end
                    for _, v233 in ipairs(v229:GetChildren()) do
                        if v233:IsA("WorldModel") or v233:IsA("Camera") then
                            v233:Destroy()
                        end
                    end
                    local v234 = v_u_23:FindFirstChild(v232.Character)
                    if v234 then
                        local v235 = Instance.new("WorldModel")
                        v235.Name = "CharacterWorldModel"
                        v235.Parent = v229
                        v_u_36 = v235
                        local v236 = v234:Clone()
                        v236.Name = "BuyMenuCharacter"
                        v236.Parent = v235
                        v_u_35 = v236
                        if v236.PrimaryPart then
                            v236:SetPrimaryPartCFrame(CFrame.new(0, 0, 0))
                        end
                        local v237 = -v236:GetBoundingBox().Y
                        local v238 = CFrame.new(0, v237, 0.4)
                        if v236.PrimaryPart then
                            v236:SetPrimaryPartCFrame(v238)
                        end
                        local v239 = Instance.new("Camera")
                        v239.CameraType = Enum.CameraType.Scriptable
                        v239.Name = "ViewportCamera"
                        v239.FieldOfView = 55
                        v239.Parent = v229
                        v229.CurrentCamera = v239
                        v_u_37 = v239
                        local v240 = v236:FindFirstChildOfClass("Humanoid")
                        if v240 and v232.IdleAnimation then
                            local v241 = v240:FindFirstChildOfClass("Animator")
                            if not v241 then
                                v241 = Instance.new("Animator")
                                v241.Parent = v240
                            end
                            local v242 = Instance.new("Animation")
                            v242.AnimationId = v232.IdleAnimation
                            local v243 = v241:LoadAnimation(v242)
                            v243.Looped = true
                            v243:Play()
                            v_u_29:Add(v243, "Stop", "BuyMenuIdleAnimTrack")
                            v_u_29:Add(v242, "Destroy", "BuyMenuIdleAnim")
                        end
                        local v244 = v_u_27.new(v229, v239)
                        v244:SetModel(v236)
                        local v245 = v244:GetMinimumFitCFrame(CFrame.new(0, v237, 0) * CFrame.Angles(0, -3.141592653589793, 0))
                        v239.CFrame = CFrame.new(0, v237, v245.Position.Z) * CFrame.Angles(0, -3.141592653589793, 0)
                        v_u_214()
                        v_u_228()
                        v_u_29:Add(function()
                            if v_u_36 then
                                v_u_36:Destroy()
                                v_u_36 = nil
                            end
                            if v_u_37 then
                                v_u_37:Destroy()
                                v_u_37 = nil
                            end
                            if v_u_35 then
                                v_u_35:Destroy()
                                v_u_35 = nil
                            end
                            v_u_32 = nil
                            v_u_31 = nil
                            v_u_34 = nil
                        end, true, "BuyMenuCharacter")
                    end
                end
            else
                return
            end
        else
            return
        end
    else
        return
    end
end
local function v_u_248()
    local v247 = v_u_39.Player
    if v247 then
        if v247.Visible and (v247.AbsoluteSize.X > 0 and v247.AbsoluteSize.Y > 0) then
            if not (v_u_35 and v_u_35.Parent) then
                v_u_246()
            end
            if v_u_37 and v_u_37.Parent then
                v247.CurrentCamera = v_u_37
            end
            v_u_228()
        end
    else
        return
    end
end
function v_u_1.openFrame()
    if v_u_8.IsActive() then
        return
    else
        local v249 = v_u_6:GetAttribute("BuyMenu")
        if v_u_14(v_u_6) then
            if v249 and not v_u_39.Visible then
                v_u_9.setForceLockOverride("BuyMenu", true)
                v_u_9.setPerspective(true, true)
                v_u_40.Gameplay.Bottom.Health.Visible = false
                v_u_40.Gameplay.Bottom.Middle.Visible = false
                v_u_40.Gameplay.Bottom.Armor.Visible = false
                v_u_40.Gameplay.Bottom.Money.Visible = false
                v_u_40.Gameplay.Bottom.Ammo.Visible = false
                v_u_39.Visible = true
                v_u_33 = nil
                v_u_248()
            end
        else
            return
        end
    end
end
function v_u_1.closeFrame()
    if v_u_39.Visible then
        v_u_9.setForceLockOverride("BuyMenu", false)
        v_u_9.setPerspective(true, false)
        v_u_40.Gameplay.Bottom.Health.Visible = true
        v_u_40.Gameplay.Bottom.Middle.Visible = true
        v_u_40.Gameplay.Bottom.Armor.Visible = true
        v_u_40.Gameplay.Bottom.Money.Visible = true
        v_u_40.Gameplay.Bottom.Ammo.Visible = true
        v_u_39.Visible = false
        v_u_33 = nil
    end
end
function v_u_1.toggleFrame()
    if v_u_8.IsActive() then
        return
    elseif v_u_6:GetAttribute("BuyMenu") and not v_u_39.Visible then
        v_u_1.openFrame()
        return
    elseif v_u_39.Visible then
        v_u_1.closeFrame()
    end
end
function v_u_1.characterAdded(_)
    if v_u_65(v_u_6, "Money") then
        v_u_28:Cleanup()
        v_u_246()
        v_u_45()
    end
end
function v_u_1.characterRemoving(_)
    v_u_29:Cleanup()
    if v_u_34 then
        v_u_34:Destroy()
        v_u_34 = nil
    end
    if v_u_31 then
        v_u_31:Stop()
        v_u_31 = nil
    end
    v_u_32 = nil
    v_u_33 = nil
    v_u_35 = nil
    v_u_36 = nil
    v_u_37 = nil
end
function v_u_1.Initialize(p250, p251)
    v_u_40 = p250
    v_u_39 = p251
    v_u_17.observeAttribute(v_u_6, "Team", function(_)
        if v_u_35 and v_u_6.Character then
            v_u_1.characterRemoving(v_u_6.Character)
        end
        if v_u_6.Character then
            v_u_246()
            if v_u_39.Visible then
                v_u_248()
            end
        end
    end)
    v_u_20.Inventory.NewInventoryItem.Listen(function(p252)
        local v253 = v_u_38
        local v254 = p252.identifier
        table.insert(v253, v254)
    end)
    v_u_20.Inventory.RemoveInventoryItem.Listen(function(p_u_255)
        v_u_11(v_u_38, function(_, p256)
            return p256 == p_u_255
        end)
    end)
    v_u_17.observeAttribute(v_u_6, "MinimumNextRoundIncome", function(p257)
        v_u_39.Menu.TopFrame.NextRoundMoney.Text = "Next Round Minimum:  $" .. tostring(p257):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "")
    end)
    v_u_17.observeAttribute(v_u_6, "Money", function(p258)
        v_u_30:setGoal(p258)
    end)
    v_u_17.observeAttribute(v_u_6, "BuyMenu", function(_)
        return function()
            v_u_1.closeFrame()
        end
    end)
    v_u_17.observeAttribute(workspace, "Timer", function(p259)
        v_u_39.Menu.TopFrame.Timer.Text = v_u_15(p259)
    end)
    v_u_16.ListenToState(function(_, p260)
        if p260 == "Buy Period" then
            table.clear(v_u_38)
        end
    end)
    v_u_4.Heartbeat:Connect(function(p261)
        local v262 = v_u_30:getPosition()
        local v263 = math.round(v262)
        local v264 = tostring(v263):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "")
        v_u_39.Menu.TopFrame.Money.TextColor3 = v_u_13()
        v_u_39.Menu.TopFrame.Money.Text = "$" .. v264
        v_u_30:update(p261)
        if v_u_39.Visible and not v_u_14(v_u_6) then
            local v265 = workspace:GetAttribute("Gamemode")
            if v265 == "Bomb Defusal" or v265 == "Hostage Rescue" then
                v_u_1.closeFrame()
                return
            end
        end
    end)
    v_u_7.OnInventoryChanged:Connect(function(p266)
        for _, v267 in ipairs(v_u_39.Menu.Container:GetDescendants()) do
            if v267:IsA("TextButton") then
                v_u_1.updateBuyMenuTemplate(p266, v267)
            end
        end
        if v_u_39.Visible then
            task.defer(v_u_228)
        end
    end)
    v_u_10.CreateListener(v_u_6, "Settings.Game.HUD.Color", function()
        local v268 = v_u_7.getCurrentInventory()
        if v268 then
            for _, v269 in ipairs(v_u_39.Menu.Container:GetDescendants()) do
                if v269:IsA("TextButton") then
                    v_u_1.updateBuyMenuTemplate(v268, v269)
                end
            end
        end
    end)
    v_u_10.CreateListener(v_u_6, "Loadout", function()
        if v_u_6.Character then
            v_u_28:Cleanup()
            v_u_29:Cleanup()
            v_u_45()
            for _, v270 in ipairs(v_u_39.Menu.Container:GetDescendants()) do
                if v270:IsA("TextButton") and v270.Parent.Name ~= "Equipment" then
                    local v271 = v_u_1.setupTemplate
                    local v272 = v270.Parent.Name
                    local v273 = v270.Name
                    v271(v270, (("Loadout.%*.Options.%*"):format(v272, (tonumber(v273)))))
                end
            end
        end
    end)
end
function v_u_1.Start()
    if v_u_6.Character then
        v_u_1.characterAdded(v_u_6.Character)
    end
    v_u_6.CharacterAdded:Connect(function(p274)
        v_u_1.characterAdded(p274)
    end)
    v_u_6.CharacterRemoving:Connect(function(p275)
        v_u_1.characterRemoving(p275)
    end)
end
return v_u_1