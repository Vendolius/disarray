local v_u_1 = {}
local v_u_2 = game:GetService("ReplicatedStorage")
local v_u_3 = game:GetService("TweenService")
local v_u_4 = game:GetService("TextService")
local v_u_5 = game:GetService("RunService")
local v_u_6 = game:GetService("Players")
local v_u_7 = game:GetService("GuiService")
local v_u_8 = game:GetService("UserInputService")
local v_u_9 = game:GetService("MarketplaceService")
require(script:WaitForChild("Types"))
local v_u_10 = v_u_6.LocalPlayer
local v_u_11 = v_u_10:GetMouse()
local v_u_12 = require(v_u_2.Controllers.DataController)
local v_u_13 = require(v_u_2.Database.Components.Libraries.Collections)
local v14 = require(v_u_2.Components.Common.GetUserPlatform)
local v_u_15 = require(v_u_2.Database.Components.Libraries.Skins)
local v_u_16 = require(v_u_2.Database.Components.Libraries.Cases)
local v_u_17 = require(v_u_2.Components.Common.GetWeaponProperties)
local v_u_18 = require(v_u_2.Database.Security.Remotes)
local v_u_19 = require(v_u_2.Database.Security.Router)
local v_u_20 = require(v_u_2.Database.Custom.GameStats.UI.Inventory.Buttons)
local v_u_21 = require(v_u_2.Database.Custom.GameStats.UI.Inventory.Sort)
local v_u_22 = require(v_u_2.Database.Custom.GameStats.Rarities)
local v_u_23 = require(v_u_2.Database.Custom.GameStats.Grenades)
local v_u_24 = require(v_u_2.Database.Custom.GameStats.Monetization.Gamepasses)
local v_u_25 = require(script.Parent.UseItemFrame)
local v_u_26 = require(script.Parent.Loadout)
local v_u_27 = require(script.Parent.Store)
local v_u_28 = require(v_u_2.Interface.Screens.Menu.Top)
local v_u_29 = require(v_u_2.Interface.MenuState)
local v_u_30 = Color3.fromRGB(53, 83, 99)
local v_u_31 = Color3.fromRGB(243, 243, 243)
local v_u_32 = Color3.fromRGB(125, 206, 243)
local v_u_33 = {}
local v_u_34 = table.find(v14(), "PC") ~= nil
local v_u_35 = nil
local v_u_36 = nil
local v_u_37 = nil
local v_u_38 = 0
local v_u_39 = false
local v_u_40 = nil
local v_u_41 = nil
local v_u_42 = false
local v_u_43 = false
local v_u_44 = false
local v_u_45 = nil
local v_u_46 = 0
local v_u_47 = nil
local v_u_48 = nil
local v_u_49 = nil
local v_u_50 = {}
local v_u_51 = {
    ["Charm Capsule"] = "Charm Pack",
    ["Package"] = "Package"
}
local function v_u_56(p52, p53)
    local v54 = p52:GetChildren()
    for _, v55 in ipairs(v54) do
        if v55.ClassName == p53 then
            v55:Destroy()
        end
    end
end
local function v_u_64(p57, p58)
    local v59 = v_u_12.Get(v_u_10, "Loadout")
    if not v59 then
        return false
    end
    local v60 = v59[p58]
    if not v60 then
        return false
    end
    if v60.Loadout then
        for _, v61 in pairs(v60.Loadout) do
            if v61 and v61.Options then
                for _, v62 in ipairs(v61.Options) do
                    if v62 == p57 then
                        return true
                    end
                end
            end
        end
    end
    if v60.Equipped then
        for _, v63 in pairs(v60.Equipped) do
            if v63 == p57 then
                return true
            end
        end
    end
    return false
end
local function v_u_72(p65, p66)
    local v67 = p65:FindFirstChild("Status")
    if v67 then
        local v68 = v67:FindFirstChild("Counter-Terrorists")
        local v69 = v67:FindFirstChild("Terrorists")
        if v68 and v69 then
            local v70 = v_u_64(p66, "Counter-Terrorists")
            local v71 = v_u_64(p66, "Terrorists")
            v68.Visible = v70
            v69.Visible = v71
        end
    end
end
local function v_u_73()
    -- failed to decompile
end
local function v_u_92(p74, p75)
    if p74.Type == "Weapon" then
        local v_u_76 = p74.Name
        local v77 = {
            ["Pistol"] = "Pistols",
            ["SMG"] = "Mid Tier",
            ["Heavy"] = "Mid Tier",
            ["Rifle"] = "Rifles"
        }
        local v78, v79 = pcall(v_u_17, v_u_76)
        local v80
        if v78 and (v79 and v79.Type) then
            v80 = v77[v79.Type]
        else
            v80 = nil
        end
        if v80 then
            local v81, v82 = v_u_73(v_u_76, p75, v80)
            if v81 and v82 then
                v_u_18.Inventory.EquipLoadoutSkin.Send({
                    ["Type"] = v80,
                    ["Slot"] = v82 - 1,
                    ["Team"] = p75,
                    ["Identifier"] = p74._id
                })
            else
                v_u_28.openFrame("Loadout")
                local v83 = v_u_10:WaitForChild("PlayerGui"):FindFirstChild("MainGui")
                if v83 then
                    local v84 = v83:FindFirstChild("Menu")
                    if v84 then
                        local v85 = v84:FindFirstChild("Top")
                        if v85 and v85.Buttons then
                            local v86 = v85.Buttons:FindFirstChild("Loadout")
                            if v86 and v86:IsA("TextButton") then
                                local v87 = game:GetService("TweenService")
                                local v88 = Color3.fromRGB(150, 220, 239)
                                local v89 = Color3.fromRGB(255, 255, 255)
                                for _, v90 in ipairs(v85.Buttons:GetChildren()) do
                                    if v90:IsA("TextButton") and v90 ~= v86 then
                                        v87:Create(v90.TextLabel, TweenInfo.new(0.15), {
                                            ["TextColor3"] = v89
                                        }):Play()
                                    end
                                end
                                v87:Create(v86.TextLabel, TweenInfo.new(0.15), {
                                    ["TextColor3"] = v88
                                }):Play()
                            end
                        end
                    end
                end
                local v91 = p75 == "Counter-Terrorists" and "CT" or "T"
                v_u_26.SelectTeam(v91)
                v_u_26.SortByCategory(nil)
                v_u_26.SortByWeapon(v_u_76)
                task.defer(function()
                    v_u_26.SortByWeapon(v_u_76)
                end)
            end
        else
            return
        end
    elseif p74.Type == "Melee" then
        if p74.Name == "CT Knife" then
            if p75 == "Terrorists" then
                return
            end
        elseif p74.Name == "T Knife" and p75 == "Counter-Terrorists" then
            return
        end
        v_u_18.Inventory.EquipSpecialItem.Send({
            ["Identifier"] = p74._id,
            ["Path"] = "Equipped Melee",
            ["Team"] = p75
        })
        return
    elseif p74.Type == "Glove" then
        v_u_18.Inventory.EquipSpecialItem.Send({
            ["Identifier"] = p74._id,
            ["Path"] = "Equipped Gloves",
            ["Team"] = p75
        })
    elseif p74.Type == "Badge" then
        v_u_18.Inventory.EquipSpecialItem.Send({
            ["Identifier"] = p74._id,
            ["Path"] = "Equipped Badge",
            ["Team"] = p75
        })
    end
end
local function v_u_99()
    local v93 = Vector2.new(v_u_11.X, v_u_11.Y)
    if v_u_48.ItemNotification.Visible then
        return true
    end
    local v94 = v_u_48.Tabs.Inventory.Sort.Button.Options
    if v94.Visible then
        local v95 = v94.AbsolutePosition
        local v96 = v94.AbsoluteSize
        if v93.X >= v95.X and (v93.X <= v95.X + v96.X and (v93.Y >= v95.Y and v93.Y <= v95.Y + v96.Y)) then
            return true
        end
    end
    if v_u_47.Visible then
        local v97 = v_u_47.AbsolutePosition
        local v98 = v_u_47.AbsoluteSize
        if v93.X >= v97.X and (v93.X <= v97.X + v98.X and (v93.Y >= v97.Y and v93.Y <= v97.Y + v98.Y)) then
            return true
        end
    end
    return false
end
local function v_u_115(p100)
    local v101 = v_u_48.AbsolutePosition
    local v102 = v_u_48.Hover.AbsoluteSize
    local v103 = p100.AbsolutePosition
    local v104 = v_u_48.AbsoluteSize
    local v105 = p100.AbsoluteSize
    local v106 = v103.X - v101.X
    local v107 = v103.Y - v101.Y
    local v108 = v104.X - (v106 + v105.X) >= v102.X + 8 and (v106 + v105.X + 8 + v102.X / 2) / v104.X or (v106 - 8 - v102.X / 2) / v104.X
    local v109 = (v107 + v105.Y / 2) / v104.Y
    local v110 = v102.Y / 2 / v104.Y
    local v111 = math.max(v109, v110)
    local v112 = 1 - v102.Y / 2 / v104.Y
    local v113 = math.min(v111, v112)
    if v_u_7:GetGuiInset().Y >= v101.Y + v113 * v104.Y - v102.Y / 2 then
        local v114 = v113 + 30 / v104.Y
        v113 = math.min(v114, v112)
    end
    return UDim2.fromScale(v108, v113)
end
local function v_u_121(p116, p117, p118)
    if p118 then
        return p117.imageAssetId or ""
    end
    if p116.Type ~= "Charm" then
        return v_u_15.GetWearImageForFloat(p117, p116.Float or 0.9999) or p117.imageAssetId or ""
    end
    local v119 = p116.Pattern
    if v119 and p117.charmImages then
        for _, v120 in ipairs(p117.charmImages) do
            if v120.pattern == v119 then
                return v120.assetId
            end
        end
    end
    return p117.imageAssetId or ""
end
local function v_u_127(p122)
    if p122.Type ~= "Case" then
        local v123 = v_u_15.GetSkinInformation(p122.Name, p122.Skin)
        return v123 and v123.collection or nil
    end
    local v124 = v_u_16.GetCaseByName(p122.Skin)
    if not (v124 and v_u_40) then
        return nil
    end
    for _, v125 in ipairs(v_u_40) do
        if v125.cases then
            for _, v126 in ipairs(v125.cases) do
                if v126 == v124.name then
                    return v125.name
                end
            end
        end
    end
    return nil
end
local function v_u_136()
    local v128 = v_u_12.Get(v_u_10, "Inventory")
    if not v128 then
        return {}
    end
    local v129 = v_u_41 or (v_u_48.Tabs.Inventory.Sort.Button.Frame.TextLabel.Text or "Newest")
    local v130 = v_u_21.GetSortComparisonFunction(v129, v_u_10, function()
        return v_u_40
    end)
    local v131 = {}
    for _, v132 in ipairs(v128) do
        local v133
        if v132 then
            v133 = v_u_23[v132.Name]
        else
            v133 = v132
        end
        local v134
        if v132 then
            v134 = v132.Type == "Case" and true or v132.Type == "Package"
        else
            v134 = v132
        end
        local v135 = v132 and (v132._id and v132.Name)
        if v135 then
            v135 = v134 or v132.Skin
        end
        if v135 and not v133 then
            table.insert(v131, v132)
        end
    end
    if v130 then
        table.sort(v131, v130)
    end
    return v131
end
local function v_u_148(p137, p138)
    if not p138 or #p138 == 0 then
        return true
    end
    local v139 = v_u_20.GetEffectiveItemType(p137)
    local v140 = v_u_20.IsCapsule(p137)
    for _, v141 in ipairs(p138) do
        if v139 == v141 then
            return true
        end
        if p137.Type and (p137.Type == v141 and not v140) then
            return true
        end
        local v142
        if p137.Name then
            local v143, v144 = pcall(v_u_17, p137.Name)
            v142 = v143 and v144 and v144 or nil
        else
            v142 = nil
        end
        if string.find(v141, ":") then
            local v145 = string.split(v141, ":")
            local v146 = v145[1]
            local v147 = v145[2]
            if v146 == "Weapon" and (v142 and (v142.Class == "Weapon" and v142.Type == v147)) then
                return true
            end
        elseif v142 and v142.Class == v141 then
            return true
        end
    end
    return false
end
local function v_u_165(p149)
    local v150 = nil
    local v151 = nil
    for _, v152 in ipairs(v_u_48.Top.Filter:GetChildren()) do
        if v152:IsA("TextButton") and v152:GetAttribute("Selected") then
            v151 = v152.Name
            break
        end
    end
    for _, v153 in ipairs(v_u_48.Top.Categories:GetChildren()) do
        if v153:IsA("TextButton") and v153:GetAttribute("Selected") then
            v150 = v153.Name
            break
        end
    end
    local v154 = nil
    if v151 and v150 then
        local v155 = v_u_20[v150]
        if v155 and v155[v151] then
            v154 = v155[v151].Search
        end
    end
    local v156 = {}
    local v157 = v_u_12.Get(v_u_10, "Inventory")
    if v157 then
        for _, v158 in ipairs(v157) do
            if v158.Charm then
                local v159 = v158.Charm
                local v160 = type(v159) == "table" and v158.Charm._id
                if not v160 then
                    local v161 = v158.Charm
                    if type(v161) == "string" then
                        v160 = v158.Charm
                    else
                        v160 = false
                    end
                end
                if v160 then
                    v156[v160] = true
                end
            end
        end
    end
    local v162 = {}
    for _, v163 in ipairs(p149) do
        local v164 = v_u_148(v163, v154)
        if v164 and (v163.Type == "Charm" and v156[v163._id]) then
            v164 = false
        end
        if v164 then
            table.insert(v162, v163)
        end
    end
    return v162
end
local function v_u_176()
    if v_u_48 then
        local v166 = v_u_48.Tabs.Inventory.Container
        local v167 = v_u_46 + 1
        local v168 = v_u_46 + 25
        local v169 = #v_u_33
        local v170 = math.min(v168, v169)
        for v171 = v167, v170 do
            local v172 = v_u_33[v171]
            if v172 and not v166:FindFirstChild(v172._id) then
                v_u_1.CreateItemTemplate(v172)
            end
        end
        v_u_46 = v170
        for _, v173 in ipairs(v166:GetChildren()) do
            if v173:IsA("Frame") and (v173.Name ~= "UIGridLayout" and (v173.Name ~= "UIListLayout" and v173.Name ~= "UIPadding")) then
                for v174, v175 in ipairs(v_u_33) do
                    if v175._id == v173.Name then
                        v173.LayoutOrder = v174
                        break
                    end
                end
            end
        end
    end
end
local function v_u_179()
    if v_u_48 then
        local v177 = v_u_48.Tabs.Inventory.Container.CanvasPosition.Y
        local v178 = v_u_48.Tabs.Inventory.Container.AbsoluteCanvasSize.Y - v_u_48.Tabs.Inventory.Container.AbsoluteSize.Y
        if v178 > 0 and (v_u_46 < #v_u_33 and v178 - v177 < 200) then
            v_u_176()
            return
        end
    end
end
local function v_u_206()
    if not (v_u_48 and v_u_48.Visible) then
        return 50
    end
    local v180 = v_u_48.Tabs.Inventory.Container
    local v181 = v180:FindFirstChildOfClass("UIGridLayout")
    if not v181 then
        return 50
    end
    local v182 = v180.AbsoluteSize
    local v183 = v182.Y
    local v184 = v182.X
    local v185 = v181.CellSize
    local v186 = v181.CellPadding
    local v187 = v185.Y.Scale * v183 + v185.Y.Offset
    local v188 = v186.Y.Scale * v183 + v186.Y.Offset
    local v189 = v185.X.Scale * v184 + v185.X.Offset
    local v190 = v186.X.Scale * v184 + v186.X.Offset
    local v191 = v180:FindFirstChildOfClass("UIPadding")
    local v192, v193, v194, v195
    if v191 then
        v192 = v191.PaddingTop.Scale * v183 + v191.PaddingTop.Offset
        v193 = v191.PaddingBottom.Scale * v183 + v191.PaddingBottom.Offset
        v194 = v191.PaddingLeft.Scale * v184 + v191.PaddingLeft.Offset
        v195 = v191.PaddingRight.Scale * v184 + v191.PaddingRight.Offset
    else
        v192 = 0
        v193 = 0
        v194 = 0
        v195 = 0
    end
    local v196 = v183 - v192 - v193
    local v197 = v184 - v194 - v195
    local v198 = v189 + v190
    local v199
    if v198 > 0 then
        local v200 = (v197 + v190) / v198
        local v201 = math.floor(v200)
        v199 = math.max(1, v201)
    else
        v199 = 1
    end
    local v202 = v187 + v188
    local v203
    if v202 > 0 then
        local v204 = (v196 + v188) / v202
        local v205 = math.floor(v204)
        v203 = math.max(1, v205)
    else
        v203 = 1
    end
    return v203 * v199 + v199
end
local function v_u_217()
    if not (v_u_48 and v_u_48.Visible) then
        return
    end
    local v207 = v_u_48.Tabs.Inventory.Container
    v_u_46 = 0
    local v208 = v_u_206()
    local v209 = math.max(v208, 50)
    local v210 = #v_u_33
    local v211 = math.min(v209, v210)
    for v212 = 1, v211 do
        local v213 = v_u_33[v212]
        if v213 and not v207:FindFirstChild(v213._id) then
            v_u_1.CreateItemTemplate(v213)
        end
    end
    for _, v214 in ipairs(v207:GetChildren()) do
        if v214:IsA("Frame") and (v214.Name ~= "UIGridLayout" and (v214.Name ~= "UIListLayout" and v214.Name ~= "UIPadding")) then
            for v215, v216 in ipairs(v_u_33) do
                if v216._id == v214.Name then
                    v214.LayoutOrder = v215
                    break
                end
            end
        end
    end
    v_u_46 = v211
    v_u_42 = false
end
local function v_u_222()
    if v_u_48 then
        local v218 = v_u_48.Tabs.Inventory.Container
        local v219 = {}
        for _, v220 in ipairs(v_u_33) do
            if v220 and v220._id then
                v219[v220._id] = true
            end
        end
        for _, v221 in ipairs(v218:GetChildren()) do
            if v221:IsA("Frame") and (v221.Name ~= "UIGridLayout" and (v221.Name ~= "UIListLayout" and (v221.Name ~= "UIPadding" and (v221.Name ~= "Title" and (v221.Name ~= "Label" and not v219[v221.Name]))))) then
                v221:Destroy()
            end
        end
        v_u_46 = 0
        v_u_42 = true
        if v_u_48.Visible then
            v_u_217()
        end
    end
end
local function v_u_230(p_u_223, p_u_224, p_u_225, p_u_226, _)
    p_u_224.MouseEnter:Connect(function()
        v_u_3:Create(p_u_224, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            ["BackgroundTransparency"] = 0.85
        }):Play()
    end)
    p_u_224.MouseLeave:Connect(function()
        v_u_3:Create(p_u_224, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            ["BackgroundTransparency"] = 1
        }):Play()
    end)
    p_u_224.Selectable = true
    local function v_u_228()
        v_u_19.broadcastRouter("RunInterfaceSound", "UI Click")
        if v_u_47 then
            v_u_47.Visible = false
        end
        v_u_41 = p_u_225
        if v_u_48 then
            if v_u_48.Visible then
                v_u_33 = v_u_136()
                v_u_33 = v_u_165(v_u_33)
                v_u_222()
            else
                v_u_43 = true
                v_u_42 = true
            end
        end
        p_u_226.Text = p_u_225
        for _, v227 in ipairs(p_u_223:GetChildren()) do
            if v227:IsA("TextButton") then
                v227.Frame.BackgroundTransparency = v227 == p_u_224 and 0 or 1
            end
        end
        p_u_223.Visible = false
    end
    p_u_224.MouseButton1Click:Connect(v_u_228)
    p_u_224.Activated:Connect(function(p229)
        if p229 and p229.UserInputType == Enum.UserInputType.Gamepad1 then
            v_u_228()
        end
    end)
end
local function v_u_255(p_u_231)
    local v_u_232 = p_u_231:FindFirstChild("HoverFrame")
    local v_u_233 = p_u_231.Size
    p_u_231.MouseEnter:Connect(function()
        local v234 = v_u_3
        local v235 = p_u_231
        local v236 = TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
        local v237 = {}
        local v238 = v_u_233
        v237.Size = UDim2.new(v238.X.Scale * 0.95, v238.X.Offset, v238.Y.Scale * 0.95, v238.Y.Offset)
        v234:Create(v235, v236, v237):Play()
        if v_u_232 and not p_u_231:GetAttribute("Selected") then
            v_u_232.BackgroundTransparency = 1
            v_u_232.Visible = true
            v_u_3:Create(v_u_232, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                ["BackgroundTransparency"] = 0.85
            }):Play()
        end
    end)
    p_u_231.MouseLeave:Connect(function()
        local v239 = v_u_3
        local v240 = p_u_231
        local v241 = TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
        local v242 = {}
        local v243 = v_u_233
        v242.Size = UDim2.new(v243.X.Scale * 1, v243.X.Offset, v243.Y.Scale * 1, v243.Y.Offset)
        v239:Create(v240, v241, v242):Play()
        if v_u_232 and not p_u_231:GetAttribute("Selected") then
            local v244 = v_u_3:Create(v_u_232, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                ["BackgroundTransparency"] = 1
            })
            v244:Play()
            v244.Completed:Once(function()
                v_u_232.Visible = false
            end)
        end
    end)
    p_u_231.MouseButton1Down:Connect(function()
        local v245 = v_u_3
        local v246 = p_u_231
        local v247 = TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
        local v248 = {}
        local v249 = v_u_233
        v248.Size = UDim2.new(v249.X.Scale * 0.9, v249.X.Offset, v249.Y.Scale * 0.9, v249.Y.Offset)
        v245:Create(v246, v247, v248):Play()
    end)
    p_u_231.MouseButton1Up:Connect(function()
        local v250 = v_u_3
        local v251 = p_u_231
        local v252 = TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
        local v253 = {}
        local v254 = v_u_233
        v253.Size = UDim2.new(v254.X.Scale * 0.95, v254.X.Offset, v254.Y.Scale * 0.95, v254.Y.Offset)
        v250:Create(v251, v252, v253):Play()
    end)
end
function v_u_1.CreateItemTemplate(p_u_256)
    if p_u_256 and p_u_256._id then
        local v257 = p_u_256.Type == "Case" and true or p_u_256.Type == "Package"
        local v258 = v257 and v_u_16.GetCaseByName(p_u_256.Skin) or v_u_15.GetSkinInformation(p_u_256.Name, p_u_256.Skin)
        if v258 then
            local v259 = v_u_22[v257 and v258.caseRarity or v258.rarity]
            local v260 = v_u_121(p_u_256, v258, v257)
            local v_u_261 = v_u_2.Assets.UI.Inventory.ItemTemplate:Clone()
            v_u_261.Main.RarityFrame.UIGradient.Color = v259.ColorSequence
            v_u_261.Main.Glow.UIGradient.Color = v259.ColorSequence
            v_u_261.Parent = v_u_48.Tabs.Inventory.Container
            v_u_261.Main.Icon.Image = v260
            v_u_261.Name = p_u_256._id
            local v262 = v257 and v258.caseType and v_u_51[v258.caseType] or v257 and v258.caseType or (p_u_256.StatTrack and "KillTrak\226\132\162 " .. p_u_256.Name or p_u_256.Name)
            local v263 = v257 and v258.skin or (p_u_256.Skin or "")
            if p_u_256.Type == "Melee" then
                v262 = "\226\152\133 " .. v262
            end
            v_u_261.Information.Weapon.Text = v262
            v_u_261.Information.Skin.Text = v263
            v_u_72(v_u_261, p_u_256._id)
            v_u_261.Button.Selectable = true
            local function v_u_278(p_u_264)
                if v_u_48.ItemNotification.Visible or v_u_99() then
                    return
                end
                local v265 = v_u_12.Get(v_u_10, "Inventory")
                if v265 then
                    for _, v266 in ipairs(v265) do
                        if v266._id == p_u_256._id then
                            p_u_256 = v266
                            break
                        end
                    end
                end
                local v267 = p_u_256.Type == "Case" and true or p_u_256.Type == "Package"
                local v268 = p_u_256.Type == "Charm Capsule" and true or p_u_256.Type == "Sticker Capsule"
                v_u_19.broadcastRouter("RunInterfaceSound", "UI Click")
                v_u_35 = p_u_256
                local function v277()
                    local v269 = v_u_47.Parent
                    local v270 = v269.AbsolutePosition
                    local v271 = v269.AbsoluteSize
                    local v272, v273
                    if v_u_8:GetLastInputType() == Enum.UserInputType.Gamepad1 or p_u_264 then
                        v272 = 0.5
                        v273 = 0.5
                    else
                        local v274 = v_u_11.X
                        local v275 = v_u_11.Y
                        local v276 = (v274 - v270.X) / v271.X
                        v273 = (v275 - v270.Y) / v271.Y + v_u_47.Size.Y.Scale / 2
                        if 1 - v276 >= v_u_47.Size.X.Scale + 0.01 then
                            v272 = v276 + v_u_47.Size.X.Scale / 2 + 0.01
                        else
                            v272 = v276 - v_u_47.Size.X.Scale / 2 - 0.01
                        end
                    end
                    v_u_47.Position = UDim2.fromScale(v272, v273)
                end
                if v267 or v268 then
                    v_u_1.SetupInformationFrame(p_u_256)
                    v_u_47.Visible = true
                    v277()
                    v_u_48.Hover.Visible = false
                    if p_u_264 then
                        task.defer(function()
                            v_u_1.SetupInformationFrameNavigation()
                            v_u_1.SelectFirstInformationFrameButton()
                        end)
                    end
                else
                    if p_u_264 then
                        v_u_47.Visible = true
                    else
                        v_u_47.Visible = not v_u_47.Visible
                    end
                    if v_u_47.Visible then
                        v277()
                        v_u_48.Hover.Visible = false
                        task.defer(function()
                            v_u_1.SetupInformationFrameNavigation()
                            if p_u_264 then
                                v_u_1.SelectFirstInformationFrameButton()
                            end
                        end)
                    elseif v_u_37 then
                        v_u_45 = tick()
                    end
                    v_u_1.SetupInformationFrame(p_u_256)
                end
            end
            v_u_261.Button.MouseButton1Click:Connect(function()
                v_u_278(false)
            end)
            v_u_261.Button.Activated:Connect(function(p279)
                if p279 and p279.UserInputType == Enum.UserInputType.Gamepad1 then
                    v_u_278(true)
                end
            end)
            if v_u_34 then
                v_u_261.MouseEnter:Connect(function()
                    v_u_36 = p_u_256
                    v_u_37 = v_u_261
                    v_u_45 = tick()
                end)
                v_u_261.MouseLeave:Connect(function()
                    v_u_37 = nil
                    v_u_36 = nil
                    v_u_45 = nil
                end)
            end
        else
            print((("[Inventory] Skipping template creation for item: %* | %* (Type: %*) - No item information found"):format(p_u_256.Name, p_u_256.Skin, p_u_256.Type)))
        end
    else
        return
    end
end
function v_u_1.UpdateInventoryFilter()
    if v_u_48 then
        if v_u_48.Visible then
            v_u_33 = v_u_136()
            v_u_33 = v_u_165(v_u_33)
            v_u_222()
        else
            v_u_43 = true
            v_u_42 = true
        end
    else
        return
    end
end
function v_u_1.UpdateInventory(p280)
    if v_u_48 then
        if p280 and type(p280) == "table" then
            if v_u_48.Visible then
                local v281 = v_u_48.Tabs.Inventory.Container
                local v282 = {}
                for _, v283 in ipairs(p280) do
                    if v283 and v283._id then
                        v282[v283._id] = true
                    end
                end
                for _, v284 in ipairs(v281:GetChildren()) do
                    if v284:IsA("Frame") and (v284.Name ~= "UIGridLayout" and (v284.Name ~= "UIListLayout" and (v284.Name ~= "UIPadding" and (v284.Name ~= "Title" and (v284.Name ~= "Label" and not v282[v284.Name]))))) then
                        v284:Destroy()
                    end
                end
                if v_u_48 then
                    if v_u_48.Visible then
                        v_u_33 = v_u_136()
                        v_u_33 = v_u_165(v_u_33)
                        v_u_222()
                    else
                        v_u_43 = true
                        v_u_42 = true
                    end
                else
                    return
                end
            else
                v_u_43 = true
                v_u_42 = true
                return
            end
        else
            print("UpdateInventory received invalid inventory data:", p280)
            return
        end
    else
        return
    end
end
function v_u_1.UpdateTemplates(p285)
    if v_u_48 and v_u_48.Visible then
        local v286 = v_u_48.Tabs.Inventory.Container
        if p285 then
            for _, v287 in ipairs(p285) do
                local v288 = v286:FindFirstChild(v287._id)
                if v288 and v288:IsA("Frame") then
                    local v289 = v_u_15.GetSkinInformation(v287.Name, v287.Skin)
                    if v289 then
                        v288.Main.RarityFrame.UIGradient.Color = v_u_22[v289.rarity].ColorSequence
                        v288.Main.Glow.UIGradient.Color = v_u_22[v289.rarity].ColorSequence
                        v288.Main.Icon.Image = v_u_121(v287, v289, false)
                    end
                    v_u_72(v288, v287._id)
                end
            end
        end
    end
end
function v_u_1.SetupInformationFrameNavigation()
    if v_u_47 then
        local v290 = {}
        if v_u_47.Charm and v_u_47.Charm.Visible then
            local v291 = {
                ["button"] = v_u_47.Charm,
                ["order"] = v_u_47.Charm.LayoutOrder
            }
            table.insert(v290, v291)
        end
        if v_u_47.Inspect and v_u_47.Inspect.Visible then
            local v292 = {
                ["button"] = v_u_47.Inspect,
                ["order"] = v_u_47.Inspect.LayoutOrder
            }
            table.insert(v290, v292)
        end
        if v_u_47.ReplaceCT and v_u_47.ReplaceCT.Visible then
            local v293 = {
                ["button"] = v_u_47.ReplaceCT,
                ["order"] = v_u_47.ReplaceCT.LayoutOrder
            }
            table.insert(v290, v293)
        end
        if v_u_47.ReplaceT and v_u_47.ReplaceT.Visible then
            local v294 = {
                ["button"] = v_u_47.ReplaceT,
                ["order"] = v_u_47.ReplaceT.LayoutOrder
            }
            table.insert(v290, v294)
        end
        if v_u_47.Unlock and v_u_47.Unlock.Visible then
            local v295 = {
                ["button"] = v_u_47.Unlock,
                ["order"] = v_u_47.Unlock.LayoutOrder
            }
            table.insert(v290, v295)
        end
        local v296 = v_u_47:FindFirstChild("QuickUnlock")
        if v296 and v296.Visible then
            local v297 = {
                ["button"] = v296,
                ["order"] = v296.LayoutOrder
            }
            table.insert(v290, v297)
        end
        table.sort(v290, function(p298, p299)
            return p298.order < p299.order
        end)
        local v300 = {}
        for _, v301 in ipairs(v290) do
            local v302 = v301.button
            table.insert(v300, v302)
        end
        for v303, v304 in ipairs(v300) do
            v304.NextSelectionUp = v300[v303 > 1 and v303 - 1 or #v300]
            v304.NextSelectionDown = v300[v303 < #v300 and v303 + 1 or 1]
            v304.NextSelectionLeft = nil
            v304.NextSelectionRight = nil
        end
    end
end
function v_u_1.SetupItemNotificationNavigation()
    if v_u_48 and v_u_48.ItemNotification then
        local v305 = v_u_48.ItemNotification.Holder
        local v306 = {}
        if v305.ViewLoadout and v305.ViewLoadout.Visible then
            local v307 = {
                ["button"] = v305.ViewLoadout,
                ["order"] = v305.ViewLoadout.LayoutOrder or 1
            }
            table.insert(v306, v307)
        end
        if v305.Continue and v305.Continue.Visible then
            local v308 = {
                ["button"] = v305.Continue,
                ["order"] = v305.Continue.LayoutOrder or 2
            }
            table.insert(v306, v308)
        end
        if #v306 ~= 0 then
            table.sort(v306, function(p309, p310)
                return p309.order < p310.order
            end)
            for v311, v312 in ipairs(v306) do
                local v313 = v312.button
                v313.NextSelectionUp = v306[v311 > 1 and v311 - 1 or #v306].button
                v313.NextSelectionDown = v306[v311 < #v306 and v311 + 1 or 1].button
                v313.NextSelectionLeft = nil
                v313.NextSelectionRight = nil
            end
        end
    else
        return
    end
end
function v_u_1.SelectFirstItemNotificationButton()
    if v_u_8.GamepadEnabled then
        if v_u_48 and (v_u_48.ItemNotification and v_u_48.ItemNotification.Visible) then
            local v314 = v_u_48.ItemNotification.Holder
            if v314.ViewLoadout and (v314.ViewLoadout.Visible and v314.ViewLoadout.Selectable) then
                v_u_7.SelectedObject = v314.ViewLoadout
            elseif v314.Continue and (v314.Continue.Visible and v314.Continue.Selectable) then
                v_u_7.SelectedObject = v314.Continue
            end
        else
            return
        end
    else
        return
    end
end
function v_u_1.SelectFirstInformationFrameButton()
    if v_u_47 and v_u_47.Visible then
        v_u_1.SetupInformationFrameNavigation()
        if v_u_47.Charm and v_u_47.Charm.Visible then
            v_u_7.SelectedObject = v_u_47.Charm
            return
        elseif v_u_47.Inspect and v_u_47.Inspect.Visible then
            v_u_7.SelectedObject = v_u_47.Inspect
            return
        elseif v_u_47.ReplaceCT and v_u_47.ReplaceCT.Visible then
            v_u_7.SelectedObject = v_u_47.ReplaceCT
            return
        elseif v_u_47.ReplaceT and v_u_47.ReplaceT.Visible then
            v_u_7.SelectedObject = v_u_47.ReplaceT
            return
        elseif v_u_47.Unlock and v_u_47.Unlock.Visible then
            v_u_7.SelectedObject = v_u_47.Unlock
        else
            local v315 = v_u_47:FindFirstChild("QuickUnlock")
            if v315 and v315.Visible then
                v_u_7.SelectedObject = v315
            end
        end
    else
        return
    end
end
function v_u_1.SetupInformationFrame(p316)
    v_u_47.Inspect.Visible = (p316.Type == "Weapon" or (p316.Type == "Glove" or p316.Type == "Melee")) and true or p316.Type == "Charm"
    v_u_47.Unlock.Visible = p316.Type == "Case" and true or p316.Type == "Package"
    v_u_47.Loadout.Visible = false
    local v317 = v_u_47:FindFirstChild("QuickUnlock")
    local v318 = v_u_47:FindFirstChild("UnlockDivider")
    if v317 then
        v317.Visible = p316.Type == "Case" and true or p316.Type == "Package"
        if v318 then
            local v319 = v_u_47.Unlock.Visible
            if v319 then
                v319 = v317.Visible
            end
            v318.Visible = v319
        end
    end
    local v320 = p316.Type == "Weapon" and true or p316.Type == "Charm"
    if not v_u_47.Charm then
        warn("[Inventory] InformationFrame.Charm element not found - item type:", p316.Type)
    end
    if v_u_47.Charm then
        v_u_47.Charm.Visible = v320
        local v321 = v320 and v_u_47.Charm:FindFirstChild("TextLabel")
        if v321 then
            if p316.Type == "Charm" then
                v321.Text = "Attach to Weapon"
            else
                local v322
                if p316.Charm == nil or p316.Charm == false then
                    v322 = false
                else
                    local v323 = p316.Charm
                    if type(v323) == "string" or p316.Charm == true then
                        v322 = true
                    else
                        local v324 = p316.Charm
                        v322 = type(v324) == "table"
                    end
                end
                if v322 then
                    v321.Text = "Detach Charm"
                else
                    v321.Text = "Attach Charm"
                end
            end
        end
    end
    local v325 = p316.Type == "Weapon"
    local v326 = p316.Type == "Melee"
    local v327 = p316.Type == "Glove"
    local v328 = p316.Type == "Badge"
    local v329 = false
    local v330 = false
    if v325 then
        local v331, v332 = pcall(v_u_17, p316.Name)
        if v331 and (v332 and v332.Team) then
            if v332.Team == "Both" then
                v329 = true
                v330 = true
            elseif v332.Team == "Counter-Terrorists" then
                v329 = true
            elseif v332.Team == "Terrorists" then
                v330 = true
            end
        end
    elseif v326 then
        if p316.Name == "CT Knife" then
            v329 = true
            v330 = false
        elseif p316.Name == "T Knife" then
            v329 = false
            v330 = true
        else
            v329 = true
            v330 = true
        end
    elseif v327 then
        local v333, v334 = pcall(v_u_17, p316.Name)
        if v333 and (v334 and v334.Team) then
            if v334.Team == "Both" then
                v329 = true
                v330 = true
            elseif v334.Team == "Counter-Terrorists" then
                v329 = true
            elseif v334.Team == "Terrorists" then
                v330 = true
            end
        end
    elseif v328 then
        v329 = true
        v330 = true
    end
    local v335 = v_u_64(p316._id, "Counter-Terrorists")
    local v336 = v_u_64(p316._id, "Terrorists")
    local v337 = v325 or (v326 or (v327 or v328))
    if v_u_47.ReplaceCT then
        local v338 = v_u_47.ReplaceCT
        if v337 then
            if v329 then
                v329 = not v335
            end
        else
            v329 = v337
        end
        v338.Visible = v329
    end
    if v_u_47.ReplaceT then
        local v339 = v_u_47.ReplaceT
        if v337 then
            if v330 then
                v330 = not v336
            end
        else
            v330 = v337
        end
        v339.Visible = v330
    end
    local v340 = {
        {
            ["dividerName"] = "CharmDivider",
            ["action"] = v_u_47.Charm
        },
        {
            ["dividerName"] = "InspectDivider",
            ["action"] = v_u_47.Inspect
        },
        {
            ["dividerName"] = "ReplaceCTDivider",
            ["action"] = v_u_47.ReplaceCT
        },
        {
            ["dividerName"] = "ReplaceTDivider",
            ["action"] = v_u_47.ReplaceT
        },
        {
            ["dividerName"] = "LoadoutDivider",
            ["action"] = v_u_47.Loadout
        }
    }
    local v341 = { "UnlockDivider" }
    for _, v342 in ipairs(v340) do
        local v343 = v342.dividerName
        table.insert(v341, v343)
    end
    for _, v344 in ipairs(v340) do
        local v345 = v_u_47:FindFirstChild(v344.dividerName)
        if v345 and v344.action then
            if v344.action.Visible then
                local v346 = v345.LayoutOrder
                local v347 = false
                for _, v348 in ipairs(v_u_47:GetChildren()) do
                    local v349 = false
                    for _, v350 in ipairs(v341) do
                        if v348.Name == v350 then
                            v349 = true
                            break
                        end
                    end
                    if not v349 and (v348 ~= v345 and (v348 ~= v344.action and (v348:IsA("Frame") or v348:IsA("TextButton")))) and (v348.LayoutOrder < v346 and v348.Visible) then
                        v347 = true
                    end
                end
                v345.Visible = v347
            else
                v345.Visible = false
            end
        end
    end
end
function v_u_1.SelectOption(p351, p352)
    if v_u_47 then
        v_u_47.Visible = false
    end
    p351.HoverFrame.BackgroundTransparency = 0
    p351.HoverFrame.Visible = true
    for _, v353 in ipairs(v_u_48.Top.Filter:GetChildren()) do
        if v353:IsA("TextButton") then
            v353.HoverFrame.Visible = v353.Name == p352
            v353.HoverFrame.BackgroundColor3 = v_u_31
            v353.TextLabel.TextColor3 = v_u_31
            v353:SetAttribute("Selected", nil)
            if v353.HoverFrame.Visible then
                v353.HoverFrame.BackgroundColor3 = v_u_30
                v353.TextLabel.TextColor3 = v_u_32
                v353:SetAttribute("Selected", true)
            end
        end
    end
    v_u_1.UpdateInventoryFilter()
end
function v_u_1.ShowNewItemNotification(p354)
    v_u_44 = false
    local v355 = false
    local v356 = 0
    for v357, v358 in ipairs(v_u_50) do
        if v358._id == p354._id then
            v356 = v357
            v355 = true
            break
        end
    end
    if not v355 then
        local v359 = v_u_50
        table.insert(v359, p354)
        v356 = #v_u_50
    end
    v_u_48.Visible = true
    v_u_1.NextInventoryItem(v356)
end
function v_u_1.NextInventoryItem(p360)
    local v361 = v_u_50[p360]
    v_u_38 = p360
    if v361 then
        local v362 = v361.Type == "Case" and true or v361.Type == "Package"
        local v363 = v362 and v_u_16.GetCaseByName(v361.Skin) or v_u_15.GetSkinInformation(v361.Name, v361.Skin)
        local v364 = v_u_22[v362 and v363.caseRarity or v363.rarity]
        local v365 = v362 and v363.Skin or ("%* | %*"):format(v361.Name, v361.Skin)
        local v366 = v_u_121(v361, v363, v362)
        local v367 = v_u_48.ItemNotification.Holder.ViewLoadout
        local v368
        if v361.Type == "Case" then
            v368 = false
        else
            v368 = v361.Type ~= "Package"
        end
        v367.Visible = v368
        v_u_48.ItemNotification.Holder.RarityFrame.UIGradient.Color = v364.ColorSequence
        v_u_48.ItemNotification.Holder.Background.ImageColor3 = v364.Color
        v_u_48.ItemNotification.Holder.IconShadow.Image = v366
        v_u_48.ItemNotification.Holder.Light.ImageColor3 = v364.Color
        v_u_48.ItemNotification.Holder.WeaponName.Text = v365
        v_u_48.ItemNotification.Holder.Icon.Image = v366
        v_u_48.ItemNotification.Visible = true
        v_u_48.ItemNotification.Holder.Title.TextColor3 = Color3.new(v364.Color.R * 0.56, v364.Color.G * 0.56, v364.Color.B * 0.56)
        task.defer(function()
            v_u_1.SetupItemNotificationNavigation()
            v_u_1.SelectFirstItemNotificationButton()
        end)
    end
end
function v_u_1.SelectCategory(p369)
    if v_u_47 then
        v_u_47.Visible = false
    end
    local v370 = v_u_20[p369]
    if v370 then
        v_u_56(v_u_48.Top.Filter, "TextButton")
        for _, v371 in ipairs(v_u_48.Top.Categories:GetChildren()) do
            if v371:IsA("TextButton") and v371:GetAttribute("IsCategoryButton") then
                v371.HoverFrame.Visible = v371.Name == p369
                v371.HoverFrame.BackgroundColor3 = v_u_31
                v371.TextLabel.TextColor3 = v_u_31
                v371:SetAttribute("Selected", nil)
                if v371.HoverFrame.Visible then
                    v371.HoverFrame.BackgroundColor3 = v_u_30
                    v371.TextLabel.TextColor3 = v_u_32
                    v371:SetAttribute("Selected", true)
                end
            end
        end
        for v_u_372, v373 in pairs(v370) do
            local v_u_374 = v_u_2.Assets.UI.Inventory.OptionTemplate:Clone()
            v_u_374.HoverFrame.BackgroundColor3 = v_u_31
            v_u_374.TextLabel.TextColor3 = v_u_31
            v_u_374.LayoutOrder = v373.LayoutOrder
            v_u_374.Parent = v_u_48.Top.Filter
            v_u_374.Visible = v_u_372 ~= "Default"
            v_u_374.TextLabel.Text = v_u_372
            v_u_374.HoverFrame.Visible = false
            v_u_374.Name = v_u_372
            local v375 = v_u_4:GetTextSize(v_u_372, v_u_374.TextLabel.TextSize, v_u_374.TextLabel.Font, Vector2.new((1 / 0), (1 / 0))).X + 16
            v_u_374.Size = UDim2.new(0, v375, v_u_374.Size.Y.Scale, v_u_374.Size.Y.Offset)
            if v373.LayoutOrder == 0 then
                v_u_1.SelectOption(v_u_374, v_u_372)
            end
            v_u_255(v_u_374)
            v_u_374.Selectable = true
            local function v376()
                v_u_1.SelectOption(v_u_374, v_u_372)
                v_u_19.broadcastRouter("RunInterfaceSound", "UI Click")
            end
            v_u_374.MouseButton1Click:Connect(v376)
            v_u_374.Activated:Connect(function(p377)
                if p377 and p377.UserInputType == Enum.UserInputType.Gamepad1 then
                    v_u_1.SelectOption(v_u_374, v_u_372)
                    v_u_19.broadcastRouter("RunInterfaceSound", "UI Click")
                end
            end)
        end
    else
        warn((("[Inventory] Category \"%*\" not found in InventoryButtons"):format(p369)))
    end
end
function v_u_1.SetupCategoryButton(p_u_378)
    v_u_255(p_u_378)
    p_u_378.Selectable = true
    local function v381()
        local v379 = v_u_1.SelectCategory
        local v380 = p_u_378.Name
        v379((tostring(v380)))
        v_u_19.broadcastRouter("RunInterfaceSound", "UI Click")
    end
    p_u_378.MouseButton1Click:Connect(v381)
    p_u_378.Activated:Connect(function(p382)
        if p382 and p382.UserInputType == Enum.UserInputType.Gamepad1 then
            local v383 = v_u_1.SelectCategory
            local v384 = p_u_378.Name
            v383((tostring(v384)))
            v_u_19.broadcastRouter("RunInterfaceSound", "UI Click")
        end
    end)
end
function v_u_1.UpdateHoverFrame(_)
    local v385 = tick() - (v_u_45 or 0)
    local v386 = v_u_99()
    if v_u_48.Visible and (not v386 and (not v_u_47.Visible and (v_u_37 and (v_u_36 and v385 > 0.75)))) then
        v_u_48.Hover.Position = v_u_115(v_u_37)
        local v387 = v_u_36
        local v388 = v387.Type == "Case" and true or v387.Type == "Package"
        local v389 = v388 and v_u_16.GetCaseByName(v387.Skin) or v_u_15.GetSkinInformation(v387.Name, v387.Skin)
        if v389 then
            local v390 = v388 and v389.caseType and v_u_51[v389.caseType] or v388 and v389.caseType or (v387.StatTrack and "KillTrak\226\132\162 " .. v387.Name or v387.Name)
            local v391 = v388 and v389.skin or v387.Skin
            local v392 = v391 == "Vanilla" and "" or (" | " .. v391 or "")
            local v393 = (v387.Type == "Melee" and "\226\152\133 " or "") .. v390
            v_u_48.Hover.ItemName.Frame.ItemName.Text = v393 .. v392
            local v394 = v_u_127(v387)
            v_u_48.Hover.ItemName.Frame.Collection.Text = v394 or ""
            local v395 = v_u_48.Hover.ItemName.CollectionIcon
            if v394 then
                local v396 = v_u_13.GetCollectionByName(v394)
                if v396 and v396.imageAssetId then
                    v395.Image = v396.imageAssetId
                    v395.Visible = true
                else
                    v395.Visible = false
                end
            else
                v395.Visible = false
            end
            local v397 = v_u_48.Hover:FindFirstChild("CollectionName")
            if v397 then
                if v394 then
                    v397.Text = v394 .. ":"
                    v397.Visible = true
                else
                    v397.Visible = false
                end
            end
            if v394 and not v388 then
                local v398 = v_u_13.GetCollectionByName(v394)
                if v398 and v398.items then
                    local v399 = v_u_48.Hover.Collection
                    local v400 = v_u_12.Get(v_u_10, "Inventory")
                    for _, v401 in ipairs(v399:GetChildren()) do
                        if v401:IsA("Frame") and v401.Name ~= "UIListLayout" then
                            v401:Destroy()
                        end
                    end
                    local v402 = {}
                    if v400 then
                        for _, v403 in ipairs(v400) do
                            if v403.Name and v403.Skin then
                                v402[v403.Name .. "|" .. v403.Skin] = true
                            end
                        end
                    end
                    local v404 = {
                        ["Blue"] = 1,
                        ["Purple"] = 2,
                        ["Pink"] = 3,
                        ["Red"] = 4,
                        ["Special"] = 5,
                        ["Forbidden"] = 6,
                        ["Stock"] = 7
                    }
                    local v405 = {}
                    for _, v406 in ipairs(v398.items) do
                        if v406.itemName and v406.skinName then
                            local v407 = v_u_15.GetSkinInformation(v406.itemName, v406.skinName)
                            if v407 then
                                local v408 = {
                                    ["item"] = v406,
                                    ["rarity"] = v407.rarity,
                                    ["rarityOrder"] = v404[v407.rarity] or 99
                                }
                                table.insert(v405, v408)
                            end
                        end
                    end
                    table.sort(v405, function(p409, p410)
                        if p409.rarityOrder == p410.rarityOrder then
                            return p409.item.itemName < p410.item.itemName
                        else
                            return p409.rarityOrder < p410.rarityOrder
                        end
                    end)
                    local v411 = v_u_2.Assets.UI.Inventory.CollectionNameTemplate
                    for v412, v413 in ipairs(v405) do
                        local v414 = v413.item
                        local v415 = v_u_15.GetSkinInformation(v414.itemName, v414.skinName)
                        if v415 and v411 then
                            local v416 = v411:Clone()
                            v416.Parent = v399
                            v416.LayoutOrder = v412
                            v416.Visible = true
                            local v417 = v416:FindFirstChild("CollectionName") or v416:FindFirstChild("gun")
                            if v417 then
                                v417.Text = "[" .. v414.itemName .. "] | " .. v414.skinName
                                local v418 = v415.rarity
                                if v418 then
                                    v418 = v_u_22[v415.rarity]
                                end
                                if v418 then
                                    v417.TextColor3 = v418.Color
                                end
                                v417.Visible = true
                            end
                            local v419 = v416:FindFirstChild("ImageLabel")
                            if v419 then
                                v419.Visible = v402[v414.itemName .. "|" .. v414.skinName] == true
                            end
                        end
                    end
                    if v397 then
                        v397.Visible = true
                    end
                    v399.Visible = true
                    local v420 = v_u_48.Hover:FindFirstChild("CollectionSpacer")
                    if v420 then
                        v420.Visible = true
                    end
                else
                    local v421 = v_u_48.Hover.Collection
                    if v421 then
                        for _, v422 in ipairs(v421:GetChildren()) do
                            if v422:IsA("Frame") and v422.Name ~= "UIListLayout" then
                                v422:Destroy()
                            end
                        end
                        v421.Visible = false
                    end
                    local v423 = v_u_48.Hover:FindFirstChild("CollectionName")
                    if v423 then
                        v423.Visible = false
                    end
                    local v424 = v_u_48.Hover:FindFirstChild("CollectionSpacer")
                    if v424 then
                        v424.Visible = false
                    end
                end
            else
                local v425 = v_u_48.Hover.Collection
                if v425 then
                    for _, v426 in ipairs(v425:GetChildren()) do
                        if v426:IsA("Frame") and v426.Name ~= "UIListLayout" then
                            v426:Destroy()
                        end
                    end
                    v425.Visible = false
                end
                local v427 = v_u_48.Hover:FindFirstChild("CollectionName")
                if v427 then
                    v427.Visible = false
                end
                local v428 = v_u_48.Hover:FindFirstChild("CollectionSpacer")
                if v428 then
                    v428.Visible = false
                end
            end
            if v388 or v387.Type ~= "Weapon" and (v387.Type ~= "Melee" and v387.Type ~= "Glove") then
                if v388 then
                    if v389.description then
                        v_u_48.Hover.Description.Text = v389.description
                    else
                        v_u_48.Hover.Description.Text = ""
                    end
                elseif v389.description then
                    v_u_48.Hover.Description.Text = v389.description
                else
                    v_u_48.Hover.Description.Text = ""
                end
            else
                local v429 = v387.Name
                local v430 = v387.Type == "Melee" and "T Knife" or (v387.Type == "Glove" and "T Glove" or v429)
                local v431 = v_u_15.GetSkinInformation(v430, "Stock")
                if v431 and v431.description then
                    v_u_48.Hover.Description.Text = v431.description
                else
                    v_u_48.Hover.Description.Text = ""
                end
            end
            if v388 or (v387.Type == "Charm Capsule" and true or v387.Type == "Sticker Capsule") then
                v_u_48.Hover.Information.Visible = false
            else
                v_u_48.Hover.Information.Visible = true
            end
            local v432 = v388 and v389.caseRarity or v389.rarity
            if v432 then
                local v433 = v_u_22[v432]
                if v433 then
                    local v434 = ({
                        ["Blue"] = "Blue",
                        ["Purple"] = "Purple",
                        ["Pink"] = "Pink",
                        ["Red"] = "Red",
                        ["Special"] = "\226\152\133 Special",
                        ["Forbidden"] = "\226\152\133 Special"
                    })[v432] or v432
                    v_u_48.Hover.Information.Rarity.Label.Text = v434
                    v_u_48.Hover.Information.Rarity.Label.TextColor3 = v433.Color
                else
                    v_u_48.Hover.Information.Rarity.Label.Text = ""
                end
            else
                v_u_48.Hover.Information.Rarity.Label.Text = ""
            end
            local v435 = v_u_48.Hover.Information.Exterior
            if v388 then
                v435.Visible = false
            else
                local v436 = v_u_15.GetWearNameForFloat(v389, v387.Float or v389.floatRange.max)
                if v436 then
                    v435.Label.Text = v436
                    v435.Visible = true
                else
                    v435.Visible = false
                end
            end
            local v437 = v_u_48.Hover.Information.Team.Team
            if (v387.Type == "Melee" or (v387.Type == "Glove" or v387.Type == "Badge")) and true or v387.Type == "Charm" then
                v437.CT.Visible = true
                v437.T.Visible = true
                v437.Label.Visible = true
                v437.Label.Text = "Both"
            elseif v387.Type == "Weapon" then
                local v438, v439 = pcall(v_u_17, v387.Name)
                if v438 and (v439 and v439.Team) then
                    local v440 = v439.Team
                    if v440 == "Counter-Terrorists" then
                        v437.CT.Visible = true
                        v437.T.Visible = false
                        v437.Label.Visible = true
                        v437.Label.Text = "Counter-Terrorists"
                    elseif v440 == "Terrorists" then
                        v437.CT.Visible = false
                        v437.T.Visible = true
                        v437.Label.Visible = true
                        v437.Label.Text = "Terrorists"
                    else
                        v437.CT.Visible = true
                        v437.T.Visible = true
                        v437.Label.Visible = true
                        v437.Label.Text = "Both"
                    end
                end
            end
        end
        v_u_48.Hover.Visible = true
    else
        v_u_48.Hover.Visible = false
    end
end
function v_u_1.Initialize(p441, p442)
    v_u_49 = p441
    v_u_48 = p442
    v_u_47 = p442.Information
    v_u_13.ObserveAvailableCollections(function(p443)
        v_u_40 = p443
    end)
    v_u_47.Inspect.Selectable = true
    local function v444()
        v_u_19.broadcastRouter("RunInterfaceSound", "UI Click")
        if v_u_35 then
            v_u_47.Visible = false
            v_u_19.broadcastRouter("WeaponInspect", v_u_35.Name, v_u_35.Skin, v_u_35.Float, v_u_35.StatTrack, v_u_35.NameTag, v_u_35.Charm, v_u_35.Stickers, v_u_35.Type, v_u_35.Pattern, v_u_35._id, v_u_35.Serial, v_u_35.IsTradeable)
        end
    end
    v_u_47.Inspect.MouseButton1Click:Connect(v444)
    v_u_47.Inspect.Activated:Connect(function(p445)
        if p445 and p445.UserInputType == Enum.UserInputType.Gamepad1 then
            v_u_19.broadcastRouter("RunInterfaceSound", "UI Click")
            if v_u_35 then
                v_u_47.Visible = false
                v_u_19.broadcastRouter("WeaponInspect", v_u_35.Name, v_u_35.Skin, v_u_35.Float, v_u_35.StatTrack, v_u_35.NameTag, v_u_35.Charm, v_u_35.Stickers, v_u_35.Type, v_u_35.Pattern, v_u_35._id, v_u_35.Serial, v_u_35.IsTradeable)
            end
        end
    end)
    if v_u_47.Charm then
        v_u_47.Charm.Selectable = true
        local function v_u_449()
            v_u_19.broadcastRouter("RunInterfaceSound", "UI Click")
            if v_u_35 then
                local v446
                if v_u_35.Charm == nil or v_u_35.Charm == false then
                    v446 = false
                else
                    local v447 = v_u_35.Charm
                    if type(v447) == "string" or v_u_35.Charm == true then
                        v446 = true
                    else
                        local v448 = v_u_35.Charm
                        v446 = type(v448) == "table"
                    end
                end
                v_u_47.Visible = false
                if v446 then
                    v_u_18.Inventory.RemoveWeaponCharm.Send({
                        ["WeaponId"] = v_u_35._id
                    })
                    return
                end
                v_u_48.Visible = false
                v_u_25.TriggerAction("AttachCharm", v_u_35)
            end
        end
        v_u_47.Charm.MouseButton1Click:Connect(v_u_449)
        v_u_47.Charm.Activated:Connect(function(p450)
            if p450 and p450.UserInputType == Enum.UserInputType.Gamepad1 then
                v_u_449()
            end
        end)
    end
    v_u_25.OnItemSelected:Connect(function(p451, p452)
        local v453 = v_u_25.GetActions().Get(p452.ActionType)
        if v453 then
            v453.OnItemSelected(p451, p452)
        end
    end)
    v_u_25.OnClosed:Connect(function(_)
        if v_u_29.GetCurrentScreen() == "Inventory" then
            v_u_48.Visible = true
        end
    end)
    v_u_47.Unlock.Selectable = true
    local function v455()
        if v_u_44 then
            return
        else
            v_u_19.broadcastRouter("RunInterfaceSound", "UI Click")
            if v_u_35 then
                local v454 = v_u_16.GetCaseByName(v_u_35.Skin)
                v_u_27.OpenCaseContent(v454.caseId, "Open", v_u_35._id)
                v_u_47.Visible = false
                v_u_48.Visible = false
            end
        end
    end
    v_u_47.Unlock.MouseButton1Click:Connect(v455)
    v_u_47.Unlock.Activated:Connect(function(p456)
        if p456 and p456.UserInputType == Enum.UserInputType.Gamepad1 then
            if v_u_44 then
                return
            end
            v_u_19.broadcastRouter("RunInterfaceSound", "UI Click")
            if v_u_35 then
                local v457 = v_u_16.GetCaseByName(v_u_35.Skin)
                v_u_27.OpenCaseContent(v457.caseId, "Open", v_u_35._id)
                v_u_47.Visible = false
                v_u_48.Visible = false
                return
            end
        end
    end)
    local function v_u_460()
        if v_u_44 then
            return
        else
            local v458 = v_u_12.Get(v_u_10, "Gamepasses")
            if v458 then
                v458 = table.find(v458, "Quick Open")
            end
            v_u_19.broadcastRouter("RunInterfaceSound", "UI Click")
            if v458 then
                if v_u_35 then
                    local v459 = v_u_16.GetCaseByName(v_u_35.Skin)
                    if v459 then
                        v_u_44 = true
                        v_u_27.SetQuickUnlock(true)
                        v_u_18.Store.OpenCase.Send({
                            ["CaseIdentifier"] = v_u_35._id,
                            ["CaseId"] = v459.caseId,
                            ["OpenType"] = "Quick Open"
                        })
                        v_u_47.Visible = false
                    else
                        v_u_19.broadcastRouter("CreateMenuNotification", "Error", "Case not found.")
                    end
                else
                    return
                end
            else
                v_u_9:PromptGamePassPurchase(v_u_10, v_u_24["Quick Open"].GamepassId)
                return
            end
        end
    end
    v_u_47.QuickUnlock.MouseButton1Click:Connect(v_u_460)
    v_u_47.QuickUnlock.Activated:Connect(function(p461)
        if p461 and p461.UserInputType == Enum.UserInputType.Gamepad1 then
            v_u_460()
        end
    end)
    if v_u_47.ReplaceT then
        v_u_47.ReplaceT.Selectable = true
        local function v462()
            v_u_19.broadcastRouter("RunInterfaceSound", "UI Click")
            if v_u_35 then
                v_u_47.Visible = false
                v_u_92(v_u_35, "Terrorists")
            end
        end
        v_u_47.ReplaceT.MouseButton1Click:Connect(v462)
        v_u_47.ReplaceT.Activated:Connect(function(p463)
            if p463 and p463.UserInputType == Enum.UserInputType.Gamepad1 then
                v_u_19.broadcastRouter("RunInterfaceSound", "UI Click")
                if v_u_35 then
                    v_u_47.Visible = false
                    v_u_92(v_u_35, "Terrorists")
                end
            end
        end)
    end
    if v_u_47.ReplaceCT then
        v_u_47.ReplaceCT.Selectable = true
        local function v464()
            v_u_19.broadcastRouter("RunInterfaceSound", "UI Click")
            if v_u_35 then
                v_u_47.Visible = false
                v_u_92(v_u_35, "Counter-Terrorists")
            end
        end
        v_u_47.ReplaceCT.MouseButton1Click:Connect(v464)
        v_u_47.ReplaceCT.Activated:Connect(function(p465)
            if p465 and p465.UserInputType == Enum.UserInputType.Gamepad1 then
                v_u_19.broadcastRouter("RunInterfaceSound", "UI Click")
                if v_u_35 then
                    v_u_47.Visible = false
                    v_u_92(v_u_35, "Counter-Terrorists")
                end
            end
        end)
    end
    v_u_48.ItemNotification.Holder.Left.MouseButton1Click:Connect(function()
        v_u_19.broadcastRouter("RunInterfaceSound", "UI Click")
        if v_u_38 > 0 then
            v_u_1.NextInventoryItem(v_u_38 - 1)
        end
    end)
    v_u_48.ItemNotification.Holder.Right.MouseButton1Click:Connect(function()
        v_u_19.broadcastRouter("RunInterfaceSound", "UI Click")
        if v_u_38 <= #v_u_50 then
            v_u_1.NextInventoryItem(v_u_38 + 1)
        end
    end)
    v_u_48.ItemNotification.Holder.Continue.Selectable = true
    v_u_48.ItemNotification.Holder.ViewLoadout.Selectable = true
    local function v466()
        v_u_19.broadcastRouter("RunInterfaceSound", "UI Click")
        v_u_48.ItemNotification.Visible = false
        v_u_38 = 0
        table.clear(v_u_50)
    end
    v_u_48.ItemNotification.Holder.Continue.MouseButton1Click:Connect(v466)
    v_u_48.ItemNotification.Holder.Continue.Activated:Connect(function(p467)
        if p467 and p467.UserInputType == Enum.UserInputType.Gamepad1 then
            v_u_19.broadcastRouter("RunInterfaceSound", "UI Click")
            v_u_48.ItemNotification.Visible = false
            v_u_38 = 0
            table.clear(v_u_50)
        end
    end)
    local function v_u_469()
        local v468 = v_u_50[v_u_38]
        v_u_19.broadcastRouter("RunInterfaceSound", "UI Click")
        v_u_48.ItemNotification.Visible = false
        v_u_38 = 0
        table.clear(v_u_50)
        if v468 and (v468.Type == "Melee" or (v468.Type == "Glove" or v468.Type == "Weapon")) and true or false then
            v_u_48.Visible = false
            v_u_26.ViewInLoadout(v468._id)
        end
    end
    v_u_48.ItemNotification.Holder.ViewLoadout.MouseButton1Click:Connect(v_u_469)
    v_u_48.ItemNotification.Holder.ViewLoadout.Activated:Connect(function(p470)
        if p470 and p470.UserInputType == Enum.UserInputType.Gamepad1 then
            v_u_469()
        end
    end)
    v_u_48.Tabs.Inventory.Sort.Button.Selectable = true
    local function v471()
        v_u_48.Tabs.Inventory.Sort.Button.Options.Visible = not v_u_48.Tabs.Inventory.Sort.Button.Options.Visible
        v_u_19.broadcastRouter("RunInterfaceSound", "UI Click")
    end
    v_u_48.Tabs.Inventory.Sort.Button.MouseButton1Click:Connect(v471)
    v_u_48.Tabs.Inventory.Sort.Button.Activated:Connect(function(p472)
        if p472 and p472.UserInputType == Enum.UserInputType.Gamepad1 then
            v_u_48.Tabs.Inventory.Sort.Button.Options.Visible = not v_u_48.Tabs.Inventory.Sort.Button.Options.Visible
            v_u_19.broadcastRouter("RunInterfaceSound", "UI Click")
        end
    end)
    for _, v473 in ipairs({
        "Alphabetical",
        "Collection",
        "Equipped",
        "Newest",
        "Quality",
        "Type"
    }) do
        local v474 = v_u_48.Tabs.Inventory.Sort.Button.Options:FindFirstChild(v473)
        if v474 then
            v_u_230(v_u_48.Tabs.Inventory.Sort.Button.Options, v474, v473, v_u_48.Tabs.Inventory.Sort.Button.Frame.TextLabel, v_u_48.Tabs.Inventory.Container)
        end
    end
    for _, v475 in ipairs(v_u_48.Top.Categories:GetChildren()) do
        if v475:IsA("TextButton") and v475:GetAttribute("IsCategoryButton") then
            v_u_1.SetupCategoryButton(v475)
        end
    end
    v_u_48:GetPropertyChangedSignal("Visible"):Connect(function()
        if v_u_48.Visible then
            if v_u_43 then
                v_u_43 = false
                if v_u_48 then
                    if v_u_48.Visible then
                        v_u_33 = v_u_136()
                        v_u_33 = v_u_165(v_u_33)
                        v_u_222()
                    else
                        v_u_43 = true
                        v_u_42 = true
                    end
                end
            end
            if v_u_42 then
                v_u_217()
            end
            local v476 = #v_u_50
            if v476 > 0 and v_u_38 < v476 then
                v_u_1.NextInventoryItem(v_u_38 + 1)
                return
            end
        end
    end)
    v_u_48.Tabs.Inventory.Container:GetPropertyChangedSignal("CanvasPosition"):Connect(function()
        v_u_179()
    end)
    v_u_48.Tabs.Inventory.Container:GetPropertyChangedSignal("AbsoluteCanvasSize"):Connect(function()
        task.defer(v_u_179)
    end)
end
function v_u_1.Start()
    v_u_12.WaitForDataLoaded(v_u_10)
    v_u_1.SelectCategory("Everything")
    local v_u_477 = nil
    local v_u_478 = nil
    if v_u_48 then
        v_u_48:GetPropertyChangedSignal("Visible"):Connect(function()
            if v_u_48.Visible then
                if v_u_477 then
                    v_u_477:Disconnect()
                end
                v_u_477 = v_u_8.InputBegan:Connect(function(p479, p480)
                    if p479.UserInputType == Enum.UserInputType.Gamepad1 then
                        if v_u_48 and (v_u_48.Visible and not p480) then
                            local v481 = p479.KeyCode
                            local v482 = v_u_7.SelectedObject
                            local v483 = v_u_48 and v_u_48.ItemNotification
                            if v483 then
                                v483 = v_u_48.ItemNotification.Visible
                            end
                            if v481 == Enum.KeyCode.ButtonB then
                                if v483 then
                                    v_u_19.broadcastRouter("RunInterfaceSound", "UI Click")
                                    v_u_48.ItemNotification.Visible = false
                                    v_u_38 = 0
                                    table.clear(v_u_50)
                                    return
                                end
                                if v_u_47 and v_u_47.Visible then
                                    v_u_47.Visible = false
                                    v_u_19.broadcastRouter("RunInterfaceSound", "UI Click")
                                    return
                                end
                                if v_u_48 and v_u_48.Tabs.Inventory.Sort.Button.Options.Visible then
                                    v_u_48.Tabs.Inventory.Sort.Button.Options.Visible = false
                                    v_u_19.broadcastRouter("RunInterfaceSound", "UI Click")
                                    return
                                end
                            end
                            if v483 then
                                local v484 = v_u_48.ItemNotification.Holder
                                if v481 == Enum.KeyCode.Thumbstick1 or (v481 == Enum.KeyCode.DPadLeft or v481 == Enum.KeyCode.DPadRight) then
                                    return
                                else
                                    local v485 = v481 == Enum.KeyCode.DPadUp
                                    if v485 or v481 == Enum.KeyCode.DPadDown then
                                        if v482 and v482:IsA("GuiButton") then
                                            local v486 = v485 and v482.NextSelectionUp or v482.NextSelectionDown
                                            if v486 and (v486 == v484.Continue or v486 == v484.ViewLoadout) then
                                                v_u_7.SelectedObject = v486
                                            end
                                        end
                                    end
                                end
                            else
                                local v487 = v_u_47 and v_u_47.Visible
                                if v487 then
                                    if v482 then
                                        v487 = v482:IsDescendantOf(v_u_47)
                                    else
                                        v487 = v482
                                    end
                                end
                                if not v487 or v481 ~= Enum.KeyCode.Thumbstick1 and (v481 ~= Enum.KeyCode.DPadLeft and v481 ~= Enum.KeyCode.DPadRight) then
                                    local v488 = v481 == Enum.KeyCode.DPadUp
                                    local v489 = (v488 or v481 == Enum.KeyCode.DPadDown) and (v482 and v482:IsA("GuiButton")) and (v488 and v482.NextSelectionUp or v482.NextSelectionDown)
                                    if v489 then
                                        if v487 then
                                            if v489:IsDescendantOf(v_u_47) then
                                                v_u_7.SelectedObject = v489
                                                return
                                            end
                                        else
                                            v_u_7.SelectedObject = v489
                                        end
                                    end
                                end
                            end
                        else
                            return
                        end
                    else
                        return
                    end
                end)
                if v_u_478 then
                    v_u_478:Disconnect()
                end
                v_u_478 = v_u_7.Changed:Connect(function(p490)
                    if p490 == "SelectedObject" then
                        local v491 = v_u_48
                        if v491 then
                            v491 = v_u_48.ItemNotification
                        end
                        if v491 and v491.Visible then
                            local v492 = v491.Holder
                            local v493 = v_u_7.SelectedObject
                            if v493 and (v493 ~= v492.Continue and (v493 ~= v492.ViewLoadout and not (v493:IsDescendantOf(v492) and v493:IsA("GuiButton")))) then
                                task.defer(function()
                                    v_u_1.SelectFirstItemNotificationButton()
                                end)
                            end
                            return
                        elseif v_u_47 and v_u_47.Visible then
                            local v494 = v_u_7.SelectedObject
                            if v494 and not v494:IsDescendantOf(v_u_47) then
                                task.defer(function()
                                    v_u_1.SelectFirstInformationFrameButton()
                                end)
                            end
                        end
                    else
                        return
                    end
                end)
                if v_u_8.GamepadEnabled then
                    task.defer(function()
                        local v495 = 0
                        while v495 < 5 do
                            task.wait(0.1)
                            v495 = v495 + 1
                            if v_u_7.SelectedObject or not (v_u_48 and v_u_48.Visible) then
                                break
                            end
                            if v_u_48.Tabs.Inventory.Container then
                                for _, v496 in ipairs(v_u_48.Tabs.Inventory.Container:GetChildren()) do
                                    if v496:IsA("Frame") and (v496.Name ~= "UIGridLayout" and (v496.Name ~= "UIListLayout" and v496.Name ~= "UIPadding")) then
                                        local v497 = v496:FindFirstChild("Button")
                                        if v497 and (v497:IsA("GuiButton") and (v497.Selectable and v497.Visible)) then
                                            v_u_7.SelectedObject = v497
                                            return
                                        end
                                    end
                                end
                            end
                        end
                    end)
                    return
                end
            else
                if v_u_477 then
                    v_u_477:Disconnect()
                    v_u_477 = nil
                end
                if v_u_478 then
                    v_u_478:Disconnect()
                    v_u_478 = nil
                end
            end
        end)
    end
    v_u_5.Heartbeat:Connect(function(p498)
        local v499 = v_u_49.Menu.Top.Buttons.Inventory.Alert
        if v_u_34 then
            v_u_1.UpdateHoverFrame(p498)
        else
            v_u_48.Hover.Visible = false
        end
        local v500 = #v_u_50
        v499.TextLabel.Text = v500
        v499.Visible = v500 > 0
        v_u_48.ItemNotification.Holder.Light.Rotation = v_u_48.ItemNotification.Holder.Light.Rotation + p498 * 10
        v_u_48.ItemNotification.Holder.Amount.TextLabel.Text = ("%* / %*"):format(v_u_38, v500)
        v_u_48.ItemNotification.Holder.Right.Visible = v_u_38 < v500
        v_u_48.ItemNotification.Holder.Left.Visible = v_u_38 > 1
    end)
    v_u_15.OnItemStockSchemasUpdated:Connect(function(_)
        local v501 = v_u_12.Get(v_u_10, "Inventory")
        v_u_1.UpdateTemplates(v501)
    end)
    v_u_18.Store.NewInventoryItem.Listen(function(p502)
        local v503 = p502.Player
        local v504 = tonumber(v503)
        if not v504 then
            return
        end
        local v505 = v_u_6:GetPlayerByUserId(v504)
        if not v505 or v_u_10 ~= v505 then
            return
        end
        for _, v506 in ipairs(p502.Items) do
            local v507 = false
            for _, v508 in ipairs(v_u_50) do
                if v508._id == v506._id then
                    v507 = true
                    break
                end
            end
            if not v507 then
                local v509 = v_u_50
                table.insert(v509, v506)
            end
        end
    end)
    v_u_12.CreateListener(v_u_10, "Inventory", function(p510)
        v_u_1.UpdateInventory(p510)
        if not v_u_39 then
            v_u_48.Tabs.Inventory.Sort.Button.Frame.TextLabel.Text = "Newest"
            v_u_41 = "Newest"
            v_u_39 = true
        end
        if v_u_48 then
            if v_u_48.Visible then
                v_u_33 = v_u_136()
                v_u_33 = v_u_165(v_u_33)
                v_u_222()
            else
                v_u_43 = true
                v_u_42 = true
            end
        else
            return
        end
    end)
    v_u_12.CreateListener(v_u_10, "Loadout", function()
        if v_u_48 and v_u_48.Visible then
            local v511 = v_u_48.Tabs.Inventory.Container
            for _, v512 in ipairs(v511:GetChildren()) do
                if v512:IsA("Frame") and (v512.Name ~= "UIGridLayout" and (v512.Name ~= "UIListLayout" and (v512.Name ~= "UIPadding" and (v512.Name ~= "Title" and v512.Name ~= "Label")))) then
                    v_u_72(v512, v512.Name)
                end
            end
        end
    end)
    v_u_29.OnInspectStateChanged:Connect(function(p513)
        if not p513 then
            task.defer(function()
                local v514 = #v_u_50
                if v_u_48.Visible and (v514 > 0 and v_u_38 < v514) then
                    v_u_1.NextInventoryItem(v_u_38 + 1)
                end
            end)
        end
    end)
    v_u_19.observerRouter("ShowNewItemNotification", function(p515)
        v_u_1.ShowNewItemNotification(p515)
    end)
end
return v_u_1