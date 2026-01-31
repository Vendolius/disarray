local v_u_1 = {}
local v_u_2 = game:GetService("ReplicatedStorage")
local v_u_3 = game:GetService("ContentProvider")
local v_u_4 = game:GetService("UserInputService")
local v_u_5 = game:GetService("GamepadService")
local v_u_6 = game:GetService("TweenService")
local v_u_7 = game:GetService("RunService")
local v_u_8 = game:GetService("GuiService")
local v9 = game:GetService("Players")
require(script:WaitForChild("Types"))
local v_u_10 = v9.LocalPlayer
local v_u_11 = v_u_10:WaitForChild("PlayerGui")
local v_u_12 = require(v_u_2.Controllers.DataController)
local v_u_13 = require(v_u_2.Database.Security.Router)
local v_u_14 = require(v_u_2.Database.Components.Libraries.Skins)
require(v_u_2.Database.Components.Libraries.Cases)
local v15 = require(v_u_2.Database.Components.Libraries.Collections)
local v_u_16 = require(v_u_2.Database.Security.Remotes)
local v_u_17 = require(v_u_2.Interface.MenuState)
local v_u_18 = require(v_u_2.Components.Common.GetWeaponProperties)
local v_u_19 = require(v_u_2.Database.Custom.GameStats.Rarities)
local v_u_20 = require(v_u_2.Database.Custom.GameStats.UI.Inventory.WeaponDropShadows)
local v_u_21 = require(v_u_2.Database.Custom.GameStats.UI.Inventory.Sort)
local v_u_22 = v_u_2.Assets.Characters
local v_u_23 = require(v_u_2.Database.Custom.GameStats.Character.Viewport)
local v_u_24 = require(v_u_2.Database.Custom.GameStats.Character.Attachments)
local v_u_25 = {
    ["Right Arm"] = "RightGlove",
    ["Left Arm"] = "LeftGlove"
}
local v_u_26 = {
    ["Right Arm"] = "RightHand",
    ["Left Arm"] = "LeftHand"
}
local v_u_27 = "Counter-Terrorists"
local v_u_28 = nil
local v_u_29 = "Newest"
local v_u_30 = nil
local v_u_31 = false
local v_u_32 = nil
local v_u_33 = nil
local v_u_34 = nil
local v_u_35 = nil
local v_u_36 = nil
local v_u_37 = nil
local v_u_38 = nil
local v_u_39 = nil
local v_u_40 = false
local v_u_41 = nil
local v_u_42 = false
local v_u_43 = nil
local v_u_44 = nil
local v_u_45 = nil
local v_u_46 = false
local v_u_47 = false
local v_u_48 = false
local v_u_49 = false
local v_u_50 = nil
local v_u_51 = nil
local v_u_52 = nil
local v_u_53 = nil
local function v_u_61(p54, p55)
    local v56 = v_u_12.Get(v_u_10, "Loadout")
    if not v56 then
        return false
    end
    local v57 = v56[p55]
    if not v57 then
        return false
    end
    if v57.Loadout then
        for _, v58 in pairs(v57.Loadout) do
            if v58 and v58.Options then
                for _, v59 in ipairs(v58.Options) do
                    if v59 == p54 then
                        return true
                    end
                end
            end
        end
    end
    if v57.Equipped then
        for _, v60 in pairs(v57.Equipped) do
            if v60 == p54 then
                return true
            end
        end
    end
    return false
end
local function v_u_69(p62, p63)
    local v64 = p62:FindFirstChild("Status")
    if v64 then
        local v65 = v64:FindFirstChild("Counter-Terrorists")
        local v66 = v64:FindFirstChild("Terrorists")
        if v65 and v66 then
            local v67 = v_u_61(p63, "Counter-Terrorists")
            local v68 = v_u_61(p63, "Terrorists")
            v65.Visible = v67
            v66.Visible = v68
        end
    end
end
local v_u_70 = {}
local v_u_71 = {
    ["CT"] = nil,
    ["T"] = nil
}
local v_u_72 = {
    ["CT"] = nil,
    ["T"] = nil
}
local v_u_73 = {
    ["CT"] = {},
    ["T"] = {}
}
local v_u_74 = {}
local v_u_75 = {
    ["CT"] = nil,
    ["T"] = nil
}
local v_u_76 = {}
local v_u_77 = 0
local v_u_78 = false
local v_u_79 = false
local v_u_80 = UDim2.fromScale(0.2, 0.2)
local v_u_81 = Vector2.new(0, 0)
local v_u_82 = {
    ["Pistol"] = "Pistols",
    ["SMG"] = "Mid Tier",
    ["Heavy"] = "Mid Tier",
    ["Rifle"] = "Rifles"
}
local v_u_83 = {
    ["Incendiary Grenade"] = true,
    ["Decoy Grenade"] = true,
    ["Smoke Grenade"] = true,
    ["HE Grenade"] = true,
    ["Flashbang"] = true,
    ["Molotov"] = true
}
local v_u_84 = {
    ["Charm"] = true,
    ["Charm Capsule"] = true,
    ["Sticker"] = true,
    ["Sticker Capsule"] = true,
    ["Grenade"] = true,
    ["Case"] = true
}
local v_u_85 = {
    ["Pistol"] = 1,
    ["SMG"] = 2,
    ["Heavy"] = 3,
    ["Rifle"] = 4,
    ["Equipment"] = 5,
    ["Miscellaneous"] = 6
}
local v_u_86 = {
    ["Glove"] = "Equipped Gloves",
    ["Melee"] = "Equipped Melee",
    ["Zeus x27"] = "Equipped Zeus x27",
    ["Badge"] = "Equipped Badge",
    ["Music Kit"] = "Equipped Music Kit",
    ["Graffiti"] = "Equipped Graffiti"
}
local v_u_87 = {
    ["Equipped Gloves"] = "Gloves",
    ["Equipped Melee"] = "Melee",
    ["Equipped Zeus x27"] = "Zeus",
    ["Equipped Badge"] = "Badge",
    ["Equipped Music Kit"] = "Music Kit",
    ["Equipped Graffiti"] = "Graffiti"
}
local v_u_88 = {
    ["Terrorists"] = { "Glock-18" },
    ["Counter-Terrorists"] = { "USP-S", "P2000" }
}
local v_u_89 = nil
local function v_u_93(p90, p91)
    for _, v92 in ipairs(p90:GetChildren()) do
        if not table.find(p91, v92.Name) then
            v92:Destroy()
        end
    end
end
local function v_u_96()
    if v_u_51 then
        local v94 = v_u_51
        local v95 = v_u_89.ActionFrame
        if v95 then
            v95.Visible = false
        end
        v_u_51 = nil
        v_u_13.broadcastRouter("WeaponInspect", v94.Name, v94.Skin, v94.Float, v94.StatTrack, v94.NameTag, v94.Charm, v94.Stickers, v94.Type, v94.Pattern, v94._id, v94.Serial, v94.IsTradeable)
    end
end
local _ = {
    ["Pistols"] = 1,
    ["Mid Tier"] = 2,
    ["Rifles"] = 3
}
local _ = {
    ["Equipped Melee"] = 1,
    ["Equipped Gloves"] = 2,
    ["Equipped Badge"] = 3,
    ["Equipped Music Kit"] = 4,
    ["Equipped Graffiti"] = 5,
    ["Equipped Zeus x27"] = 6
}
local v_u_97 = nil
v15.ObserveAvailableCollections(function(p98)
    v_u_97 = p98
end)
local function v_u_124()
    local v99 = v_u_12.Get(v_u_10, "Inventory")
    if not v99 then
        return {}
    end
    local v100 = v_u_21.GetSortComparisonFunction(v_u_29, v_u_10, function()
        return v_u_97
    end)
    local v101 = {}
    local v102 = {}
    for _, v103 in ipairs(v99) do
        if v103 and (v103._id and (not v101[v103._id] and (not v_u_84[v103.Type] and (v103.Type ~= "Case" and (not v_u_83[v103.Name] and v103.Name))))) then
            local v104 = v103.Name
            if type(v104) == "string" then
                if v_u_86[v103.Type] ~= nil then
                    local v105, v106 = pcall(v_u_18, v103.Name)
                    local v107 = not (v105 and (v106 and v106.Team))
                    local v108 = v103.Name
                    local v109 = v_u_27
                    local v110
                    if v108 and (type(v108) == "string" and v108 ~= "") then
                        local v111, v112 = pcall(v_u_18, v108)
                        if v111 and (v112 and v112.Team) then
                            v110 = v112.Team == "Both" and true or v112.Team == v109
                        else
                            v110 = false
                        end
                    else
                        v110 = false
                    end
                    if v107 or v110 then
                        v101[v103._id] = true
                        table.insert(v102, v103)
                    end
                else
                    local v113 = v103.Name
                    local v114 = v_u_27
                    local v115
                    if v113 and (type(v113) == "string" and v113 ~= "") then
                        local v116, v117 = pcall(v_u_18, v113)
                        if v116 and (v117 and v117.Team) then
                            v115 = v117.Team == "Both" and true or v117.Team == v114
                        else
                            v115 = false
                        end
                    else
                        v115 = false
                    end
                    if v115 then
                        v101[v103._id] = true
                        table.insert(v102, v103)
                    else
                        local v118, v119 = pcall(v_u_18, v103.Name)
                        if not (v118 and (v119 and v119.Team)) then
                            v101[v103._id] = true
                            table.insert(v102, v103)
                        end
                    end
                end
            end
        end
    end
    if v_u_28 then
        v102 = {}
        for _, v120 in ipairs(v102) do
            if v120.Type ~= "Case" and (v120.Type ~= "Charm Capsule" and (v120.Type ~= "Sticker Capsule" and v120.Name)) then
                local v121 = v120.Name
                if type(v121) == "string" then
                    local v122, v123 = pcall(v_u_18, v120.Name)
                    if v122 and (v123 and v123.Type == v_u_28) then
                        table.insert(v102, v120)
                    end
                end
            end
        end
    end
    if v100 then
        table.sort(v102, v100)
    end
    return v102
end
local function v_u_153()
    if not v_u_89 then
        return
    end
    local v125 = v_u_89.Tabs.Container.Container
    local v126 = v_u_77 + 1
    local v127 = v_u_77 + 25
    local v128 = #v_u_76
    local v129 = math.min(v127, v128)
    for v130 = v126, v129 do
        local v131 = v_u_76[v130]
        if v131 and not v125:FindFirstChild(v131._id) then
            v_u_1.CreateItemTemplate(v131)
        end
    end
    v_u_77 = v129
    for _, v132 in ipairs(v125:GetChildren()) do
        if v132:IsA("Frame") and (v132.Name ~= "UIGridLayout" and (v132.Name ~= "UIListLayout" and v132.Name ~= "UIPadding")) then
            for v133, v134 in ipairs(v_u_76) do
                if v134._id == v132.Name then
                    v132.LayoutOrder = v133
                    break
                end
            end
        end
    end
    if v_u_30 then
        local v_u_135 = v_u_30.teamKey
        local v_u_136 = v_u_30.sidebarName
        task.defer(function()
            if not (v_u_89 and v_u_30) then
                return
            end
            local v137 = v_u_89.Tabs.Container.Container
            local v138 = v_u_12.Get(v_u_10, "Inventory")
            local v139 = v_u_136 == "Melee" and "Melee" or "Glove"
            local v140 = v_u_135 == "CT" and "Counter-Terrorists" or (v_u_135 == "T" and "Terrorists" or false)
            for _, v141 in ipairs(v137:GetChildren()) do
                if v141:IsA("Frame") then
                    local v142 = v141.Name
                    for _, v144 in ipairs(v138) do
                        if v144._id == v142 then
                            goto l17
                        end
                    end
                    local v144 = nil
                    ::l17::
                    if v144 then
                        if v144.Type == v139 then
                            local v145, v146 = pcall(v_u_18, v144.Name)
                            if v145 and (v146 and (v146.Class and v146.Class ~= v139)) then
                                v141.Visible = false
                            else
                                local v147 = v144.Name
                                if v140 == "Counter-Terrorists" then
                                    if v147 == "T Knife" or v147 == "T Gloves" then
                                        v141.Visible = false
                                    else
                                        ::l32::
                                        local v148 = not (v145 and (v146 and v146.Team))
                                        local v149 = v144.Name
                                        local v150
                                        if v149 and (type(v149) == "string" and v149 ~= "") then
                                            local v151, v152 = pcall(v_u_18, v149)
                                            if v151 and (v152 and v152.Team) then
                                                v150 = v152.Team == "Both" and true or v152.Team == v140
                                            else
                                                v150 = false
                                            end
                                        else
                                            v150 = false
                                        end
                                        v141.Visible = v148 or v150
                                    end
                                else
                                    if v140 ~= "Terrorists" or v147 ~= "CT Knife" and v147 ~= "CT Gloves" then
                                        goto l32
                                    end
                                    v141.Visible = false
                                end
                            end
                        else
                            v141.Visible = false
                        end
                    else
                        v141.Visible = false
                    end
                end
            end
        end)
    end
end
local function v_u_157()
    if v_u_89 then
        local v154 = v_u_89.Tabs.Container.Container
        local v155 = v154.CanvasPosition.Y
        local v156 = v154.AbsoluteCanvasSize.Y - v154.AbsoluteSize.Y
        if v156 > 0 and (v_u_77 < #v_u_76 and v156 - v155 < 200) then
            v_u_153()
        end
    else
        return
    end
end
local function v_u_184()
    if not (v_u_89 and v_u_89.Visible) then
        return 50
    end
    local v158 = v_u_89.Tabs.Container.Container
    local v159 = v158:FindFirstChildOfClass("UIGridLayout")
    if not v159 then
        return 50
    end
    local v160 = v158.AbsoluteSize
    local v161 = v160.Y
    local v162 = v160.X
    local v163 = v159.CellSize
    local v164 = v159.CellPadding
    local v165 = v163.Y.Scale * v161 + v163.Y.Offset
    local v166 = v164.Y.Scale * v161 + v164.Y.Offset
    local v167 = v163.X.Scale * v162 + v163.X.Offset
    local v168 = v164.X.Scale * v162 + v164.X.Offset
    local v169 = v158:FindFirstChildOfClass("UIPadding")
    local v170, v171, v172, v173
    if v169 then
        v170 = v169.PaddingTop.Scale * v161 + v169.PaddingTop.Offset
        v171 = v169.PaddingBottom.Scale * v161 + v169.PaddingBottom.Offset
        v172 = v169.PaddingLeft.Scale * v162 + v169.PaddingLeft.Offset
        v173 = v169.PaddingRight.Scale * v162 + v169.PaddingRight.Offset
    else
        v170 = 0
        v171 = 0
        v172 = 0
        v173 = 0
    end
    local v174 = v161 - v170 - v171
    local v175 = v162 - v172 - v173
    local v176 = v167 + v168
    local v177
    if v176 > 0 then
        local v178 = (v175 + v168) / v176
        local v179 = math.floor(v178)
        v177 = math.max(1, v179)
    else
        v177 = 1
    end
    local v180 = v165 + v166
    local v181
    if v180 > 0 then
        local v182 = (v174 + v166) / v180
        local v183 = math.floor(v182)
        v181 = math.max(1, v183)
    else
        v181 = 1
    end
    return v181 * v177 + v177
end
local function v_u_213()
    if not (v_u_89 and v_u_89.Visible) then
        return
    end
    local v185 = v_u_89.Tabs.Container.Container
    v_u_77 = 0
    local v186 = v_u_184()
    local v187 = math.max(v186, 50)
    local v188 = #v_u_76
    local v189 = math.min(v187, v188)
    for v190 = 1, v189 do
        local v191 = v_u_76[v190]
        if v191 and not v185:FindFirstChild(v191._id) then
            v_u_1.CreateItemTemplate(v191)
        end
    end
    for _, v192 in ipairs(v185:GetChildren()) do
        if v192:IsA("Frame") and (v192.Name ~= "UIGridLayout" and (v192.Name ~= "UIListLayout" and v192.Name ~= "UIPadding")) then
            for v193, v194 in ipairs(v_u_76) do
                if v194._id == v192.Name then
                    v192.LayoutOrder = v193
                    break
                end
            end
        end
    end
    v_u_77 = v189
    v_u_78 = false
    if v_u_30 then
        local v_u_195 = v_u_30.teamKey
        local v_u_196 = v_u_30.sidebarName
        task.defer(function()
            if not (v_u_89 and v_u_30) then
                return
            end
            local v197 = v_u_89.Tabs.Container.Container
            local v198 = v_u_12.Get(v_u_10, "Inventory")
            local v199 = v_u_196 == "Melee" and "Melee" or "Glove"
            local v200 = v_u_195 == "CT" and "Counter-Terrorists" or (v_u_195 == "T" and "Terrorists" or false)
            for _, v201 in ipairs(v197:GetChildren()) do
                if v201:IsA("Frame") then
                    local v202 = v201.Name
                    for _, v204 in ipairs(v198) do
                        if v204._id == v202 then
                            goto l17
                        end
                    end
                    local v204 = nil
                    ::l17::
                    if v204 then
                        if v204.Type == v199 then
                            local v205, v206 = pcall(v_u_18, v204.Name)
                            if v205 and (v206 and (v206.Class and v206.Class ~= v199)) then
                                v201.Visible = false
                            else
                                local v207 = v204.Name
                                if v200 == "Counter-Terrorists" then
                                    if v207 == "T Knife" or v207 == "T Gloves" then
                                        v201.Visible = false
                                    else
                                        ::l32::
                                        local v208 = not (v205 and (v206 and v206.Team))
                                        local v209 = v204.Name
                                        local v210
                                        if v209 and (type(v209) == "string" and v209 ~= "") then
                                            local v211, v212 = pcall(v_u_18, v209)
                                            if v211 and (v212 and v212.Team) then
                                                v210 = v212.Team == "Both" and true or v212.Team == v200
                                            else
                                                v210 = false
                                            end
                                        else
                                            v210 = false
                                        end
                                        v201.Visible = v208 or v210
                                    end
                                else
                                    if v200 ~= "Terrorists" or v207 ~= "CT Knife" and v207 ~= "CT Gloves" then
                                        goto l32
                                    end
                                    v201.Visible = false
                                end
                            end
                        else
                            v201.Visible = false
                        end
                    else
                        v201.Visible = false
                    end
                end
            end
        end)
    end
end
local function v_u_218()
    if v_u_89 then
        local v214 = v_u_89.Tabs.Container.Container
        local v215 = {}
        for _, v216 in ipairs(v_u_76) do
            if v216 and v216._id then
                v215[v216._id] = true
            end
        end
        for _, v217 in ipairs(v214:GetChildren()) do
            if v217:IsA("Frame") and (v217.Name ~= "UIGridLayout" and (v217.Name ~= "UIPadding" and not v215[v217.Name])) then
                v217:Destroy()
            end
        end
        v_u_77 = 0
        v_u_78 = true
        if v_u_89.Visible then
            v_u_213()
        end
    end
end
local function v_u_221(p219, p220)
    v_u_6:Create(p219, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        ["BackgroundTransparency"] = p220 and 0.85 or 1
    }):Play()
end
local function v_u_227(p222, p223)
    local v224 = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    local v225 = p223 and 0 or 1
    for _, v226 in ipairs(p222:GetChildren()) do
        if v226:IsA("Frame") and (v226:FindFirstChild("Price") and v226:FindFirstChild("WeaponName")) then
            v_u_6:Create(v226:FindFirstChild("Price"), v224, {
                ["TextTransparency"] = v225
            }):Play()
            v_u_6:Create(v226:FindFirstChild("WeaponName"), v224, {
                ["TextTransparency"] = v225
            }):Play()
        end
    end
end
local function v_u_233(p228, p229)
    for _, v230 in ipairs(p228:GetChildren()) do
        if v230:IsA("TextButton") then
            local v231 = v230:FindFirstChild("Frame")
            if v231 then
                local v232 = v230.Name == p229
                v231.BackgroundTransparency = v232 and 0 or 1
                if v232 then
                    v231.BackgroundColor3 = Color3.fromRGB(53, 83, 99)
                end
            end
        end
    end
end
local function v_u_243(p234, p235, p236, p237, p238)
    local v239 = v_u_2.Assets.UI.Loadout:FindFirstChild("SortingTemplate")
    if not v239 then
        return nil
    end
    local v_u_240 = v239:Clone()
    v_u_240.Name = p235
    v_u_240.LayoutOrder = p237
    v_u_240.Parent = p234
    local v241 = v_u_240:FindFirstChild("Frame")
    if v241 then
        local v242 = v241:FindFirstChild("TextButton")
        if v242 then
            v242.Text = p236
        end
        v241.BackgroundTransparency = 1
        v241.Active = false
    end
    v_u_240.MouseEnter:Connect(function()
        v_u_221(v_u_240, true)
    end)
    v_u_240.MouseLeave:Connect(function()
        v_u_221(v_u_240, false)
    end)
    v_u_240.MouseButton1Click:Connect(p238)
    return v_u_240
end
local function v_u_246(p244)
    for _, v245 in ipairs(p244:GetChildren()) do
        if v245:IsA("TextButton") then
            v245:Destroy()
        end
    end
end
local function v_u_256()
    local v247 = v_u_12.Get(v_u_10, "Inventory")
    if not v247 then
        return {}
    end
    local v248 = {}
    for _, v249 in ipairs(v247) do
        if not (v_u_84[v249.Type] or v_u_83[v249.Name]) then
            local v250, v251 = pcall(v_u_18, v249.Name)
            if v250 and (v251 and v251.Type) then
                v248[v251.Type] = true
            end
        end
    end
    local v252 = {}
    for v253 in pairs(v248) do
        table.insert(v252, v253)
    end
    table.sort(v252, function(p254, p255)
        return (v_u_85[p254] or 99) < (v_u_85[p255] or 99)
    end)
    return v252
end
local function v_u_265(p257)
    local v258 = v_u_12.Get(v_u_10, "Inventory")
    if not v258 then
        return {}
    end
    local v259 = {}
    for _, v260 in ipairs(v258) do
        if not (v_u_84[v260.Type] or v_u_83[v260.Name]) then
            local v261, v262 = pcall(v_u_18, v260.Name)
            if v261 and (v262 and (not p257 or v262.Type == p257)) then
                v259[v260.Name] = true
            end
        end
    end
    local v263 = {}
    for v264 in pairs(v259) do
        table.insert(v263, v264)
    end
    table.sort(v263)
    return v263
end
local function v_u_270(p266)
    local v267 = v_u_11:GetGuiObjectsAtPosition(p266.X, p266.Y)
    for _, v268 in ipairs(v267) do
        if v268.Name ~= "DragIcon" and (v268:IsA("ViewportFrame") and v268.Name == "Player") then
            local v269 = v268.Parent
            if v269 and (v269.Name == "CT" or v269.Name == "T") then
                return true
            end
        end
    end
    return false
end
local function v_u_275(p271)
    local v272 = v_u_14.GetSkinInformation(p271.Name, p271.Skin)
    if not v272 then
        return nil
    end
    local v273 = v_u_14.GetWearImageForFloat(v272, p271.Float or 0.9999) or v272.imageAssetId or ""
    local v274 = Instance.new("ImageLabel")
    v274.Name = "DragIcon"
    v274.Size = v_u_80
    v274.AnchorPoint = Vector2.new(0.5, 0.5)
    v274.BackgroundTransparency = 1
    v274.Image = v273
    v274.ScaleType = Enum.ScaleType.Fit
    v274.ZIndex = 100
    v274.Active = false
    return v274
end
local function v_u_287(p276, p277)
    local v278 = v_u_89.Teams
    local v279 = (v_u_27 == "Counter-Terrorists" and v278.GunsCT or v278.GunsT):FindFirstChild(p276)
    if v279 then
        local v280 = 0
        for _, v281 in ipairs(v279:GetChildren()) do
            if v281:IsA("Frame") and (v281.Name ~= "Frame" and v281:FindFirstChild("Button")) then
                v280 = v280 + 1
                local v282
                if p276 == "Pistols" and (v280 == 1 and p277) then
                    local v283 = v_u_88[v_u_27]
                    if v283 then
                        v282 = table.find(v283, p277) ~= nil
                    else
                        v282 = false
                    end
                else
                    v282 = true
                end
                local v284 = v281:FindFirstChild("MoveFrame")
                if v284 and v284:IsA("GuiObject") then
                    v284.Visible = v282
                end
                if v282 then
                    local v285 = v281:FindFirstChild("Weapon")
                    if v285 then
                        local v286 = v285:FindFirstChild("Icon")
                        if v286 then
                            v286.Size = UDim2.fromScale(0.9, 0.85)
                        end
                    end
                end
            end
        end
    end
end
local function v_u_291()
    local v288 = v_u_89.Teams:FindFirstChild(v_u_27 == "Counter-Terrorists" and "CT" or "T")
    local v289 = v288 and v288:FindFirstChild("Player")
    if v289 then
        local v290 = v289:FindFirstChild("MoveFrame")
        if v290 and v290:IsA("GuiObject") then
            v290.Visible = true
        end
    end
end
local function v_u_304()
    local v292 = v_u_89.Teams
    for _, v293 in ipairs({ v292.GunsCT, v292.GunsT }) do
        for _, v294 in ipairs({ "Mid Tier", "Pistols", "Rifles" }) do
            local v295 = v293:FindFirstChild(v294)
            if v295 then
                for _, v296 in ipairs(v295:GetChildren()) do
                    if v296:IsA("Frame") and v296.Name ~= "Frame" then
                        local v297 = v296:FindFirstChild("MoveFrame")
                        if v297 and v297:IsA("GuiObject") then
                            v297.Visible = false
                        end
                        local v298 = v296:FindFirstChild("Weapon")
                        if v298 then
                            local v299 = v298:FindFirstChild("Icon")
                            if v299 then
                                v299.Size = UDim2.fromScale(1, 0.95)
                            end
                        end
                    end
                end
            end
        end
    end
    for _, v300 in ipairs({ "CT", "T" }) do
        local v301 = v292:FindFirstChild(v300)
        if v301 then
            local v302 = v301:FindFirstChild("Player")
            if v302 then
                local v303 = v302:FindFirstChild("MoveFrame")
                if v303 and v303:IsA("GuiObject") then
                    v303.Visible = false
                end
            end
        end
    end
end
local function v_u_311(p305)
    local v306 = p305.Parent
    if not (v306 and v306:IsA("Frame")) then
        return nil, nil
    end
    local v307 = v306.Parent
    if not (v307 and v307:IsA("Frame")) then
        return nil, nil
    end
    local v308 = v307.Name
    if v308 ~= "Mid Tier" and (v308 ~= "Pistols" and v308 ~= "Rifles") then
        return nil, nil
    end
    local v309 = 0
    for _, v310 in ipairs(v307:GetChildren()) do
        if v310:IsA("Frame") and (v310.Name ~= "Frame" and v310:FindFirstChild("Button")) then
            v309 = v309 + 1
            if v310 == v306 then
                return v308, v309
            end
        end
    end
    return nil, nil
end
local function v_u_320(p312)
    local v313 = v_u_12.Get(v_u_10, "Inventory")
    if not v313 then
        return nil, nil, nil
    end
    local v314 = p312.Parent
    if v314 and v314:IsA("Frame") then
        local v315 = v314.Name
        local v316, v317 = v_u_311(p312)
        if v316 and v317 then
            for _, v319 in ipairs(v313) do
                if v319._id == v315 then
                    ::l11::
                    return v319, v316, v317
                end
            end
            local v319 = nil
            goto l11
        end
    end
    return nil, nil, nil
end
local function v_u_336(p_u_321)
    local v322 = v_u_12.Get(v_u_10, "Inventory")
    local v326
    if v322 then
        local v324 = p_u_321.Parent
        if not (v324 and v324:IsA("Frame")) then
            v326 = nil
            goto l3
        end
        local v325 = v324.Name
        for _, v326 in ipairs(v322) do
            if v326._id == v325 then
                goto l3
            end
        end
        v326 = nil
        goto l3
    else
        v326 = nil
        ::l3::
        if v326 then
            v_u_41 = v326
            v_u_42 = false
            v_u_43 = p_u_321
            v_u_44 = nil
            v_u_45 = nil
            if not v_u_47 then
                v_u_47 = true
                v_u_8.AutoSelectGuiEnabled = false
                v_u_8.SelectedObject = nil
                pcall(function()
                    v_u_5:EnableGamepadCursor(p_u_321 or v_u_89)
                end)
            end
            local v327 = v326.Name
            local v328, v329 = pcall(v_u_18, v327)
            local v330
            if v328 and (v329 and v329.Type) then
                v330 = v_u_82[v329.Type]
            else
                v330 = nil
            end
            if v330 then
                v_u_287(v330, v326.Name)
                return
            elseif v_u_86[v326.Type] then
                v_u_291()
            else
                local v331, v332 = pcall(v_u_18, v326.Name)
                if v331 and (v332 and (v332.Class == "Melee" or v332.Class == "Glove")) then
                    v_u_291()
                end
            end
        else
            local v333, v334, v335 = v_u_320(p_u_321)
            if v333 and (v334 and v335) then
                v_u_41 = v333
                v_u_42 = true
                v_u_43 = p_u_321
                v_u_44 = v334
                v_u_45 = v335
                if not v_u_47 then
                    v_u_47 = true
                    v_u_8.AutoSelectGuiEnabled = false
                    v_u_8.SelectedObject = nil
                    pcall(function()
                        v_u_5:EnableGamepadCursor(p_u_321 or v_u_89)
                    end)
                end
                v_u_287(v334, v333.Name)
            end
        end
    end
end
local function v_u_346(p337)
    local v338 = v_u_11:GetGuiObjectsAtPosition(p337.X, p337.Y)
    for _, v339 in ipairs(v338) do
        if v339.Name ~= "DragIcon" and (v339:IsA("ImageButton") and (v339.Name == "Button" and v339.Parent)) then
            local v340 = v339.Parent
            if v340:IsA("Frame") and v340.Parent then
                local v341 = v340.Parent
                if v341:IsA("Frame") then
                    local v342 = v341.Name
                    if v342 == "Mid Tier" or (v342 == "Pistols" or v342 == "Rifles") then
                        local v343 = 0
                        local v344 = 1
                        for _, v345 in ipairs(v341:GetChildren()) do
                            if v345:IsA("Frame") and (v345.Name ~= "Frame" and v345:FindFirstChild("Button")) then
                                v343 = v343 + 1
                                if v345 == v340 then
                                    v344 = v343
                                    break
                                end
                            end
                        end
                        return v342, v344, v339
                    end
                end
            end
        end
    end
    return nil, nil, nil
end
local function v_u_354(p347, p348)
    local v349 = v_u_12.Get(v_u_10, "Loadout")
    if not v349 then
        return false, nil
    end
    local v350 = v349[v_u_27]
    if not (v350 and (v350.Loadout and v350.Loadout[p348])) then
        return false, nil
    end
    local v351 = v350.Loadout[p348].Options
    for v352, v353 in ipairs(v351) do
        if v353 == p347 then
            return true, v352
        end
    end
    return false, nil
end
local function v_u_355()
    -- failed to decompile
end
local function v_u_359(p356, p357, p358)
    if v_u_49 then
        return false
    end
    v_u_49 = true
    v_u_16.Inventory.EquipLoadoutSkin.Send({
        ["Type"] = p356,
        ["Slot"] = p357 - 1,
        ["Team"] = v_u_27,
        ["Identifier"] = p358
    })
    task.delay(5, function()
        v_u_49 = false
    end)
    return true
end
local function v_u_363(p360, p361, p362)
    if v_u_49 then
        return false
    end
    v_u_49 = true
    v_u_16.Inventory.SwapLoadoutSkins.Send({
        ["Type"] = p360,
        ["SlotOne"] = p361 - 1,
        ["SlotTwo"] = p362 - 1,
        ["Team"] = v_u_27
    })
    task.delay(5, function()
        v_u_49 = false
    end)
    return true
end
local function v_u_367(p364, p365)
    if v_u_49 then
        return false
    end
    v_u_49 = true
    local v366 = {
        ["Path"] = p364,
        ["Team"] = v_u_27,
        ["Identifier"] = p365
    }
    v_u_16.Inventory.EquipSpecialItem.Send(v366)
    task.delay(5, function()
        v_u_49 = false
    end)
    return true
end
local function v_u_392()
    if v_u_41 then
        local v368 = v_u_4:GetMouseLocation()
        local v369 = v_u_8:GetGuiInset()
        local v370 = Vector2.new(v368.X - v369.X, v368.Y - v369.Y)
        local v371, v372, _ = v_u_346(v370)
        if v371 and v372 then
            local v373 = v_u_41.Name
            local v374 = v_u_27
            local v375
            if v373 and (type(v373) == "string" and v373 ~= "") then
                local v376, v377 = pcall(v_u_18, v373)
                if v376 and (v377 and v377.Team) then
                    v375 = v377.Team == "Both" and true or v377.Team == v374
                else
                    v375 = false
                end
            else
                v375 = false
            end
            if v375 then
                local v378 = v_u_41.Name
                local v379, v380 = pcall(v_u_18, v378)
                local v381
                if v379 and (v380 and v380.Type) then
                    v381 = v_u_82[v380.Type]
                else
                    v381 = nil
                end
                if v381 == v371 then
                    local v382, v383 = v_u_354(v_u_41._id, v371)
                    if v382 and v383 then
                        if v383 ~= v372 then
                            v_u_363(v371, v383, v372)
                        end
                    else
                        local v384, v385 = v_u_355(v_u_41.Name, v371)
                        if v384 and v385 then
                            v_u_359(v371, v385, v_u_41._id)
                        else
                            v_u_359(v371, v372, v_u_41._id)
                        end
                    end
                    v_u_41 = nil
                    v_u_42 = false
                    v_u_43 = nil
                    v_u_44 = nil
                    v_u_45 = nil
                    v_u_48 = false
                    if v_u_47 then
                        v_u_47 = false
                        pcall(function()
                            v_u_5:DisableGamepadCursor()
                        end)
                        v_u_8.AutoSelectGuiEnabled = true
                    end
                    v_u_304()
                else
                    v_u_41 = nil
                    v_u_42 = false
                    v_u_43 = nil
                    v_u_44 = nil
                    v_u_45 = nil
                    v_u_48 = false
                    if v_u_47 then
                        v_u_47 = false
                        pcall(function()
                            v_u_5:DisableGamepadCursor()
                        end)
                        v_u_8.AutoSelectGuiEnabled = true
                    end
                    v_u_304()
                end
            else
                v_u_41 = nil
                v_u_42 = false
                v_u_43 = nil
                v_u_44 = nil
                v_u_45 = nil
                v_u_48 = false
                if v_u_47 then
                    v_u_47 = false
                    pcall(function()
                        v_u_5:DisableGamepadCursor()
                    end)
                    v_u_8.AutoSelectGuiEnabled = true
                end
                v_u_304()
                return
            end
        else
            local v386 = v_u_41.Type
            if v386 then
                v386 = v_u_86[v_u_41.Type]
            end
            if not v386 then
                local v387, v388 = pcall(v_u_18, v_u_41.Name)
                v386 = v387 and (v388 and (v388.Class == "Melee" or v388.Class == "Glove")) and true or v386
            end
            if v386 and v_u_270(v370) then
                local v389 = v_u_86[v_u_41.Type]
                if not v389 then
                    local v390, v391 = pcall(v_u_18, v_u_41.Name)
                    if v390 and v391 then
                        v389 = v391.Class == "Melee" and "Equipped Melee" or (v391.Class == "Glove" and "Equipped Gloves" or v389)
                    end
                end
                if v389 then
                    v_u_367(v389, v_u_41._id)
                end
                v_u_41 = nil
                v_u_42 = false
                v_u_43 = nil
                v_u_44 = nil
                v_u_45 = nil
                v_u_48 = false
                if v_u_47 then
                    v_u_47 = false
                    pcall(function()
                        v_u_5:DisableGamepadCursor()
                    end)
                    v_u_8.AutoSelectGuiEnabled = true
                end
                v_u_304()
            else
                v_u_41 = nil
                v_u_42 = false
                v_u_43 = nil
                v_u_44 = nil
                v_u_45 = nil
                v_u_48 = false
                if v_u_47 then
                    v_u_47 = false
                    pcall(function()
                        v_u_5:DisableGamepadCursor()
                    end)
                    v_u_8.AutoSelectGuiEnabled = true
                end
                v_u_304()
            end
        end
    else
        return
    end
end
local function v_u_393()
    if v_u_89 and v_u_89.Visible then
        if v_u_41 then
            v_u_41 = nil
            v_u_42 = false
            v_u_43 = nil
            v_u_44 = nil
            v_u_45 = nil
            v_u_48 = false
            if v_u_47 then
                v_u_47 = false
                pcall(function()
                    v_u_5:DisableGamepadCursor()
                end)
                v_u_8.AutoSelectGuiEnabled = true
            end
            v_u_304()
        end
    end
end
function v_u_1.HandleSpecialItemDrop()
    if v_u_33 and v_u_35 then
        local v394 = v_u_86[v_u_35]
        if not v394 and v_u_34 then
            local v395, v396 = pcall(v_u_18, v_u_34)
            if v395 and v396 then
                v394 = v396.Class == "Melee" and "Equipped Melee" or (v396.Class == "Glove" and "Equipped Gloves" or v394)
            end
        end
        if v394 then
            v_u_367(v394, v_u_33)
        end
    else
        return
    end
end
function v_u_1.HandleDrop(p397, p398)
    if v_u_33 and v_u_34 then
        local v399 = v_u_34
        local v400 = v_u_27
        local v401
        if v399 and (type(v399) == "string" and v399 ~= "") then
            local v402, v403 = pcall(v_u_18, v399)
            if v402 and (v403 and v403.Team) then
                v401 = v403.Team == "Both" and true or v403.Team == v400
            else
                v401 = false
            end
        else
            v401 = false
        end
        if v401 then
            local v404 = v_u_34
            local v405, v406 = pcall(v_u_18, v404)
            local v407
            if v405 and (v406 and v406.Type) then
                v407 = v_u_82[v406.Type]
            else
                v407 = nil
            end
            if v407 == p397 then
                local v408 = v_u_12.Get(v_u_10, "Loadout")
                if v408 then
                    local v409 = v408[v_u_27]
                    if v409 and (v409.Loadout and v409.Loadout[p397]) then
                        local v410 = v409.Loadout[p397].Options
                        if p398 < 1 or #v410 < p398 then
                            return
                        else
                            local v411, v412 = v_u_354(v_u_33, p397)
                            if v411 and v412 then
                                if v412 ~= p398 then
                                    v_u_363(p397, v412, p398)
                                end
                                return
                            else
                                local v413, v414 = v_u_355(v_u_34, p397)
                                if v413 and v414 then
                                    v_u_359(p397, v414, v_u_33)
                                else
                                    v_u_359(p397, p398, v_u_33)
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
    else
        return
    end
end
local function v_u_426(p415)
    if v_u_39 then
        v_u_39:Disconnect()
        v_u_39 = nil
    end
    v_u_37 = nil
    v_u_38 = nil
    v_u_40 = false
    if v_u_31 then
        return
    else
        local v416 = v_u_275(p415)
        if v416 then
            v_u_31 = true
            v_u_32 = v416
            v_u_33 = p415._id
            v_u_34 = p415.Name
            v_u_35 = p415.Type
            local v417 = p415.Name
            local v418, v419 = pcall(v_u_18, v417)
            local v420
            if v418 and (v419 and v419.Type) then
                v420 = v_u_82[v419.Type]
            else
                v420 = nil
            end
            if v420 then
                v_u_287(v420, p415.Name)
            elseif v_u_86[p415.Type] then
                v_u_291()
            else
                local v421, v422 = pcall(v_u_18, p415.Name)
                if v421 and (v422 and (v422.Class == "Melee" or v422.Class == "Glove")) then
                    v_u_291()
                end
            end
            local v423 = v_u_11:FindFirstChild("MainGui")
            if v423 then
                v416.Parent = v423
            else
                v416.Parent = v_u_11
            end
            local v424 = v_u_4:GetMouseLocation()
            v416.Position = UDim2.fromOffset(v424.X + v_u_81.X, v424.Y + v_u_81.Y)
            v_u_36 = v_u_7.RenderStepped:Connect(function()
                if v_u_32 then
                    local v425 = v_u_4:GetMouseLocation()
                    v_u_32.Position = UDim2.fromOffset(v425.X + v_u_81.X, v425.Y + v_u_81.Y)
                end
            end)
        end
    end
end
function v_u_1.OnItemMouseDown(p427, p428)
    if v_u_41 or v_u_47 then
        return
    elseif not (v_u_31 or v_u_37) then
        v_u_37 = p427
        v_u_38 = v_u_4:GetMouseLocation()
        v_u_40 = p428 or false
        v_u_39 = v_u_7.RenderStepped:Connect(function()
            if v_u_37 and (v_u_38 and (v_u_4:GetMouseLocation() - v_u_38).Magnitude >= 10) then
                local v429 = v_u_37
                if v_u_39 then
                    v_u_39:Disconnect()
                    v_u_39 = nil
                end
                v_u_37 = nil
                v_u_38 = nil
                v_u_40 = false
                v_u_426(v429)
            end
        end)
    end
end
function v_u_1.OnItemClick(p430)
    local v431 = p430.Name
    local v432 = v_u_89.Tabs.Container.Container
    local v433, v434 = pcall(v_u_18, v431)
    if v433 and (v434 and v434.Type) then
        v_u_28 = v434.Type
        v_u_89.Tabs.Container.WeaponSort.Category.Frame.TextLabel.Text = v434.Type
        v_u_1.PopulateWeaponDropdown()
    end
    v_u_89.Tabs.Container.WeaponSort.Weapon.Frame.TextLabel.Text = v431
    local v435 = v_u_12.Get(v_u_10, "Inventory")
    for _, v436 in ipairs(v432:GetChildren()) do
        if v436:IsA("Frame") then
            local v437 = v436.Name
            for _, v439 in ipairs(v435) do
                if v439._id == v437 then
                    goto l11
                end
            end
            local v439 = nil
            ::l11::
            if v439 then
                v436.Visible = v439.Name == v431
            end
        end
    end
    local v440 = v_u_89.Tabs.Container.WeaponSort:FindFirstChild("Reset")
    if v440 then
        local v441 = v_u_89.Tabs.Container.WeaponSort.Weapon
        v440.Visible = v_u_28 ~= nil and true or v441.Frame.TextLabel.Text ~= "All Weapons"
    end
end
function v_u_1.EndDrag()
    if v_u_37 and not v_u_31 then
        local v442 = v_u_37
        local v443 = v_u_40
        if v_u_39 then
            v_u_39:Disconnect()
            v_u_39 = nil
        end
        v_u_37 = nil
        v_u_38 = nil
        v_u_40 = false
        if v443 then
            v_u_1.OnItemClick(v442)
        end
        return
    elseif v_u_31 then
        local v444 = v_u_4:GetMouseLocation()
        local v445 = v_u_8:GetGuiInset()
        local v446 = Vector2.new(v444.X - v445.X, v444.Y - v445.Y)
        local v447 = v_u_35
        if v447 then
            v447 = v_u_86[v_u_35]
        end
        if not v447 and v_u_34 then
            local v448, v449 = pcall(v_u_18, v_u_34)
            v447 = v448 and (v449 and (v449.Class == "Melee" or v449.Class == "Glove")) and true or v447
        end
        if v447 and v_u_270(v446) then
            v_u_1.HandleSpecialItemDrop()
        else
            local v450, v451 = v_u_346(v446)
            if v450 and v451 then
                v_u_1.HandleDrop(v450, v451)
            end
        end
        if v_u_39 then
            v_u_39:Disconnect()
            v_u_39 = nil
        end
        v_u_37 = nil
        v_u_38 = nil
        v_u_40 = false
        if v_u_36 then
            v_u_36:Disconnect()
            v_u_36 = nil
        end
        if v_u_32 then
            v_u_32:Destroy()
            v_u_32 = nil
        end
        v_u_31 = false
        v_u_33 = nil
        v_u_34 = nil
        v_u_35 = nil
        v_u_304()
    end
end
function v_u_1.CreateItemTemplate(p_u_452)
    local v453 = v_u_14.GetSkinInformation(p_u_452.Name, p_u_452.Skin)
    if v453 then
        local v_u_454 = v_u_2.Assets.UI.Inventory.ItemTemplate:Clone()
        v_u_454.Main.RarityFrame.UIGradient.Color = v_u_19[v453.rarity].ColorSequence
        v_u_454.Main.Glow.UIGradient.Color = v_u_19[v453.rarity].ColorSequence
        v_u_454.Parent = v_u_89.Tabs.Container.Container
        local v455 = v_u_14.GetWearImageForFloat(v453, p_u_452.Float or 0.9999) or (v453.imageAssetId or "")
        v_u_454.Main.Icon.Image = v455
        local v456 = p_u_452.StatTrack and "KillTrak\226\132\162 " .. p_u_452.Name or p_u_452.Name
        if p_u_452.Type == "Melee" then
            v456 = "\226\152\133 " .. v456
        end
        v_u_454.Information.Weapon.Text = v456
        v_u_454.Information.Skin.Text = p_u_452.Skin
        v_u_454.Name = p_u_452._id
        local v457 = v_u_20[p_u_452.Name]
        local v_u_458
        if v457 then
            v_u_458 = v_u_454.Main.Icon:Clone()
            v_u_458.Name = "DropShadow"
            v_u_458.Image = v457
            v_u_458.ImageTransparency = 1
            v_u_458.ZIndex = v_u_454.Main.Icon.ZIndex - 1
            v_u_458.Parent = v_u_454.Main
        else
            v_u_458 = nil
        end
        local v_u_459 = v_u_454.Main.Icon
        local v_u_460 = v_u_459.Position
        local v_u_461 = UDim2.new(0, 0, -0.05, 0)
        local v_u_462 = TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
        v_u_454.Button.MouseEnter:Connect(function()
            v_u_6:Create(v_u_459, v_u_462, {
                ["Position"] = UDim2.new(v_u_460.X.Scale + v_u_461.X.Scale, v_u_460.X.Offset + v_u_461.X.Offset, v_u_460.Y.Scale + v_u_461.Y.Scale, v_u_460.Y.Offset + v_u_461.Y.Offset)
            }):Play()
            if v_u_458 then
                v_u_6:Create(v_u_458, v_u_462, {
                    ["ImageTransparency"] = 0.3
                }):Play()
            end
        end)
        v_u_454.Button.MouseLeave:Connect(function()
            v_u_6:Create(v_u_459, v_u_462, {
                ["Position"] = v_u_460
            }):Play()
            if v_u_458 then
                v_u_6:Create(v_u_458, v_u_462, {
                    ["ImageTransparency"] = 1
                }):Play()
            end
        end)
        v_u_454.Button.MouseButton1Down:Connect(function()
            v_u_1.OnItemMouseDown(p_u_452)
        end)
        v_u_454.Button.Selectable = true
        v_u_454.Button.SelectionGained:Connect(function()
            v_u_6:Create(v_u_459, v_u_462, {
                ["Position"] = UDim2.new(v_u_460.X.Scale + v_u_461.X.Scale, v_u_460.X.Offset + v_u_461.X.Offset, v_u_460.Y.Scale + v_u_461.Y.Scale, v_u_460.Y.Offset + v_u_461.Y.Offset)
            }):Play()
            if v_u_458 then
                v_u_6:Create(v_u_458, v_u_462, {
                    ["ImageTransparency"] = 0.3
                }):Play()
            end
        end)
        v_u_454.Button.SelectionLost:Connect(function()
            v_u_6:Create(v_u_459, v_u_462, {
                ["Position"] = v_u_460
            }):Play()
            if v_u_458 then
                v_u_6:Create(v_u_458, v_u_462, {
                    ["ImageTransparency"] = 1
                }):Play()
            end
        end)
        v_u_454.Button.Activated:Connect(function(p463)
            if p463 and (p463.UserInputType == Enum.UserInputType.Gamepad1 and not v_u_41) then
                v_u_336(v_u_454.Button)
            end
        end)
        v_u_69(v_u_454, p_u_452._id)
    end
end
function v_u_1.CreateLoadoutTemplate(p464, p_u_465, p466)
    local v467 = v_u_14.GetSkinInformation(p_u_465.Name, p_u_465.Skin)
    local v468, v469 = pcall(v_u_18, p_u_465.Name)
    local v470 = v468 and (v469 and v469.Cost) or 0
    if v467 then
        local v471 = p466 == "Counter-Terrorists" and "LoadoutTemplateCT" or "LoadoutTemplateT"
        local v_u_472 = v_u_2.Assets.UI.Loadout:FindFirstChild(v471):Clone()
        v_u_472:WaitForChild("Weapon")
        v_u_472.Weapon:WaitForChild("Icon")
        v_u_472.Weapon.Rarity.UIGradient.Color = v_u_19[v467.rarity].ColorSequence
        v_u_472.Weapon.Glow.ImageColor3 = v_u_19[v467.rarity].Color
        v_u_472.Parent = p464
        v_u_472.Name = p_u_465._id
        local v473 = v_u_14.GetWearImageForFloat(v467, p_u_465.Float or 0.9999) or (v467.imageAssetId or "")
        v_u_472.Price.Text = "$" .. tostring(v470)
        v_u_472.WeaponName.Text = p_u_465.Name
        v_u_472.Weapon.Icon.Image = v473
        local v474 = v_u_20[p_u_465.Name]
        local v_u_475
        if v474 then
            v_u_475 = v_u_472.Weapon.Icon:Clone()
            v_u_475.Name = "DropShadow"
            v_u_475.Image = v474
            v_u_475.ImageTransparency = 1
            v_u_475.ZIndex = v_u_472.Weapon.Icon.ZIndex - 1
            v_u_475.Parent = v_u_472.Weapon
        else
            v_u_475 = nil
        end
        local v_u_476 = v_u_472.Weapon.Icon
        local v_u_477 = v_u_476.Position
        local v_u_478 = UDim2.new(0, 0, -0.05, 0)
        local v_u_479 = TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
        v_u_472.Button.MouseEnter:Connect(function()
            v_u_6:Create(v_u_476, v_u_479, {
                ["Position"] = UDim2.new(v_u_477.X.Scale + v_u_478.X.Scale, v_u_477.X.Offset + v_u_478.X.Offset, v_u_477.Y.Scale + v_u_478.Y.Scale, v_u_477.Y.Offset + v_u_478.Y.Offset)
            }):Play()
            if v_u_475 then
                v_u_6:Create(v_u_475, v_u_479, {
                    ["ImageTransparency"] = 0.3
                }):Play()
            end
        end)
        v_u_472.Button.MouseLeave:Connect(function()
            v_u_6:Create(v_u_476, v_u_479, {
                ["Position"] = v_u_477
            }):Play()
            if v_u_475 then
                v_u_6:Create(v_u_475, v_u_479, {
                    ["ImageTransparency"] = 1
                }):Play()
            end
        end)
        local v480 = v_u_50 == p464.Name
        v_u_472.Price.TextTransparency = v480 and 0 or 1
        v_u_472.WeaponName.TextTransparency = v480 and 0 or 1
        v_u_472.Button.MouseButton1Down:Connect(function()
            v_u_1.OnItemMouseDown(p_u_465, true)
        end)
        v_u_472.Button.MouseEnter:Connect(function()
            v_u_1.OnLoadoutItemHover(p_u_465)
        end)
        v_u_472.Button.MouseLeave:Connect(function()
            v_u_1.OnLoadoutItemUnhover()
        end)
        v_u_472.Button.Selectable = true
        v_u_472.Button.SelectionGained:Connect(function()
            v_u_1.OnLoadoutItemHover(p_u_465)
            v_u_6:Create(v_u_476, v_u_479, {
                ["Position"] = UDim2.new(v_u_477.X.Scale + v_u_478.X.Scale, v_u_477.X.Offset + v_u_478.X.Offset, v_u_477.Y.Scale + v_u_478.Y.Scale, v_u_477.Y.Offset + v_u_478.Y.Offset)
            }):Play()
            if v_u_475 then
                v_u_6:Create(v_u_475, v_u_479, {
                    ["ImageTransparency"] = 0.3
                }):Play()
            end
        end)
        v_u_472.Button.SelectionLost:Connect(function()
            v_u_6:Create(v_u_476, v_u_479, {
                ["Position"] = v_u_477
            }):Play()
            if v_u_475 then
                v_u_6:Create(v_u_475, v_u_479, {
                    ["ImageTransparency"] = 1
                }):Play()
            end
        end)
        v_u_472.Button.Activated:Connect(function(p481)
            if p481 and (p481.UserInputType == Enum.UserInputType.Gamepad1 and not v_u_41) then
                v_u_336(v_u_472.Button)
            end
        end)
    end
end
function v_u_1.PopulateCategoryDropdown()
    local v_u_482 = v_u_89.Tabs.Container.WeaponSort.Category.ScrollingFrame
    if v_u_482 then
        v_u_246(v_u_482)
        v_u_243(v_u_482, "All", "All Categories", 0, function()
            v_u_1.SortByCategory(nil)
            v_u_233(v_u_482, "All")
            v_u_482.Visible = false
        end)
        local v483 = v_u_256()
        for v484, v_u_485 in ipairs(v483) do
            v_u_243(v_u_482, v_u_485, v_u_485, v484, function()
                v_u_1.SortByCategory(v_u_485)
                v_u_233(v_u_482, v_u_485)
                v_u_482.Visible = false
            end)
        end
        v_u_233(v_u_482, "All")
    end
end
function v_u_1.PopulateWeaponDropdown()
    local v_u_486 = v_u_89.Tabs.Container.WeaponSort.Weapon:FindFirstChild("Options")
    if v_u_486 and (v_u_486:IsA("Frame") or v_u_486:IsA("ScrollingFrame")) then
        v_u_246(v_u_486)
        v_u_243(v_u_486, "All", "All Weapons", 0, function()
            v_u_1.SortByWeapon(nil)
            v_u_233(v_u_486, "All")
            v_u_486.Visible = false
        end)
        local v487 = v_u_265(v_u_28)
        for v488, v_u_489 in ipairs(v487) do
            v_u_243(v_u_486, v_u_489, v_u_489, v488, function()
                v_u_1.SortByWeapon(v_u_489)
                v_u_233(v_u_486, v_u_489)
                v_u_486.Visible = false
            end)
        end
        v_u_233(v_u_486, "All")
    end
end
function v_u_1.SortByCategory(p490)
    v_u_28 = p490
    local _ = v_u_89.Tabs.Container.Container
    v_u_89.Tabs.Container.WeaponSort.Category.Frame.TextLabel.Text = p490 or "All Categories"
    v_u_1.PopulateWeaponDropdown()
    v_u_89.Tabs.Container.WeaponSort.Weapon.Frame.TextLabel.Text = "All Weapons"
    local v491 = v_u_89.Tabs.Container.WeaponSort:FindFirstChild("Reset")
    if v491 then
        local v492 = v_u_89.Tabs.Container.WeaponSort.Weapon
        v491.Visible = v_u_28 ~= nil and true or v492.Frame.TextLabel.Text ~= "All Weapons"
    end
    if v_u_89 and v_u_89.Visible then
        v_u_76 = v_u_124()
        v_u_218()
    else
        v_u_79 = true
        v_u_78 = true
    end
end
function v_u_1.SortByWeapon(p493, p494)
    local v495 = v_u_89.Tabs.Container.Container
    v_u_89.Tabs.Container.WeaponSort.Weapon.Frame.TextLabel.Text = p493 or "All Weapons"
    for _, v496 in ipairs(v495:GetChildren()) do
        if v496:IsA("Frame") then
            if p493 then
                local v497 = v_u_12.Get(v_u_10, "Inventory")
                local v498 = v496.Name
                for _, v500 in ipairs(v497) do
                    if v500._id == v498 then
                        goto l9
                    end
                end
                local v500 = nil
                ::l9::
                if v500 then
                    v496.Visible = v500.Name == p493 and (p494 == nil and true or v500.Skin == p494)
                end
            else
                v496.Visible = true
            end
        end
    end
    if v_u_28 then
        v_u_1.SortByCategory(v_u_28)
    end
    local v501 = v_u_89.Tabs.Container.WeaponSort:FindFirstChild("Reset")
    if v501 then
        local v502 = v_u_89.Tabs.Container.WeaponSort.Weapon
        v501.Visible = v_u_28 ~= nil and true or v502.Frame.TextLabel.Text ~= "All Weapons"
    end
end
function v_u_1.SortBySkinMetadata(p503)
    v_u_29 = p503
    local _ = v_u_89.Tabs.Container.Container
    v_u_89.Tabs.Container.SkinSort.Sort.Frame.TextLabel.Text = p503
    if v_u_21.GetSortComparisonFunction(p503, v_u_10, function()
        return v_u_97
    end) then
        if not (v_u_89 and v_u_89.Visible) then
            v_u_79 = true
            v_u_78 = true
            return
        end
        v_u_76 = v_u_124()
        v_u_218()
    end
end
function v_u_1.UpdateInventoryContainer()
    if v_u_89 then
        if v_u_89.Visible then
            v_u_41 = nil
            v_u_42 = false
            v_u_43 = nil
            v_u_44 = nil
            v_u_45 = nil
            v_u_48 = false
            if v_u_47 then
                v_u_47 = false
                pcall(function()
                    v_u_5:DisableGamepadCursor()
                end)
                v_u_8.AutoSelectGuiEnabled = true
            end
            v_u_304()
            local v504 = v_u_12.Get(v_u_10, "Inventory")
            local v505 = {}
            for _, v506 in ipairs(v504) do
                if v506 and v506._id then
                    v505[v506._id] = true
                end
            end
            local v507 = v_u_89.Tabs.Container.Container
            for _, v508 in ipairs(v507:GetChildren()) do
                if v508:IsA("Frame") and (v508.Name ~= "UIGridLayout" and (v508.Name ~= "UIPadding" and not v505[v508.Name])) then
                    v508:Destroy()
                end
            end
            v_u_1.PopulateCategoryDropdown()
            v_u_1.PopulateWeaponDropdown()
            v_u_1.SortBySkinMetadata(v_u_29)
        else
            v_u_79 = true
            v_u_78 = true
        end
    else
        return
    end
end
function v_u_1.UpdateLoadoutContainer()
    -- failed to decompile
end
function v_u_1.UpdateSidebarFrames(p509, p510)
    local v511 = v_u_12.Get(v_u_10, "Inventory")
    local v512 = p510 or v_u_27
    local v513 = v512 == "Counter-Terrorists" and "CT" or "T"
    local v514 = v_u_89.Teams:FindFirstChild(v513)
    if not v514 then
        return
    end
    local v515 = v514:FindFirstChild("Sidebar")
    if not v515 then
        return
    end
    local v516 = p509[v512]
    if not (v516 and v516.Equipped) then
        return
    end
    for v517, v518 in pairs(v_u_87) do
        local v519 = v516.Equipped[v517]
        local v520 = v515:FindFirstChild(v518)
        if v520 then
            local v521 = v520:FindFirstChild("Weapon")
            local v522
            if v521 then
                v522 = v521:FindFirstChild("Icon")
            else
                v522 = v521
            end
            local v523
            if v521 then
                v523 = v521:FindFirstChild("Rarity")
            else
                v523 = v521
            end
            local v524
            if v521 then
                v524 = v521:FindFirstChild("Glow")
            else
                v524 = v521
            end
            local v525 = nil
            local v526 = false
            local v528
            if v519 and v519 ~= "" then
                for _, v528 in ipairs(v511) do
                    if v528._id == v519 then
                        goto l28
                    end
                end
                v528 = nil
                ::l28::
                if v528 then
                    local v529 = v_u_14.GetSkinInformation(v528.Name, v528.Skin)
                    if v529 then
                        v526 = true
                        if v522 then
                            v522.Image = v_u_14.GetWearImageForFloat(v529, v528.Float or 0.9999) or (v529.imageAssetId or "")
                            v522.Visible = true
                        end
                        if v523 then
                            v523.Visible = true
                            local v530 = v523:FindFirstChild("UIGradient")
                            if v530 then
                                v530.Color = v_u_19[v529.rarity].ColorSequence
                            end
                        end
                        if v524 then
                            v524.Visible = true
                            v524.ImageColor3 = v_u_19[v529.rarity].Color
                        end
                    end
                else
                    v528 = v525
                end
            else
                v528 = v525
            end
            if not v526 then
                if v522 then
                    v522.Visible = false
                end
                if v523 then
                    v523.Visible = false
                end
                if v524 then
                    v524.Visible = false
                end
            end
            if v521 and (v518 == "Melee" or v518 == "Gloves") then
                if v528 then
                    v521:SetAttribute("EquippedItemId", v528._id)
                else
                    v521:SetAttribute("EquippedItemId", nil)
                end
                v521:SetAttribute("SidebarName", v518)
                v521:SetAttribute("TeamKey", v512 == "Counter-Terrorists" and "CT" or "T")
            end
        end
    end
end
local function v_u_546()
    local v531 = v_u_89.Teams
    for _, v532 in ipairs({ "CT", "T" }) do
        local v533 = v_u_23.VIEWPORT_CHARACTER_CONFIG[v532]
        local v534 = v531:FindFirstChild(v532)
        if v534 then
            local v535 = v534:FindFirstChild("Player")
            if v535 then
                for _, v536 in ipairs(v535:GetChildren()) do
                    if v536:IsA("WorldModel") or v536:IsA("Camera") then
                        v536:Destroy()
                    end
                end
                local v537 = v_u_22:FindFirstChild(v533.Character)
                if v537 then
                    local v538 = Instance.new("WorldModel")
                    v538.Name = "CharacterWorldModel"
                    v538.Parent = v535
                    local v539 = v537:Clone()
                    v539.Name = "ViewportCharacter"
                    v539.Parent = v538
                    v_u_70[v532] = v539
                    local v540 = v533.CharacterOffset or CFrame.new(0, 0, 0)
                    if v539.PrimaryPart then
                        v539:SetPrimaryPartCFrame(v540)
                    else
                        v539:PivotTo(v540)
                    end
                    local v541 = v539:FindFirstChildOfClass("Humanoid")
                    if v541 and v533.IdleAnimation then
                        local v542 = v541:FindFirstChildOfClass("Animator")
                        if not v542 then
                            v542 = Instance.new("Animator")
                            v542.Parent = v541
                        end
                        local v543 = Instance.new("Animation")
                        v543.AnimationId = v533.IdleAnimation
                        local v544 = v542:LoadAnimation(v543)
                        v544.Looped = true
                        v544:Play()
                    end
                    local v545 = Instance.new("Camera")
                    v545.Name = "ViewportCamera"
                    v545.CameraType = Enum.CameraType.Scriptable
                    v545.FieldOfView = 50
                    v545.CFrame = CFrame.new(0, 0, 0) * v533.CameraOffset
                    v545.Parent = v535
                    v535.CurrentCamera = v545
                end
            end
        end
    end
end
local function v_u_567(p547)
    local v548 = v_u_70[p547]
    if not v548 then
        return
    end
    local v549 = v_u_73[p547]
    if v549 then
        for _, v550 in ipairs(v549) do
            if v550 and v550.Parent then
                v550:Destroy()
            end
        end
        v_u_73[p547] = {}
    end
    local v551 = p547 == "CT" and "Counter-Terrorists" or "Terrorists"
    local v552 = v_u_12.Get(v_u_10, "Loadout")
    if not (v552 and v552[v551]) then
        return
    end
    local v553 = v552[v551].Equipped
    if v553 then
        v553 = v552[v551].Equipped["Equipped Gloves"]
    end
    if not v553 then
        return
    end
    local v554 = v_u_12.Get(v_u_10, "Inventory")
    local v555 = nil
    for _, v556 in ipairs(v554) do
        if v556._id == v553 then
            v555 = v556
            break
        end
    end
    if v555 then
        local v557 = v_u_14.GetGloves(v555.Name, v555.Skin, v555.Float)
        if v557 then
            local v558 = {}
            for _, v559 in ipairs(v557:GetChildren()) do
                if v559:IsA("BasePart") then
                    local v560 = v_u_26[v559.Name]
                    if v560 then
                        local v561 = v548:FindFirstChild(v560)
                        if v561 then
                            local v562 = v559:Clone()
                            v562.Name = v_u_25[v559.Name] or v559.Name
                            v562.CastShadow = false
                            v562.CanCollide = false
                            v562.CanTouch = false
                            v562.Anchored = false
                            v562.CanQuery = false
                            v562.CFrame = v561.CFrame * CFrame.Angles(-1.5707963267948966, 0, 0)
                            local v563 = v561.Size.X * 1.1
                            local v564 = v561.Size.Z
                            local v565 = v561.Size.Y
                            v562.Size = Vector3.new(v563, v564, v565) * 1.1
                            v562.Parent = v548
                            local v566 = Instance.new("Motor6D")
                            v566.Name = "GloveAttachment"
                            v566.Part0 = v561
                            v566.Part1 = v562
                            v566.C0 = CFrame.new(0, 0, -0.025)
                            v566.C1 = v562.PivotOffset * CFrame.Angles(1.5707963267948966, 0, 0)
                            v566.Parent = v562
                            table.insert(v558, v562)
                        end
                    end
                end
            end
            v_u_73[p547] = v558
            v557:Destroy()
        end
    else
        return
    end
end
local function v_u_630(p568, p569)
    local v570 = v_u_70[p568]
    if v570 then
        if p569 and v_u_75[p568] == p569._id then
            local v571 = v_u_72[p568]
            if not (v571 and v571.IsPlaying) then
                local v572 = v570:FindFirstChildOfClass("Humanoid")
                local v573 = v572 and v572:FindFirstChildOfClass("Animator")
                if v573 then
                    local v574 = nil
                    if p569.Type == "Melee" then
                        v574 = "Melee"
                    else
                        local v575, v576 = pcall(v_u_18, p569.Name)
                        if v575 and v576 then
                            local v577 = v576.Type
                            local v578 = v576.AimingOptions
                            local v579 = v576.MuzzleType
                            if v577 == nil then
                                v574 = nil
                            elseif v578 == "SniperScope" then
                                v574 = "Sniper"
                            elseif v577 == "Heavy" then
                                v574 = v579 == "MachineGun" and "LMG" or "Heavy"
                            else
                                v574 = ({
                                    ["Pistol"] = "Pistol",
                                    ["Rifle"] = "Rifle",
                                    ["SMG"] = "SMG",
                                    ["Equipment"] = nil,
                                    ["Miscellaneous"] = nil
                                })[v577]
                            end
                        end
                    end
                    if v574 then
                        local v580 = p569.Name
                        local v581
                        if v574 and v_u_23.ANIMATION_MAPPING[v574] then
                            local v582 = v_u_23.ANIMATION_MAPPING[v574]
                            if v580 and v582[v580] then
                                v581 = v582[v580]
                            else
                                v581 = v582.Default
                            end
                        else
                            v581 = nil
                        end
                        if v581 then
                            local v583 = v573:LoadAnimation(v581)
                            v583.Looped = true
                            v583.Priority = Enum.AnimationPriority.Action
                            v583:Play()
                            v_u_72[p568] = v583
                        end
                    end
                end
            end
            return
        else
            local v584 = v_u_72[p568]
            if v584 then
                v584:Stop()
                v_u_72[p568] = nil
            end
            local v585 = v_u_71[p568]
            if v585 then
                v585:Destroy()
                v_u_71[p568] = nil
            end
            v_u_75[p568] = nil
            for _, v586 in pairs({ v_u_24.DEFAULT_JOINT_PART, "UpperTorso", "LeftHand" }) do
                local v587 = v570:FindFirstChild(v586)
                if v587 then
                    local v588 = v587:FindFirstChild("WeaponAttachment")
                    if v588 then
                        v588:Destroy()
                    end
                    local v589 = v587:FindFirstChild("WeaponAttachmentHandleR")
                    if v589 then
                        v589:Destroy()
                    end
                    local v590 = v587:FindFirstChild("WeaponAttachmentHandleL")
                    if v590 then
                        v590:Destroy()
                    end
                end
            end
            if p569 then
                local v591 = v_u_14.GetCharacterModel(p569.Name, p569.Skin, p569.Float, p569.StatTrack, p569.NameTag)
                if v591 then
                    v591.Name = p569.Name
                    local v592 = v570:FindFirstChild(v_u_24.WEAPON_JOINT_PARTS[p569.Name] or v_u_24.DEFAULT_JOINT_PART)
                    if v592 then
                        if not v591.PrimaryPart then
                            local v593 = v591:FindFirstChild("Weapon")
                            if v593 then
                                v593 = v593:FindFirstChild("Insert")
                            end
                            if v593 then
                                v591.PrimaryPart = v593
                            else
                                local v594 = v591:FindFirstChild("Insert", true)
                                if v594 then
                                    v591.PrimaryPart = v594
                                end
                            end
                        end
                        if v591.PrimaryPart then
                            for _, v595 in ipairs(v591:GetDescendants()) do
                                if v595:IsA("BasePart") then
                                    v595.CanCollide = false
                                    v595.CanQuery = false
                                    v595.CanTouch = false
                                    v595.Anchored = false
                                    v595.Massless = true
                                end
                            end
                            v591.Parent = v570
                            local v596, v597 = pcall(v_u_18, p569.Name)
                            local v598
                            if v596 and v597 then
                                v598 = v597.ShootingOptions == "Dual"
                            else
                                v598 = false
                            end
                            local v599 = v591:FindFirstChild("Properties")
                            if not v599 then
                                local v600 = v591:FindFirstChild("Weapon")
                                if v600 then
                                    v599 = v600:FindFirstChild("Properties")
                                end
                            end
                            local v601 = v599 or v591:FindFirstChild("Properties", true)
                            if v598 then
                                local v602 = v570:FindFirstChild("RightHand")
                                local v603 = v570:FindFirstChild("LeftHand")
                                if v602 and v603 then
                                    local v604 = v591:FindFirstChild("HandleR", true)
                                    if v604 then
                                        local v605 = Instance.new("Motor6D")
                                        v605.Name = "WeaponAttachmentHandleR"
                                        v605.Part0 = v602
                                        v605.Part1 = v604
                                        v605.Parent = v602
                                        if v601 then
                                            local v606 = v601:FindFirstChild("C0RIGHT")
                                            if v606 then
                                                v605.C0 = v606.Value
                                            end
                                            local v607 = v601:FindFirstChild("C1RIGHT")
                                            if v607 then
                                                v605.C1 = v607.Value
                                            end
                                        end
                                    end
                                    local v608 = v591:FindFirstChild("HandleL", true)
                                    if v608 then
                                        local v609 = Instance.new("Motor6D")
                                        v609.Name = "WeaponAttachmentHandleL"
                                        v609.Part0 = v603
                                        v609.Part1 = v608
                                        v609.Parent = v603
                                        if v601 then
                                            local v610 = v601:FindFirstChild("C0LEFT")
                                            if v610 then
                                                v609.C0 = v610.Value
                                            end
                                            local v611 = v601:FindFirstChild("C1LEFT")
                                            if v611 then
                                                v609.C1 = v611.Value
                                            end
                                        end
                                    end
                                end
                            else
                                local v612 = Instance.new("Motor6D")
                                v612.Name = "WeaponAttachment"
                                v612.Part0 = v592
                                v612.Part1 = v591.PrimaryPart
                                v612.Parent = v592
                                if v601 then
                                    local v613 = v601:FindFirstChild("C0")
                                    if v613 then
                                        v612.C0 = v613.Value
                                    end
                                    local v614 = v601:FindFirstChild("C1")
                                    if v614 then
                                        v612.C1 = v614.Value
                                    end
                                end
                            end
                            v_u_71[p568] = v591
                            v_u_75[p568] = p569._id
                            local v615 = v570:FindFirstChildOfClass("Humanoid")
                            if v615 then
                                local v616 = v615:FindFirstChildOfClass("Animator")
                                if v616 then
                                    local v617 = nil
                                    if p569.Type == "Melee" then
                                        v617 = "Melee"
                                    elseif v597 then
                                        local v618 = v597.Type
                                        local v619 = v597.AimingOptions
                                        local v620 = v597.MuzzleType
                                        if v618 == nil then
                                            v617 = nil
                                        elseif v619 == "SniperScope" then
                                            v617 = "Sniper"
                                        elseif v618 == "Heavy" then
                                            v617 = v620 == "MachineGun" and "LMG" or "Heavy"
                                        else
                                            v617 = ({
                                                ["Pistol"] = "Pistol",
                                                ["Rifle"] = "Rifle",
                                                ["SMG"] = "SMG",
                                                ["Equipment"] = nil,
                                                ["Miscellaneous"] = nil
                                            })[v618]
                                        end
                                    else
                                        local v621, v622 = pcall(v_u_18, p569.Name)
                                        if v621 and v622 then
                                            local v623 = v622.Type
                                            local v624 = v622.AimingOptions
                                            local v625 = v622.MuzzleType
                                            if v623 == nil then
                                                v617 = nil
                                            elseif v624 == "SniperScope" then
                                                v617 = "Sniper"
                                            elseif v623 == "Heavy" then
                                                v617 = v625 == "MachineGun" and "LMG" or "Heavy"
                                            else
                                                v617 = ({
                                                    ["Pistol"] = "Pistol",
                                                    ["Rifle"] = "Rifle",
                                                    ["SMG"] = "SMG",
                                                    ["Equipment"] = nil,
                                                    ["Miscellaneous"] = nil
                                                })[v623]
                                            end
                                        end
                                    end
                                    if v617 then
                                        local v626 = p569.Name
                                        local v627
                                        if v617 and v_u_23.ANIMATION_MAPPING[v617] then
                                            local v628 = v_u_23.ANIMATION_MAPPING[v617]
                                            if v626 and v628[v626] then
                                                v627 = v628[v626]
                                            else
                                                v627 = v628.Default
                                            end
                                        else
                                            v627 = nil
                                        end
                                        if v627 then
                                            local v629 = v616:LoadAnimation(v627)
                                            v629.Looped = true
                                            v629.Priority = Enum.AnimationPriority.Action
                                            v629:Play()
                                            v_u_72[p568] = v629
                                        end
                                    end
                                end
                            else
                                return
                            end
                        else
                            v591:Destroy()
                            return
                        end
                    else
                        v591:Destroy()
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
local function v_u_639(p631)
    local v632 = p631 == "CT" and "Counter-Terrorists" or "Terrorists"
    local v633 = v_u_12.Get(v_u_10, "Loadout")
    local v634 = v_u_12.Get(v_u_10, "Inventory")
    if not (v633 and v634) then
        return
    end
    local v635 = v633[v632]
    if not (v635 and v635.Equipped) then
        return
    end
    local v636 = v635.Equipped["Equipped Melee"]
    if v636 and v636 ~= "" then
        for _, v638 in ipairs(v634) do
            if v638._id == v636 then
                goto l16
            end
        end
        local v638 = nil
        ::l16::
        if v638 then
            v_u_630(p631, v638)
            return
        end
    end
    v_u_630(p631, {
        ["_id"] = "default_knife",
        ["Type"] = "Melee",
        ["Serial"] = 0,
        ["Name"] = p631 == "CT" and "CT Knife" or "T Knife",
        ["Skin"] = "Stock",
        ["Float"] = 0,
        ["StatTrack"] = false,
        ["IsTradeable"] = false,
        ["NameTag"] = false,
        ["Charm"] = false
    })
end
function v_u_1.OnLoadoutItemHover(p640)
    v_u_630(v_u_27 == "Counter-Terrorists" and "CT" or "T", p640)
end
function v_u_1.OnLoadoutItemUnhover() end
local function v_u_657()
    local v_u_641 = v_u_12.Get(v_u_10, "Inventory")
    if v_u_641 then
        local v642 = v_u_89.Teams
        for _, v_u_643 in ipairs({ "CT", "T" }) do
            local v644 = v642:FindFirstChild(v_u_643)
            if v644 then
                local v645 = v644:FindFirstChild("Sidebar")
                if v645 then
                    for _, v_u_646 in ipairs({ "Melee", "Gloves" }) do
                        local v647 = v645:FindFirstChild(v_u_646)
                        if v647 then
                            local v648 = v647:FindFirstChild("Weapon")
                            if v648 then
                                local v649 = v_u_643 .. "_" .. v_u_646
                                local v650 = v_u_74[v649]
                                if v650 then
                                    if v650.MouseEnter then
                                        v650.MouseEnter:Disconnect()
                                    end
                                    if v650.MouseLeave then
                                        v650.MouseLeave:Disconnect()
                                    end
                                end
                                local v_u_651 = v648:GetAttribute("EquippedItemId")
                                local v_u_652 = v648:GetAttribute("TeamKey")
                                v_u_74[v649] = {
                                    ["MouseEnter"] = v648.MouseEnter:Connect(function()
                                        if not v_u_651 or v_u_651 == "" then
                                            if v_u_646 == "Melee" then
                                                v_u_639(v_u_652 or v_u_643)
                                            end
                                            goto l10
                                        end
                                        local v653 = v_u_641
                                        local v654 = v_u_651
                                        for _, v656 in ipairs(v653) do
                                            if v656._id == v654 then
                                                goto l7
                                            end
                                        end
                                        local v656 = nil
                                        ::l7::
                                        if v656 and v_u_646 == "Melee" then
                                            v_u_630(v_u_652 or v_u_643, v656)
                                            return
                                        end
                                        ::l10::
                                    end),
                                    ["MouseLeave"] = v648.MouseLeave:Connect(function() end)
                                }
                            end
                        end
                    end
                end
            end
        end
    end
end
function v_u_1.SelectTeam(p658)
    local v659 = v_u_89.Teams
    v659.GunsCT.Visible = p658 == "CT"
    v659.GunsT.Visible = p658 == "T"
    if v_u_52 == nil then
        v_u_52 = v_u_89.Teams.CT.BackgroundTransparency
    end
    if v_u_53 == nil then
        v_u_53 = v_u_89.Teams.T.BackgroundTransparency
    end
    v_u_89.Teams.CT.Visible = true
    v_u_89.Teams.T.Visible = true
    local v660 = TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    local v661 = v_u_89.Teams.CT:FindFirstChild("Sidebar")
    local v662 = v_u_89.Teams.T:FindFirstChild("Sidebar")
    local v663 = v_u_89.Teams.CT:FindFirstChild("Equip")
    local v664 = v_u_89.Teams.T:FindFirstChild("Equip")
    local v665
    if v663 then
        v665 = v663:FindFirstChild("Frame")
    else
        v665 = v663
    end
    local v666
    if v664 then
        v666 = v664:FindFirstChild("Frame")
    else
        v666 = v664
    end
    local v667
    if v665 then
        v667 = v665:FindFirstChild("UIStroke")
    else
        v667 = v665
    end
    local v668
    if v666 then
        v668 = v666:FindFirstChild("UIStroke")
    else
        v668 = v666
    end
    if v663 then
        v663 = v663:FindFirstChild("skin")
    end
    if v664 then
        v664 = v664:FindFirstChild("skin")
    end
    local v669 = v_u_89.Teams.CT:FindFirstChild("Player")
    local v670 = v_u_89.Teams.T:FindFirstChild("Player")
    local v671 = Color3.fromRGB(104, 140, 175)
    local v672 = Color3.fromRGB(136, 115, 56)
    local v673 = Color3.fromRGB(0, 0, 0)
    if p658 == "CT" then
        local v674 = {
            ["BackgroundTransparency"] = v_u_52
        }
        v_u_6:Create(v_u_89.Teams.CT, v660, v674):Play()
        v_u_89.Teams.CT.Border.Visible = true
        v_u_6:Create(v_u_89.Teams.T, v660, {
            ["BackgroundTransparency"] = 1
        }):Play()
        v_u_89.Teams.T.Frame.Visible = false
        if v661 then
            v_u_6:Create(v661, v660, {
                ["GroupTransparency"] = 0
            }):Play()
        end
        if v662 then
            v_u_6:Create(v662, v660, {
                ["GroupTransparency"] = 0.65
            }):Play()
        end
        if v669 then
            v_u_6:Create(v669, v660, {
                ["ImageTransparency"] = 0
            }):Play()
        end
        if v670 then
            v_u_6:Create(v670, v660, {
                ["ImageTransparency"] = 0.6
            }):Play()
        end
        if v665 then
            v_u_6:Create(v665, v660, {
                ["BackgroundTransparency"] = 0
            }):Play()
        end
        if v667 then
            v_u_6:Create(v667, v660, {
                ["Transparency"] = 0
            }):Play()
        end
        if v663 then
            v_u_6:Create(v663, v660, {
                ["TextColor3"] = v673
            }):Play()
        end
        if v666 then
            v_u_6:Create(v666, v660, {
                ["BackgroundTransparency"] = 1
            }):Play()
        end
        if v668 then
            v_u_6:Create(v668, v660, {
                ["Transparency"] = 0.6
            }):Play()
        end
        if v664 then
            v_u_6:Create(v664, v660, {
                ["TextColor3"] = v672
            }):Play()
        end
    else
        local v675 = {
            ["BackgroundTransparency"] = v_u_53
        }
        v_u_6:Create(v_u_89.Teams.T, v660, v675):Play()
        v_u_89.Teams.T.Frame.Visible = true
        v_u_6:Create(v_u_89.Teams.CT, v660, {
            ["BackgroundTransparency"] = 1
        }):Play()
        v_u_89.Teams.CT.Border.Visible = false
        if v661 then
            v_u_6:Create(v661, v660, {
                ["GroupTransparency"] = 0.65
            }):Play()
        end
        if v662 then
            v_u_6:Create(v662, v660, {
                ["GroupTransparency"] = 0
            }):Play()
        end
        if v669 then
            v_u_6:Create(v669, v660, {
                ["ImageTransparency"] = 0.6
            }):Play()
        end
        if v670 then
            v_u_6:Create(v670, v660, {
                ["ImageTransparency"] = 0
            }):Play()
        end
        if v666 then
            v_u_6:Create(v666, v660, {
                ["BackgroundTransparency"] = 0
            }):Play()
        end
        if v668 then
            v_u_6:Create(v668, v660, {
                ["Transparency"] = 0
            }):Play()
        end
        if v664 then
            v_u_6:Create(v664, v660, {
                ["TextColor3"] = v673
            }):Play()
        end
        if v665 then
            v_u_6:Create(v665, v660, {
                ["BackgroundTransparency"] = 1
            }):Play()
        end
        if v667 then
            v_u_6:Create(v667, v660, {
                ["Transparency"] = 0.6
            }):Play()
        end
        if v663 then
            v_u_6:Create(v663, v660, {
                ["TextColor3"] = v671
            }):Play()
        end
    end
    v_u_27 = p658 == "CT" and "Counter-Terrorists" or (p658 == "T" and "Terrorists" or false)
    v_u_28 = nil
    v_u_89.Tabs.Container.WeaponSort.Category.Frame.TextLabel.Text = "All Categories"
    v_u_89.Tabs.Container.WeaponSort.Weapon.Frame.TextLabel.Text = "All Weapons"
    local v676 = v_u_12.Get(v_u_10, "Loadout")
    v_u_1.UpdateLoadoutContainer(v676)
    v_u_1.UpdateSidebarFrames(v676)
    v_u_1.UpdateInventoryContainer()
    v_u_1.PopulateCategoryDropdown()
    v_u_1.PopulateWeaponDropdown()
end
function v_u_1.Initialize(p677, p678)
    v_u_89 = p678
    v_u_89:GetPropertyChangedSignal("Visible"):Connect(function()
        if v_u_89.Visible then
            if v_u_79 then
                v_u_79 = false
                v_u_1.SortBySkinMetadata(v_u_29)
            end
            if v_u_78 then
                v_u_213()
            end
        else
            if v_u_39 then
                v_u_39:Disconnect()
                v_u_39 = nil
            end
            v_u_37 = nil
            v_u_38 = nil
            v_u_40 = false
            if v_u_36 then
                v_u_36:Disconnect()
                v_u_36 = nil
            end
            if v_u_32 then
                v_u_32:Destroy()
                v_u_32 = nil
            end
            v_u_31 = false
            v_u_33 = nil
            v_u_34 = nil
            v_u_35 = nil
            v_u_304()
            v_u_41 = nil
            v_u_42 = false
            v_u_43 = nil
            v_u_44 = nil
            v_u_45 = nil
            v_u_48 = false
            if v_u_47 then
                v_u_47 = false
                pcall(function()
                    v_u_5:DisableGamepadCursor()
                end)
                v_u_8.AutoSelectGuiEnabled = true
            end
            v_u_304()
        end
    end)
    local v679 = v_u_89.Tabs.Container.Container
    v679:GetPropertyChangedSignal("CanvasPosition"):Connect(function()
        if v_u_89 then
            local v680 = v_u_89.Tabs.Container.Container
            local v681 = v680.CanvasPosition.Y
            local v682 = v680.AbsoluteCanvasSize.Y - v680.AbsoluteSize.Y
            if v682 > 0 and (v_u_77 < #v_u_76 and v682 - v681 < 200) then
                v_u_153()
            end
        else
            return
        end
    end)
    v679:GetPropertyChangedSignal("AbsoluteCanvasSize"):Connect(function()
        task.defer(v_u_157)
    end)
    local v_u_683 = p677:FindFirstChild("Menu")
    if v_u_683 then
        v_u_683:GetPropertyChangedSignal("Visible"):Connect(function()
            if not v_u_683.Visible then
                if v_u_39 then
                    v_u_39:Disconnect()
                    v_u_39 = nil
                end
                v_u_37 = nil
                v_u_38 = nil
                v_u_40 = false
                if v_u_36 then
                    v_u_36:Disconnect()
                    v_u_36 = nil
                end
                if v_u_32 then
                    v_u_32:Destroy()
                    v_u_32 = nil
                end
                v_u_31 = false
                v_u_33 = nil
                v_u_34 = nil
                v_u_35 = nil
                v_u_304()
                v_u_41 = nil
                v_u_42 = false
                v_u_43 = nil
                v_u_44 = nil
                v_u_45 = nil
                v_u_48 = false
                if v_u_47 then
                    v_u_47 = false
                    pcall(function()
                        v_u_5:DisableGamepadCursor()
                    end)
                    v_u_8.AutoSelectGuiEnabled = true
                end
                v_u_304()
                local v684 = v_u_89.ActionFrame
                if v684 then
                    v684.Visible = false
                end
                v_u_51 = nil
                if v_u_17.IsInspectActive() then
                    v_u_13.broadcastRouter("WeaponInspectClose")
                end
            end
        end)
    end
    local v_u_685 = v_u_89.ActionFrame
    if v_u_685 then
        v_u_685.Visible = false
        local v686 = v_u_685:FindFirstChild("Inspect")
        if v686 then
            v686.MouseButton1Click:Connect(v_u_96)
        end
        local v687 = v_u_685:FindFirstChild("Charm")
        if v687 then
            v687.MouseButton1Click:Connect(function()
                if v_u_51 then
                    local v688 = v_u_51
                    local v689
                    if v688.Charm == nil or v688.Charm == false then
                        v689 = false
                    else
                        local v690 = v688.Charm
                        if type(v690) == "string" or v688.Charm == true then
                            v689 = true
                        else
                            local v691 = v688.Charm
                            v689 = type(v691) == "table"
                        end
                    end
                    local v692 = v_u_89.ActionFrame
                    if v692 then
                        v692.Visible = false
                    end
                    v_u_51 = nil
                    if v689 then
                        v_u_16.Inventory.RemoveWeaponCharm.Send({
                            ["WeaponId"] = v688._id
                        })
                    end
                end
            end)
        end
        v_u_4.InputBegan:Connect(function(p693, p694)
            if not p694 then
                if p693.UserInputType == Enum.UserInputType.MouseButton1 or (p693.UserInputType == Enum.UserInputType.MouseButton2 or p693.UserInputType == Enum.UserInputType.Touch) then
                    task.defer(function()
                        if v_u_685.Visible and v_u_51 then
                            local v695 = v_u_4:GetMouseLocation()
                            local v696 = v_u_685.AbsolutePosition
                            local v697 = v_u_685.AbsoluteSize
                            local v698
                            if v695.X >= v696.X then
                                v698 = v695.X <= v696.X + v697.X
                            else
                                v698 = false
                            end
                            local v699
                            if v695.Y >= v696.Y then
                                v699 = v695.Y <= v696.Y + v697.Y
                            else
                                v699 = false
                            end
                            if not (v698 and v699) then
                                local v700 = v_u_89.ActionFrame
                                if v700 then
                                    v700.Visible = false
                                end
                                v_u_51 = nil
                            end
                        end
                    end)
                end
            end
        end)
    end
    task.spawn(function()
        local v701 = {}
        for _, v702 in pairs(v_u_20) do
            table.insert(v701, v702)
        end
        v_u_3:PreloadAsync(v701)
    end)
    v_u_546()
    v_u_567("CT")
    v_u_567("T")
    v_u_639("CT")
    v_u_639("T")
    local v703 = v_u_89.Teams
    for _, v704 in ipairs({ v703.GunsCT, v703.GunsT }) do
        for _, v_u_705 in ipairs({ "Mid Tier", "Pistols", "Rifles" }) do
            local v_u_706 = v704:FindFirstChild(v_u_705)
            if v_u_706 and v_u_706:IsA("Frame") then
                v_u_706.MouseEnter:Connect(function()
                    v_u_50 = v_u_705
                    v_u_227(v_u_706, true)
                end)
                v_u_706.MouseLeave:Connect(function()
                    v_u_50 = nil
                    v_u_227(v_u_706, false)
                end)
            end
        end
    end
    v_u_12.CreateListener(v_u_10, "Loadout", function(p707)
        v_u_49 = false
        v_u_1.UpdateLoadoutContainer(p707)
        v_u_1.UpdateSidebarFrames(p707, "Counter-Terrorists")
        v_u_1.UpdateSidebarFrames(p707, "Terrorists")
        v_u_567("CT")
        v_u_567("T")
        v_u_657()
        if v_u_89 and v_u_89.Visible then
            local v708 = v_u_89.Tabs.Container.Container
            for _, v709 in ipairs(v708:GetChildren()) do
                if v709:IsA("Frame") and (v709.Name ~= "UIGridLayout" and (v709.Name ~= "UIListLayout" and v709.Name ~= "UIPadding")) then
                    v_u_69(v709, v709.Name)
                end
            end
        end
    end)
    v_u_16.Inventory.LoadoutResponse.Listen(function()
        v_u_49 = false
    end)
    v_u_12.CreateListener(v_u_10, "Inventory", function()
        v_u_1.UpdateInventoryContainer()
        if v_u_89 and v_u_89.Visible then
            local v710 = v_u_89.Tabs.Container.Container
            for _, v711 in ipairs(v710:GetChildren()) do
                if v711:IsA("Frame") and (v711.Name ~= "UIGridLayout" and (v711.Name ~= "UIListLayout" and v711.Name ~= "UIPadding")) then
                    v_u_69(v711, v711.Name)
                end
            end
        end
    end)
    v_u_4.InputEnded:Connect(function(p712, _)
        if (p712.UserInputType == Enum.UserInputType.MouseButton1 or p712.UserInputType == Enum.UserInputType.Touch) and (v_u_31 or v_u_37) then
            v_u_1.EndDrag()
        end
    end)
    v_u_4.InputBegan:Connect(function(p713, _)
        if p713.UserInputType == Enum.UserInputType.Gamepad1 then
            if p713.KeyCode == Enum.KeyCode.ButtonA then
                if v_u_41 and v_u_47 then
                    v_u_48 = true
                    return
                end
            elseif p713.KeyCode == Enum.KeyCode.ButtonB then
                v_u_393()
            end
        end
    end)
    v_u_4.InputEnded:Connect(function(p714, _)
        if p714.UserInputType == Enum.UserInputType.Gamepad1 then
            if p714.KeyCode == Enum.KeyCode.ButtonA and (v_u_41 and (v_u_47 and v_u_48)) then
                v_u_392()
            end
        end
    end)
    v_u_4.LastInputTypeChanged:Connect(function(p715)
        local v716 = v_u_46
        v_u_46 = p715 == Enum.UserInputType.Gamepad1
        if v716 and not v_u_46 then
            v_u_41 = nil
            v_u_42 = false
            v_u_43 = nil
            v_u_44 = nil
            v_u_45 = nil
            v_u_48 = false
            if v_u_47 then
                v_u_47 = false
                pcall(function()
                    v_u_5:DisableGamepadCursor()
                end)
                v_u_8.AutoSelectGuiEnabled = true
            end
            v_u_304()
        end
        if not v716 and v_u_46 then
            if v_u_39 then
                v_u_39:Disconnect()
                v_u_39 = nil
            end
            v_u_37 = nil
            v_u_38 = nil
            v_u_40 = false
            if v_u_36 then
                v_u_36:Disconnect()
                v_u_36 = nil
            end
            if v_u_32 then
                v_u_32:Destroy()
                v_u_32 = nil
            end
            v_u_31 = false
            v_u_33 = nil
            v_u_34 = nil
            v_u_35 = nil
            v_u_304()
        end
    end)
    v_u_46 = v_u_4:GetLastInputType() == Enum.UserInputType.Gamepad1
    local v717 = v_u_89.Tabs.Container.SkinSort.Sort
    local v_u_718 = v717.Options
    v717.MouseButton1Click:Connect(function()
        local v719 = v_u_718.Visible
        local v720 = v_u_89.Tabs.Container.SkinSort.Sort.Options
        local v721 = v_u_89.Tabs.Container.WeaponSort.Category
        local v722 = v_u_89.Tabs.Container.WeaponSort.Weapon
        v720.Visible = false
        if v721.ScrollingFrame then
            v721.ScrollingFrame.Visible = false
        end
        local v723 = v722:FindFirstChild("Options")
        if v723 then
            v723.Visible = false
        end
        v_u_718.Visible = not v719
    end)
    for _, v_u_724 in ipairs(v_u_718:GetChildren()) do
        if v_u_724:IsA("TextButton") then
            v_u_724.MouseEnter:Connect(function()
                v_u_221(v_u_724, true)
            end)
            v_u_724.MouseLeave:Connect(function()
                v_u_221(v_u_724, false)
            end)
            v_u_724.MouseButton1Click:Connect(function()
                v_u_1.SortBySkinMetadata(v_u_724.Name)
                v_u_233(v_u_718, v_u_724.Name)
                v_u_718.Visible = false
            end)
        end
    end
    local v_u_725 = v_u_89.Tabs.Container.WeaponSort.Category
    local v_u_726 = v_u_725.ScrollingFrame
    if v_u_726 then
        v_u_246(v_u_726)
        v_u_725.MouseButton1Click:Connect(function()
            local v727 = v_u_726.Visible
            local v728 = v_u_89.Tabs.Container.SkinSort.Sort.Options
            local v729 = v_u_89.Tabs.Container.WeaponSort.Category
            local v730 = v_u_89.Tabs.Container.WeaponSort.Weapon
            v728.Visible = false
            if v729.ScrollingFrame then
                v729.ScrollingFrame.Visible = false
            end
            local v731 = v730:FindFirstChild("Options")
            if v731 then
                v731.Visible = false
            end
            v_u_726.Visible = not v727
        end)
    end
    local v_u_732 = v_u_89.Tabs.Container.WeaponSort.Weapon
    local v_u_733 = v_u_732:FindFirstChild("Options")
    if v_u_733 and (v_u_733:IsA("Frame") or v_u_733:IsA("ScrollingFrame")) then
        v_u_246(v_u_733)
        v_u_732.MouseButton1Click:Connect(function()
            local v734 = v_u_733.Visible
            local v735 = v_u_89.Tabs.Container.SkinSort.Sort.Options
            local v736 = v_u_89.Tabs.Container.WeaponSort.Category
            local v737 = v_u_89.Tabs.Container.WeaponSort.Weapon
            v735.Visible = false
            if v736.ScrollingFrame then
                v736.ScrollingFrame.Visible = false
            end
            local v738 = v737:FindFirstChild("Options")
            if v738 then
                v738.Visible = false
            end
            v_u_733.Visible = not v734
        end)
    end
    local v_u_739 = v_u_89.Tabs.Container.WeaponSort:FindFirstChild("Reset")
    if v_u_739 then
        v_u_739.Visible = false
        v_u_739.MouseButton1Click:Connect(function()
            v_u_28 = nil
            v_u_725.Frame.TextLabel.Text = "All Categories"
            v_u_732.Frame.TextLabel.Text = "All Weapons"
            v_u_739.Visible = false
            v_u_1.PopulateWeaponDropdown()
            local v740 = v_u_89.Tabs.Container.Container
            for _, v741 in ipairs(v740:GetChildren()) do
                if v741:IsA("Frame") then
                    v741.Visible = true
                end
            end
            v_u_1.SortBySkinMetadata(v_u_29)
        end)
    end
end
function v_u_1.ViewInLoadout(p742)
    local v743 = v_u_12.Get(v_u_10, "Inventory")
    for _, v745 in ipairs(v743) do
        if v745._id == p742 then
            goto l4
        end
    end
    local v745 = nil
    ::l4::
    if v745 then
        local v746 = v745.Name
        local v747 = v745.Skin
        local v748, v749 = pcall(v_u_18, v746)
        if v748 and (v749 and v749.Type) then
            v_u_28 = v749.Type
            v_u_89.Tabs.Container.WeaponSort.Category.Frame.TextLabel.Text = v749.Type
            v_u_1.PopulateWeaponDropdown()
        end
        v_u_89.Tabs.Container.WeaponSort.Weapon.Frame.TextLabel.Text = v746
        v_u_1.SortByWeapon(v746, v747)
        local v750 = v_u_89.Tabs.Container.WeaponSort:FindFirstChild("Reset")
        if v750 then
            local v751 = v_u_89.Tabs.Container.WeaponSort.Weapon
            v750.Visible = v_u_28 ~= nil and true or v751.Frame.TextLabel.Text ~= "All Weapons"
        end
        if not v_u_89.Visible then
            v_u_17.SetScreen("Loadout")
            v_u_89.Visible = true
        end
    else
        return
    end
end
function v_u_1.Start()
    v_u_12.WaitForDataLoaded(v_u_10)
    v_u_1.SelectTeam("CT")
    local v752 = v_u_12.Get(v_u_10, "Loadout")
    if v752 then
        v_u_1.UpdateSidebarFrames(v752, "Counter-Terrorists")
        v_u_1.UpdateSidebarFrames(v752, "Terrorists")
        v_u_657()
    end
    v_u_1.PopulateCategoryDropdown()
    v_u_1.PopulateWeaponDropdown()
    v_u_1.SortBySkinMetadata("Newest")
    v_u_233(v_u_89.Tabs.Container.SkinSort.Sort.Options, "Newest")
    local function v_u_757()
        v_u_28 = nil
        v_u_89.Tabs.Container.WeaponSort.Category.Frame.TextLabel.Text = "All Categories"
        v_u_89.Tabs.Container.WeaponSort.Weapon.Frame.TextLabel.Text = "All Weapons"
        local v753 = v_u_89.Tabs.Container.Container
        for _, v754 in ipairs(v753:GetChildren()) do
            if v754:IsA("Frame") then
                v754.Visible = true
            end
        end
        v_u_1.SortBySkinMetadata(v_u_29)
        local v755 = v_u_89.Tabs.Container.WeaponSort:FindFirstChild("Reset")
        if v755 then
            local v756 = v_u_89.Tabs.Container.WeaponSort.Weapon
            v755.Visible = v_u_28 ~= nil and true or v756.Frame.TextLabel.Text ~= "All Weapons"
        end
    end
    local v_u_758 = {}
    local function v_u_790()
        local v759 = v_u_89.Teams
        for _, v_u_760 in ipairs({ "CT", "T" }) do
            local v761 = v759:FindFirstChild(v_u_760)
            if v761 then
                local v762 = v761:FindFirstChild("Sidebar")
                if v762 then
                    for _, v_u_763 in ipairs({ "Melee", "Gloves" }) do
                        local v764 = v762:FindFirstChild(v_u_763)
                        if v764 then
                            local v765 = v764:FindFirstChild("Button")
                            if v765 then
                                local function v788()
                                    local v766 = v_u_30
                                    if v766 then
                                        if v_u_30.teamKey == v_u_760 then
                                            v766 = v_u_30.sidebarName == v_u_763
                                        else
                                            v766 = false
                                        end
                                    end
                                    if v766 then
                                        v_u_30 = nil
                                        v_u_757()
                                    else
                                        local v_u_767 = v_u_763 == "Melee" and "Melee" or "Glove"
                                        local v_u_768 = v_u_760 == "CT" and "Counter-Terrorists" or (v_u_760 == "T" and "Terrorists" or false)
                                        v_u_28 = nil
                                        v_u_89.Tabs.Container.WeaponSort.Category.Frame.TextLabel.Text = "All Categories"
                                        v_u_89.Tabs.Container.WeaponSort.Weapon.Frame.TextLabel.Text = "All Weapons"
                                        v_u_30 = {
                                            ["teamKey"] = v_u_760,
                                            ["sidebarName"] = v_u_763
                                        }
                                        local v_u_769 = v_u_89.Tabs.Container.Container
                                        local v_u_770 = v_u_12.Get(v_u_10, "Inventory")
                                        local function v_u_785()
                                            for _, v771 in ipairs(v_u_769:GetChildren()) do
                                                if v771:IsA("Frame") then
                                                    local v772 = v_u_770
                                                    local v773 = v771.Name
                                                    for _, v775 in ipairs(v772) do
                                                        if v775._id == v773 then
                                                            goto l7
                                                        end
                                                    end
                                                    local v775 = nil
                                                    ::l7::
                                                    if v775 then
                                                        if v775.Type == v_u_767 then
                                                            local v776, v777 = pcall(v_u_18, v775.Name)
                                                            if v776 and (v777 and (v777.Class and v777.Class ~= v_u_767)) then
                                                                v771.Visible = false
                                                            else
                                                                local v778 = v775.Name
                                                                if v_u_768 == "Counter-Terrorists" then
                                                                    if v778 == "T Knife" or v778 == "T Gloves" then
                                                                        v771.Visible = false
                                                                    else
                                                                        ::l22::
                                                                        local v779 = not (v776 and (v777 and v777.Team))
                                                                        local v780 = v775.Name
                                                                        local v781 = v_u_768
                                                                        local v782
                                                                        if v780 and (type(v780) == "string" and v780 ~= "") then
                                                                            local v783, v784 = pcall(v_u_18, v780)
                                                                            if v783 and (v784 and v784.Team) then
                                                                                v782 = v784.Team == "Both" and true or v784.Team == v781
                                                                            else
                                                                                v782 = false
                                                                            end
                                                                        else
                                                                            v782 = false
                                                                        end
                                                                        v771.Visible = v779 or v782
                                                                    end
                                                                else
                                                                    if v_u_768 ~= "Terrorists" or v778 ~= "CT Knife" and v778 ~= "CT Gloves" then
                                                                        goto l22
                                                                    end
                                                                    v771.Visible = false
                                                                end
                                                            end
                                                        else
                                                            v771.Visible = false
                                                        end
                                                    else
                                                        v771.Visible = false
                                                    end
                                                end
                                            end
                                        end
                                        v_u_785()
                                        task.defer(v_u_785)
                                        v_u_1.SortBySkinMetadata(v_u_29)
                                        task.defer(function()
                                            v_u_785()
                                            task.defer(v_u_785)
                                        end)
                                        local v786 = v_u_89.Tabs.Container.WeaponSort:FindFirstChild("Reset")
                                        if v786 then
                                            local v787 = v_u_89.Tabs.Container.WeaponSort.Weapon
                                            v786.Visible = v_u_28 ~= nil and true or v787.Frame.TextLabel.Text ~= "All Weapons"
                                        end
                                    end
                                end
                                local v789 = ("%*_%*"):format(v_u_760, v_u_763)
                                if v_u_758[v789] then
                                    v_u_758[v789]:Disconnect()
                                end
                                v_u_758[v789] = v765.MouseButton1Click:Connect(v788)
                            end
                        end
                    end
                end
            end
        end
    end
    v_u_790()
    v_u_89.Teams.ButtonCT.MouseButton1Click:Connect(function()
        if v_u_27 ~= "Counter-Terrorists" then
            v_u_1.SelectTeam("CT")
            v_u_89.Teams.ButtonCT.Interactable = false
            v_u_89.Teams.ButtonT.Interactable = true
            v_u_30 = nil
            v_u_28 = nil
            v_u_89.Tabs.Container.WeaponSort.Category.Frame.TextLabel.Text = "All Categories"
            v_u_89.Tabs.Container.WeaponSort.Weapon.Frame.TextLabel.Text = "All Weapons"
            local v791 = v_u_89.Tabs.Container.Container
            for _, v792 in ipairs(v791:GetChildren()) do
                if v792:IsA("Frame") then
                    v792.Visible = true
                end
            end
            v_u_1.SortBySkinMetadata(v_u_29)
            local v793 = v_u_89.Tabs.Container.WeaponSort:FindFirstChild("Reset")
            if v793 then
                local v794 = v_u_89.Tabs.Container.WeaponSort.Weapon
                v793.Visible = v_u_28 ~= nil and true or v794.Frame.TextLabel.Text ~= "All Weapons"
            end
            task.defer(v_u_790)
        end
    end)
    v_u_89.Teams.ButtonT.MouseButton1Click:Connect(function()
        if v_u_27 ~= "Terrorists" then
            v_u_1.SelectTeam("T")
            v_u_89.Teams.ButtonT.Interactable = false
            v_u_89.Teams.ButtonCT.Interactable = true
            v_u_30 = nil
            v_u_757()
            task.defer(v_u_790)
        end
    end)
    v_u_89.Teams.ButtonCT.Interactable = false
    v_u_89.Teams.ButtonT.Interactable = true
end
return v_u_1