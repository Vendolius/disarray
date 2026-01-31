local v_u_1 = {}
local v_u_2 = game:GetService("ReplicatedStorage")
local v_u_3 = game:GetService("TweenService")
local v_u_4 = game:GetService("Players")
local v5 = require(v_u_2.Shared.Janitor)
local v_u_6 = require(v_u_2.Database.Security.Remotes)
local v_u_7 = require(v_u_2.Database.Components.Libraries.Skins)
local v_u_8 = require(v_u_2.Database.Components.Libraries.Cases)
local v_u_9 = require(v_u_2.Controllers.CameraController)
local v_u_10 = require(v_u_2.Controllers.SpectateController)
local v_u_11 = require(v_u_2.Controllers.DataController)
local v_u_12 = require(v_u_2.Database.Security.Router)
local v_u_13 = require(v_u_2.Interface.MenuState)
local v_u_14 = require(v_u_2.Database.Custom.GameStats.Rarities)
local v_u_15 = require(v_u_2.Database.Custom.GameStats.LevelsIcon)
local v_u_16 = require(v_u_2.Classes.Sound)
local v_u_17 = CFrame.Angles(-1.5707963267948966, 0, 0)
local v_u_18 = CFrame.new(0, 0, -0.025)
local v_u_19 = CFrame.new(-0.251, 0.806, -0.406) * CFrame.Angles(0, -1.5707963267948966, 1.5707963267948966)
local v_u_20 = {
    {
        ["maxLevel"] = 5,
        ["title"] = "Recruit"
    },
    {
        ["maxLevel"] = 10,
        ["title"] = "Private"
    },
    {
        ["maxLevel"] = 15,
        ["title"] = "Corporal"
    },
    {
        ["maxLevel"] = 20,
        ["title"] = "Sergeant"
    },
    {
        ["maxLevel"] = 25,
        ["title"] = "Master Sergeant"
    },
    {
        ["maxLevel"] = 30,
        ["title"] = "Lieutenant"
    },
    {
        ["maxLevel"] = 35,
        ["title"] = "Captain"
    },
    {
        ["maxLevel"] = 40,
        ["title"] = "Global Elite"
    }
}
local v_u_21 = v_u_4.LocalPlayer
local v_u_22 = v_u_21:WaitForChild("PlayerGui")
local v_u_23 = workspace.CurrentCamera
local v_u_24 = v_u_2.Assets.Characters
local v_u_25 = {
    {
        ["Entrance"] = "rbxassetid://100747011940776",
        ["Idle"] = "rbxassetid://100747011940776"
    },
    {
        ["Entrance"] = "rbxassetid://103701913618746",
        ["Idle"] = "rbxassetid://100955283476946"
    },
    {
        ["Entrance"] = "rbxassetid://91396952135880",
        ["Idle"] = "rbxassetid://120200138438261"
    },
    {
        ["Entrance"] = "rbxassetid://136102955582599",
        ["Idle"] = "rbxassetid://74544097369437"
    },
    {
        ["Entrance"] = "rbxassetid://71439100344953",
        ["Idle"] = "rbxassetid://122693948164334"
    }
}
local v_u_26 = {
    ["CT"] = {
        ["Character"] = "IDF",
        ["Weapon"] = "M4A1-S",
        ["Glove"] = "CT Glove"
    },
    ["T"] = {
        ["Character"] = "Anarchist",
        ["Weapon"] = "AK-47",
        ["Glove"] = "T Glove"
    }
}
local v_u_27 = {
    ["Counter-Terrorists"] = "CT",
    ["Terrorists"] = "T"
}
local v_u_28 = {
    ["Right Arm"] = "RightGlove",
    ["Left Arm"] = "LeftGlove"
}
local v_u_29 = {
    ["Right Arm"] = "RightHand",
    ["Left Arm"] = "LeftHand"
}
local v_u_30 = v5.new()
local v_u_31 = false
local v_u_32 = 0
local v_u_33 = nil
local function v_u_39()
    local v34 = workspace:FindFirstChild("Debris")
    if v34 then
        for _, v35 in v34:GetChildren() do
            v35:Destroy()
        end
    end
    local v36 = workspace:FindFirstChild("Characters")
    if v36 then
        for _, v37 in v36:GetChildren() do
            if v37:IsA("Folder") then
                for _, v38 in v37:GetChildren() do
                    v38:Destroy()
                end
            end
        end
    end
    if v_u_21.Character then
        v_u_21.Character:Destroy()
    end
end
local function v_u_42(p40, p41)
    if p40:IsA("TextLabel") or p40:IsA("TextButton") then
        p40.TextTransparency = p41
        return
    elseif p40:IsA("ImageLabel") or p40:IsA("ImageButton") then
        p40.ImageTransparency = p41
        return
    elseif p40:IsA("Frame") then
        p40.BackgroundTransparency = p41
    elseif p40:IsA("UIStroke") then
        p40.Transparency = p41
    end
end
local function v_u_46(p43, p44)
    local v45 = TweenInfo.new(0.5)
    if p43:IsA("TextLabel") or p43:IsA("TextButton") then
        v_u_3:Create(p43, v45, {
            ["TextTransparency"] = p44
        }):Play()
        return
    elseif p43:IsA("ImageLabel") or p43:IsA("ImageButton") then
        v_u_3:Create(p43, v45, {
            ["ImageTransparency"] = p44
        }):Play()
        return
    elseif p43:IsA("Frame") then
        v_u_3:Create(p43, v45, {
            ["BackgroundTransparency"] = p44
        }):Play()
    elseif p43:IsA("UIStroke") then
        v_u_3:Create(p43, v45, {
            ["Transparency"] = p44
        }):Play()
    end
end
local function v_u_49(p47)
    if p47:GetAttribute("SkipFade") then
        return true
    end
    local v48 = p47.Parent
    while v48 and v48:IsA("GuiObject") do
        if v48:GetAttribute("SkipFade") then
            return true
        end
        v48 = v48.Parent
    end
    return false
end
local function v_u_54(p50, p51)
    local v52
    if v_u_49(p50) then
        v52 = nil
    else
        v52 = v_u_3:Create(p50, TweenInfo.new(0.5), {
            ["BackgroundTransparency"] = p51
        })
    end
    for _, v53 in p50:GetDescendants() do
        if not v_u_49(v53) then
            v_u_46(v53, p51)
        end
    end
    if v52 then
        v52:Play()
    end
    return v52
end
local function v_u_57(p55)
    if not v_u_49(p55) then
        p55.BackgroundTransparency = 1
    end
    for _, v56 in p55:GetDescendants() do
        if not v_u_49(v56) then
            v_u_42(v56, 1)
        end
    end
    p55.Visible = true
    return v_u_54(p55, 0)
end
local function v_u_61(p58)
    local v59 = {}
    for _, v60 in p58:GetDescendants() do
        if v60:IsA("UIStroke") then
            v59[v60] = v60.Transparency
        end
    end
    return {
        ["BackgroundTransparency"] = p58.BackgroundTransparency,
        ["Strokes"] = v59
    }
end
local function v_u_89(p62)
    local v63 = v_u_22:FindFirstChild("MainGui")
    local v64
    if v63 then
        local v65 = v63:FindFirstChild("Gameplay")
        if v65 then
            v64 = v65:FindFirstChild("Middle")
        else
            v64 = nil
        end
    else
        v64 = nil
    end
    local v66
    if v64 then
        v66 = v64:FindFirstChild("EndScreen")
    else
        v66 = nil
    end
    if not v66 then
        return nil
    end
    local v67 = v66:FindFirstChild("Level")
    if not v67 then
        return nil
    end
    local v68 = v_u_33 or v_u_11.Get(v_u_21, "Level")
    if not v68 then
        return nil
    end
    local v69 = v68.Level or 1
    local v70 = v68.Experience or 0
    local v71 = v68.NextExperienceRequirement or 1000
    local v72 = v67:FindFirstChild("TextLabel")
    if not v72 then
        ::l18::
        local v73 = v67:FindFirstChild("Rank")
        if v73 then
            v73.Image = v_u_15[tostring(v69)] or ""
        end
        local v74 = v67:FindFirstChild("LevelBar")
        if not v74 then
            return nil
        end
        local v75 = v74:FindFirstChild("Current")
        local v76 = v74:FindFirstChild("Earned")
        if not (v75 and v76) then
            return nil
        end
        local v77 = v67:FindFirstChild("CurrentInfo", true)
        local v78 = v67:FindFirstChild("EarnedInfo", true)
        if not (v77 and v78) then
            return nil
        end
        v75:SetAttribute("SkipFade", true)
        v76:SetAttribute("SkipFade", true)
        v77:SetAttribute("SkipFade", true)
        v78:SetAttribute("SkipFade", true)
        local v79 = ("%*xp"):format(v70)
        local v80 = v77:FindFirstChild("Amount")
        if v80 then
            v80.Text = v79
        end
        local v81 = ("+%*xp"):format(p62)
        local v82 = v78:FindFirstChild("Amount")
        if v82 then
            v82.Text = v81
        end
        local v83 = v75.Size.Y
        local v84 = v_u_61(v77)
        local v85 = v_u_61(v78)
        return {
            ["currentXP"] = v70,
            ["xpEarned"] = p62,
            ["nextLevelXP"] = math.max(v71, 1),
            ["currentLevel"] = v69,
            ["barHeight"] = v83,
            ["levelBar"] = v74,
            ["levelFrame"] = v67,
            ["currentBar"] = v75,
            ["earnedBar"] = v76,
            ["currentInfo"] = v77,
            ["earnedInfo"] = v78,
            ["currentInfoTransparency"] = v84,
            ["earnedInfoTransparency"] = v85
        }
    end
    local v86 = "[%* Rank %*]"
    for _, v87 in ipairs(v_u_20) do
        if v69 <= v87.maxLevel then
            v88 = v87.title
            ::l22::
            v72.Text = v86:format(v88, v69)
            goto l18
        end
    end
    local v88 = "Global Elite"
    goto l22
end
local function v_u_100(p90, p91, p92, p93)
    local v94 = p90.Position
    local v95 = p91.AbsolutePosition.X + p92 * p91.AbsoluteSize.X
    local v96 = p90.Parent
    local v97 = v96 and v96.AbsolutePosition.X or 0
    local v98 = p90.AnchorPoint.X * p90.AbsoluteSize.X
    local v99 = v95 - v97 + v98
    return v_u_3:Create(p90, p93, {
        ["Position"] = UDim2.new(0, v99, v94.Y.Scale, v94.Y.Offset)
    })
end
local function v_u_111(p101, p102, p103, p104, p105)
    local v106 = p101.AbsolutePosition.X + p101.AbsoluteSize.X
    local v107 = p102.Parent.AbsolutePosition.X
    local v108 = p102.AnchorPoint.X * p102.AbsoluteSize.X
    if v107 + p103 - v108 < v106 + 5 then
        local v109 = p101.AbsoluteSize.Y / 2 + 5
        return UDim2.new(0, p103, p104, p105 + v109)
    else
        local v110 = p101.Position
        return UDim2.new(0, p103, v110.Y.Scale, v110.Y.Offset)
    end
end
local function v_u_123(p112, p113, p114, p115, p116, p117, p118)
    local v119 = p114.AbsolutePosition.X + p115 * p114.AbsoluteSize.X
    local v120 = p112.Parent
    local v121 = v120 and v120.AbsolutePosition.X or 0
    local v122 = p112.AnchorPoint.X * p112.AbsoluteSize.X
    return v_u_3:Create(p112, p116, {
        ["Position"] = v_u_111(p113, p112, v119 - v121 + v122, p117, p118)
    })
end
local function v_u_221(p124)
    if not v_u_31 then
        return
    end
    local v125 = p124.currentXP / p124.nextLevelXP
    local v126 = math.clamp(v125, 0, 1)
    local v127 = p124.currentXP + p124.xpEarned
    local v128 = v127 / p124.nextLevelXP
    local v129 = math.clamp(v128, 0, 1)
    local v130 = p124.nextLevelXP <= v127
    p124.currentBar.Visible = false
    p124.earnedBar.Visible = false
    local v131 = p124.currentBar
    local v132 = p124.barHeight
    v131.Size = UDim2.new(0, 0, v132.Scale, v132.Offset)
    local v133 = p124.earnedBar
    local v134 = p124.barHeight
    v133.Size = UDim2.new(0, 0, v134.Scale, v134.Offset)
    p124.currentInfo.Visible = false
    p124.earnedInfo.Visible = false
    local v135 = p124.currentInfo
    local v136 = p124.currentInfoTransparency
    v135.BackgroundTransparency = v136.BackgroundTransparency
    for v137, v138 in pairs(v136.Strokes) do
        if v137 and v137.Parent then
            v137.Transparency = v138
        end
    end
    local v139 = p124.earnedInfo
    local v140 = p124.earnedInfoTransparency
    v139.BackgroundTransparency = v140.BackgroundTransparency
    for v141, v142 in pairs(v140.Strokes) do
        if v141 and v141.Parent then
            v141.Transparency = v142
        end
    end
    local v143 = p124.levelBar
    local v144 = p124.currentInfo
    local v145 = v143.AbsolutePosition.X + 0 * v143.AbsoluteSize.X
    local v146 = v144.Parent
    local v147 = v146 and v146.AbsolutePosition.X or 0
    local v148 = v144.AnchorPoint.X * v144.AbsoluteSize.X
    local v149 = v145 - v147 + v148
    local v150 = p124.levelBar
    local v151 = p124.earnedInfo
    local v152 = v150.AbsolutePosition.X + 0 * v150.AbsoluteSize.X
    local v153 = v151.Parent
    local v154 = v153 and v153.AbsolutePosition.X or 0
    local v155 = v151.AnchorPoint.X * v151.AbsoluteSize.X
    local v156 = v152 - v154 + v155
    local v157 = p124.currentInfo.Position
    local v158 = p124.earnedInfo.Position
    p124.currentInfo.Position = UDim2.new(0, v149, v157.Y.Scale, v157.Y.Offset)
    p124.earnedInfo.Position = UDim2.new(0, v156, v158.Y.Scale, v158.Y.Offset)
    task.wait(0.5)
    if not v_u_31 then
        return
    end
    p124.currentBar.Visible = true
    p124.currentInfo.Visible = true
    if v126 > 0 then
        local v159 = TweenInfo.new(0.75, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
        local v160 = v_u_3
        local v161 = p124.currentBar
        local v162 = {}
        local v163 = p124.barHeight
        v162.Size = UDim2.new(v126, 0, v163.Scale, v163.Offset)
        local v164 = v160:Create(v161, v159, v162)
        local v165 = v_u_100(p124.currentInfo, p124.levelBar, v126, v159)
        local v166 = {
            ["Parent"] = v_u_23,
            ["Name"] = "XP Bar Fill"
        }
        v_u_16.new("Interface"):play(v166)
        v164:Play()
        v165:Play()
        v164.Completed:Wait()
        if not v_u_31 then
            return
        end
    end
    if p124.xpEarned <= 0 then
        return
    end
    task.wait(0.6)
    if not v_u_31 then
        return
    end
    local v167 = p124.earnedBar
    local v168 = p124.barHeight
    v167.Size = UDim2.new(v126, 0, v168.Scale, v168.Offset)
    p124.earnedBar.Visible = true
    p124.earnedInfo.Visible = true
    local v169 = p124.levelBar
    local v170 = p124.earnedInfo
    local v171 = v169.AbsolutePosition.X + v126 * v169.AbsoluteSize.X
    local v172 = v170.Parent
    local v173 = v172 and v172.AbsolutePosition.X or 0
    local v174 = v170.AnchorPoint.X * v170.AbsoluteSize.X
    local v175 = v171 - v173 + v174
    local v176 = v_u_111(p124.currentInfo, p124.earnedInfo, v175, v158.Y.Scale, v158.Y.Offset)
    p124.earnedInfo.Position = v176
    if not v130 then
        local v177 = TweenInfo.new(0.75, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
        local v178 = v_u_3
        local v179 = p124.earnedBar
        local v180 = {}
        local v181 = p124.barHeight
        v180.Size = UDim2.new(v129, 0, v181.Scale, v181.Offset)
        local v182 = v178:Create(v179, v177, v180)
        local v183 = v_u_123(p124.earnedInfo, p124.currentInfo, p124.levelBar, v129, v177, v158.Y.Scale, v158.Y.Offset)
        local v184 = {
            ["Parent"] = v_u_23,
            ["Name"] = "XP Bar Fill"
        }
        local v185 = v_u_16.new("Interface"):play(v184)
        if v185 then
            v185.PlaybackSpeed = 1.15
        end
        v182:Play()
        v183:Play()
        v182.Completed:Wait()
        return
    end
    local v186 = TweenInfo.new(0.375, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
    local v187 = v_u_3
    local v188 = p124.earnedBar
    local v189 = {}
    local v190 = p124.barHeight
    v189.Size = UDim2.new(1, 0, v190.Scale, v190.Offset)
    local v191 = v187:Create(v188, v186, v189)
    local v192 = v_u_123(p124.earnedInfo, p124.currentInfo, p124.levelBar, 1, v186, v158.Y.Scale, v158.Y.Offset)
    local v193 = {
        ["Parent"] = v_u_23,
        ["Name"] = "XP Bar Fill"
    }
    local v194 = v_u_16.new("Interface"):play(v193)
    if v194 then
        v194.PlaybackSpeed = 1.15
    end
    v191:Play()
    v192:Play()
    v191.Completed:Wait()
    if not v_u_31 then
        return
    end
    local v195 = {
        ["Parent"] = v_u_23,
        ["Name"] = "Level Up"
    }
    v_u_16.new("Interface"):play(v195)
    local v196 = (v127 - p124.nextLevelXP) / p124.nextLevelXP
    local v197 = math.clamp(v196, 0, 1)
    local v198 = p124.currentLevel + 1
    local v199 = p124.levelFrame:FindFirstChild("TextLabel")
    if not v199 then
        ::l41::
        local v200 = p124.levelFrame:FindFirstChild("Rank")
        if v200 then
            v200.Image = v_u_15[tostring(v198)] or ""
        end
        local v201 = p124.currentBar
        local v202 = p124.barHeight
        v201.Size = UDim2.new(0, 0, v202.Scale, v202.Offset)
        local v203 = p124.earnedBar
        local v204 = p124.barHeight
        v203.Size = UDim2.new(0, 0, v204.Scale, v204.Offset)
        p124.currentInfo.Visible = false
        local v205 = p124.levelBar
        local v206 = p124.earnedInfo
        local v207 = v205.AbsolutePosition.X + 0 * v205.AbsoluteSize.X
        local v208 = v206.Parent
        local v209 = v208 and v208.AbsolutePosition.X or 0
        local v210 = v206.AnchorPoint.X * v206.AbsoluteSize.X
        local v211 = v207 - v209 + v210
        p124.earnedInfo.Position = UDim2.new(0, v211, v158.Y.Scale, v158.Y.Offset)
        local v212 = v_u_3
        local v213 = p124.earnedBar
        local v214 = {}
        local v215 = p124.barHeight
        v214.Size = UDim2.new(v197, 0, v215.Scale, v215.Offset)
        local v216 = v212:Create(v213, v186, v214)
        local v217 = v_u_100(p124.earnedInfo, p124.levelBar, v197, v186)
        v216:Play()
        v217:Play()
        v216.Completed:Wait()
        return
    end
    local v218 = "[%* Rank %*]"
    for _, v219 in ipairs(v_u_20) do
        if v198 <= v219.maxLevel then
            v220 = v219.title
            ::l45::
            v199.Text = v218:format(v220, v198)
            goto l41
        end
    end
    local v220 = "Global Elite"
    goto l45
end
local function v_u_227(p222)
    local v223 = not p222.Type and "" or string.lower(p222.Type)
    local v224 = p222.Name
    if v223 == "credits" then
        return "rbxassetid://115958498634807"
    end
    if v223 == "case" or (v223 == "sticker capsule" or (v223 == "charm pack" or v223 == "charm capsule")) then
        local v225 = v_u_8.GetCaseByName(v224)
        if v225 and v225.imageAssetId then
            return v225.imageAssetId
        end
    end
    local v226 = p222.Skin and (v224 and v_u_7.GetSkinInformation(v224, p222.Skin))
    if v226 then
        if v226.wearImages and v226.wearImages[1] then
            return v226.wearImages[1].assetId
        end
        if v226.charmImages and v226.charmImages[1] then
            return v226.charmImages[1].assetId
        end
        if v226.imageAssetId then
            return v226.imageAssetId
        end
    end
    return "rbxassetid://18822070027"
end
local function v_u_255(p228)
    if v_u_31 and (p228 and #p228 ~= 0) then
        local v229 = v_u_22:FindFirstChild("MainGui")
        local v230
        if v229 then
            local v231 = v229:FindFirstChild("Gameplay")
            if v231 then
                v230 = v231:FindFirstChild("Middle")
            else
                v230 = nil
            end
        else
            v230 = nil
        end
        local v232
        if v230 then
            v232 = v230:FindFirstChild("EndScreen")
        else
            v232 = nil
        end
        if v232 then
            local v233 = v232:FindFirstChild("Drops")
            local v234
            if v233 then
                v234 = v233:FindFirstChild("Container")
            else
                v234 = v233
            end
            local v235
            if v234 then
                v235 = v234:FindFirstChild("ItemTemplate")
            else
                v235 = v234
            end
            if v235 then
                v234:SetAttribute("SkipFade", true)
                v235.Visible = false
                for _, v236 in v234:GetChildren() do
                    if v236:IsA("Frame") and v236.Name ~= "ItemTemplate" then
                        v236:Destroy()
                    end
                end
                v233.Visible = false
                task.wait(0.8)
                if v_u_31 then
                    local v237 = {}
                    for v238, v239 in ipairs(p228) do
                        local v240 = v239.reward
                        local v241 = v240.type == "credits"
                        local v242 = v240.inventoryItem
                        if v241 or v242 then
                            local v243 = v235:Clone()
                            v243.Name = "Drop_" .. v238
                            v243.Visible = false
                            v243.Parent = v234
                            local v244 = v243:FindFirstChild("Content")
                            if v244 then
                                local v245 = v244:FindFirstChild("Icon")
                                if v245 then
                                    v245.Image = v241 and "rbxassetid://115958498634807" or v_u_227(v242)
                                end
                                local v246 = v244:FindFirstChild("amount") or v244:FindFirstChild("Amount")
                                if v246 then
                                    if v241 and v240.amount then
                                        v246.Visible = true
                                        v246.Text = ("x%*"):format(v240.amount)
                                    else
                                        v246.Visible = false
                                    end
                                end
                                local v247 = v244:FindFirstChild("RarityFrame")
                                if v247 then
                                    v247 = v247:FindFirstChild("UIGradient")
                                end
                                if v247 then
                                    if v241 then
                                        v242 = "Rare"
                                    elseif v242 then
                                        v242 = v242.Rarity
                                    end
                                    if v242 then
                                        local v248 = v_u_14[v242]
                                        if v248 and v248.ColorSequence then
                                            v247.Color = v248.ColorSequence
                                        end
                                    end
                                end
                                local v249 = v244.Size
                                v244.Size = UDim2.new(v249.X.Scale * 1.25, v249.X.Offset * 1.25, v249.Y.Scale * 1.25, v249.Y.Offset * 1.25)
                                local v250 = v243:FindFirstChild("Player", true)
                                if v250 and v239.userId > 0 then
                                    v250.Image = ("rbxthumb://type=AvatarHeadShot&id=%*&w=150&h=150"):format(v239.userId)
                                end
                                table.insert(v237, {
                                    ["item"] = v243,
                                    ["content"] = v244,
                                    ["originalSize"] = v249
                                })
                            else
                                v243:Destroy()
                            end
                        end
                    end
                    if #v237 == 0 then
                        return
                    else
                        v_u_57(v233)
                        task.wait(0.5)
                        if v_u_31 then
                            local v_u_251 = TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
                            for v252, v_u_253 in ipairs(v237) do
                                task.delay((v252 - 1) * 0.35, function()
                                    if v_u_31 then
                                        v_u_253.item.Visible = true
                                        local v254 = v_u_3:Create(v_u_253.content, v_u_251, {
                                            ["Size"] = v_u_253.originalSize
                                        })
                                        v_u_30:Add(v254, "Cancel")
                                        v254:Play()
                                    end
                                end)
                            end
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
    else
        return
    end
end
local function v_u_282(p256, p257, p258, p259)
    local v260 = v_u_22:FindFirstChild("MainGui")
    if v260 then
        local v261 = v260:FindFirstChild("Menu")
        if v261 then
            v261.Visible = false
            v_u_9.setForceLockOverride("Menu", false)
        end
        local v262 = v260:FindFirstChild("Gameplay")
        if v262 then
            v262.Visible = true
            for _, v263 in v262:GetChildren() do
                if v263:IsA("Frame") or v263:IsA("CanvasGroup") then
                    v263.Visible = false
                end
            end
            local v264 = v262:FindFirstChild("Middle")
            if v264 then
                for _, v265 in v264:GetChildren() do
                    if v265:IsA("Frame") or v265:IsA("CanvasGroup") then
                        v265.Visible = false
                    end
                end
                v264.Visible = true
                local v266 = v264:FindFirstChild("EndScreen")
                if v266 then
                    v266.Visible = true
                    local v267 = v266:FindFirstChild("Victory")
                    local v268 = v266:FindFirstChild("Defeat")
                    if v267 then
                        v267.BackgroundTransparency = 0
                        for _, v269 in v267:GetDescendants() do
                            v_u_42(v269, 0)
                        end
                        v267.Visible = p256
                    end
                    if v268 then
                        v268.BackgroundTransparency = 0
                        for _, v270 in v268:GetDescendants() do
                            v_u_42(v270, 0)
                        end
                        v268.Visible = not p256
                    end
                    local v271 = v266:FindFirstChild("MVP")
                    if v271 then
                        v271.Visible = true
                    end
                    if p257 == "Counter-Terrorists" then
                        local v272 = p258
                        p258 = p259
                        p259 = v272
                    end
                    local v273 = ("<b>%*</b> - %*"):format(p259, p258)
                    if v267 then
                        local v274 = v267:FindFirstChild("Score")
                        local v275 = v274 and v274:FindFirstChild("TextLabel")
                        if v275 then
                            v275.Text = v273
                        end
                    end
                    if v268 then
                        local v276 = v268:FindFirstChild("Score")
                        local v277 = v276 and v276:FindFirstChild("TextLabel")
                        if v277 then
                            v277.Text = v273
                        end
                    end
                    local v278 = v266:FindFirstChild("MapVote")
                    if v278 then
                        v278.Visible = false
                    end
                    local v279 = v266:FindFirstChild("Top")
                    if v279 then
                        v279.Visible = false
                    end
                    local v280 = v266:FindFirstChild("Level")
                    if v280 then
                        v280.Visible = false
                    end
                    local v281 = v266:FindFirstChild("Drops")
                    if v281 then
                        v281.Visible = false
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
local function v_u_303()
    local v283 = v_u_22:FindFirstChild("MainGui")
    if v283 then
        local v284 = v283:FindFirstChild("Gameplay")
        if v284 then
            local v285 = v284:FindFirstChild("Middle")
            if v285 then
                local v286 = v285:FindFirstChild("EndScreen")
                if v286 then
                    v286.Visible = false
                    local v287 = v286:FindFirstChild("Victory")
                    local v288 = v286:FindFirstChild("Defeat")
                    local v289 = v286:FindFirstChild("Level")
                    if v287 then
                        v287.Visible = false
                    end
                    if v288 then
                        v288.Visible = false
                    end
                    if v289 then
                        v289.Visible = false
                        local v290 = v289:FindFirstChild("LevelBar")
                        if v290 then
                            local v291 = v290:FindFirstChild("Current")
                            local v292 = v290:FindFirstChild("Earned")
                            if v291 then
                                v291:SetAttribute("SkipFade", nil)
                            end
                            if v292 then
                                v292:SetAttribute("SkipFade", nil)
                            end
                        end
                        local v293 = v289:FindFirstChild("CurrentInfo", true)
                        local v294 = v289:FindFirstChild("EarnedInfo", true)
                        if v293 then
                            v293:SetAttribute("SkipFade", nil)
                        end
                        if v294 then
                            v294:SetAttribute("SkipFade", nil)
                        end
                    end
                    local v295 = v286:FindFirstChild("MVP")
                    if v295 then
                        v295.Visible = false
                        for v296 = 1, 5 do
                            local v297 = v295:FindFirstChild((tostring(v296)))
                            if v297 then
                                v297.Visible = false
                            end
                        end
                    end
                    local v298 = v286:FindFirstChild("Drops")
                    if v298 then
                        v298.Visible = false
                        local v299 = v298:FindFirstChild("Container")
                        if v299 then
                            v299:SetAttribute("SkipFade", nil)
                            for _, v300 in v299:GetChildren() do
                                if v300:IsA("Frame") and v300.Name ~= "ItemTemplate" then
                                    v300:Destroy()
                                end
                            end
                        end
                    end
                    local v301 = v286:FindFirstChild("MapVote")
                    if v301 then
                        v301.Visible = true
                    end
                    local v302 = v286:FindFirstChild("Top")
                    if v302 then
                        v302.Visible = true
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
local function v_u_307(p304)
    local v305 = v_u_11.Get(v_u_21, "Inventory")
    if type(v305) ~= "table" then
        return nil
    end
    for _, v306 in ipairs(v305) do
        if v306 and v306._id == p304 then
            return v306
        end
    end
    return nil
end
local function v_u_332(p308, p309, p310)
    local v311 = nil
    local v312 = nil
    local v313 = nil
    if p310 then
        v311 = p310.Name
        v312 = p310.Skin
        v313 = p310.Float
    else
        local v314 = p309 == "CT" and "Counter-Terrorists" or "Terrorists"
        local v315 = v_u_11.Get(v_u_21, "Loadout")
        local v316
        if type(v315) == "table" then
            local v317 = v315[v314]
            if type(v317) == "table" and v317.Equipped then
                v316 = v317.Equipped["Equipped Gloves"]
                if type(v316) ~= "string" or v316 == "" then
                    v316 = nil
                end
            else
                v316 = nil
            end
        else
            v316 = nil
        end
        if v316 then
            local v318 = v_u_307(v316)
            if v318 then
                v311 = v318.Name
                v312 = v318.Skin
                v313 = v318.Float
            end
        end
    end
    local v319 = v311 or v_u_26[p309].Glove
    local v320
    if v312 and (v312 ~= "" and v313 ~= nil) then
        v320 = v_u_7.GetGloves(v319, v312, v313) or nil
    else
        v320 = nil
    end
    local v321
    if v320 then
        v321 = v320:GetChildren()
    else
        local v322 = v_u_2.Assets.Weapons:FindFirstChild(v319)
        if not v322 then
            return
        end
        v321 = v322:GetChildren()
    end
    local v323 = p308:FindFirstChild("CharacterArmor") or Instance.new("Folder")
    v323.Name = "CharacterArmor"
    v323.Parent = p308
    for _, v324 in ipairs(v321) do
        if v324:IsA("BasePart") then
            local v325 = v_u_29[v324.Name]
            if v325 then
                local v326 = p308:FindFirstChild(v325)
                if v326 then
                    local v327 = v324:Clone()
                    v327.Name = v_u_28[v324.Name]
                    v327.CastShadow = false
                    v327.CanCollide = false
                    v327.CanTouch = false
                    v327.Anchored = false
                    v327.CanQuery = false
                    v327.CFrame = v326.CFrame * v_u_17
                    local v328 = v326.Size.X * 1.1
                    local v329 = v326.Size.Z
                    local v330 = v326.Size.Y
                    v327.Size = Vector3.new(v328, v329, v330) * 1.1
                    v327.Parent = v323
                    local v331 = Instance.new("Motor6D")
                    v331.Name = "GloveAttachment"
                    v331.Part0 = v326
                    v331.Part1 = v327
                    v331.C0 = v_u_18
                    v331.C1 = v327.PivotOffset * CFrame.Angles(1.5707963267948966, 0, 0)
                    v331.Parent = v327
                end
            end
        end
    end
end
local function v_u_342(p333, p334)
    local v335 = v_u_11.Get(v_u_21, "Loadout")
    if type(v335) ~= "table" then
        return nil
    end
    local v336 = v335[p333]
    if type(v336) ~= "table" or not v336.Loadout then
        return nil
    end
    local v337 = v336.Loadout.Rifles
    if v337 then
        local v338 = v337.Options
        if type(v338) == "table" then
            local v339 = v_u_11.Get(v_u_21, "Inventory")
            if type(v339) ~= "table" then
                return nil
            end
            for _, v340 in ipairs(v337.Options) do
                if type(v340) == "string" and v340 ~= "" then
                    for _, v341 in ipairs(v339) do
                        if v341 and (v341._id == v340 and v341.Name == p334) then
                            return {
                                ["Skin"] = v341.Skin,
                                ["Float"] = v341.Float,
                                ["StatTrack"] = v341.StatTrack,
                                ["NameTag"] = v341.NameTag
                            }
                        end
                    end
                end
            end
            return nil
        end
    end
    return nil
end
local function v_u_357(p343, p344, p345)
    local v346 = v_u_26[p344].Weapon
    local v347 = nil
    if p345 and (p345.Skin and p345.Skin ~= "") then
        v347 = v_u_7.GetCharacterModel(v346, p345.Skin, p345.Float, p345.StatTrack, p345.NameTag)
    else
        local v348 = v_u_342(p344 == "CT" and "Counter-Terrorists" or "Terrorists", v346)
        if v348 and (v348.Skin and v348.Skin ~= "") then
            v347 = v_u_7.GetCharacterModel(v346, v348.Skin, v348.Float, v348.StatTrack, v348.NameTag)
        end
    end
    local v349 = v347 or v_u_7.GetBaseWeaponModel(v346, "Character")
    if v349 then
        v349.Name = v346
        local v350 = p343:FindFirstChild("RightHand")
        if v350 then
            if not v349.PrimaryPart then
                local v351 = v349:FindFirstChild("Weapon")
                if v351 then
                    v351 = v351:FindFirstChild("Insert")
                end
                if not v351 then
                    v349:Destroy()
                    return
                end
                v349.PrimaryPart = v351
            end
            for _, v352 in v349:GetDescendants() do
                if v352:IsA("BasePart") then
                    v352.CanCollide = false
                    v352.CanQuery = false
                    v352.CanTouch = false
                    v352.Anchored = false
                    v352.Massless = true
                end
            end
            v349.Parent = p343
            local v353 = Instance.new("Motor6D")
            v353.Name = "WeaponAttachment"
            v353.Part0 = v350
            v353.Part1 = v349.PrimaryPart
            v353.Parent = v350
            if v346 == "AK-47" then
                v353.C0 = v_u_19
            else
                local v354 = v349:FindFirstChild("Properties")
                if v354 then
                    local v355 = v354:FindFirstChild("C0")
                    local v356 = v354:FindFirstChild("C1")
                    if v355 then
                        v353.C0 = v355.Value
                    end
                    if v356 then
                        v353.C1 = v356.Value
                    end
                end
            end
        else
            v349:Destroy()
            return
        end
    else
        return
    end
end
local function v_u_398(p358)
    local v359 = v_u_22:FindFirstChild("MainGui")
    if not v359 then
        return
    end
    local v360 = v359:FindFirstChild("Gameplay")
    if not v360 then
        return
    end
    local v361 = v360:FindFirstChild("Middle")
    if not v361 then
        return
    end
    local v362 = v361:FindFirstChild("EndScreen")
    if not v362 then
        return
    end
    local v363 = v362:FindFirstChild("MVP")
    if not v363 then
        return
    end
    local v364 = {
        3,
        2,
        4,
        1,
        5
    }
    for v365 = 1, 5 do
        local v366 = v363:FindFirstChild((tostring(v365)))
        if v366 then
            v366.Visible = false
        end
    end
    for v367, v368 in ipairs(p358) do
        local v369 = v364[v367]
        local v370 = v363:FindFirstChild((tostring(v369)))
        if v370 then
            local v371 = v368.data
            local v372 = v368.userId
            local v373 = v_u_4:GetPlayerByUserId((tonumber(v372)))
            local v374 = v373 and v373.Name or ("Player_%*"):format(v372)
            local v375 = v370:FindFirstChild("Username")
            if v375 then
                v375.Text = v374
            end
            local v376 = v370:FindFirstChild("KDA")
            if v376 then
                v376.Text = ("%*-%*-%*"):format(v371.Kills or 0, v371.Deaths or 0, v371.Assists or 0)
            end
            local v377 = v370:FindFirstChild("HSP")
            if v377 then
                local v378 = v371.Kills or 0
                local v379 = v371.Headshots or 0
                local v380
                if v378 <= 0 then
                    v380 = "0%"
                else
                    local v381 = v379 / v378 * 100
                    v380 = ("%*%%"):format((math.floor(v381)))
                end
                v377.Text = v380
            end
            local v382 = v370:FindFirstChild("APR")
            if v382 then
                local v383 = v371.ADR or 0
                local v384 = math.floor(v383)
                v382.Text = tostring(v384)
            end
            local v385 = v370:FindFirstChild("Score")
            if v385 then
                local v386 = v371.Score or 0
                v385.Text = tostring(v386)
            end
            local v387 = v370:FindFirstChild("Category")
            if v387 then
                v387.Text = v371.Accolade or "Participant"
            end
            local v388 = v370:FindFirstChild("Player")
            local v389 = v388 and v388:FindFirstChild("Avatar")
            if v389 then
                v389.Image = ("rbxthumb://type=AvatarHeadShot&id=%*&w=150&h=150"):format(v372)
            end
            local v390 = v370:FindFirstChild("Pin")
            if v390 then
                if v373 and v371.Team then
                    local v391, v392 = v_u_11.Get(v373, "Loadout", "Inventory")
                    local v393 = ""
                    if v391 and v392 then
                        local v394 = v391[v371.Team]
                        if v394 and v394.Equipped then
                            local v395 = v394.Equipped["Equipped Badge"]
                            if v395 and v395 ~= "" then
                                for _, v396 in ipairs(v392) do
                                    if v396._id == v395 then
                                        local v397 = v_u_7.GetSkinInformation(v396.Name, v396.Skin)
                                        if v397 and v397.imageAssetId then
                                            v393 = v397.imageAssetId
                                        end
                                        break
                                    end
                                end
                            end
                        end
                    end
                    if v393 == "" then
                        v390.Visible = false
                    else
                        v390.Image = v393
                        v390.Visible = true
                    end
                else
                    v390.Visible = false
                end
            end
            v370.Visible = true
        end
    end
end
local function v_u_428(p399, p400)
    local v401 = workspace:FindFirstChild("Map")
    if v401 then
        v401 = workspace.Map:FindFirstChild("EndScreen")
    end
    if not v401 then
        return {}
    end
    local v402 = v_u_27[p400]
    if not v402 then
        return {}
    end
    local v403 = v_u_26[v402]
    if not v403 then
        return {}
    end
    local v404 = v_u_24:FindFirstChild(v403.Character)
    if not v404 then
        return {}
    end
    local v405 = {}
    for v406, v407 in pairs(p399) do
        table.insert(v405, {
            ["userId"] = v406,
            ["data"] = v407
        })
    end
    table.sort(v405, function(p408, p409)
        return (p408.data.ADR or 0) > (p409.data.ADR or 0)
    end)
    local v410 = #v405
    local v411 = {}
    for v412 = 1, math.min(5, v410) do
        local v413 = v405[v412]
        table.insert(v411, v413)
    end
    v_u_398(v411)
    local v414 = {
        3,
        2,
        4,
        1,
        5
    }
    local v415 = {}
    for v416, v417 in ipairs(v411) do
        local v418 = v414[v416]
        local v419 = v401:FindFirstChild((tostring(v418)))
        if v419 then
            local v420 = v404:Clone()
            v420.Name = "EndScreenCharacter_" .. v417.userId
            v420:PivotTo(v419.CFrame)
            v420.Parent = v401
            v_u_332(v420, v402, v417.data.Gloves)
            v_u_357(v420, v402, v417.data.Weapon)
            local v421 = v420:FindFirstChild("Humanoid")
            if v421 then
                local v422 = v421:FindFirstChildOfClass("Animator")
                if not v422 then
                    v422 = Instance.new("Animator")
                    v422.Parent = v421
                end
                local v423 = v_u_25[v418]
                if v423 then
                    local v424 = Instance.new("Animation")
                    v424.AnimationId = v423.Entrance
                    local v425 = v422:LoadAnimation(v424)
                    v425.Looped = false
                    v425.Priority = Enum.AnimationPriority.Action
                    v425:Play()
                    local v426 = Instance.new("Animation")
                    v426.AnimationId = v423.Idle
                    local v427 = v422:LoadAnimation(v426)
                    v427.Looped = true
                    v427.Priority = Enum.AnimationPriority.Idle
                    v427:Play()
                    v_u_30:Add(v424)
                    v_u_30:Add(v425)
                    v_u_30:Add(v426)
                    v_u_30:Add(v427)
                end
            end
            v_u_30:Add(v420, "Destroy")
            table.insert(v415, v420)
        end
    end
    return v415
end
local function v_u_433()
    local v429 = workspace:FindFirstChild("Map")
    if v429 then
        v429 = workspace.Map:FindFirstChild("EndScreen")
    end
    if not v429 then
        return nil
    end
    local v430 = v429:FindFirstChild("Start")
    local v431 = v429:FindFirstChild("End")
    if not (v430 and v431) then
        warn("[EndScreen] Missing Start or End part!")
        return nil
    end
    v_u_23.CameraType = Enum.CameraType.Scriptable
    v_u_23.CFrame = v430.CFrame
    v_u_23.Focus = v430.CFrame
    v_u_23.FieldOfView = 60
    v_u_9.setMouseEnabled(true)
    local v432 = v_u_3:Create(v_u_23, TweenInfo.new(14, Enum.EasingStyle.Linear), {
        ["CFrame"] = v431.CFrame
    })
    v432:Play()
    return v432
end
local function v_u_441()
    v_u_13.SetBlurEnabled(false)
    if v_u_13.IsCaseSceneActive() then
        v_u_12.broadcastRouter("CaseSceneCloseForGameEnd")
    end
    if v_u_13.IsInspectActive() then
        v_u_12.broadcastRouter("WeaponInspectCloseForGameEnd")
    end
    local v434 = v_u_22:FindFirstChild("MainGui")
    if v434 then
        local v435 = v434:FindFirstChild("Menu")
        if v435 and v435.Visible then
            v435.Visible = false
            v_u_9.setForceLockOverride("Menu", false)
        end
        if v435 then
            v435.BackgroundTransparency = 1
        end
    end
    local v436 = v_u_22:FindFirstChild("MainGui")
    local v437
    if v436 then
        local v438 = v436:FindFirstChild("Gameplay")
        if v438 then
            v437 = v438:FindFirstChild("Middle")
        else
            v437 = nil
        end
    else
        v437 = nil
    end
    if v437 then
        local v439 = v437:FindFirstChild("BuyMenu")
        if v439 and v439.Visible then
            require(v_u_2.Interface.Screens.Gameplay.Middle.BuyMenu).closeFrame()
        end
        local v440 = v437:FindFirstChild("TeamSelection")
        if v440 and v440.Visible then
            require(v_u_2.Interface.Screens.Gameplay.Middle.TeamSelection).closeFrame()
        end
    end
end
function v_u_1.IsActive()
    return v_u_31
end
function v_u_1._runSequence(p442, p_u_443, p444, p445, p_u_446, p_u_447, p448, p449)
    v_u_32 = v_u_32 + 1
    local v_u_450 = v_u_32
    v_u_39()
    v_u_282(p_u_443, p445, p448, p449)
    v_u_428(p442, p444)
    local v451 = v_u_433()
    if v451 then
        v_u_30:Add(v451, "Cancel")
    end
    task.delay(4, function()
        if v_u_450 == v_u_32 then
            local v452 = v_u_22:FindFirstChild("MainGui")
            local v453
            if v452 then
                local v454 = v452:FindFirstChild("Gameplay")
                if v454 then
                    v453 = v454:FindFirstChild("Middle")
                else
                    v453 = nil
                end
            else
                v453 = nil
            end
            local v455
            if v453 then
                v455 = v453:FindFirstChild("EndScreen")
            else
                v455 = nil
            end
            if v455 then
                local v_u_456 = v455:FindFirstChild("Victory")
                local v_u_457 = v455:FindFirstChild("Defeat")
                local v_u_458 = v455:FindFirstChild("Level")
                local v_u_459 = v_u_89(p_u_446)
                local v460 = p_u_443 and v_u_456 and v_u_456 or v_u_457
                if v460 and v460.Visible then
                    v_u_54(v460, 1)
                end
                task.delay(0.5, function()
                    if v_u_450 == v_u_32 then
                        if v_u_456 then
                            v_u_456.Visible = false
                        end
                        if v_u_457 then
                            v_u_457.Visible = false
                        end
                        if v_u_458 then
                            v_u_57(v_u_458)
                            task.spawn(function()
                                if v_u_459 then
                                    v_u_221(v_u_459)
                                end
                                if p_u_447 and #p_u_447 > 0 then
                                    v_u_255(p_u_447)
                                end
                            end)
                        end
                    end
                end)
            end
        else
            return
        end
    end)
    task.delay(14, function()
        if v_u_450 == v_u_32 then
            v_u_1._finishSequence()
        end
    end)
end
function v_u_1._finishSequence()
    v_u_30:Cleanup()
    v_u_303()
    v_u_31 = false
    v_u_9.SetEnabled(true)
    local v461 = require(v_u_2.Controllers.MenuSceneController)
    v461.ShowMenuScene()
    if v461.IsActive() then
        require(v_u_2.Interface.Screens.Menu.Top).ResetToMainMenu()
        local v462 = v_u_22:FindFirstChild("MainGui")
        if v462 then
            if not v462.Menu.Visible then
                v_u_9.setForceLockOverride("Menu", true)
                v462.Menu.Visible = true
            end
            v462.Gameplay.Visible = false
        end
    end
    local v463 = v_u_11.Get(v_u_21, "Level")
    if v463 then
        v_u_33 = {
            ["Level"] = v463.Level,
            ["Experience"] = v463.Experience,
            ["NextExperienceRequirement"] = v463.NextExperienceRequirement
        }
    end
end
function v_u_1.Begin(p464)
    if v_u_31 then
        warn("[EndScreen] Begin skipped: already active")
        return
    elseif v_u_13.IsCaseSceneActive() and v_u_12.broadcastRouter("IsCaseSceneRolling") == true then
        return
    else
        local v465
        if p464.Players then
            local v466 = p464.Players
            local v467 = v_u_21.UserId
            v465 = v466[tostring(v467)] or nil
        else
            v465 = nil
        end
        if not v465 then
            local v468 = warn
            local v469 = v_u_21.UserId
            local v470 = tostring(v469)
            local v471 = v_u_21
            local v472 = tostring(v471:GetAttribute("Team"))
            local v473 = p464.WinningTeam
            v468(("[EndScreen] Local player missing from payload (userId=%s, teamAttr=%s, winningTeam=%s)"):format(v470, v472, (tostring(v473))))
        end
        local v474 = v465 and v465.Team or v_u_21:GetAttribute("Team")
        if v474 and (v474 == "Counter-Terrorists" or v474 == "Terrorists") then
            v_u_441()
            v_u_10.Stop(false, true)
            v_u_9.SetEnabled(false)
            v_u_31 = true
            local v475 = p464.WinningTeam == v474
            local v476 = {}
            for v477, v478 in pairs(p464.Players) do
                if v478.Team == v474 then
                    v476[v477] = v478
                end
            end
            local v479 = v465 and v465.ExperienceEarned or 0
            local v480 = {}
            for v481 in pairs(p464.Players) do
                local v482 = tonumber(v481)
                if v482 then
                    table.insert(v480, v482)
                end
            end
            table.sort(v480)
            local v483 = {}
            for _, v484 in ipairs(v480) do
                local v485 = p464.Players[tostring(v484)]
                if v485 then
                    v485 = v485.LevelRewards
                end
                if v485 then
                    for _, v486 in ipairs(v485) do
                        table.insert(v483, {
                            ["userId"] = v484,
                            ["reward"] = v486
                        })
                    end
                end
            end
            v_u_1._runSequence(v476, v475, v474, p464.WinningTeam, v479, v483, p464.CTScore or 0, p464.TScore or 0)
        else
            local v487 = warn
            local v488 = tostring(v474)
            local v489 = v_u_21
            local v490 = tostring(v489:GetAttribute("Team"))
            local v491 = p464.WinningTeam
            v487(("[EndScreen] Begin skipped: invalid team (team=%s, teamAttr=%s, winningTeam=%s)"):format(v488, v490, (tostring(v491))))
        end
    end
end
function v_u_1.Initialize()
    local v492 = v_u_22:FindFirstChild("MainGui")
    local v493
    if v492 then
        local v494 = v492:FindFirstChild("Gameplay")
        if v494 then
            v493 = v494:FindFirstChild("Middle")
        else
            v493 = nil
        end
    else
        v493 = nil
    end
    local v495
    if v493 then
        v495 = v493:FindFirstChild("EndScreen")
    else
        v495 = nil
    end
    local v496 = v495 and v495:FindFirstChild("Drops")
    if v496 then
        v496.Visible = false
    end
    v_u_11.CreateListener(v_u_21, "Level", function(p497)
        if v_u_33 == nil and p497 then
            v_u_33 = {
                ["Level"] = p497.Level,
                ["Experience"] = p497.Experience,
                ["NextExperienceRequirement"] = p497.NextExperienceRequirement
            }
        end
    end)
    v_u_6.Match.EndScreen.Listen(function(p498)
        v_u_1.Begin(p498)
    end)
end
return v_u_1