local v_u_1 = {}
local v_u_2 = game:GetService("ReplicatedStorage")
local v_u_3 = game:GetService("TweenService")
local v4 = game:GetService("Players")
require(script:WaitForChild("Types"))
local v_u_5 = v4.LocalPlayer
local v_u_6 = v_u_5:WaitForChild("PlayerGui")
local v_u_7 = require(v_u_2.Controllers.DataController)
local v_u_8 = require(v_u_2.Database.Components.Libraries.Skins)
local v_u_9 = require(v_u_2.Database.Components.Libraries.Cases)
local v_u_10 = require(v_u_2.Database.Components.Libraries.Collections)
local v_u_11 = require(v_u_2.Database.Security.Router)
local v12 = require(v_u_2.Packages.Signal)
local v_u_13 = require(v_u_2.Interface.MenuState)
local v_u_14 = require(v_u_2.Database.Custom.GameStats.UI.Inventory.Sort)
local v_u_15 = require(v_u_2.Database.Custom.GameStats.Rarities)
local v_u_16 = require(v_u_2.Database.Custom.GameStats.Grenades)
local v_u_17 = require(script.Actions)
local v_u_18 = nil
local v_u_19 = nil
local v_u_20 = nil
local v_u_21 = false
local v_u_22 = nil
local v_u_23 = nil
local v_u_24 = nil
local v_u_25 = {}
local v_u_26 = 0
local v_u_27 = nil
local v_u_28 = nil
local v_u_29 = nil
local v_u_30 = nil
local v_u_31 = nil
local v_u_32 = nil
v_u_1.OnItemSelected = v12.new()
v_u_1.OnClosed = v12.new()
local function v_u_38(p33, p34)
    local v35 = p33:GetChildren()
    for _, v36 in ipairs(v35) do
        if v36.ClassName == p34 then
            v36:Destroy()
        end
    end
    v_u_10.ObserveAvailableCollections(function(p37)
        v_u_23 = p37
    end)
end
local function v_u_44(p_u_39, p_u_40, _, p_u_41, p_u_42, _)
    p_u_40.MouseEnter:Connect(function()
        v_u_3:Create(p_u_40, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            ["BackgroundTransparency"] = 0.85
        }):Play()
    end)
    p_u_40.MouseLeave:Connect(function()
        v_u_3:Create(p_u_40, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            ["BackgroundTransparency"] = 1
        }):Play()
    end)
    p_u_40.MouseButton1Click:Connect(function()
        v_u_11.broadcastRouter("RunInterfaceSound", "UI Click")
        v_u_24 = p_u_41
        v_u_1.PopulateItems()
        p_u_42.Text = p_u_41
        for _, v43 in ipairs(p_u_39:GetChildren()) do
            if v43:IsA("TextButton") then
                v43.Frame.BackgroundTransparency = v43 == p_u_40 and 0 or 1
            end
        end
        p_u_39.Visible = false
    end)
end
local function v_u_68(p_u_45)
    local v_u_46 = p_u_45.Size
    local v47 = p_u_45.Button
    p_u_45.MouseEnter:Connect(function()
        local v48 = v_u_3
        local v49 = p_u_45
        local v50 = TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
        local v51 = {}
        local v52 = v_u_46
        v51.Size = UDim2.new(v52.X.Scale * 0.95, v52.X.Offset, v52.Y.Scale * 0.95, v52.Y.Offset)
        v48:Create(v49, v50, v51):Play()
    end)
    p_u_45.MouseLeave:Connect(function()
        local v53 = v_u_3
        local v54 = p_u_45
        local v55 = TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
        local v56 = {}
        local v57 = v_u_46
        v56.Size = UDim2.new(v57.X.Scale * 1, v57.X.Offset, v57.Y.Scale * 1, v57.Y.Offset)
        v53:Create(v54, v55, v56):Play()
    end)
    v47.MouseButton1Down:Connect(function()
        local v58 = v_u_3
        local v59 = p_u_45
        local v60 = TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
        local v61 = {}
        local v62 = v_u_46
        v61.Size = UDim2.new(v62.X.Scale * 0.9, v62.X.Offset, v62.Y.Scale * 0.9, v62.Y.Offset)
        v58:Create(v59, v60, v61):Play()
    end)
    v47.MouseButton1Up:Connect(function()
        local v63 = v_u_3
        local v64 = p_u_45
        local v65 = TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
        local v66 = {}
        local v67 = v_u_46
        v66.Size = UDim2.new(v67.X.Scale * 0.95, v67.X.Offset, v67.Y.Scale * 0.95, v67.Y.Offset)
        v63:Create(v64, v65, v66):Play()
    end)
end
local function v_u_94()
    if not (v_u_28 and v_u_28.Visible) then
        return 50
    end
    local v69 = v_u_28:FindFirstChildOfClass("UIGridLayout")
    if not v69 then
        return 50
    end
    local v70 = v_u_28.AbsoluteSize
    local v71 = v70.Y
    local v72 = v70.X
    local v73 = v69.CellSize
    local v74 = v69.CellPadding
    local v75 = v73.Y.Scale * v71 + v73.Y.Offset
    local v76 = v74.Y.Scale * v71 + v74.Y.Offset
    local v77 = v73.X.Scale * v72 + v73.X.Offset
    local v78 = v74.X.Scale * v72 + v74.X.Offset
    local v79 = v_u_28:FindFirstChildOfClass("UIPadding")
    local v80, v81, v82, v83
    if v79 then
        v80 = v79.PaddingTop.Scale * v71 + v79.PaddingTop.Offset
        v81 = v79.PaddingBottom.Scale * v71 + v79.PaddingBottom.Offset
        v82 = v79.PaddingLeft.Scale * v72 + v79.PaddingLeft.Offset
        v83 = v79.PaddingRight.Scale * v72 + v79.PaddingRight.Offset
    else
        v80 = 0
        v81 = 0
        v82 = 0
        v83 = 0
    end
    local v84 = v71 - v80 - v81
    local v85 = v72 - v82 - v83
    local v86 = v77 + v78
    local v87
    if v86 > 0 then
        local v88 = (v85 + v78) / v86
        local v89 = math.floor(v88)
        v87 = math.max(1, v89)
    else
        v87 = 1
    end
    local v90 = v75 + v76
    local v91
    if v90 > 0 then
        local v92 = (v84 + v76) / v90
        local v93 = math.floor(v92)
        v91 = math.max(1, v93)
    else
        v91 = 1
    end
    return v91 * v87 + v87
end
local function v_u_105()
    if v_u_28 then
        local function v96(p95)
            if v_u_18 then
                v_u_1.OnItemSelected:Fire(p95, v_u_18)
                v_u_1.Hide()
            end
        end
        v_u_10.ObserveAvailableCollections(function(p97)
            v_u_23 = p97
        end)
        local v98 = v_u_26 + 1
        local v99 = v_u_26 + 25
        local v100 = #v_u_25
        local v101 = math.min(v99, v100)
        for v102 = v98, v101 do
            local v103 = v_u_25[v102]
            if v103 and not v_u_28:FindFirstChild(v103._id) then
                v_u_1.CreateItemTemplate(v103, v96)
            end
        end
        v_u_10.ObserveAvailableCollections(function(p104)
            v_u_23 = p104
        end)
        v_u_26 = v101
    end
end
local function v_u_109()
    if v_u_28 then
        local v106 = v_u_28.CanvasPosition.Y
        local v107 = v_u_28.AbsoluteCanvasSize.Y - v_u_28.AbsoluteSize.Y
        if v107 > 0 and (v_u_26 < #v_u_25 and v107 - v106 < 200) then
            v_u_105()
        end
        v_u_10.ObserveAvailableCollections(function(p108)
            v_u_23 = p108
        end)
    end
end
local function v_u_126()
    if v_u_21 then
        return true
    end
    print("Initializing")
    v_u_31 = v_u_6:FindFirstChild("MainGui")
    if not v_u_31 then
        warn("[UseItemFrame] MainGui not found")
        return false
    end
    local v110 = v_u_31:FindFirstChild("Menu")
    if not v110 then
        warn("[UseItemFrame] Menu frame not found")
        return false
    end
    v_u_27 = v110:FindFirstChild("UseItemFrame")
    if not v_u_27 then
        warn("[UseItemFrame] UseItemFrame not found in Menu")
        return false
    end
    local v111 = v_u_27:FindFirstChild("Tabs")
    local v112 = v111 and v111:FindFirstChild("Inventory")
    if v112 then
        v_u_28 = v112:FindFirstChild("Container")
        v_u_32 = v112:FindFirstChild("Sort")
    end
    v_u_10.ObserveAvailableCollections(function(p113)
        v_u_23 = p113
    end)
    local v_u_114 = v_u_32 and v_u_32:FindFirstChild("Button")
    if v_u_114 then
        local v115 = v_u_114:FindFirstChild("Frame"):FindFirstChild("TextLabel")
        if v115 then
            v115.Text = "Newest"
            v_u_24 = "Newest"
        end
        v_u_114.MouseButton1Click:Connect(function()
            local v116 = v_u_114:FindFirstChild("Options")
            if v116 then
                v116.Visible = not v116.Visible
                v_u_11.broadcastRouter("RunInterfaceSound", "UI Click")
            end
        end)
        local v117 = v_u_114:FindFirstChild("Options")
        local v118 = v_u_114:FindFirstChild("Frame"):FindFirstChild("TextLabel")
        if v117 and v118 then
            for _, v119 in ipairs({
                "Alphabetical",
                "Collection",
                "Equipped",
                "Newest",
                "Quality",
                "Type"
            }) do
                local v120 = v117:FindFirstChild(v119)
                if v120 then
                    v_u_44(v117, v120, nil, v119, v118, v_u_28)
                end
            end
        end
    end
    v_u_10.ObserveAvailableCollections(function(p121)
        v_u_23 = p121
    end)
    local v122 = v_u_27:FindFirstChild("Top")
    if v122 then
        v_u_29 = v122:FindFirstChild("TextLabel")
        v_u_30 = v122:FindFirstChild("Close")
        if v_u_30 then
            v_u_30.MouseButton1Click:Connect(function()
                v_u_11.broadcastRouter("RunInterfaceSound", "UI Click")
                v_u_1.OnClosed:Fire(v_u_18)
                v_u_1.Hide()
            end)
        end
    end
    v_u_10.ObserveAvailableCollections(function(p123)
        v_u_23 = p123
    end)
    v_u_7.CreateListener(v_u_5, "Inventory", function(_)
        if v_u_1.IsVisible() then
            v_u_1.PopulateItems()
        end
    end)
    v_u_13.OnScreenChanged:Connect(function(_, _)
        if v_u_1.IsVisible() then
            v_u_1.OnClosed:Fire(v_u_18)
            v_u_1.Hide()
        end
    end)
    v_u_13.OnInspectStateChanged:Connect(function(p124)
        if p124 and v_u_1.IsVisible() then
            v_u_1.OnClosed:Fire(v_u_18)
            v_u_1.Hide()
        end
    end)
    v_u_13.OnCaseSceneStateChanged:Connect(function(p125)
        if p125 and v_u_1.IsVisible() then
            v_u_1.OnClosed:Fire(v_u_18)
            v_u_1.Hide()
        end
    end)
    if v_u_28 then
        v_u_28:GetPropertyChangedSignal("CanvasPosition"):Connect(function()
            v_u_109()
        end)
    end
    v_u_21 = true
    return true
end
function v_u_1.CreateItemTemplate(p_u_127, p_u_128)
    if not (p_u_127 and p_u_127._id) then
        return
    end
    if not v_u_28 then
        return
    end
    local v129 = p_u_127.Type == "Case"
    local v130 = v129 and v_u_9.GetCaseByName(p_u_127.Skin) or v_u_8.GetSkinInformation(p_u_127.Name, p_u_127.Skin)
    if not v130 then
        return
    end
    local v131 = v_u_15[v129 and v130.caseRarity or v130.rarity]
    local v132 = nil
    if v129 then
        v132 = v130.imageAssetId or ""
    elseif p_u_127.Type == "Charm" then
        local v133 = p_u_127.Pattern
        if v133 and v130.charmImages then
            for _, v134 in ipairs(v130.charmImages) do
                if v134.pattern == v133 then
                    v132 = v134.assetId
                    break
                end
            end
        end
        if not v132 then
            v132 = v130.imageAssetId or ""
        end
    else
        v132 = v_u_8.GetWearImageForFloat(v130, p_u_127.Float or 0.9999) or (v130.imageAssetId or "")
    end
    local v_u_135 = v_u_2.Assets.UI.Inventory.ItemTemplate:Clone()
    v_u_135.Main.RarityFrame.UIGradient.Color = v131.ColorSequence
    v_u_135.Main.Glow.UIGradient.Color = v131.ColorSequence
    v_u_135.Parent = v_u_28
    v_u_135.Main.Icon.Image = v132
    v_u_135.Name = p_u_127._id
    local v136 = p_u_127.StatTrack and "KillTrak\226\132\162 " .. p_u_127.Name or p_u_127.Name
    v_u_135.Information.Weapon.Text = v136
    v_u_135.Information.Skin.Text = v129 and v130.skin or p_u_127.Skin
    if p_u_127.Type == "Charm" then
        v_u_135.Button.MouseButton2Click:Connect(function()
            v_u_11.broadcastRouter("RunInterfaceSound", "UI Click")
            v_u_11.broadcastRouter("WeaponInspect", p_u_127.Name, p_u_127.Skin, p_u_127.Float, p_u_127.StatTrack, p_u_127.NameTag, p_u_127.Charm, p_u_127.Stickers, p_u_127.Type, p_u_127.Pattern, p_u_127._id, p_u_127.Serial, p_u_127.IsTradeable)
        end)
    end
    v_u_135.Button.MouseButton1Click:Connect(function()
        v_u_11.broadcastRouter("RunInterfaceSound", "UI Click")
        p_u_128(p_u_127)
    end)
    v_u_135.MouseEnter:Connect(function()
        v_u_20 = v_u_135
        v_u_22 = tick()
    end)
    v_u_135.MouseLeave:Connect(function()
        v_u_20 = nil
        v_u_22 = nil
    end)
    v_u_68(v_u_135)
end
function v_u_1.PopulateItems()
    if v_u_28 then
        v_u_38(v_u_28, "Frame")
        v_u_26 = 0
        v_u_25 = {}
        local v137 = v_u_7.Get(v_u_5, "Inventory")
        if v137 and type(v137) == "table" then
            for _, v138 in ipairs(v137) do
                local v139
                if v138 then
                    v139 = v_u_16[v138.Name]
                else
                    v139 = v138
                end
                local v140
                if v138 then
                    v140 = v138.Type == "Case"
                else
                    v140 = v138
                end
                local v141 = v138 and (v138._id and v138.Name)
                if v141 then
                    v141 = v140 or v138.Skin
                end
                if v141 and not (v139 or v140) and (not (v_u_19 and v_u_18) or v_u_19(v138, v_u_18)) then
                    local v142 = v_u_25
                    table.insert(v142, v138)
                end
            end
            v_u_10.ObserveAvailableCollections(function(p143)
                v_u_23 = p143
            end)
            local v144 = v_u_24 or v_u_32 and v_u_32.Button.Frame.TextLabel.Text or "Newest"
            local v145 = v_u_14.GetSortComparisonFunction(v144, v_u_5, function()
                return v_u_23
            end)
            if v145 then
                table.sort(v_u_25, v145)
            end
            local function v147(p146)
                if v_u_18 then
                    v_u_1.OnItemSelected:Fire(p146, v_u_18)
                    v_u_1.Hide()
                end
            end
            v_u_10.ObserveAvailableCollections(function(p148)
                v_u_23 = p148
            end)
            local v149 = v_u_94()
            local v150 = math.max(v149, 50)
            local v151 = #v_u_25
            local v152 = math.min(v150, v151)
            for v153 = 1, v152 do
                local v154 = v_u_25[v153]
                if v154 then
                    v_u_1.CreateItemTemplate(v154, v147)
                end
            end
            v_u_10.ObserveAvailableCollections(function(p155)
                v_u_23 = p155
            end)
            v_u_26 = v152
        end
    else
        return
    end
end
function v_u_1.Show(p156, p157)
    if v_u_126() then
        if v_u_27 then
            v_u_18 = p156
            v_u_19 = p157
            if v_u_29 then
                if p156.SourceItem then
                    local v158 = p156.SourceItem
                    local v159 = v158.Name
                    if v158.StatTrack then
                        v159 = "KillTrak\226\132\162 " .. v159
                    end
                    if v158.Skin then
                        v159 = v159 .. " | " .. v158.Skin
                    end
                    v_u_29.Text = ("Select an item to use with %*"):format(v159)
                elseif p156.Title then
                    v_u_29.Text = p156.Title
                else
                    v_u_29.Text = "Select an item"
                end
            end
            v_u_10.ObserveAvailableCollections(function(p160)
                v_u_23 = p160
            end)
            v_u_1.PopulateItems()
            v_u_27.Visible = true
        end
    else
        warn("[UseItemFrame] Failed to initialize")
        return
    end
end
function v_u_1.Hide()
    if v_u_27 then
        v_u_27.Visible = false
    end
    v_u_18 = nil
    v_u_19 = nil
end
function v_u_1.IsVisible()
    return v_u_27 and v_u_27.Visible or false
end
function v_u_1.GetCurrentContext()
    return v_u_18
end
v_u_1.Filters = {}
function v_u_1.Filters.WeaponsWithoutCharm(p161, _)
    if p161.Type ~= "Weapon" then
        return false
    end
    local v162
    if p161.Charm == nil or p161.Charm == false then
        v162 = false
    else
        local v163 = p161.Charm
        if type(v163) == "string" or p161.Charm == true then
            v162 = true
        else
            local v164 = p161.Charm
            v162 = type(v164) == "table"
        end
    end
    return not v162
end
local function v172(p165, _)
    if p165.Type ~= "Charm" then
        return false
    end
    local v166 = v_u_7.Get(v_u_5, "Inventory")
    if v166 then
        for _, v167 in ipairs(v166) do
            if v167.Charm then
                local v168 = v167.Charm
                local v169 = type(v168) == "table" and v167.Charm._id
                if not v169 then
                    local v170 = v167.Charm
                    if type(v170) == "string" then
                        v169 = v167.Charm
                    else
                        v169 = false
                    end
                end
                if v169 == p165._id then
                    return false
                end
            end
        end
    end
    v_u_10.ObserveAvailableCollections(function(p171)
        v_u_23 = p171
    end)
    return true
end
v_u_1.Filters.AllCharms = v172
function v_u_1.Filters.AllWeapons(p173, _)
    return p173.Type == "Weapon"
end
function v_u_1.Filters.AllMelees(p174, _)
    return p174.Type == "Melee"
end
function v_u_1.Filters.AllGloves(p175, _)
    return p175.Type == "Glove"
end
function v_u_1.Initialize(p176, p177)
    v_u_31 = p176
    v_u_27 = p177
    local v178 = p177:FindFirstChild("Tabs")
    local v179 = v178 and v178:FindFirstChild("Inventory")
    if v179 then
        v_u_28 = v179:FindFirstChild("Container")
        v_u_32 = v179:FindFirstChild("Sort")
    end
    v_u_10.ObserveAvailableCollections(function(p180)
        v_u_23 = p180
    end)
    if v_u_32 then
        local v_u_181 = v_u_32:FindFirstChild("Button")
        if v_u_181 then
            local v182 = v_u_181:FindFirstChild("Frame"):FindFirstChild("TextLabel")
            if v182 then
                v182.Text = "Newest"
                v_u_24 = "Newest"
            end
            v_u_181.MouseButton1Click:Connect(function()
                local v183 = v_u_181:FindFirstChild("Options")
                if v183 then
                    v183.Visible = not v183.Visible
                    v_u_11.broadcastRouter("RunInterfaceSound", "UI Click")
                end
            end)
            local v184 = v_u_181:FindFirstChild("Options")
            local v185 = v_u_181:FindFirstChild("Frame"):FindFirstChild("TextLabel")
            if v184 and v185 then
                for _, v186 in ipairs({
                    "Alphabetical",
                    "Collection",
                    "Equipped",
                    "Newest",
                    "Quality",
                    "Type"
                }) do
                    local v187 = v184:FindFirstChild(v186)
                    if v187 then
                        v_u_44(v184, v187, nil, v186, v185, v_u_28)
                    end
                end
            end
        end
    end
    v_u_10.ObserveAvailableCollections(function(p188)
        v_u_23 = p188
    end)
    local v189 = p177:FindFirstChild("Top")
    if v189 then
        v_u_29 = v189:FindFirstChild("TextLabel")
        v_u_30 = v189:FindFirstChild("Close")
        if v_u_30 then
            v_u_30.MouseButton1Click:Connect(function()
                v_u_11.broadcastRouter("RunInterfaceSound", "UI Click")
                v_u_1.OnClosed:Fire(v_u_18)
                v_u_1.Hide()
            end)
        end
    end
    v_u_10.ObserveAvailableCollections(function(p190)
        v_u_23 = p190
    end)
    if v_u_28 then
        v_u_28:GetPropertyChangedSignal("CanvasPosition"):Connect(function()
            v_u_109()
        end)
    end
    p177.Visible = false
    v_u_21 = true
end
function v_u_1.Start()
    v_u_17.InitializeAll()
    v_u_7.CreateListener(v_u_5, "Inventory", function(_)
        if v_u_1.IsVisible() then
            v_u_1.PopulateItems()
        end
    end)
    v_u_13.OnScreenChanged:Connect(function(_, _)
        if v_u_1.IsVisible() then
            v_u_1.OnClosed:Fire(v_u_18)
            v_u_1.Hide()
        end
    end)
    v_u_13.OnInspectStateChanged:Connect(function(p191)
        if p191 and v_u_1.IsVisible() then
            v_u_1.OnClosed:Fire(v_u_18)
            v_u_1.Hide()
        end
    end)
    v_u_13.OnCaseSceneStateChanged:Connect(function(p192)
        if p192 and v_u_1.IsVisible() then
            v_u_1.OnClosed:Fire(v_u_18)
            v_u_1.Hide()
        end
    end)
end
function v_u_1.TriggerAction(p193, p194)
    local v195 = v_u_17.Get(p193)
    if v195 then
        local v196 = v195.GetContext(p194)
        local v197 = v195.GetFilter(p194)
        v_u_1.Show(v196, v197)
    else
        warn((("[UseItemFrame] Unknown action type: %*"):format(p193)))
    end
end
function v_u_1.GetActions()
    return v_u_17
end
return v_u_1