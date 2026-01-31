local v_u_1 = {}
local v_u_2 = game:GetService("ReplicatedStorage")
local v_u_3 = game:GetService("HttpService")
local v_u_4 = game:GetService("Players")
require(v_u_2.Database.Custom.Types)
require(script:WaitForChild("Types"))
local v_u_5 = require(v_u_2.Components.Common.GetWeaponProperties)
local v_u_6 = nil
local v7 = require(v_u_2.Packages.Signal)
local v_u_8 = v_u_2:WaitForChild("Assets")
local v_u_9 = v_u_8:WaitForChild("Weapons")
local v_u_10 = v_u_8:WaitForChild("Skins")
local v_u_11 = v7.new()
v_u_1.OnItemStockSchemasUpdated = v_u_11
local v_u_12 = {}
local function v_u_20(p13)
    if not v_u_6 then
        local v14, v15 = pcall(function()
            return require(v_u_2.Controllers.DataController)
        end)
        if v14 then
            v_u_6 = v15
        end
    end
    local v16 = v_u_6
    if not v16 then
        return nil
    end
    local v17 = v_u_4.LocalPlayer
    if not v17 then
        return nil
    end
    local v18 = v16.Get(v17, "Inventory")
    if not v18 or typeof(v18) ~= "table" then
        return nil
    end
    for _, v19 in ipairs(v18) do
        if v19._id == p13 and v19.Type == "Charm" then
            return {
                ["Skin"] = v19.Skin,
                ["Pattern"] = v19.Pattern
            }
        end
    end
    return nil
end
local function v_u_31(p21, p_u_22)
    local v23 = p21 or 0
    local v24 = typeof(v23) == "number"
    assert(v24, "KillCount must be a number")
    local v25, v26 = pcall(function(...)
        return v_u_5(p_u_22)
    end)
    if v25 and v26 then
        if v26.Class == "Melee" then
            local v27 = math.floor(v23)
            local v28 = math.clamp(v27, 0, 9999)
            return tostring(v28)
        else
            local v29 = math.floor(v23)
            local v30 = math.clamp(v29, 0, 999999)
            return string.format("%06d", v30)
        end
    else
        return nil
    end
end
local function v_u_38(p32, p33, p34)
    local v35 = v_u_10:FindFirstChild(p32)
    if v35 then
        if p34 and p32 == "Smoke Grenade" then
            local v36 = v35:FindFirstChild(p34)
            if v36 and v36:IsA("Folder") then
                return v36
            end
        end
        local v37 = v35:FindFirstChild(p33)
        if v37 and v37:IsA("Folder") then
            return v37
        else
            return nil
        end
    else
        return nil
    end
end
local function v_u_51(p39, p40)
    local v41 = p39.floatRange
    local v42 = p39.floatChances
    local v43 = v41.min
    local v44 = v41.max
    local v45 = math.clamp(p40, v43, v44)
    local v46 = v41.max - v41.min
    local v47 = v46 > 0 and (v45 - v41.min) / v46 or 0
    local v48 = 0
    for _, v49 in ipairs(v42) do
        v48 = v48 + v49.chance / 100
        if v47 <= v48 then
            return v49.wear
        end
    end
    local v50 = v42[#v42]
    if v50 then
        return v50.wear
    else
        return nil
    end
end
local function v_u_57(p52, p53)
    for _, v54 in ipairs(p53:GetChildren()) do
        if v54:IsA("SurfaceAppearance") then
            local v55 = p52:FindFirstChild(v54.Name, true)
            if v55 and v55:IsA("MeshPart") then
                local v56 = v55:FindFirstChildOfClass("SurfaceAppearance")
                if v56 then
                    v56:Destroy()
                end
                v54:Clone().Parent = v55
            end
        end
    end
end
local function v_u_70(p58, p59, p60, p_u_61)
    local v62, v63 = pcall(function(...)
        return v_u_5(p_u_61)
    end)
    local v64 = v62 and (v63 and v63.Class == "Melee") and "KillTrackKnife" or "KillTrak"
    local v65 = v_u_8.Other[v64]:Clone()
    local v66 = p59.PrimaryPart
    if v66 then
        local v67 = p58:FindFirstChild("KillTrack", true)
        if v67 then
            local v68 = v65.PrimaryPart
            local v69 = Instance.new("WeldConstraint")
            v69.Part0 = v68
            v69.Part1 = v66
            v69.Parent = v68
            v65:PivotTo(v67.WorldCFrame)
            v65.Screen.SurfaceGui.TextLabel.Text = v_u_31(p60, p_u_61)
            v65.Parent = p58
        else
            v65:Destroy()
        end
    else
        v65:Destroy()
        return
    end
end
local function v_u_77(p71, p72, p73)
    local v74 = p71:FindFirstChild("Weapon")
    if v74 then
        v_u_70(p71, v74, p72, p73)
    else
        local v75 = p71:FindFirstChild("WeaponL")
        local v76 = p71:FindFirstChild("WeaponR")
        if v75 then
            v_u_70(p71, v75, p72, p73)
        end
        if v76 then
            v_u_70(p71, v76, p72, p73)
        end
    end
end
local function v_u_86(p78, p79, p80)
    local v81 = v_u_8.Other.NamePlate:Clone()
    local v82 = p79.PrimaryPart
    if v82 then
        local v83 = v82:FindFirstChild("Nametag")
        if v83 then
            local v84 = v81.PrimaryPart
            local v85 = Instance.new("WeldConstraint")
            v85.Part0 = v84
            v85.Part1 = v82
            v85.Parent = v84
            v81:PivotTo(v83.WorldCFrame)
            v81.Screen.SurfaceGui.TextLabel.Text = tostring(p80)
            v81.Parent = p78
        else
            v81:Destroy()
        end
    else
        v81:Destroy()
        return
    end
end
local function v_u_92(p87, p88)
    local v89 = p87:FindFirstChild("Weapon")
    if v89 then
        v_u_86(p87, v89, p88)
    else
        local v90 = p87:FindFirstChild("WeaponL")
        local v91 = p87:FindFirstChild("WeaponR")
        if v90 then
            v_u_86(p87, v90, p88)
        end
        if v91 then
            v_u_86(p87, v91, p88)
        end
    end
end
local function v_u_106(p93, p94, p95, p_u_96)
    local v97, v98 = pcall(function(...)
        return v_u_5(p_u_96)
    end)
    local v99 = v97 and (v98 and v98.Class == "Melee") and "KillTrackKnife" or "KillTrak"
    local v100 = v_u_8.Other[v99]:Clone()
    local v101 = p94.PrimaryPart
    if v101 then
        local v102 = p94:FindFirstChild("KillTrack", true)
        if v102 then
            local v103 = v100.PrimaryPart
            local v104 = Instance.new("WeldConstraint")
            v104.Part0 = v103
            v104.Part1 = v101
            v104.Parent = v103
            v100:PivotTo(v102.WorldCFrame)
            local v105 = v100.Screen.SurfaceGui
            v105.SizingMode = Enum.SurfaceGuiSizingMode.FixedSize
            v105.CanvasSize = Vector2.new(100, 25)
            v105.TextLabel.Text = v_u_31(p95, p_u_96)
            v105.TextLabel.TextSize = 29
            v105.TextLabel.Size = UDim2.fromScale(1, 1)
            v100.Parent = p93
        else
            v100:Destroy()
        end
    else
        v100:Destroy()
        return
    end
end
local function v_u_113(p107, p108, p109)
    local v110 = p107:FindFirstChild("Weapon")
    if v110 then
        v_u_106(p107, v110, p108, p109)
    else
        local v111 = p107:FindFirstChild("WeaponL")
        local v112 = p107:FindFirstChild("WeaponR")
        if v111 then
            v_u_106(p107, v111, p108, p109)
        end
        if v112 then
            v_u_106(p107, v112, p108, p109)
        end
    end
end
local function v_u_123(p114, p115, p116)
    local v117 = v_u_8.Other.NamePlate:Clone()
    local v118 = p115.PrimaryPart
    if v118 then
        local v119 = v118:FindFirstChild("Nametag")
        if v119 then
            local v120 = v117.PrimaryPart
            local v121 = Instance.new("WeldConstraint")
            v121.Part0 = v120
            v121.Part1 = v118
            v121.Parent = v120
            v117:PivotTo(v119.WorldCFrame)
            local v122 = v117.Screen.SurfaceGui
            v122.SizingMode = Enum.SurfaceGuiSizingMode.FixedSize
            v122.CanvasSize = Vector2.new(100, 8)
            v122.TextLabel.Text = tostring(p116)
            v122.TextLabel.TextSize = 8.98
            v122.TextLabel.Size = UDim2.fromScale(0.95, 1)
            v122.TextLabel.Position = UDim2.fromOffset(5, 0)
            v117.Parent = p114
        else
            v117:Destroy()
        end
    else
        v117:Destroy()
        return
    end
end
local function v_u_129(p124, p125)
    local v126 = p124:FindFirstChild("Weapon")
    if v126 then
        v_u_123(p124, v126, p125)
    else
        local v127 = p124:FindFirstChild("WeaponL")
        local v128 = p124:FindFirstChild("WeaponR")
        if v127 then
            v_u_123(p124, v127, p125)
        end
        if v128 then
            v_u_123(p124, v128, p125)
        end
    end
end
local function v_u_146(p130, p131, p132, p133)
    local v134 = v_u_8:FindFirstChild("Charms")
    local v135
    if v134 then
        v135 = v134:FindFirstChild("CharmBase")
    else
        v135 = v134
    end
    if v135 and v135:IsA("Model") then
        local v136 = v134:FindFirstChild(p131)
        if v136 then
            v136 = v136:FindFirstChild((tostring(p132)))
        end
        if v136 and v136:IsA("Model") then
            local v137 = p130:FindFirstChild("Charm" .. p133, true)
            if v137 then
                local v138 = v137.Parent
                if v138 and v138:IsA("BasePart") then
                    local v139 = v135:Clone()
                    v139.Parent = p130
                    v139:PivotTo(v137.WorldCFrame * CFrame.Angles(0, 0, 0))
                    if v139.PrimaryPart then
                        local v140 = v139.PrimaryPart
                        local v141 = Instance.new("WeldConstraint")
                        v141.Part0 = v140
                        v141.Part1 = v138
                        v141.Parent = v140
                    end
                    local v142 = v136:Clone()
                    v142.Parent = v139
                    local v143 = v139:FindFirstChild("Part")
                    if v143 and v143:IsA("BasePart") then
                        v142:PivotTo(v143.CFrame)
                        v143:Destroy()
                    end
                    local v144 = v139:FindFirstChild("HingeConstraint", true)
                    local v145 = v144 and (v142.PrimaryPart and v142.PrimaryPart:FindFirstChild("Attachment"))
                    if v145 then
                        v144.Attachment1 = v145
                    end
                end
            else
                print("Charm attachment not found for weapon:", p130.Name, p133)
                return
            end
        else
            warn("Specific charm not found for weapon:", p130.Name, p131, p132)
            return
        end
    else
        warn("Charm base not found for weapon:", p130.Name)
        return
    end
end
local function v_u_155(p147, p148)
    if typeof(p148) == "table" then
        if p148._id and p148.Position then
            local v149 = p148.Position
            local v150, v151
            if p148.Skin and p148.Pattern then
                v150 = p148.Skin
                v151 = p148.Pattern
            else
                local v152 = v_u_20(p148._id)
                if not v152 then
                    return
                end
                v150 = v152.Skin
                v151 = v152.Pattern
            end
            if v150 and v151 then
                if p147:FindFirstChild("Weapon") then
                    v_u_146(p147, v150, v151, v149)
                else
                    local v153 = p147:FindFirstChild("WeaponL")
                    local v154 = p147:FindFirstChild("WeaponR")
                    if v153 then
                        v_u_146(p147, v150, v151, v149)
                    end
                    if v154 then
                        v_u_146(p147, v150, v151, v149)
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
local function v_u_172(p156, p157, p158, p159)
    local v160 = v_u_8:FindFirstChild("Charms")
    local v161
    if v160 then
        v161 = v160:FindFirstChild("CharmBase")
    else
        v161 = v160
    end
    if v161 and v161:IsA("Model") then
        local v162 = v160:FindFirstChild(p157)
        if v162 then
            v162 = v162:FindFirstChild((tostring(p158)))
        end
        if v162 and v162:IsA("Model") then
            local v163 = p156:FindFirstChild("Charm" .. p159, true)
            if v163 then
                local v164 = v163.Parent
                if v164 and v164:IsA("BasePart") then
                    local v165 = v161:Clone()
                    v165.Parent = p156
                    v165:PivotTo(v163.WorldCFrame * CFrame.Angles(0, 0, 0))
                    if v165.PrimaryPart then
                        local v166 = v165.PrimaryPart
                        local v167 = Instance.new("WeldConstraint")
                        v167.Part0 = v166
                        v167.Part1 = v164
                        v167.Parent = v166
                    end
                    local v168 = v162:Clone()
                    v168.Parent = v165
                    local v169 = v165:FindFirstChild("Part")
                    if v169 and v169:IsA("BasePart") then
                        v168:PivotTo(v169.CFrame)
                        v169:Destroy()
                    end
                    local v170 = v165:FindFirstChild("HingeConstraint", true)
                    local v171 = v170 and (v168.PrimaryPart and v168.PrimaryPart:FindFirstChild("Attachment"))
                    if v171 then
                        v170.Attachment1 = v171
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
local function v_u_181(p173, p174)
    if typeof(p174) == "table" then
        if p174._id and p174.Position then
            local v175 = p174.Position
            local v176, v177
            if p174.Skin and p174.Pattern then
                v176 = p174.Skin
                v177 = p174.Pattern
            else
                local v178 = v_u_20(p174._id)
                if not v178 then
                    return
                end
                v176 = v178.Skin
                v177 = v178.Pattern
            end
            if v176 and v177 then
                if p173:FindFirstChild("Weapon") then
                    v_u_172(p173, v176, v177, v175)
                else
                    local v179 = p173:FindFirstChild("WeaponL")
                    local v180 = p173:FindFirstChild("WeaponR")
                    if v179 then
                        v_u_172(p173, v176, v177, v175)
                    end
                    if v180 then
                        v_u_172(p173, v176, v177, v175)
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
function v_u_1.GetCharmModel(p182, p183)
    local v184 = v_u_8:FindFirstChild("Charms")
    local v185
    if v184 then
        v185 = v184:FindFirstChild("CharmBase")
    else
        v185 = v184
    end
    if not (v185 and v185:IsA("Model")) then
        warn((("Skins.GetCharmModel: Charm base not found for charm \"%*\" with pattern \"%*\""):format(p182, p183)))
        return nil
    end
    local v186 = v184:FindFirstChild(p182)
    if v186 then
        v186 = v186:FindFirstChild((tostring(p183)))
    end
    if not (v186 and v186:IsA("Model")) then
        warn((("Skins.GetCharmModel: Specific charm not found for charm \"%*\" with pattern \"%*\""):format(p182, p183)))
        return nil
    end
    local v187 = v185:Clone()
    v187.Name = p182
    local v188 = v186:Clone()
    v188.Parent = v187
    local v189 = v187:FindFirstChild("Part")
    if v189 and v189:IsA("BasePart") then
        v188:PivotTo(v189.CFrame)
        v189:Destroy()
    end
    local v190 = v187:FindFirstChild("HingeConstraint", true)
    local v191 = v190 and (v188.PrimaryPart and v188.PrimaryPart:FindFirstChild("Attachment"))
    if v191 then
        v190.Attachment1 = v191
    end
    return v187
end
function v_u_1.GetWearNameForFloat(p192, p193)
    return v_u_51(p192, p193)
end
function v_u_1.GetKillTrackValue(p194, p195)
    return v_u_31(p194, p195)
end
function v_u_1.GetMagazine(p196, p197, p198)
    local v199
    if typeof(p196) == "string" and (typeof(p197) == "string" and p196 ~= "") then
        v199 = p197 ~= ""
    else
        v199 = false
    end
    if not v199 then
        return nil
    end
    local v200 = v_u_1.GetSkinInformation(p196, p197)
    if not v200 and next(v_u_12) == nil then
        v_u_11:Wait()
        v200 = v_u_1.GetSkinInformation(p196, p197)
    end
    if not v200 then
        return nil
    end
    local v201 = v_u_9:FindFirstChild(p196)
    if not (v201 and v201:IsA("Folder")) then
        v201 = nil
    end
    if v201 then
        v201 = v201:FindFirstChild("Character")
    end
    if not (v201 and v201:IsA("Model")) then
        return nil
    end
    local v202 = {}
    for _, v203 in ipairs(v201:GetDescendants()) do
        if v203:IsA("BasePart") and v203:HasTag("CharacterMagazine") then
            table.insert(v202, v203)
        end
    end
    if #v202 == 0 then
        return nil
    end
    local v204 = Instance.new("Model")
    v204.Name = "Magazine"
    for _, v205 in ipairs(v202) do
        local v206 = v205:Clone()
        v206.Parent = v204
        if not v204.PrimaryPart then
            v204.PrimaryPart = v206
        end
    end
    local v207 = v_u_51(v200, p198 or v200.floatRange.min)
    if v207 then
        local v208 = v_u_10:FindFirstChild(p196)
        local v209
        if v208 then
            v209 = v208:FindFirstChild(p197)
            if not (v209 and v209:IsA("Folder")) then
                v209 = nil
            end
        else
            v209 = nil
        end
        if v209 then
            v209 = v209:FindFirstChild("Character")
        end
        if v209 then
            v209 = v209:FindFirstChild(v207)
        end
        if v209 and v209:IsA("Folder") then
            v_u_57(v204, v209)
        end
    end
    return v204
end
function v_u_1.GetGloves(p210, p211, p212)
    local v213
    if typeof(p210) == "string" and (typeof(p211) == "string" and p210 ~= "") then
        v213 = p211 ~= ""
    else
        v213 = false
    end
    if not v213 then
        return nil
    end
    local v214 = v_u_1.GetSkinInformation(p210, p211)
    if not v214 and next(v_u_12) == nil then
        v_u_11:Wait()
        v214 = v_u_1.GetSkinInformation(p210, p211)
    end
    if not v214 then
        return nil
    end
    local v215 = v_u_9:FindFirstChild(p210)
    if not (v215 and v215:IsA("Folder")) then
        v215 = nil
    end
    if not v215 then
        return nil
    end
    local v216 = Instance.new("Model")
    v216.Name = p210
    for _, v217 in ipairs(v215:GetChildren()) do
        if v217:IsA("BasePart") then
            v217:Clone().Parent = v216
        end
    end
    local v218 = v_u_51(v214, p212 or v214.floatRange.min)
    if v218 then
        local v219 = v_u_10:FindFirstChild(p210)
        local v220
        if v219 then
            v220 = v219:FindFirstChild(p211)
            if not (v220 and v220:IsA("Folder")) then
                v220 = nil
            end
        else
            v220 = nil
        end
        if v220 then
            v220 = v220:FindFirstChild("Camera")
        end
        if v220 then
            v220 = v220:FindFirstChild(v218)
        end
        if v220 and v220:IsA("Folder") then
            v_u_57(v216, v220)
        end
    end
    return v216
end
function v_u_1.GetCharacterModel(p221, p222, p223, p224, p225, p226, _, p227)
    local v228
    if typeof(p221) == "string" and (typeof(p222) == "string" and p221 ~= "") then
        v228 = p222 ~= ""
    else
        v228 = false
    end
    if not v228 then
        return nil
    end
    local v229 = v_u_1.GetSkinInformation(p221, p222)
    if not v229 and next(v_u_12) == nil then
        v_u_11:Wait()
        v229 = v_u_1.GetSkinInformation(p221, p222)
    end
    if not v229 then
        warn((("SkinHandler.GetCharacterModel: Skin \"%*\" not found for weapon \"%*\""):format(p222, p221)))
        return nil
    end
    local v230 = v_u_9:FindFirstChild(p221)
    if not (v230 and v230:IsA("Folder")) then
        v230 = nil
    end
    if v230 then
        v230 = v230:FindFirstChild("Character")
    end
    if not (v230 and v230:IsA("Model")) then
        warn((("SkinHandler.GetCharacterModel: Base character model not found for weapon \"%*\""):format(p221)))
        return nil
    end
    local v231 = v230:Clone()
    local v232 = v_u_51(v229, p223 or v229.floatRange.max)
    if v232 then
        local v233 = v_u_38(p221, p222, p227)
        if v233 then
            v233 = v233:FindFirstChild("Character")
        end
        if v233 then
            v233 = v233:FindFirstChild(v232)
        end
        if v233 and v233:IsA("Folder") then
            v_u_57(v231, v233)
        end
    end
    if p224 then
        v_u_77(v231, p224, p221)
    end
    if p225 then
        v_u_92(v231, p225)
    end
    if p226 then
        print(p226)
        v_u_155(v231, p226)
    end
    return v231
end
function v_u_1.GetWorldModel(p234, p235, p236, p237, p238, p239, _)
    local v240
    if typeof(p234) == "string" and (typeof(p235) == "string" and p234 ~= "") then
        v240 = p235 ~= ""
    else
        v240 = false
    end
    if not v240 then
        return nil
    end
    local v241 = v_u_1.GetSkinInformation(p234, p235)
    if not v241 and next(v_u_12) == nil then
        v_u_11:Wait()
        v241 = v_u_1.GetSkinInformation(p234, p235)
    end
    if not v241 then
        return nil
    end
    local v242 = v_u_9:FindFirstChild(p234)
    if not (v242 and v242:IsA("Folder")) then
        v242 = nil
    end
    if v242 then
        v242 = v242:FindFirstChild("Other")
    end
    if v242 then
        v242 = v242:FindFirstChild("World")
    end
    if not (v242 and v242:IsA("Model")) then
        return nil
    end
    local v243 = v242:Clone()
    local v244 = v_u_51(v241, p236 or v241.floatRange.max)
    if v244 then
        local v245 = v_u_10:FindFirstChild(p234)
        local v246
        if v245 then
            v246 = v245:FindFirstChild(p235)
            if not (v246 and v246:IsA("Folder")) then
                v246 = nil
            end
        else
            v246 = nil
        end
        if v246 then
            v246 = v246:FindFirstChild("Character")
        end
        if v246 then
            v246 = v246:FindFirstChild(v244)
        end
        if v246 and v246:IsA("Folder") then
            v_u_57(v243, v246)
        end
    end
    if p237 then
        v_u_77(v243, p237, p234)
    end
    if p238 then
        v_u_92(v243, p238)
    end
    if p239 then
        v_u_155(v243, p239)
    end
    return v243
end
function v_u_1.GetCameraModel(p247, p248, p249, p250, p251, p252, _, p253)
    local v254
    if typeof(p247) == "string" and (typeof(p248) == "string" and p247 ~= "") then
        v254 = p248 ~= ""
    else
        v254 = false
    end
    if not v254 then
        return nil
    end
    local v255 = v_u_1.GetSkinInformation(p247, p248)
    if not v255 and next(v_u_12) == nil then
        v_u_11:Wait()
        v255 = v_u_1.GetSkinInformation(p247, p248)
    end
    if not v255 then
        return nil
    end
    local v256 = v_u_9:FindFirstChild(p247)
    if not (v256 and v256:IsA("Folder")) then
        v256 = nil
    end
    if v256 then
        v256 = v256:FindFirstChild("Camera")
    end
    if not (v256 and v256:IsA("Model")) then
        return nil
    end
    local v257 = v256:Clone()
    local v258 = v_u_51(v255, p249 or v255.floatRange.max)
    if v258 then
        local v259 = v_u_38(p247, p248, p253)
        if v259 then
            v259 = v259:FindFirstChild("Camera")
        end
        if v259 then
            v259 = v259:FindFirstChild(v258)
        end
        if v259 and v259:IsA("Folder") then
            v_u_57(v257, v259)
        end
    end
    if p250 then
        v_u_113(v257, p250, p247)
    end
    if p251 then
        v_u_129(v257, p251)
    end
    if p252 then
        v_u_181(v257, p252)
    end
    return v257
end
function v_u_1.GetSkinInformation(p260, p261)
    local v262
    if typeof(p260) == "string" and (typeof(p261) == "string" and p260 ~= "") then
        v262 = p261 ~= ""
    else
        v262 = false
    end
    if v262 then
        local v263 = v_u_12[p260]
        if v263 then
            return v263[p261]
        else
            return nil
        end
    else
        return nil
    end
end
function v_u_1.GetAllSkinsForWeapon(p264)
    if typeof(p264) ~= "string" or p264 == "" then
        return nil
    end
    local v265 = v_u_12[p264]
    if not v265 then
        return nil
    end
    local v266 = {}
    for _, v267 in pairs(v265) do
        table.insert(v266, v267)
    end
    return v266
end
function v_u_1.GetWearImageForFloat(p268, p269)
    local v270 = v_u_51(p268, p269)
    if not v270 then
        return nil
    end
    for _, v271 in ipairs(p268.wearImages) do
        if v271.wear == v270 then
            return v271.assetId
        end
    end
    return nil
end
function v_u_1.GetBaseWeaponModel(p272, p273)
    if typeof(p272) == "string" and p272 ~= "" then
        local v274 = v_u_9:FindFirstChild(p272)
        if not (v274 and v274:IsA("Folder")) then
            v274 = nil
        end
        if v274 then
            local v275 = v274:FindFirstChild(p273)
            if v275 and v275:IsA("Model") then
                return v275:Clone()
            else
                return nil
            end
        else
            return nil
        end
    else
        return nil
    end
end
if v_u_2:GetAttribute("AvaiableSkins") then
    v_u_12 = v_u_3:JSONDecode((v_u_2:GetAttribute("AvaiableSkins")))
    if #v_u_11:GetConnections() > 0 then
        v_u_11:Fire(v_u_12)
    end
end
v_u_2:GetAttributeChangedSignal("AvaiableSkins"):Connect(function()
    local v276 = v_u_2:GetAttribute("AvaiableSkins")
    if v276 then
        v_u_12 = v_u_3:JSONDecode(v276)
        if #v_u_11:GetConnections() > 0 then
            v_u_11:Fire(v_u_12)
        end
    else
        return
    end
end)
return v_u_1