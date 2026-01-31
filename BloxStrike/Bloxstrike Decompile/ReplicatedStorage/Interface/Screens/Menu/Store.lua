local v_u_1 = {}
local v_u_2 = game:GetService("MarketplaceService")
local v_u_3 = game:GetService("ReplicatedStorage")
local v_u_4 = game:GetService("PolicyService")
local v_u_5 = game:GetService("TweenService")
local v_u_6 = game:GetService("RunService")
local v_u_7 = game:GetService("Players")
require(v_u_3.Database.Custom.Types)
local v_u_8 = require(v_u_3.Controllers.DataController)
local v_u_9 = require(v_u_3.Controllers.CaseSceneController)
local v_u_10 = require(v_u_3.Components.Common.InterfaceAnimations.ActivateButton)
local v_u_11 = require(v_u_3.Components.Common.GetUserPlatform)
local v_u_12 = require(v_u_3.Database.Components.Libraries.Bundles)
local v_u_13 = require(v_u_3.Database.Components.Libraries.Skins)
local v_u_14 = require(v_u_3.Database.Components.Libraries.Cases)
local v_u_15 = require(v_u_3.Database.Security.Remotes)
local v_u_16 = require(v_u_3.Database.Security.Router)
local v_u_17 = require(v_u_3.Interface.MenuState)
local v_u_18 = require(v_u_3.Packages.Observers)
local v19 = require(v_u_3.Shared.Spring)
local v_u_20 = require(v_u_3.Database.Custom.GameStats.Monetization.DevProducts)
local v_u_21 = require(v_u_3.Database.Custom.GameStats.Monetization.Gamepasses)
local v_u_22 = require(v_u_3.Database.Custom.GameStats.Rarities)
local v_u_23 = v19.new(1, 8, 0)
local v_u_24 = v_u_7.LocalPlayer
local v_u_25 = -1
local v_u_26 = true
local v_u_27 = nil
local v_u_28 = nil
local v_u_29 = Color3.fromRGB(243, 243, 243)
local v_u_30 = Color3.fromRGB(125, 206, 243)
local v_u_31 = Color3.fromRGB(100, 168, 195)
local v_u_32 = Color3.fromRGB(53, 83, 99)
local v_u_33 = Color3.fromRGB(127, 143, 144)
local v_u_34 = UDim2.fromOffset(215, 125)
local v_u_35 = UDim2.fromOffset(215, 150)
local v_u_36 = {
    ["chrysalis"] = "rbxassetid://127888213250008"
}
local v_u_37 = {
    ["Blue"] = 1,
    ["Purple"] = 2,
    ["Pink"] = 3,
    ["Red"] = 4,
    ["Special"] = 5
}
local v_u_38 = nil
local v_u_39 = nil
local v_u_40 = {
    ["isOpening"] = false,
    ["isPendingOpenRequest"] = false,
    ["isQuickUnlock"] = false,
    ["currentTween"] = nil,
    ["currentZoomTween"] = nil,
    ["renderConnection"] = nil,
    ["currentInventoryItem"] = nil,
    ["currentCaseIdentifier"] = nil,
    ["pendingOpenRequestId"] = nil
}
local function v_u_41(...) end
local function v_u_45(p42, p43)
    for _, v44 in ipairs(p42:GetChildren()) do
        if not table.find(p43, v44.Name) then
            v44:Destroy()
        end
    end
end
local function v_u_58(p46)
    local v47 = DateTime.fromIsoDate(p46)
    local v48 = DateTime.now()
    local v49 = v47.UnixTimestamp - v48.UnixTimestamp
    if v49 <= 0 then
        return "00:00:00:00"
    end
    local v50 = string.format
    local v51 = v49 / 86400
    local v52 = math.floor(v51)
    local v53 = v49 % 86400 / 3600
    local v54 = math.floor(v53)
    local v55 = v49 % 3600 / 60
    local v56 = math.floor(v55)
    local v57 = v49 % 60
    return v50("%02d:%02d:%02d:%02d", v52, v54, v56, (math.floor(v57)))
end
local function v_u_70(p_u_59)
    local v_u_60 = p_u_59.Size
    p_u_59.MouseEnter:Connect(function()
        local v61 = v_u_5
        local v62 = p_u_59
        local v63 = TweenInfo.new(0.2, Enum.EasingStyle.Exponential, Enum.EasingDirection.InOut)
        local v64 = {}
        local v65 = v_u_60
        v64.Size = UDim2.fromScale(v65.X.Scale * 0.9, v65.Y.Scale * 0.9)
        v61:Create(v62, v63, v64):Play()
        v_u_16.broadcastRouter("RunInterfaceSound", "UI Highlight")
        if p_u_59.Name ~= "Credits" and not p_u_59:GetAttribute("Selected") then
            local v66 = {
                ["BackgroundTransparency"] = 0.8,
                ["BackgroundColor3"] = v_u_33
            }
            v_u_5:Create(p_u_59.HoverFrame, TweenInfo.new(0.2, Enum.EasingStyle.Exponential, Enum.EasingDirection.InOut), v66):Play()
            local v67 = {
                ["TextColor3"] = v_u_31
            }
            v_u_5:Create(p_u_59.TextLabel, TweenInfo.new(0.2, Enum.EasingStyle.Exponential, Enum.EasingDirection.InOut), v67):Play()
        end
    end)
    p_u_59.MouseLeave:Connect(function()
        local v68 = {
            ["Size"] = v_u_60
        }
        v_u_5:Create(p_u_59, TweenInfo.new(0.2, Enum.EasingStyle.Exponential, Enum.EasingDirection.InOut), v68):Play()
        if p_u_59.Name ~= "Credits" and not p_u_59:GetAttribute("Selected") then
            local v69 = {
                ["TextColor3"] = v_u_29
            }
            v_u_5:Create(p_u_59.TextLabel, TweenInfo.new(0.2, Enum.EasingStyle.Exponential, Enum.EasingDirection.InOut), v69):Play()
            v_u_5:Create(p_u_59.HoverFrame, TweenInfo.new(0.2, Enum.EasingStyle.Exponential, Enum.EasingDirection.InOut), {
                ["BackgroundTransparency"] = 1
            }):Play()
        end
    end)
    p_u_59.MouseButton1Click:Connect(function()
        v_u_16.broadcastRouter("RunInterfaceSound", "UI Click")
    end)
end
local function v_u_78(p71)
    local v72 = 0
    for _, v73 in ipairs(p71.contents) do
        v72 = v72 + v73.weight
    end
    local v74 = math.random() * v72
    local v75 = 0
    for _, v76 in ipairs(p71.contents) do
        v75 = v75 + v76.weight
        if v74 <= v75 then
            return v76, v76.isSpecial or false
        end
    end
    local v77 = p71.contents[1]
    return v77, v77.isSpecial or false
end
local function v_u_87(p79, p80, p81, p82)
    local v83 = {}
    for v84 = 1, 75 do
        if v84 == p81 then
            table.insert(v83, {
                ["item"] = p80,
                ["isGold"] = p82
            })
        else
            local v85, v86 = v_u_78(p79)
            table.insert(v83, {
                ["item"] = v85,
                ["isGold"] = v86
            })
        end
    end
    return v83
end
local function v_u_104(p88, p89, p90, p91)
    local v92 = v_u_3.Assets.UI.Store.CaseScroll
    local v93
    if p89.isGold then
        v93 = v92:FindFirstChild("GoldTemplate")
    else
        v93 = v92:FindFirstChild("ItemTemplate")
    end
    if v93 then
        local v94 = v93:Clone()
        v94.Name = tostring(p90)
        v94.LayoutOrder = p90
        v94.Size = p91
        v94.SizeConstraint = Enum.SizeConstraint.RelativeXY
        v94.AutomaticSize = Enum.AutomaticSize.None
        v94.Parent = p88
        if p89.isGold then
            local v95 = string.lower(p89.item.skin.skinName)
            v94.Frame.Icon.Image = "rbxassetid://132217734282843"
            if v_u_36[v95] then
                v94.Frame.Icon.Image = v_u_36[v95]
                return
            end
        else
            local v96 = v_u_22[p89.item.rarity]
            local v97 = v_u_13.GetSkinInformation(p89.item.skin.weaponName, p89.item.skin.skinName)
            local v98 = v94:FindFirstChild("Frame")
            if v96 and (v97 and v98) then
                local v99 = v98:FindFirstChild("RarityFrame")
                local v100 = v99 and v99:FindFirstChild("UIGradient")
                if v100 then
                    v100.Color = v96.ColorSequence
                end
                local v101 = v98:FindFirstChild("Icon")
                if v101 then
                    local v102 = ""
                    if v97.wearImages and #v97.wearImages > 0 then
                        v102 = v97.wearImages[1].assetId
                    elseif v97.charmImages and #v97.charmImages > 0 then
                        v102 = v97.charmImages[1].assetId
                    elseif v97.imageAssetId then
                        v102 = v97.imageAssetId
                    end
                    v101.Image = v102
                end
                local v103 = v98:FindFirstChild("Rarity")
                if v103 then
                    v103.ImageColor3 = v96.Color
                    return
                end
            end
        end
    else
        warn("[Store] Missing case scroll template")
    end
end
local function v_u_113(p105, p106, p107, p108)
    for _, v109 in ipairs(p105:GetChildren()) do
        if v109:IsA("Frame") or (v109:IsA("ImageLabel") or v109:IsA("ImageButton")) then
            v109:Destroy()
        end
    end
    local v110 = p105:FindFirstChildOfClass("UIListLayout")
    if v110 then
        v110.FillDirection = Enum.FillDirection.Horizontal
        v110.HorizontalAlignment = Enum.HorizontalAlignment.Left
        v110.VerticalAlignment = Enum.VerticalAlignment.Center
        v110.Padding = UDim.new(0, p108)
    end
    for v111, v112 in ipairs(p106) do
        v_u_104(p105, v112, v111, p107)
    end
end
local function v_u_121(p114, p115)
    local v116 = p114.AbsoluteSize.X
    local v117 = math.max(v116, 1)
    local v118 = p115 / v117
    local v119 = math.max(v118, 1)
    p114.CanvasSize = UDim2.fromScale(v119, 0)
    local v120 = p115 - v117
    p114:SetAttribute("ScrollMaxOffset", (math.max(0, v120)))
    p114:SetAttribute("ScrollViewportWidth", v117)
end
local function v_u_136(p_u_122, p123, p124, p125, p_u_126, p_u_127)
    local v128 = TweenInfo.new(7, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
    local v_u_129 = v_u_5:Create(p_u_122, v128, {
        ["CanvasPosition"] = Vector2.new(p124, 0)
    })
    local v130 = v_u_5:Create(p123, v128, {
        ["CanvasPosition"] = Vector2.new(p125, 0)
    })
    v_u_40.currentTween = v_u_129
    v_u_40.currentZoomTween = v130
    local v_u_131 = 0
    local v_u_132 = nil
    v_u_132 = v_u_6.RenderStepped:Connect(function()
        if v_u_40.isOpening then
            local v133 = p_u_122.CanvasPosition.X
            local v134 = p_u_126 <= 0 and 0 or v133 / p_u_126
            local v135 = math.floor(v134) + 1
            if v_u_131 < v135 and v135 <= 75 then
                p_u_127(v135)
                v_u_131 = v135
            end
            if v_u_129.PlaybackState == Enum.PlaybackState.Completed and v_u_132 then
                v_u_132:Disconnect()
                v_u_132 = nil
                v_u_40.renderConnection = nil
            end
        elseif v_u_132 then
            v_u_132:Disconnect()
            v_u_132 = nil
            v_u_40.renderConnection = nil
        end
    end)
    v_u_40.renderConnection = v_u_132
    v_u_129.Completed:Connect(function()
        if v_u_132 then
            v_u_132:Disconnect()
            v_u_132 = nil
            v_u_40.renderConnection = nil
        end
    end)
    v_u_129:Play()
    v130:Play()
    return v_u_129
end
local function v_u_155(p_u_137)
    local v_u_138 = p_u_137.Size
    p_u_137.Button.MouseEnter:Connect(function()
        v_u_16.broadcastRouter("RunInterfaceSound", "UI Highlight")
        p_u_137.Hoverstroke.Enabled = true
        local v139 = v_u_5
        local v140 = p_u_137
        local v141 = TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
        local v142 = {}
        local v143 = v_u_138
        v142.Size = UDim2.fromScale(v143.X.Scale * 0.975, v143.Y.Scale * 0.975)
        v139:Create(v140, v141, v142):Play()
    end)
    p_u_137.Button.MouseLeave:Connect(function()
        p_u_137.Hoverstroke.Enabled = false
        local v144 = {
            ["Size"] = v_u_138
        }
        v_u_5:Create(p_u_137, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), v144):Play()
    end)
    p_u_137.Button.MouseButton1Down:Connect(function()
        v_u_16.broadcastRouter("RunInterfaceSound", "UI Click")
        local v145 = v_u_5
        local v146 = p_u_137
        local v147 = TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
        local v148 = {}
        local v149 = v_u_138
        v148.Size = UDim2.fromScale(v149.X.Scale * 0.95, v149.Y.Scale * 0.95)
        v145:Create(v146, v147, v148):Play()
    end)
    p_u_137.Button.MouseButton1Up:Connect(function()
        local v150 = v_u_5
        local v151 = p_u_137
        local v152 = TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
        local v153 = {}
        local v154 = v_u_138
        v153.Size = UDim2.fromScale(v154.X.Scale * 0.975, v154.Y.Scale * 0.975)
        v150:Create(v151, v152, v153):Play()
    end)
    p_u_137.Button.MouseButton1Click:Connect(function()
        if v_u_26 then
            v_u_2:PromptProductPurchase(v_u_24, v_u_20[p_u_137.Name].DevProductId)
        end
    end)
end
function v_u_1.PurchaseCase(p156, p157)
    local v158 = v_u_8.Get(v_u_24, "Credits")
    local v159 = p156.price * p157
    if v159 <= v158 then
        v_u_15.Store.PurchaseCase.Send({
            ["CaseId"] = p156.caseId,
            ["Amount"] = p157
        })
        return
    elseif v_u_26 then
        local v160 = v159 - v158
        v_u_2:PromptProductPurchase(v_u_24, v_u_20[v160 <= 300 and "+ 300 Credits" or (v160 <= 945 and "+ 945 Credits" or (v160 <= 2700 and "+ 2,700 Credits" or "+ 9,500 Credits"))].DevProductId)
        v_u_1.CloseCaseContent("Store")
        v_u_1.OpenTab("Credits")
    end
end
function v_u_1.CreateCaseTemplate(p_u_161, p162)
    local v163 = v_u_22[p_u_161.caseRarity]
    if v163 then
        local v164 = v_u_3.Assets.UI.Store.CaseTemplate:Clone()
        v164.Contents.Rarity.UIGradient.Color = v163.ColorSequence
        local v165 = v164.Buy.Credits.Amount
        local v166 = p_u_161.price
        v165.Text = ("%*"):format((tostring(v166):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "")))
        v164.Contents.Glow.ImageColor3 = v163.Color
        v164.Alert.Visible = p_u_161.status == "featured"
        v164.Contents.Icon.Image = p_u_161.imageAssetId
        v164.Footer.CaseName.Text = p_u_161.name
        v164.Parent = p162
        v164.Name = p_u_161.caseId
        v_u_10(v164.Purchase)
        v164.Purchase.MouseButton1Click:Connect(function()
            v_u_16.broadcastRouter("RunInterfaceSound", "UI Click")
            v_u_1.OpenCaseContent(p_u_161.caseId, "Inspect")
        end)
        v_u_10(v164.Gift)
        v164.Gift.MouseButton1Click:Connect(function()
            v_u_1.OpenGift(p_u_161.caseId, "Case")
        end)
    end
end
function v_u_1.ActivateGiftTemplate(p_u_167, p_u_168)
    p_u_167.Button.MouseEnter:Connect(function()
        v_u_16.broadcastRouter("RunInterfaceSound", "UI Highlight")
        v_u_5:Create(p_u_167.Player.Username, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            ["TextColor3"] = Color3.fromRGB(255, 200, 0)
        }):Play()
    end)
    p_u_167.Button.MouseLeave:Connect(function()
        v_u_5:Create(p_u_167.Player.Username, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            ["TextColor3"] = Color3.fromRGB(190, 190, 190)
        }):Play()
    end)
    p_u_167.Button.MouseButton1Click:Connect(function()
        if p_u_168 == v_u_24.UserId then
            return
        else
            local v169 = v_u_38:GetAttribute("GiftProductName")
            local v170 = v_u_38:GetAttribute("GiftProductType")
            v_u_16.broadcastRouter("RunInterfaceSound", "UI Click")
            if v170 == "Case" then
                if v_u_8.Get(v_u_24, "Credits") >= v_u_14.GetCase(v169).price then
                    local v171 = v_u_15.Store.GiftCase.Send
                    local v172 = {}
                    local v173 = p_u_168
                    v172.RecipientUserId = tostring(v173)
                    v172.CaseId = v169
                    v171(v172)
                    v_u_38.Gift.Visible = false
                end
            else
                local v174 = v_u_15.Store.CreateGift.Send
                local v175 = {}
                local v176 = p_u_168
                v175.RecipientUserId = tostring(v176)
                v175.ProductName = v169
                v175.ProductType = v170
                v174(v175)
                if v170 == "Gamepass" then
                    v_u_2:PromptGamePassPurchase(v_u_24, v_u_21[v169].GamepassId)
                    return
                elseif v170 == "DevProduct" then
                    v_u_2:PromptProductPurchase(v_u_24, v_u_20[v169].DevProductId)
                end
            end
        end
    end)
end
function v_u_1.SetupCreditsFrame(p_u_177)
    v_u_155(p_u_177)
    v_u_10(p_u_177.Purchase)
    p_u_177.Purchase.MouseButton1Click:Connect(function()
        if v_u_26 then
            v_u_2:PromptProductPurchase(v_u_24, v_u_20[p_u_177.Name].DevProductId)
        end
    end)
    v_u_10(p_u_177.Gift)
    p_u_177.Gift.MouseButton1Click:Connect(function()
        v_u_1.OpenGift("Gift " .. p_u_177.Name, "DevProduct")
    end)
end
function v_u_1.UpdateCases()
    local v178 = v_u_14.GetFeaturedCases(6)
    v_u_45(v_u_38.Tabs.Container.Featured.Container.Items, { "UIListLayout" })
    local v179 = v_u_14.GetCases()
    v_u_45(v_u_38.Tabs.Container.Cases.Cases, { "UIListLayout", "UIGridLayout" })
    for _, v180 in ipairs(v178) do
        if v180.caseType ~= "Package" then
            v_u_1.CreateCaseTemplate(v180, v_u_38.Tabs.Container.Featured.Container.Items)
        end
    end
    for _, v181 in ipairs(v179) do
        if v181.caseType ~= "Package" then
            v_u_1.CreateCaseTemplate(v181, v_u_38.Tabs.Container.Cases.Cases)
        end
    end
end
function v_u_1.OpenCaseContent(p182, p183, p184)
    local v185 = v_u_14.GetCase(p182)
    v_u_27 = p184
    v_u_28 = v185
    if v185 then
        if v_u_38.Visible or v_u_17.GetCurrentScreen() == "Store" then
            v_u_17.SetScreen("Store")
            v_u_38.CaseContent:SetAttribute("WasVisibleBeforeInspect", true)
        else
            v_u_38.CaseContent:SetAttribute("WasVisibleBeforeInspect", false)
        end
        v_u_38.CaseContent.Title.Text = p183 == "Inspect" and "Inspect Container" or "Unlock Container"
        local v186 = v_u_38.CaseContent.List.Buy.Header.TextLabel
        local v187 = v185.price
        v186.Text = ("BUY (%*)"):format((tostring(v187):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "")))
        v_u_38.CaseContent.List.Amount.Visible = p183 == "Inspect"
        v_u_38.CaseContent.List.Amount.Header.TextLabel.Text = "1"
        v_u_38.CaseContent.List.Buy.Visible = p183 == "Inspect"
        v_u_38.CaseContent.CaseName.Text = v185.name
        v_u_38.CaseContent.List.Open.Visible = p183 == "Open"
        v_u_38.CaseContent:SetAttribute("State", p183)
        v_u_38.Tabs.Container.Visible = false
        v_u_38.CaseContent.Visible = true
        v_u_39.Menu.Top.Visible = false
        v_u_38.Top.Visible = false
        v_u_38.Visible = true
        for _, v188 in ipairs(v_u_38.CaseContent.List.Amount.Container:GetChildren()) do
            if v188:IsA("TextButton") then
                v188.Frame.BackgroundTransparency = v188.Name == "1" and 0 or 1
                v188:SetAttribute("Selected", v188.Name == "1")
            end
        end
        for _, v189 in ipairs(v_u_38.CaseContent.CaseChances:GetChildren()) do
            if v189:IsA("TextLabel") then
                v189.Visible = false
            end
        end
        for _, v190 in ipairs(v185.rarityChances) do
            local v191 = v_u_38.CaseContent.CaseChances:FindFirstChild(v190.rarity)
            v191.Text = ("%*: %*%%"):format(v190.rarity, v190.chance)
            v191.Visible = true
        end
        if v185.caseType == "Case" then
            local v192 = v185.rarityChances
            local v193 = 0
            for _, v194 in ipairs(v192) do
                v193 = v193 + v194.chance
            end
            local v195 = (100 - v193) * 100
            local v196 = math.round(v195) / 100
            v_u_38.CaseContent.CaseChances.Special.Text = ("Special: %*%%"):format(v196)
            v_u_38.CaseContent.CaseChances.Special.Visible = true
        end
        v_u_9.ShowCaseScene(v185.caseType, v185.name)
        task.defer(function()
            v_u_38.Visible = true
            v_u_38.CaseContent.Visible = true
            if v_u_39 and v_u_39.Menu then
                v_u_39.Menu.Visible = true
            end
        end)
        v_u_45(v_u_38.CaseContent.Container, { "UIGridLayout", "UIPadding" })
        local v197 = table.clone(v185.contents)
        table.sort(v197, function(p198, p199)
            return (v_u_37[p198.rarity] or 0) < (v_u_37[p199.rarity] or 0)
        end)
        for _, v_u_200 in ipairs(v197) do
            local v201 = v_u_13.GetSkinInformation(v_u_200.skin.weaponName, v_u_200.skin.skinName)
            local v202 = v_u_22[v_u_200.rarity]
            local v203
            if v201.wearImages and v201.wearImages[1] then
                v203 = v201.wearImages[1].assetId
            elseif v201.charmImages and v201.charmImages[1] then
                v203 = v201.charmImages[1].assetId
            else
                v203 = v201.imageAssetId or ""
            end
            local v204 = v_u_3.Assets.UI.Store.ItemTemplate:Clone()
            v204.Content.RarityFrame.UIGradient.Color = v202.ColorSequence
            v204.Footer.WeaponName.Text = v_u_200.skin.weaponName
            v204.Content.Rarity.ImageColor3 = v202.Color
            v204.Footer.SkinName.Text = v_u_200.skin.skinName
            v204.Parent = v_u_38.CaseContent.Container
            v204.Content.Icon.Image = v203
            local v_u_205 = v204.Content:FindFirstChild("Inspect")
            if v_u_205 then
                v_u_205.Visible = false
                v_u_10(v_u_205)
                v204.Content.MouseEnter:Connect(function()
                    v_u_205.Visible = true
                end)
                v204.Content.MouseLeave:Connect(function()
                    v_u_205.Visible = false
                end)
                v_u_205.MouseButton1Click:Connect(function()
                    v_u_16.broadcastRouter("RunInterfaceSound", "UI Click")
                    local v206 = v_u_200.skin.type == "Charm" and "Charm" or nil
                    v_u_16.broadcastRouter("WeaponInspect", v_u_200.skin.weaponName, v_u_200.skin.skinName, 0, nil, nil, nil, nil, v206, 1, nil, 1, nil)
                end)
                local v207 = v_u_11()
                local v208
                if table.find(v207, "Mobile") == nil then
                    v208 = false
                else
                    v208 = #v207 <= 1
                end
                local v209 = v204.Content:FindFirstChild("MobileInspect")
                if v209 and not v208 then
                    v209.Visible = false
                end
                if v208 and v209 then
                    v_u_10(v209)
                    v209.Activated:Connect(function()
                        v_u_205.Visible = true
                    end)
                    v_u_205:GetPropertyChangedSignal("Visible"):Connect(function()
                        if v_u_205.Visible then
                            v_u_16.broadcastRouter("RunInterfaceSound", "UI Click")
                            local v210 = v_u_200.skin.type == "Charm" and "Charm" or nil
                            v_u_16.broadcastRouter("WeaponInspect", v_u_200.skin.weaponName, v_u_200.skin.skinName, 0, nil, nil, nil, nil, v210, 1, nil, 1, nil)
                        end
                    end)
                end
            end
        end
        if v185.caseType == "Case" then
            local v211 = v_u_3.Assets.UI.Store.GoldTemplate:Clone()
            v211.Content.Icon.Image = v_u_36[v185.caseId] or "rbxassetid://132217734282843"
            v211.Parent = v_u_38.CaseContent.Container
            return
        end
    end
end
function v_u_1.OpenGift(p212, p213)
    v_u_38:SetAttribute("GiftProductName", p212)
    v_u_38:SetAttribute("GiftProductType", p213)
    v_u_38.Gift.Visible = true
end
function v_u_1.SearchPlayerGift(p214)
    local v215 = v_u_38.Gift.Container:FindFirstChild("SearchResult")
    if v215 then
        v215:Destroy()
    end
    local v_u_216 = tonumber(p214)
    if p214 == "" or not v_u_216 then
        return
    else
        for _, v217 in ipairs(v_u_38.Gift.Container:GetChildren()) do
            if v217:IsA("Frame") then
                v217.Visible = false
            end
        end
        local v218, v219 = pcall(function()
            return v_u_7:GetNameFromUserIdAsync(v_u_216)
        end)
        if v218 then
            local v220 = v_u_3.Assets.UI.Store.PlayerTemplate:Clone()
            v220.Player.Avatar.Image = ("rbxthumb://type=AvatarHeadShot&id=%*&w=420&h=420"):format(v_u_216)
            v220.Player.Username.Text = ("@%*"):format(v219)
            v220.Parent = v_u_38.Gift.Container
            v220.Name = "SearchResult"
            v_u_1.ActivateGiftTemplate(v220, v_u_216)
        end
    end
end
function v_u_1.OpenTab(p221)
    if p221 == "Credits" and not v_u_26 then
        v_u_16.broadcastRouter("CreateMenuNotification", "Error", "Paid random items are not allowed in your region.")
    else
        for _, v222 in ipairs(v_u_38.Top.Categories:GetChildren()) do
            if v222:IsA("TextButton") then
                v222:SetAttribute("Selected", v222.Name == p221)
                if v222.Name == p221 and v222.Name ~= "Credits" then
                    v222.HoverFrame.BackgroundTransparency = 0
                    v222.HoverFrame.BackgroundColor3 = v_u_32
                    v222.TextLabel.TextColor3 = v_u_30
                elseif v222.Name ~= "Credits" then
                    v222.HoverFrame.BackgroundColor3 = Color3.fromRGB(243, 243, 243)
                    v222.TextLabel.TextColor3 = v_u_29
                    v222.HoverFrame.BackgroundTransparency = 1
                end
                v222:SetAttribute("Selected", v222.Name == p221)
            end
        end
        for _, v223 in ipairs(v_u_38.Tabs.Container:GetChildren()) do
            if v223:IsA("Frame") then
                v223.Visible = v223.Name == p221
            end
        end
    end
end
function v_u_1.OpenCase(p224, p_u_225, p226)
    v_u_41("OpenCase called")
    v_u_41("  caseId:", p224)
    v_u_41("  caseIdentifier:", p226 or "nil")
    v_u_41("  inventoryItem.Name:", p_u_225 and (p_u_225.Name or "nil") or "nil")
    v_u_41("  inventoryItem.Skin:", p_u_225 and (p_u_225.Skin or "nil") or "nil")
    v_u_41("  isQuickUnlock (before clear):", v_u_40.isQuickUnlock)
    local v227 = v_u_40.isQuickUnlock
    v_u_41("  shouldQuickUnlock:", v227)
    v_u_40.isPendingOpenRequest = false
    v_u_40.pendingOpenRequestId = nil
    v_u_40.isQuickUnlock = false
    v_u_40.currentCaseIdentifier = p226
    if v_u_40.currentTween then
        v_u_40.currentTween:Cancel()
        v_u_40.currentTween = nil
    end
    if v_u_40.currentZoomTween then
        v_u_40.currentZoomTween:Cancel()
        v_u_40.currentZoomTween = nil
    end
    if v_u_40.renderConnection then
        v_u_40.renderConnection:Disconnect()
        v_u_40.renderConnection = nil
    end
    local v_u_228 = v_u_14.GetCase(p224)
    if v_u_228 then
        v_u_41("  caseContents found, caseType:", v_u_228.caseType)
        if v227 then
            v_u_41("  Quick Unlock path - skipping animations")
            if p226 then
                v_u_41("  Sending CaseOpenSequenceFinished for quick unlock")
                v_u_15.Store.CaseOpenSequenceFinished.Send({
                    ["CaseIdentifier"] = p226
                })
            end
            v_u_41("  Hiding case scene for quick unlock")
            v_u_9.HideCaseScene()
            v_u_38.Tabs.Container.Visible = true
            v_u_38.CaseContent.Visible = false
            v_u_39.Menu.Top.Visible = true
            v_u_38.Top.Visible = true
            v_u_38.Visible = false
            v_u_17.SetScreen("Inventory")
            v_u_16.broadcastRouter("RunStoreSound", "Case Close")
            v_u_16.broadcastRouter("ShowNewItemNotification", p_u_225)
        else
            v_u_41("  Setting isOpening = true")
            v_u_40.isOpening = true
            v_u_40.currentInventoryItem = p_u_225
            v_u_38.CaseContent.Visible = false
            local v229 = v_u_228.caseType == "Charm Capsule"
            local v230 = v_u_228.caseType == "Package"
            v_u_41("  isCharmCapsule:", v229)
            v_u_41("  isPackage:", v230)
            local function v255()
                v_u_41("startRollAnimation called")
                v_u_41("  isOpening:", v_u_40.isOpening)
                if not v_u_40.isOpening then
                    v_u_41("  BLOCKED: isOpening is false, user closed early")
                    return
                end
                v_u_41("  Proceeding with roll animation")
                v_u_39.Menu.OpenCase.CaseName.Text = ("Unlock %*"):format(v_u_228.name)
                v_u_39.Menu.OpenCase.Visible = true
                v_u_38.Visible = false
                local v231 = v_u_39.Menu.OpenCase
                local v232 = v231:FindFirstChild("CanvasGroup")
                local v233 = v231:FindFirstChild("Zoom")
                if not (v232 and v233) then
                    warn("[Store] Missing CanvasGroup or Zoom group in OpenCase UI")
                    return
                end
                local v234 = v232:FindFirstChild("Container")
                local v235 = v233:FindFirstChild("Container")
                if not (v234 and v235) then
                    warn("[Store] Missing scroll containers for case opening")
                    return
                end
                local v236 = nil
                local v237 = false
                for _, v238 in ipairs(v_u_228.contents) do
                    if v238.skin.skinName == p_u_225.Skin and v238.skin.weaponName == p_u_225.Name then
                        v237 = v238.isSpecial or false
                        v236 = v238
                        break
                    end
                end
                if not v236 then
                    if p_u_225.Type == "Melee" and true or p_u_225.Type == "Glove" then
                        v236 = {
                            ["skin"] = {
                                ["weaponName"] = p_u_225.Name,
                                ["skinName"] = p_u_225.Skin,
                                ["type"] = p_u_225.Type
                            },
                            ["isSpecial"] = true,
                            ["rarity"] = "Special",
                            ["skinId"] = "",
                            ["weight"] = 0
                        }
                        v237 = true
                    else
                        v236 = v_u_228.contents[1]
                        v237 = v236.isSpecial or false
                    end
                end
                local v239 = v_u_87(v_u_228, v236, 55, v237)
                v_u_113(v234, v239, v_u_34, 8)
                v_u_113(v235, v239, v_u_35, 8)
                v234.CanvasPosition = Vector2.new(0, 0)
                v235.CanvasPosition = Vector2.new(0, 0)
                task.wait()
                v_u_121(v234, 16725)
                v_u_121(v235, 16725)
                local v240 = math.random(-97.72727272727272, 97.72727272727272)
                local v241 = v234.AbsoluteSize.X
                local v242 = math.max(v241, 1)
                local v243 = 16725 - v242
                local v244 = math.max(0, v243)
                local v245
                if v244 <= 0 then
                    v245 = 0
                else
                    local v246 = 12153.5 - v242 * 0.5 + v240
                    v245 = math.clamp(v246, 0, v244)
                end
                local v247 = v235.AbsoluteSize.X
                local v248 = math.max(v247, 1)
                local v249 = 16725 - v248
                local v250 = math.max(0, v249)
                local v251
                if v250 <= 0 then
                    v251 = 0
                else
                    local v252 = 12153.5 - v248 * 0.5 + v240
                    v251 = math.clamp(v252, 0, v250)
                end
                local v253 = v_u_136(v234, v235, v245, v251, 223, function()
                    v_u_16.broadcastRouter("RunInterfaceSound", "UI Click")
                end)
                if v253 then
                    v253.Completed:Wait()
                    if not v_u_40.isOpening then
                        return
                    end
                    v_u_16.broadcastRouter("RunInterfaceSound", "UI Notification")
                    task.wait(0.5)
                    if not v_u_40.isOpening then
                        return
                    end
                    v_u_40.isOpening = false
                    v_u_40.currentInventoryItem = nil
                    v_u_40.currentTween = nil
                    v_u_40.currentZoomTween = nil
                    local v254 = v_u_40.currentCaseIdentifier
                    if v254 then
                        v_u_15.Store.CaseOpenSequenceFinished.Send({
                            ["CaseIdentifier"] = v254
                        })
                        v_u_40.currentCaseIdentifier = nil
                    end
                    v_u_39.Menu.OpenCase.Visible = false
                    v_u_9.HideCaseScene()
                    v_u_38.Tabs.Container.Visible = true
                    v_u_38.CaseContent.Visible = false
                    v_u_39.Menu.Top.Visible = true
                    v_u_38.Top.Visible = true
                    v_u_38.Visible = false
                    v_u_17.SetScreen("Inventory")
                    v_u_16.broadcastRouter("RunStoreSound", "Case Close")
                    v_u_16.broadcastRouter("WeaponInspect", p_u_225.Name, p_u_225.Skin, p_u_225.Float, p_u_225.StatTrack, p_u_225.NameTag, p_u_225.Charm, p_u_225.Stickers, p_u_225.Type, p_u_225.Pattern, p_u_225._id, p_u_225.Serial, p_u_225.IsTradeable)
                end
            end
            local function v257()
                if v_u_40.isOpening then
                    v_u_40.isOpening = false
                    v_u_40.currentInventoryItem = nil
                    v_u_40.currentTween = nil
                    v_u_40.currentZoomTween = nil
                    local v256 = v_u_40.currentCaseIdentifier
                    if v256 then
                        v_u_15.Store.CaseOpenSequenceFinished.Send({
                            ["CaseIdentifier"] = v256
                        })
                        v_u_40.currentCaseIdentifier = nil
                    end
                    v_u_9.HideCaseScene()
                    v_u_38.Tabs.Container.Visible = true
                    v_u_38.CaseContent.Visible = false
                    v_u_39.Menu.Top.Visible = true
                    v_u_38.Top.Visible = true
                    v_u_38.Visible = false
                    v_u_17.SetScreen("Inventory")
                    v_u_16.broadcastRouter("RunStoreSound", "Case Close")
                    v_u_16.broadcastRouter("WeaponInspect", p_u_225.Name, p_u_225.Skin, p_u_225.Float, p_u_225.StatTrack, p_u_225.NameTag, p_u_225.Charm, p_u_225.Stickers, p_u_225.Type, p_u_225.Pattern, p_u_225._id, p_u_225.Serial, p_u_225.IsTradeable)
                end
            end
            v_u_41("Handling transition based on case type")
            v_u_41("  isCharmCapsule:", v229)
            v_u_41("  isPackage:", v230)
            if v229 then
                v_u_41("  Path: Charm Capsule - TransitionToUnboxing with callback")
                v_u_9.TransitionToUnboxing(v255)
            elseif v230 then
                v_u_41("  Path: Package - TransitionToUnboxing, wait for animation, skip to inspect")
                v_u_9.TransitionToUnboxing()
                v_u_41("  Waiting for opening animation...")
                v_u_9.WaitForOpeningAnimation()
                v_u_41("  Opening animation complete, calling skipToInspect")
                v257()
            else
                v_u_41("  Path: Regular Case - TransitionToUnboxing, wait 0.8s, start roll")
                v_u_9.TransitionToUnboxing()
                v_u_41("  Waiting 0.8 seconds for case opening animation...")
                task.wait(0.8)
                v_u_41("  Wait complete, starting roll animation")
                v255()
            end
            v_u_41("OpenCase function complete")
        end
    else
        v_u_41("  BLOCKED: caseContents not found for caseId:", p224)
        return
    end
end
function v_u_1.StopCaseOpening()
    v_u_41("StopCaseOpening called")
    v_u_41("  isOpening:", v_u_40.isOpening)
    v_u_41("  currentInventoryItem:", v_u_40.currentInventoryItem and v_u_40.currentInventoryItem.Name or "nil")
    if v_u_40.isOpening then
        v_u_16.broadcastRouter("RunStoreSound", "Case Close")
    end
    if v_u_40.currentTween then
        v_u_40.currentTween:Cancel()
        v_u_40.currentTween = nil
    end
    if v_u_40.currentZoomTween then
        v_u_40.currentZoomTween:Cancel()
        v_u_40.currentZoomTween = nil
    end
    if v_u_40.renderConnection then
        v_u_40.renderConnection:Disconnect()
        v_u_40.renderConnection = nil
    end
    local v258 = v_u_40.currentInventoryItem
    v_u_41("  Clearing state: isOpening = false")
    v_u_40.isOpening = false
    v_u_40.currentInventoryItem = nil
    v_u_41("  Hiding case scene")
    v_u_9.HideCaseScene()
    v_u_41("  StopCaseOpening complete")
    return v258
end
function v_u_1.SetQuickUnlock(p259)
    v_u_40.isQuickUnlock = p259
end
function v_u_1.CloseCaseContent(p260)
    v_u_9.HideCaseScene()
    v_u_28 = nil
    v_u_27 = nil
    v_u_38.CaseContent:SetAttribute("WasVisibleBeforeInspect", false)
    if p260 == "Inventory" then
        v_u_17.SetScreen("Inventory")
    end
    v_u_38.Tabs.Container.Visible = true
    v_u_38.CaseContent.Visible = false
    v_u_39.Menu.Top.Visible = true
    v_u_38.Top.Visible = true
    if p260 == "Inventory" then
        v_u_39.Menu.Inventory.Visible = true
        v_u_38.Visible = false
    else
        v_u_38.Visible = true
    end
end
function v_u_1.Initialize(p261, p262)
    v_u_39 = p261
    v_u_38 = p262
    v_u_39.Menu.OpenCase.Contents.Close.MouseButton1Click:Connect(function()
        local v263 = v_u_1.StopCaseOpening()
        v_u_39.Menu.OpenCase.Visible = false
        local v264 = v_u_40.currentCaseIdentifier
        if v264 then
            v_u_15.Store.CaseOpenSequenceFinished.Send({
                ["CaseIdentifier"] = v264
            })
            v_u_40.currentCaseIdentifier = nil
        end
        v_u_38.Tabs.Container.Visible = true
        v_u_38.CaseContent.Visible = false
        v_u_39.Menu.Top.Visible = true
        v_u_38.Top.Visible = true
        v_u_38.Visible = false
        v_u_17.SetScreen("Inventory")
        if v263 then
            v_u_16.broadcastRouter("WeaponInspect", v263.Name, v263.Skin, v263.Float, v263.StatTrack, v263.NameTag, v263.Charm, v263.Stickers, v263.Type, v263.Pattern, v263._id, v263.Serial, v263.IsTradeable)
        else
            v_u_39.Menu.Inventory.Visible = true
        end
    end)
    v_u_10(v_u_38.CaseContent.List.Open)
    v_u_38.CaseContent.List.Open.MouseButton1Click:Connect(function()
        v_u_41("Open button clicked")
        v_u_41("  CurrentCase:", v_u_28 and v_u_28.caseId or "nil")
        v_u_41("  CurrentCaseIdentifier:", v_u_27 or "nil")
        v_u_41("  isOpening:", v_u_40.isOpening)
        v_u_41("  isPendingOpenRequest:", v_u_40.isPendingOpenRequest)
        v_u_41("  isQuickUnlock:", v_u_40.isQuickUnlock)
        if v_u_28 and not (v_u_40.isOpening or v_u_40.isPendingOpenRequest) then
            if v_u_27 then
                local v_u_265 = v_u_27
                v_u_40.isPendingOpenRequest = true
                v_u_40.pendingOpenRequestId = v_u_265
                v_u_41("  Sending OpenCase request to server, requestId:", v_u_265)
                local v266 = v_u_40.isQuickUnlock and "Quick Open" or "Standard"
                v_u_15.Store.OpenCase.Send({
                    ["OpenType"] = v266,
                    ["CaseId"] = v_u_28.caseId,
                    ["CaseIdentifier"] = v_u_265
                })
                task.delay(12, function()
                    if v_u_40.isPendingOpenRequest and v_u_40.pendingOpenRequestId == v_u_265 then
                        v_u_40.isPendingOpenRequest = false
                        v_u_40.pendingOpenRequestId = nil
                        v_u_40.isQuickUnlock = false
                        v_u_16.broadcastRouter("CreateMenuNotification", "Error", "Opening case timed out. Please try again.")
                    end
                end)
            else
                v_u_41("  BLOCKED: No CurrentCaseIdentifier")
                v_u_16.broadcastRouter("CreateMenuNotification", "Error", "Case identifier missing. Please reopen the case.")
            end
        else
            v_u_41("  BLOCKED: CurrentCase or state check failed")
            return
        end
    end)
    v_u_10(v_u_38.CaseContent.List.Buy)
    v_u_38.CaseContent.List.Buy.MouseButton1Click:Connect(function()
        if v_u_28 then
            local v267 = v_u_1.PurchaseCase
            local v268 = v_u_28
            local v269 = v_u_38.CaseContent.List.Amount.Header.TextLabel.Text
            v267(v268, (tonumber(v269)))
        end
    end)
    v_u_10(v_u_38.CaseContent.List.Close)
    v_u_38.CaseContent.List.Close.MouseButton1Click:Connect(function()
        if not v_u_40.isPendingOpenRequest then
            v_u_1.CloseCaseContent(v_u_38.CaseContent:GetAttribute("State") == "Inspect" and "Store" or "Inventory")
        end
    end)
    v_u_45(v_u_38.Gift.Container, { "UICorner", "UIListLayout" })
    v_u_38.Gift.Close.MouseButton1Click:Connect(function()
        v_u_16.broadcastRouter("RunInterfaceSound", "UI Click")
        v_u_38.Gift.Visible = false
    end)
    v_u_10(v_u_38.Top.Credits.Buy)
    v_u_38.Top.Credits.Buy.MouseButton1Click:Connect(function()
        v_u_1.OpenTab("Credits")
    end)
    v_u_10(v_u_38.Tabs.Container.Featured.Bundle.Gift)
    v_u_38.Tabs.Container.Featured.Bundle.Gift.MouseButton1Click:Connect(function()
        v_u_1.OpenGift("Gift Featured Bundle", "DevProduct")
    end)
    v_u_10(v_u_38.Tabs.Container.Featured.Bundle.Purchase)
    v_u_38.Tabs.Container.Featured.Bundle.Purchase.MouseButton1Click:Connect(function()
        local v270 = v_u_8.Get(v_u_24, "Gamepasses")
        local v271 = v_u_12.GetActiveBundle()
        if v270 and (v271 and not table.find(v270, v271.bundleId)) then
            v_u_2:PromptProductPurchase(v_u_24, v_u_20["Purchase Featured Bundle"].DevProductId)
        end
    end)
    local v272 = {
        ["M4A1-S"] = {
            ["productName"] = "M4A1-S | Anodized Red",
            ["weaponName"] = "M4A1-S",
            ["skinName"] = "Anodized Red"
        },
        ["MP9"] = {
            ["productName"] = "MP-9 | Anodized Red",
            ["weaponName"] = "MP9",
            ["skinName"] = "Anodized Red"
        },
        ["AUG"] = {
            ["productName"] = "AUG | Anodized Red",
            ["weaponName"] = "AUG",
            ["skinName"] = "Anodized Red"
        }
    }
    for v273, v_u_274 in pairs(v272) do
        local v275 = v_u_38.Tabs.Container.Featured.Bundle.Frame:FindFirstChild(v273)
        if v275 then
            if v275:FindFirstChild("Gift") then
                v_u_10(v275.Gift)
                v275.Gift.MouseButton1Click:Connect(function()
                    v_u_1.OpenGift("Gift " .. v_u_274.productName, "DevProduct")
                end)
            end
            if v275:FindFirstChild("Purchase") then
                v_u_10(v275.Purchase)
                v275.Purchase.MouseButton1Click:Connect(function()
                    v_u_2:PromptProductPurchase(v_u_24, v_u_20[v_u_274.productName].DevProductId)
                end)
            end
            if v275:FindFirstChild("Inspect") then
                v_u_10(v275.Inspect)
                v275.Inspect.MouseButton1Click:Connect(function()
                    v_u_16.broadcastRouter("RunInterfaceSound", "UI Click")
                    v_u_16.broadcastRouter("WeaponInspect", v_u_274.weaponName, v_u_274.skinName, 0, nil, nil, nil, nil, nil, 1, nil, 1, nil)
                end)
            end
        end
    end
    v_u_38.Gift.Search.TextBox.Focused:Connect(function()
        local v276 = v_u_38.Gift.Container:FindFirstChild("SearchResult")
        if v276 then
            v276:Destroy()
        end
        for _, v277 in ipairs(v_u_38.Gift.Container:GetChildren()) do
            if v277:IsA("Frame") then
                v277.Visible = true
            end
        end
    end)
    v_u_38.Gift.Search.TextBox.FocusLost:Connect(function()
        v_u_1.SearchPlayerGift(v_u_38.Gift.Search.TextBox.Text)
    end)
    v_u_6.Heartbeat:Connect(function(p278)
        local v279 = v_u_23:getPosition()
        local v280 = v_u_38.Top.Credits.TextLabel
        local v281 = math.round(v279)
        v280.Text = ("%*"):format((tostring(v281):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "")))
        v_u_23:update(p278)
        local v282 = v_u_25 + 0.85 * p278
        v_u_38.Top.Categories.Credits.TextLabel.UIGradient.Offset = Vector2.new(v282, 0)
        v_u_25 = v282
        if v_u_25 > 1 then
            v_u_25 = -1
        end
        local v283 = v_u_12.GetActiveBundle()
        if v283 then
            v_u_38.Tabs.Container.Featured.Bundle.Header.Timer.Text = v_u_58(v283.discontinueDate)
        end
    end)
end
function v_u_1.Start()
    v_u_1.OpenTab("Featured")
    local v284, v285 = pcall(function()
        return v_u_4:GetPolicyInfoForPlayerAsync(v_u_24)
    end)
    v_u_26 = not (v284 and (v285 and v285.ArePaidRandomItemsRestricted))
    if not v_u_26 then
        v_u_38.Top.Categories.Credits.Visible = false
    end
    for _, v_u_286 in ipairs(v_u_38.Top.Categories:GetChildren()) do
        if v_u_286:IsA("TextButton") then
            v_u_70(v_u_286)
            v_u_286.MouseButton1Click:Connect(function()
                v_u_1.OpenTab(v_u_286.Name)
            end)
        end
    end
    for _, v287 in ipairs(v_u_38.Tabs.Container.Credits.Container:GetChildren()) do
        if v287:IsA("Frame") then
            v_u_1.SetupCreditsFrame(v287)
        end
    end
    v_u_38.CaseContent.List.Amount.MouseButton1Click:Connect(function()
        local v_u_288 = v_u_38.CaseContent.List.Amount.Container
        v_u_288.Visible = not v_u_288.Visible
        if v_u_288.Visible then
            task.defer(function()
                local v289 = v_u_288.AbsoluteCanvasSize.Y - v_u_288.AbsoluteWindowSize.Y
                local v290 = math.max(0, v289)
                v_u_288.CanvasPosition = Vector2.new(v_u_288.CanvasPosition.X, v290)
            end)
        end
    end)
    for _, v_u_291 in ipairs(v_u_38.CaseContent.List.Amount.Container:GetChildren()) do
        if v_u_291:IsA("TextButton") then
            v_u_291.MouseEnter:Connect(function()
                if not v_u_291:GetAttribute("Selected") then
                    v_u_291.Frame.BackgroundTransparency = 0.5
                end
            end)
            v_u_291.MouseLeave:Connect(function()
                if not v_u_291:GetAttribute("Selected") then
                    v_u_291.Frame.BackgroundTransparency = 1
                end
            end)
            v_u_291.MouseButton1Click:Connect(function()
                local v292 = v_u_28.price
                local v293 = v_u_291.Name
                local v294 = v292 * tonumber(v293)
                v_u_38.CaseContent.List.Buy.Header.TextLabel.Text = ("BUY (%*)"):format((tostring(v294):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "")))
                local v295 = v_u_38.CaseContent.List.Amount.Header.TextLabel
                local v296 = v_u_291.Name
                v295.Text = tostring(v296)
                v_u_38.CaseContent.List.Amount.Container.Visible = false
                for _, v297 in ipairs(v_u_38.CaseContent.List.Amount.Container:GetChildren()) do
                    if v297:IsA("TextButton") then
                        v297.Frame.BackgroundTransparency = v297 == v_u_291 and 0 or 1
                        v297:SetAttribute("Selected", v297 == v_u_291)
                    end
                end
            end)
        end
    end
    v_u_8.CreateListener(v_u_24, "Gamepasses", function(p298)
        local v299 = v_u_12.GetActiveBundle()
        if v299 and table.find(p298, v299.bundleId) then
            v_u_38.Tabs.Container.Featured.Bundle.Purchase.Credits.Amount.Text = "OWNED"
        end
    end)
    v_u_8.CreateListener(v_u_24, "Credits", function(p300)
        v_u_23:setGoal(p300)
    end)
    v_u_14.ObserveAvailableCases(function(_)
        v_u_1.UpdateCases()
    end)
    v_u_12.ObserveActiveBundle(function(p301)
        if p301 then
            v_u_38.Tabs.Container.Featured.Bundle.BundleName.Text = p301.name
        end
    end)
    v_u_15.Store.CaseOpened.Listen(function(p302)
        v_u_41("CaseOpened received from server")
        v_u_41("  CaseId:", p302.CaseId)
        v_u_41("  CaseIdentifier:", p302.CaseIdentifier or "nil")
        v_u_41("  InventoryItem:", p302.InventoryItem and (p302.InventoryItem.Name or "nil") or "nil")
        v_u_41("  DeletedCaseId:", p302.DeletedCaseId or "nil")
        if p302.InventoryItem or p302.DeletedCaseId then
            v_u_8.ApplyInventoryDelta(v_u_24, p302.InventoryItem and ({ p302.InventoryItem } or {}) or {}, p302.DeletedCaseId and ({ p302.DeletedCaseId } or nil) or nil)
        end
        v_u_41("  Calling Store.OpenCase...")
        v_u_1.OpenCase(p302.CaseId, p302.InventoryItem, p302.CaseIdentifier)
    end)
    v_u_15.Store.CaseOpenDenied.Listen(function()
        v_u_41("CaseOpenDenied received from server")
        v_u_41("  Clearing pending request state")
        v_u_40.isPendingOpenRequest = false
        v_u_40.pendingOpenRequestId = nil
        v_u_40.isQuickUnlock = false
    end)
    v_u_17.OnInspectStateChanged:Connect(function(p303)
        if not p303 then
            task.defer(function()
                local v304 = v_u_17.GetCurrentScreen()
                local v305 = v_u_38.CaseContent:GetAttribute("WasVisibleBeforeInspect") == true
                local v306 = v_u_9.IsActive()
                if v_u_28 and (v304 == "Store" and (v305 and v306)) then
                    v_u_38.Visible = true
                    v_u_38.Tabs.Container.Visible = false
                    v_u_38.CaseContent.Visible = true
                    v_u_39.Menu.Top.Visible = false
                    v_u_38.Top.Visible = false
                    v_u_17.SetBlurEnabled(false)
                    local v307 = v_u_17.GetMenuFrame()
                    if v307 then
                        v307.BackgroundTransparency = 1
                        return
                    end
                elseif v_u_38.CaseContent.Visible and v304 == "Inventory" then
                    v_u_38.Visible = true
                    v_u_38.Tabs.Container.Visible = false
                    v_u_38.CaseContent.Visible = true
                    v_u_39.Menu.Top.Visible = false
                    v_u_38.Top.Visible = false
                    local v308 = v_u_39.Menu:FindFirstChild("Inventory")
                    if v308 then
                        v308.Visible = false
                    end
                    v_u_17.SetBlurEnabled(false)
                    local v309 = v_u_17.GetMenuFrame()
                    if v309 then
                        v309.BackgroundTransparency = 1
                    end
                    if not v_u_9.IsActive() and v_u_28 then
                        v_u_9.ShowCaseScene(v_u_28.caseId)
                    end
                end
            end)
        end
    end)
    v_u_18.observePlayer(function(p310)
        if v_u_24 == p310 then
            return function() end
        end
        local v_u_311 = v_u_3.Assets.UI.Store.PlayerTemplate:Clone()
        v_u_311.Player.Avatar.Image = ("rbxthumb://type=AvatarHeadShot&id=%*&w=420&h=420"):format(p310.UserId)
        v_u_311.Player.Username.Text = ("@%*"):format(p310.Name)
        v_u_311.Parent = v_u_38.Gift.Container
        local v312 = p310.UserId
        v_u_311.Name = tostring(v312)
        v_u_1.ActivateGiftTemplate(v_u_311, p310.UserId)
        return function()
            if v_u_311 then
                v_u_311:Destroy()
            end
        end
    end)
end
return v_u_1