local v_u_1 = {}
v_u_1.__index = v_u_1
local v2 = game:GetService("ReplicatedStorage")
local v_u_3 = game:GetService("CollectionService")
local v_u_4 = game:GetService("TweenService")
local v_u_5 = game:GetService("HttpService")
local v_u_6 = game:GetService("RunService")
local v_u_7 = game:GetService("GuiService")
local v_u_8 = game:GetService("Workspace")
local v_u_9 = game:GetService("Players")
require(script:WaitForChild("Types"))
local v_u_10 = v_u_9.LocalPlayer
local v_u_11 = require(v2.Controllers.CharacterController)
local v_u_12 = require(v2.Controllers.SpectateController)
local v_u_13 = require(v2.Controllers.DataController)
local v_u_14 = require(v2.Database.Custom.GameStats.Settings.Colors)
local v_u_15 = require(v2.Components.Common.GetPreferenceColor)
local v16 = require(v2.Components.Common.GetUserPlatform)
local v_u_17 = require(v2.Database.Security.Remotes)
local v_u_18 = require(v2.Database.Security.Router)
local v_u_19 = require(v2.Shared.Janitor)
local v_u_20 = table.find(v16(), "Mobile")
if v_u_20 then
    v_u_20 = #v16() <= 1
end
local v_u_21 = v2.Assets.UI.Radar
local v_u_22 = workspace.CurrentCamera
local v_u_23 = v_u_20 and 120 or 200
local v_u_24 = v_u_8:WaitForChild("Debris")
local v_u_25 = {
    ["DeadTeammate"] = 13,
    ["LocalPlayer"] = 15,
    ["Teammate"] = 14,
    ["Enemy"] = 17,
    ["Bomb"] = 19,
    ["Site"] = 16,
    ["EnemyQuestionMark"] = 20,
    ["Hostage"] = 18
}
local v_u_26 = Color3.fromRGB(255, 0, 0)
local v_u_27 = nil
local v_u_28 = {
    ["CentersPlayer"] = true,
    ["Rotation"] = false,
    ["Zoom"] = 0.7,
    ["Scale"] = 1
}
local v_u_29 = nil
local function v_u_33()
    local v30 = workspace:FindFirstChild("Map")
    if not v30 then
        return nil
    end
    local v31 = v_u_3:GetTagged("Minimap")
    for _, v32 in ipairs(v31) do
        if v32:IsA("BasePart") and v32:IsDescendantOf(v30) then
            return {
                ["Part"] = v32,
                ["Lower"] = v32:FindFirstChild("Lower"),
                ["Upper"] = v32:FindFirstChild("Upper"),
                ["Size"] = v32.Size
            }
        end
    end
    return nil
end
local function v_u_37(p_u_34, p35, p36)
    if v_u_29 then
        v_u_29:Destroy()
        v_u_29 = nil
    end
    v_u_29 = v_u_1.new(v_u_27, p_u_34)
    if v_u_29 then
        v_u_29.LocalPlayer = p35
        v_u_29.Team = p35:GetAttribute("Team")
        v_u_29.IsSpectating = p36 or false
        if p36 then
            v_u_29.MapImage.Rotation = 90
            if v_u_29.UpperMapImage then
                v_u_29.UpperMapImage.Rotation = 90
            end
        end
    end
    if v_u_29 and p_u_34 then
        v_u_29.Janitor:Add(p_u_34:GetAttributeChangedSignal("Dead"):Connect(function()
            if v_u_29 and p_u_34:GetAttribute("Dead") then
                v_u_29:Destroy()
                v_u_29 = nil
            end
        end))
    end
end
local function v_u_44()
    local v38 = v_u_3:GetTagged("PlantArea")
    local v39 = {}
    for _, v40 in ipairs(v38) do
        if v40:IsA("BasePart") then
            local v41 = v40:GetAttribute("Site")
            if v41 and (v41 == "A" or v41 == "B") then
                if not v39[v41] then
                    v39[v41] = {}
                end
                local v42 = v39[v41]
                local v43 = v40.CFrame
                table.insert(v42, v43)
            end
        end
    end
    return v39
end
local function v_u_76(p45, p46, p47)
    local function v70(p48, p49, p50, p51, p52)
        local v53 = 0
        local v54 = p49.X
        local v55, v56
        if math.abs(v54) < 0.0001 then
            if p48.X < p50.X or p48.X > p51.X then
                return false
            end
            v55 = p52
            v56 = v53
        else
            local v57 = 1 / p49.X
            v55 = (p50.X - p48.X) * v57
            v56 = (p51.X - p48.X) * v57
            if v56 >= v55 then
                local v58 = v55
                v55 = v56
                v56 = v58
            end
            if v53 >= v56 then
                v56 = v53
            end
            if v55 >= p52 then
                v55 = p52
            end
            if v55 < v56 then
                return false
            end
        end
        local v59 = p49.Y
        if math.abs(v59) < 0.0001 then
            if p48.Y < p50.Y or p48.Y > p51.Y then
                return false
            end
        else
            local v60 = 1 / p49.Y
            local v61 = (p50.Y - p48.Y) * v60
            local v62 = (p51.Y - p48.Y) * v60
            if v62 >= v61 then
                local v63 = v61
                v61 = v62
                v62 = v63
            end
            if v56 >= v62 then
                v62 = v56
            end
            if v61 >= v55 then
                v61 = v55
            end
            if v61 < v62 then
                return false
            end
            v55 = v61
            v56 = v62
        end
        local v64 = p49.Z
        if math.abs(v64) < 0.0001 then
            if p48.Z < p50.Z or p48.Z > p51.Z then
                return false
            end
        else
            local v65 = 1 / p49.Z
            local v66 = (p50.Z - p48.Z) * v65
            local v67 = (p51.Z - p48.Z) * v65
            if v67 >= v66 then
                local v68 = v66
                v66 = v67
                v67 = v68
            end
            if v56 >= v67 then
                v67 = v56
            end
            if v66 >= v55 then
                v66 = v55
            end
            if v66 < v67 then
                return false
            end
            v56 = v67
        end
        local v69
        if v56 >= 0 then
            v69 = v56 <= p52
        else
            v69 = false
        end
        return v69
    end
    local v71 = v_u_24
    if v71 then
        for _, v72 in ipairs(v71:GetChildren()) do
            if v72.Name:match("^VoxelSmoke_") and v72:IsA("Folder") then
                for _, v73 in ipairs(v72:GetChildren()) do
                    if v73:IsA("BasePart") and v73.Name == "SmokeVoxel" then
                        local v74 = v73.Size
                        local v75 = v73.Position
                        if v70(p45, p46, v75 - v74 / 2, v75 + v74 / 2, p47) then
                            return true
                        end
                    end
                end
            end
        end
    end
    return false
end
local function v_u_92(p77, p78, p79)
    if not (p77 and p77.PrimaryPart) then
        return false
    end
    local v80 = p77.PrimaryPart.Position + Vector3.new(0, 1.5, 0)
    for _, v81 in ipairs(v_u_9:GetPlayers()) do
        if v81 ~= p78 and v81:GetAttribute("Team") == p79 then
            local v82 = v81.Character
            if v82 and v82.PrimaryPart then
                local v83 = v82.PrimaryPart
                local v84 = v83.Position + Vector3.new(0, 1.5, 0)
                local v85 = (v80 - v84).Magnitude
                if v85 <= 200 then
                    local v86 = (v80 - v84).Unit
                    if v86:Dot(v83.CFrame.LookVector) > 0.5 and not v_u_76(v84, v86, v85) then
                        local v87 = v_u_3:GetTagged("Hostage")
                        local v88 = { v82, p77 }
                        for _, v89 in ipairs(v87) do
                            if v89:IsA("Model") then
                                table.insert(v88, v89)
                            end
                        end
                        local v90 = RaycastParams.new()
                        v90.FilterType = Enum.RaycastFilterType.Exclude
                        v90.FilterDescendantsInstances = v88
                        local v91 = v_u_8:Raycast(v84, v86 * v85, v90)
                        if not v91 or v91.Instance:IsDescendantOf(p77) then
                            return true
                        end
                    end
                end
            end
        end
    end
    return false
end
local function v_u_113(p93, p94, _, p95)
    local v96 = p95 or v_u_10
    for _, v97 in ipairs(v_u_9:GetPlayers()) do
        if v97:GetAttribute("Team") == "Counter-Terrorists" then
            local v98 = v97.Character
            if v98 and v98.PrimaryPart then
                local v99, v100, v101
                if v97 == v96 then
                    if v_u_22 then
                        local v102 = v_u_22.CFrame
                        v99 = v102.Position
                        local v103 = v102.LookVector
                        local v104 = p93 - v99
                        v100 = v104.Magnitude
                        if v100 <= 200 and v100 > 0 then
                            v101 = v104.Unit
                            if v101:Dot(v103) > 0.5 then
                                ::l15::
                                local v105 = { v98 }
                                if p94 then
                                    table.insert(v105, p94)
                                end
                                local v106 = v_u_3:GetTagged("Hostage")
                                for _, v107 in ipairs(v106) do
                                    if v107:IsA("Model") then
                                        table.insert(v105, v107)
                                    end
                                end
                                if not v_u_76(v99, v101, v100) then
                                    local v108 = RaycastParams.new()
                                    v108.FilterType = Enum.RaycastFilterType.Exclude
                                    v108.FilterDescendantsInstances = v105
                                    local v109 = v_u_8:Raycast(v99, v101 * v100, v108)
                                    if not v109 then
                                        return true
                                    end
                                    if p94 and v109.Instance:IsDescendantOf(p94) then
                                        return true
                                    end
                                end
                            end
                        end
                    end
                else
                    local v110 = v98.PrimaryPart
                    v99 = v110.Position + Vector3.new(0, 1.5, 0)
                    local v111 = v110.CFrame.LookVector
                    local v112 = p93 - v99
                    v100 = v112.Magnitude
                    if v100 <= 200 and v100 > 0 then
                        v101 = v112.Unit
                        if v101:Dot(v111) > 0.5 then
                            goto l15
                        end
                    end
                end
            end
        end
    end
    return false
end
local function v_u_134(p114, p115, _, p116)
    local v117 = p116 or v_u_10
    for _, v118 in ipairs(v_u_9:GetPlayers()) do
        if v118:GetAttribute("Team") == "Terrorists" then
            local v119 = v118.Character
            if v119 and v119.PrimaryPart then
                local v120, v121, v122
                if v118 == v117 then
                    if v_u_22 then
                        local v123 = v_u_22.CFrame
                        v120 = v123.Position
                        local v124 = v123.LookVector
                        local v125 = p114 - v120
                        v121 = v125.Magnitude
                        if v121 <= 200 and v121 > 0 then
                            v122 = v125.Unit
                            if v122:Dot(v124) > 0.5 then
                                ::l15::
                                local v126 = v_u_3:GetTagged("Hostage")
                                local v127 = { v119 }
                                for _, v128 in ipairs(v126) do
                                    if v128:IsA("Model") then
                                        table.insert(v127, v128)
                                    end
                                end
                                if not v_u_76(v120, v122, v121) then
                                    local v129 = RaycastParams.new()
                                    v129.FilterType = Enum.RaycastFilterType.Exclude
                                    v129.FilterDescendantsInstances = v127
                                    local v130 = v_u_8:Raycast(v120, v122 * v121, v129)
                                    if not v130 then
                                        return true
                                    end
                                    if p115 and v130.Instance:IsDescendantOf(p115) then
                                        return true
                                    end
                                end
                            end
                        end
                    end
                else
                    local v131 = v119.PrimaryPart
                    v120 = v131.Position + Vector3.new(0, 1.5, 0)
                    local v132 = v131.CFrame.LookVector
                    local v133 = p114 - v120
                    v121 = v133.Magnitude
                    if v121 <= 200 and v121 > 0 then
                        v122 = v133.Unit
                        if v122:Dot(v132) > 0.5 then
                            goto l15
                        end
                    end
                end
            end
        end
    end
    return false
end
local function v_u_140(p135, p136, p137)
    local v138 = nil
    if p136 == "Teammate" then
        v138 = v_u_21.Player:Clone()
        v138.ZIndex = v_u_25.Teammate
    elseif p136 == "Enemy" then
        v138 = v_u_21.Enemy:Clone()
        v138.ZIndex = v_u_25.Enemy
    elseif p136 == "DeadTeammate" then
        v138 = v_u_21.Dead:Clone()
        v138.ZIndex = v_u_25.DeadTeammate
    end
    if not v138 then
        error((("Invalid icon type: %*"):format(p136)))
    end
    v138.Position = UDim2.fromScale(0.5, 0.5)
    v138.AnchorPoint = Vector2.new(0.5, 0.5)
    v138.Size = UDim2.fromOffset(p137, p137)
    v138.Parent = p135
    for _, v139 in ipairs(v138:GetChildren()) do
        if v139.Name == "Direction" and v139:IsA("ImageLabel") then
            v139.Visible = false
        end
    end
    return v138
end
local function v_u_152(p141, p142)
    local v143 = p141.X
    local v144 = p141.Z
    local v145 = Vector3.new(v143, 0, v144)
    local v146 = v145.Magnitude < 1e-6 and Vector3.new(0, 0, 1) or v145.Unit
    if p142 then
        v146 = p142.CFrame:VectorToObjectSpace(v146)
    end
    local v147 = v146.X
    local v148 = v146.Z
    local v149 = -v147
    local v150 = -v148
    local v151 = math.atan2(v150, v149)
    return (math.deg(v151) + 90) % 360
end
function v_u_1.WorldToRadar(p153, p154)
    if not p153.MinimapReference then
        return nil
    end
    if not (p153.Character and p153.Character.PrimaryPart) then
        return nil
    end
    local v155 = p153.MinimapReference
    local v156 = v155.Part
    local _ = p153.Character.PrimaryPart.Position
    local v157 = p153.ViewCenterLocal or Vector3.new(0, 0, 0)
    local _ = p153.Settings.CentersPlayer
    local v158 = v156.CFrame:PointToObjectSpace(p154)
    local v159 = v158.X - v157.X
    local v160 = v158.Z - v157.Z
    local v161 = -v159
    local v162 = -v160
    local v163 = p153.Settings.Zoom
    local v164 = v161 / v163
    local v165 = v162 / v163
    if p153.MapImage.Rotation ~= 0 then
        local v166 = -p153.MapImage.Rotation
        local v167 = math.rad(v166)
        local v168 = math.cos(v167)
        local v169 = math.sin(v167)
        v164 = v164 * v168 - v165 * v169
        v165 = v164 * v169 + v165 * v168
    end
    local v170 = v155.Size
    local v171 = v164 / v170.X + 0.5
    local v172 = v165 / v170.Z + 0.5
    return Vector2.new(v171, v172)
end
local function v_u_194(p173, p174, p175)
    local v176 = v_u_22.ViewportSize
    local v177 = v176.X
    local v178 = v176.Y
    local v179 = v_u_7:GetGuiInset().X
    local v180 = v179 + 50
    local v181 = p173.AnchorPoint or Vector2.new(0, 0)
    local v182
    if p175.X.Scale == 0 then
        v182 = p175.X.Offset
    else
        v182 = p175.X.Scale * v177 + p175.X.Offset
    end
    local v183
    if p175.Y.Scale == 0 then
        v183 = p175.Y.Offset
    else
        v183 = p175.Y.Scale * v178 + p175.Y.Offset
    end
    local v184, v185, v186, v187
    if v181.X == 0 and v181.Y == 0 then
        v184 = v182 + p174
        v185 = v183 + p174
        v186 = v183
        v187 = v182
    elseif v181.X == 0.5 and v181.Y == 0.5 then
        v187 = v182 - p174 / 2
        v186 = v183 - p174 / 2
        v184 = v182 + p174 / 2
        v185 = v183 + p174 / 2
    else
        v187 = v182 - v181.X * p174
        v186 = v183 - v181.Y * p174
        v184 = v187 + p174
        v185 = v186 + p174
    end
    local v188 = 0
    local v189 = v187 >= v179 + 10 and 0 or v179 + 10 - v187
    if v177 - 0 - 10 < v184 then
        v189 = v177 - 0 - 10 - v184
    end
    if v186 < v180 + 10 then
        v188 = v180 + 10 - v186
    end
    if v178 - 0 - 10 < v185 then
        v188 = v178 - 0 - 10 - v185
    end
    local v190 = v182 + v189
    local v191 = v183 + v188
    local v192
    if p175.X.Scale == 0 then
        v192 = UDim.new(0, v190)
    else
        v192 = UDim.new(0, v190)
    end
    local v193
    if p175.Y.Scale == 0 then
        v193 = UDim.new(0, v191)
    else
        v193 = UDim.new(0, v191)
    end
    return UDim2.new(v192, v193)
end
function v_u_1.UpdateIcon(p195, p196, p197, p198)
    local v199 = p195.Icons[p196]
    if v199 then
        local v200 = p195:WorldToRadar(p197)
        if v200 then
            local v201 = v200.X - 0.5
            local v202 = v200.Y - 0.5
            local v203 = v201 * v201 + v202 * v202
            local v204 = math.sqrt(v203)
            local v205 = v200.X
            local v206 = v200.Y
            if v204 > 0.5 then
                local v207 = v201 / v204
                local v208 = v202 / v204
                v205 = 0.5 + v207 * 0.5
                v206 = 0.5 + v208 * 0.5
            end
            v199.Instance.Visible = true
            v199.Instance.Position = UDim2.fromScale(v205, v206)
            if p198 then
                v199.Instance.Rotation = math.deg(p198)
            end
        else
            v199.Instance.Visible = false
        end
    else
        return
    end
end
function v_u_1.UpdateTeammateIcon(p209, p210, p211, p212)
    local v213 = p209.Icons[p210]
    if v213 then
        local v214 = v213.Instance
        if v214 and v214:IsA("GuiObject") then
            if p209.MinimapReference then
                local v215 = p209.MinimapReference
                local v216 = v215.Part
                local v217 = v215.Size
                local v218 = v216.CFrame:PointToObjectSpace(p211)
                local v219 = v218.X
                local v220 = v218.Z
                local v221 = -v219
                local v222 = -v220
                local v223 = v221 / v217.X + 0.5
                local v224 = v222 / v217.Z + 0.5
                local v225 = p209.MapImage.ImageRectOffset
                local v226 = p209.MapImage.ImageRectSize
                local v227 = v223 * 1024
                local v228 = v224 * 1024
                local v229 = v227 - v225.X
                local v230 = v228 - v225.Y
                local v231 = v229 / v226.X
                local v232 = v230 / v226.Y
                if p209.MapImage.Rotation ~= 0 then
                    local v233 = p209.MapImage.Rotation
                    local v234 = math.rad(v233)
                    local v235 = math.cos(v234)
                    local v236 = math.sin(v234)
                    local v237 = v231 - 0.5
                    local v238 = v232 - 0.5
                    v231 = 0.5 + (v237 * v235 - v238 * v236)
                    v232 = 0.5 + (v237 * v236 + v238 * v235)
                end
                local v239 = v231 - 0.5
                local v240 = v232 - 0.5
                local v241 = v239 * v239 + v240 * v240
                local v242 = math.sqrt(v241)
                if v242 > 0.5 then
                    local v243 = v239 / v242
                    local v244 = v240 / v242
                    v231 = 0.5 + v243 * 0.5
                    v232 = 0.5 + v244 * 0.5
                end
                v214.Position = UDim2.fromScale(v231, v232)
                v214.Visible = true
                if p212 and v214:IsA("ImageLabel") then
                    v214.Rotation = math.deg(p212)
                end
            else
                v214.Visible = false
            end
        else
            return
        end
    else
        return
    end
end
function v_u_1.CreatePlayerIcon(p245, p246, p247)
    local v248
    if p247 == "Enemy" then
        local v249 = p246:GetAttribute("Slot5")
        local v250 = v249 and v_u_5:JSONDecode(v249 or "[]")
        if v250 then
            v250 = v250.Weapon == "C4"
        end
        local v251 = p246:GetAttribute("IsCarryingHostage") == true
        if v250 then
            v248 = v_u_21.Bomb:Clone()
            v248.Size = UDim2.fromOffset(14, 14)
        elseif v251 then
            local v252 = v_u_21:FindFirstChild("Hostage")
            if v252 and v252:IsA("ImageLabel") then
                v248 = v252:Clone()
            else
                v248 = v_u_21.Player:Clone()
            end
            v248.Size = UDim2.fromOffset(30, 30)
        else
            v248 = v_u_21.Player:Clone()
            v248.Size = UDim2.fromOffset(12, 12)
        end
        v248.ImageColor3 = Color3.fromRGB(255, 0, 0)
        v248.ZIndex = v_u_25.Enemy
        v248.Position = UDim2.fromScale(0.5, 0.5)
        v248.AnchorPoint = Vector2.new(0.5, 0.5)
        v248.Parent = p245.RadarContainer
        for _, v253 in ipairs(v248:GetChildren()) do
            if v253.Name == "Direction" and v253:IsA("ImageLabel") then
                v253.Visible = false
            end
        end
    else
        v248 = v_u_140(p245.RadarContainer, p247, 12)
        local v254 = p246:GetAttribute("Team")
        local v255 = v254 and v_u_14["Team Color"][v254]
        if v255 then
            v248.ImageColor3 = v255
        end
        for _, v256 in ipairs(v248:GetChildren()) do
            if v256.Name == "Direction" and v256:IsA("ImageLabel") then
                v256.Visible = false
            end
        end
    end
    v248.Name = p246.Name
    local v257 = p246.UserId .. "_" .. p247
    p245.Icons[v257] = {
        ["Instance"] = v248,
        ["Player"] = p246,
        ["Target"] = nil,
        ["Type"] = p247
    }
    return v257
end
function v_u_1.RemoveIcon(p258, p259)
    local v260 = p258.Icons[p259]
    if v260 then
        v260.Instance:Destroy()
        p258.Icons[p259] = nil
    end
end
function v_u_1.RefreshPlayerIcon(p261, p262)
    local v263 = p262.UserId .. "_Player"
    local v264 = p262.UserId .. "_Dead"
    if p261.Icons[v263] then
        p261:RemoveIcon(v263)
    end
    if p261.Icons[v264] then
        p261:RemoveIcon(v264)
    end
    p261.EnemyVisibilityState[v263] = nil
    p261.EnemyLastSeenPositions[v263] = nil
    p261.EnemyLastSeenPositions[v263 .. "_Frozen"] = nil
    p261.DeadPlayerPositions[p262.UserId] = nil
    p261.FadedDeadIcons[v264] = nil
end
function v_u_1.RefreshIconsOnTeamChange(p265)
    local v266 = p265.Team
    local v267 = v_u_10:GetAttribute("Team")
    if v267 then
        p265.Team = v267
        if p265.Team ~= v266 then
            local v268 = {}
            for v269, v270 in pairs(p265.Icons) do
                if v270.Player and v270.Player ~= v_u_10 then
                    table.insert(v268, v269)
                end
            end
            for _, v271 in ipairs(v268) do
                p265:RemoveIcon(v271)
            end
            p265.EnemyVisibilityState = {}
            p265.EnemyLastSeenPositions = {}
            p265.DeadPlayerPositions = {}
            p265.FadedDeadIcons = {}
            if p265.Icons.LocalPlayer then
                local v272 = p265.Icons.LocalPlayer.Instance
                local v273 = p265.Team
                local v274 = v273 and v_u_14["Team Color"][v273]
                if v274 then
                    v272.ImageColor3 = v274
                end
            end
        end
    else
        return
    end
end
function v_u_1.UpdatePlayerIcons(p_u_275, _)
    local v276 = p_u_275.MinimapReference
    if v276 then
        v276 = p_u_275.MinimapReference.Part
    end
    if p_u_275.Character and p_u_275.Character.PrimaryPart then
        if not p_u_275.Icons.LocalPlayer then
            local v277 = v_u_21.Player:Clone()
            v277.Name = "LocalPlayer"
            v277.Position = UDim2.fromScale(0.5, 0.5)
            v277.AnchorPoint = Vector2.new(0.5, 0.5)
            v277.ZIndex = v_u_25.LocalPlayer
            v277.Parent = p_u_275.RadarContainer
            local v278 = p_u_275.Team
            local v279 = v278 and v_u_14["Team Color"][v278]
            if v279 then
                v277.ImageColor3 = v279
            end
            p_u_275.Icons.LocalPlayer = {
                ["Instance"] = v277,
                ["Player"] = p_u_275.LocalPlayer,
                ["Target"] = nil,
                ["Type"] = "Teammate"
            }
        end
        local v280 = p_u_275.Icons.LocalPlayer.Instance
        v280.Visible = true
        local v281 = p_u_275.LocalPlayer:GetAttribute("Slot5")
        local v282 = v281 and v_u_5:JSONDecode(v281 or "[]")
        if v282 then
            v282 = v282.Weapon == "C4"
        end
        local v283 = v280.ImageColor3
        if v282 then
            v280.Image = v_u_21.Bomb.Image
            v280.Size = UDim2.fromOffset(14, 14)
            v280.ImageColor3 = v283
        else
            v280.Image = v_u_21.Player.Image
            v280.Size = UDim2.fromOffset(12, 12)
            v280.ImageColor3 = v283
        end
        local v284 = not (v276 and (p_u_275.Character and p_u_275.Character.PrimaryPart)) and 0 or v_u_152(p_u_275.Character.PrimaryPart.CFrame.LookVector, v276) + p_u_275.MapImage.Rotation + 0
        local _ = p_u_275.Settings.CentersPlayer
        v280.Position = UDim2.fromScale(0.5, 0.5)
        v280.Rotation = v284
    end
    for _, v285 in ipairs(v_u_9:GetPlayers()) do
        if v285 ~= p_u_275.LocalPlayer then
            local v286 = v285.Character
            local v287
            if v286 then
                v287 = v286.PrimaryPart
            else
                v287 = v286
            end
            local v288 = v285:GetAttribute("Team")
            if v288 and v288 ~= "Spectators" then
                local v289 = p_u_275.DeadPlayerPositions[v285.UserId]
                local v290 = v289 ~= nil
                local v291
                if v286 then
                    v291 = v286:GetAttribute("Dead") == true
                else
                    v291 = false
                end
                local v292 = v288 == p_u_275.Team
                local v_u_293 = v285.UserId .. "_Player"
                if v291 or v290 then
                    if p_u_275.Icons[v_u_293] then
                        local v294 = p_u_275.Icons[v_u_293].Instance
                        if v294 and v294:IsA("GuiObject") then
                            v294.Visible = false
                        end
                        p_u_275:RemoveIcon(v_u_293)
                    end
                    if not v289 and v287 then
                        v289 = v287.Position
                        p_u_275.DeadPlayerPositions[v285.UserId] = v289
                    end
                    if v289 then
                        local v_u_295 = v285.UserId .. "_Dead"
                        if not (p_u_275.Icons[v_u_295] or p_u_275.FadedDeadIcons[v_u_295]) then
                            local v296 = v285:GetAttribute("Team")
                            local v297 = v_u_140(p_u_275.RadarContainer, "DeadTeammate", 12)
                            v297.Name = v285.Name .. "_Dead"
                            v297.ImageTransparency = 0
                            for _, v298 in ipairs(v297:GetChildren()) do
                                if v298.Name == "Direction" and v298:IsA("ImageLabel") then
                                    v298.Visible = false
                                end
                            end
                            if v292 then
                                local v299 = v_u_14["Team Color"][v296]
                                if v299 then
                                    v297.ImageColor3 = v299
                                end
                            else
                                v297.ImageColor3 = Color3.fromRGB(255, 0, 0)
                            end
                            local v300 = {
                                ["Instance"] = v297,
                                ["Player"] = v285,
                                ["Target"] = nil,
                                ["Type"] = "DeadTeammate",
                                ["DefaultSize"] = v_u_21.Dead.Size
                            }
                            p_u_275.Icons[v_u_295] = v300
                            if v289 and p_u_275.MinimapReference then
                                local v301 = p_u_275.MinimapReference
                                local v302 = v301.Part
                                local v303 = v301.Size
                                local v304 = v302.CFrame:PointToObjectSpace(v289)
                                local v305 = v304.X
                                local v306 = v304.Z
                                local v307 = -v305
                                local v308 = -v306
                                local v309 = v307 / v303.X + 0.5
                                local v310 = v308 / v303.Z + 0.5
                                local v311 = p_u_275.MapImage.ImageRectOffset
                                local v312 = p_u_275.MapImage.ImageRectSize
                                local v313 = v309 * 1024
                                local v314 = v310 * 1024
                                local v315 = v313 - v311.X
                                local v316 = v314 - v311.Y
                                local v317 = v315 / v312.X
                                local v318 = v316 / v312.Y
                                if p_u_275.MapImage.Rotation ~= 0 then
                                    local v319 = p_u_275.MapImage.Rotation
                                    local v320 = math.rad(v319)
                                    local v321 = math.cos(v320)
                                    local v322 = math.sin(v320)
                                    local v323 = v317 - 0.5
                                    local v324 = v318 - 0.5
                                    v317 = 0.5 + (v323 * v321 - v324 * v322)
                                    v318 = 0.5 + (v323 * v322 + v324 * v321)
                                end
                                local v325 = v317 - 0.5
                                local v326 = v318 - 0.5
                                local v327 = v325 * v325 + v326 * v326
                                local v328 = math.sqrt(v327)
                                if v328 > 0.5 then
                                    local v329 = v325 / v328
                                    local v330 = v326 / v328
                                    v317 = 0.5 + v329 * 0.5
                                    v318 = 0.5 + v330 * 0.5
                                end
                                v297.Position = UDim2.fromScale(v317, v318)
                                v297.Visible = true
                            end
                            task.delay(2, function()
                                local v331 = p_u_275.Icons[v_u_295]
                                if v331 and (v331.Instance and v331.Instance.Parent) then
                                    p_u_275.FadedDeadIcons[v_u_295] = true
                                    local v332 = v_u_4:Create(v331.Instance, TweenInfo.new(4, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
                                        ["ImageTransparency"] = 1
                                    })
                                    v332:Play()
                                    v332.Completed:Connect(function()
                                        if p_u_275.Icons[v_u_295] then
                                            p_u_275:RemoveIcon(v_u_295)
                                        end
                                    end)
                                end
                            end)
                        end
                    end
                    if not v292 then
                        p_u_275.EnemyVisibilityState[v_u_293] = nil
                        p_u_275.EnemyLastSeenPositions[v_u_293] = nil
                        p_u_275.EnemyLastSeenPositions[v_u_293 .. "_Frozen"] = nil
                    end
                else
                    if v286 and v287 then
                        local v333 = v285.UserId .. "_Dead"
                        if p_u_275.Icons[v333] then
                            p_u_275:RemoveIcon(v333)
                        end
                        p_u_275.DeadPlayerPositions[v285.UserId] = nil
                        p_u_275.FadedDeadIcons[v333] = nil
                        if not p_u_275.Icons[v_u_293] then
                            if v292 then
                                local v334 = p_u_275:CreatePlayerIcon(v285, "Teammate")
                                p_u_275.Icons[v_u_293] = p_u_275.Icons[v334]
                                p_u_275.Icons[v334] = nil
                            else
                                local v335 = p_u_275:CreatePlayerIcon(v285, "Enemy")
                                p_u_275.Icons[v_u_293] = p_u_275.Icons[v335]
                                p_u_275.Icons[v335] = nil
                                if p_u_275.Icons[v_u_293] then
                                    p_u_275.Icons[v_u_293].Instance.Visible = false
                                end
                            end
                        end
                    end
                    local v336
                    if v286 then
                        v336 = v286:GetAttribute("Dead") == true
                    else
                        v336 = false
                    end
                    if not (p_u_275.DeadPlayerPositions[v285.UserId] or v336) then
                        if v292 then
                            if p_u_275.Icons[v_u_293] and v287 then
                                p_u_275:UpdateTeammateIcon(v_u_293, v287.Position, nil)
                            elseif p_u_275.Icons[v_u_293] then
                                p_u_275:RemoveIcon(v_u_293)
                            end
                        elseif p_u_275.Icons[v_u_293] then
                            local v337
                            if v286 then
                                v337 = v286:GetAttribute("Dead") == true
                            else
                                v337 = false
                            end
                            local v338 = p_u_275.DeadPlayerPositions[v285.UserId]
                            if not v286 and true or (v338 and true or v337) then
                                if p_u_275.Icons[v_u_293] then
                                    p_u_275:RemoveIcon(v_u_293)
                                end
                                if not v338 then
                                    if v287 then
                                        v338 = v287.Position
                                        p_u_275.DeadPlayerPositions[v285.UserId] = v338
                                    elseif p_u_275.EnemyLastSeenPositions[v_u_293] then
                                        v338 = p_u_275.EnemyLastSeenPositions[v_u_293]
                                        p_u_275.DeadPlayerPositions[v285.UserId] = v338
                                    elseif p_u_275.EnemyLastSeenPositions[v_u_293 .. "_Frozen"] then
                                        v338 = p_u_275.EnemyLastSeenPositions[v_u_293 .. "_Frozen"]
                                        p_u_275.DeadPlayerPositions[v285.UserId] = v338
                                    end
                                end
                                if v338 then
                                    local v_u_339 = v285.UserId .. "_Dead"
                                    if not (p_u_275.Icons[v_u_339] or p_u_275.FadedDeadIcons[v_u_339]) then
                                        local v340 = v285:GetAttribute("Team")
                                        local v341 = v340 == p_u_275.Team
                                        local v342 = v_u_140(p_u_275.RadarContainer, "DeadTeammate", 12)
                                        v342.Name = v285.Name .. "_Dead"
                                        v342.ImageTransparency = 0
                                        for _, v343 in ipairs(v342:GetChildren()) do
                                            if v343.Name == "Direction" and v343:IsA("ImageLabel") then
                                                v343.Visible = false
                                            end
                                        end
                                        if v341 then
                                            local v344 = v_u_14["Team Color"][v340]
                                            if v344 then
                                                v342.ImageColor3 = v344
                                            end
                                        else
                                            v342.ImageColor3 = Color3.fromRGB(255, 0, 0)
                                        end
                                        local v345 = {
                                            ["Instance"] = v342,
                                            ["Player"] = v285,
                                            ["Target"] = nil,
                                            ["Type"] = "DeadTeammate",
                                            ["DefaultSize"] = v_u_21.Dead.Size
                                        }
                                        p_u_275.Icons[v_u_339] = v345
                                        task.delay(2, function()
                                            local v346 = p_u_275.Icons[v_u_339]
                                            if v346 and (v346.Instance and v346.Instance.Parent) then
                                                p_u_275.FadedDeadIcons[v_u_339] = true
                                                local v347 = v_u_4:Create(v346.Instance, TweenInfo.new(4, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
                                                    ["ImageTransparency"] = 1
                                                })
                                                v347:Play()
                                                v347.Completed:Connect(function()
                                                    if p_u_275.Icons[v_u_339] then
                                                        p_u_275:RemoveIcon(v_u_339)
                                                    end
                                                end)
                                            end
                                        end)
                                    end
                                end
                                p_u_275.EnemyVisibilityState[v_u_293] = nil
                                p_u_275.EnemyLastSeenPositions[v_u_293] = nil
                                p_u_275.EnemyLastSeenPositions[v_u_293 .. "_Frozen"] = nil
                            else
                                local v348 = v_u_92(v286, v285, p_u_275.Team)
                                local v349 = p_u_275.EnemyVisibilityState[v_u_293] or false
                                if v348 then
                                    if p_u_275.Icons[v_u_293] and p_u_275.Icons[v_u_293].Type == "EnemyQuestionMark" then
                                        local v350 = p_u_275.Icons[v_u_293].FadeTween
                                        if v350 then
                                            v350:Cancel()
                                            p_u_275.Icons[v_u_293].FadeTween = nil
                                        end
                                        local v351 = p_u_275.Icons[v_u_293].Instance
                                        if v351:IsA("TextLabel") then
                                            local v352 = v351.Position
                                            local v353 = v351.AnchorPoint
                                            v351:Destroy()
                                            local v354 = v285:GetAttribute("Slot5")
                                            local v355 = v354 and v_u_5:JSONDecode(v354 or "[]")
                                            if v355 then
                                                v355 = v355.Weapon == "C4"
                                            end
                                            local v356 = v285:GetAttribute("IsCarryingHostage") == true
                                            local v357 = Instance.new("ImageLabel")
                                            v357.Name = v285.Name .. "_Enemy"
                                            if v355 then
                                                v357.Image = v_u_21.Bomb.Image
                                                v357.Size = UDim2.fromOffset(14, 14)
                                            elseif v356 then
                                                local v358 = v_u_21:FindFirstChild("Hostage")
                                                if v358 and v358:IsA("ImageLabel") then
                                                    v357.Image = v358.Image
                                                else
                                                    v357.Image = v_u_21.Player.Image
                                                end
                                                v357.Size = UDim2.fromOffset(30, 30)
                                            else
                                                v357.Image = v_u_21.Player.Image
                                                v357.Size = UDim2.fromOffset(12, 12)
                                            end
                                            v357.ImageColor3 = Color3.fromRGB(255, 0, 0)
                                            v357.BackgroundTransparency = 1
                                            v357.BorderSizePixel = 0
                                            v357.Position = v352
                                            v357.AnchorPoint = v353
                                            v357.ZIndex = v_u_25.Enemy
                                            v357.Visible = true
                                            v357.Parent = p_u_275.RadarContainer
                                            p_u_275.Icons[v_u_293].Instance = v357
                                            p_u_275.Icons[v_u_293].Type = "Enemy"
                                            p_u_275.Icons[v_u_293].FadeTween = nil
                                            p_u_275.EnemyLastSeenPositions[v_u_293 .. "_Frozen"] = nil
                                        end
                                    end
                                    if p_u_275.Icons[v_u_293] and v287 then
                                        local v359 = p_u_275.Icons[v_u_293].Instance
                                        v359.Visible = true
                                        local v360 = v285:GetAttribute("Slot5")
                                        local v361 = v360 and v_u_5:JSONDecode(v360 or "[]")
                                        if v361 then
                                            v361 = v361.Weapon == "C4"
                                        end
                                        local v362 = v285:GetAttribute("IsCarryingHostage") == true
                                        v359.ImageColor3 = Color3.fromRGB(255, 0, 0)
                                        if v361 then
                                            v359.Image = v_u_21.Bomb.Image
                                            v359.Size = UDim2.fromOffset(14, 14)
                                        elseif v362 then
                                            local v363 = v_u_21:FindFirstChild("Hostage")
                                            if v363 and v363:IsA("ImageLabel") then
                                                v359.Image = v363.Image
                                            else
                                                v359.Image = v_u_21.Player.Image
                                            end
                                            v359.Size = UDim2.fromOffset(30, 30)
                                        else
                                            v359.Image = v_u_21.Player.Image
                                            v359.Size = UDim2.fromOffset(12, 12)
                                        end
                                        p_u_275:UpdateTeammateIcon(v_u_293, v287.Position, nil)
                                        p_u_275.EnemyLastSeenPositions[v_u_293] = v287.Position
                                    elseif p_u_275.Icons[v_u_293] then
                                        p_u_275:RemoveIcon(v_u_293)
                                    end
                                else
                                    local v364
                                    if v286 then
                                        v364 = v286:GetAttribute("Dead") == true
                                    else
                                        v364 = false
                                    end
                                    if not v286 and true or (p_u_275.DeadPlayerPositions[v285.UserId] and true or v364) then
                                        if p_u_275.Icons[v_u_293] then
                                            p_u_275:RemoveIcon(v_u_293)
                                        end
                                        p_u_275.EnemyVisibilityState[v_u_293] = nil
                                        p_u_275.EnemyLastSeenPositions[v_u_293] = nil
                                        p_u_275.EnemyLastSeenPositions[v_u_293 .. "_Frozen"] = nil
                                    elseif v349 and p_u_275.Icons[v_u_293] then
                                        local v365 = p_u_275.Icons[v_u_293].Instance
                                        local v366 = nil
                                        local v367 = nil
                                        local v368 = p_u_275.Icons[v_u_293].FadeTween
                                        if v368 then
                                            v368:Cancel()
                                            p_u_275.Icons[v_u_293].FadeTween = nil
                                        end
                                        if v365:IsA("ImageLabel") then
                                            v366 = v365.Position
                                            v367 = v365.AnchorPoint
                                            v365:Destroy()
                                        elseif v365:IsA("TextLabel") then
                                            v366 = v365.Position
                                            v367 = v365.AnchorPoint
                                            v365:Destroy()
                                        end
                                        local v369 = v_u_21.EnemySeen:Clone()
                                        v369.Name = v285.Name .. "_QuestionMark"
                                        v369.Position = v366
                                        v369.AnchorPoint = v367
                                        v369.ZIndex = v_u_25.EnemyQuestionMark
                                        v369.TextTransparency = 0
                                        v369.Visible = true
                                        v369.Parent = p_u_275.RadarContainer
                                        p_u_275.Icons[v_u_293].Instance = v369
                                        p_u_275.Icons[v_u_293].Type = "EnemyQuestionMark"
                                        p_u_275.Icons[v_u_293].FadeTween = nil
                                        if p_u_275.EnemyLastSeenPositions[v_u_293] then
                                            p_u_275.EnemyLastSeenPositions[v_u_293 .. "_Frozen"] = p_u_275.EnemyLastSeenPositions[v_u_293]
                                        end
                                        task.delay(0.1, function()
                                            if p_u_275.Icons[v_u_293] and p_u_275.Icons[v_u_293].Instance:IsA("TextLabel") then
                                                local v370 = p_u_275.Icons[v_u_293].Instance
                                                v370.TextTransparency = 0
                                                local v371 = v_u_4:Create(v370, TweenInfo.new(5, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
                                                    ["TextTransparency"] = 1
                                                })
                                                v371:Play()
                                                p_u_275.Icons[v_u_293].FadeTween = v371
                                                v371.Completed:Connect(function()
                                                    if p_u_275.Icons[v_u_293] then
                                                        p_u_275:RemoveIcon(v_u_293)
                                                        p_u_275.EnemyLastSeenPositions[v_u_293 .. "_Frozen"] = nil
                                                    end
                                                end)
                                            end
                                        end)
                                    end
                                    if p_u_275.Icons[v_u_293] and p_u_275.Icons[v_u_293].Type == "EnemyQuestionMark" then
                                        local v372 = p_u_275.EnemyLastSeenPositions[v_u_293 .. "_Frozen"]
                                        if v372 then
                                            p_u_275:UpdateQuestionMarkIcon(v_u_293, v372)
                                        end
                                    elseif p_u_275.Icons[v_u_293] then
                                        p_u_275.Icons[v_u_293].Instance.Visible = false
                                    end
                                end
                                if p_u_275.Icons[v_u_293] then
                                    p_u_275.EnemyVisibilityState[v_u_293] = v348
                                end
                            end
                        end
                    end
                end
            else
                local v373 = v285.UserId .. "_Player"
                local v374 = v285.UserId .. "_Dead"
                if p_u_275.Icons[v373] then
                    p_u_275:RemoveIcon(v373)
                end
                if p_u_275.Icons[v374] then
                    p_u_275:RemoveIcon(v374)
                end
                p_u_275.EnemyVisibilityState[v373] = nil
                p_u_275.EnemyLastSeenPositions[v373] = nil
                p_u_275.EnemyLastSeenPositions[v373 .. "_Frozen"] = nil
                p_u_275.DeadPlayerPositions[v285.UserId] = nil
                p_u_275.FadedDeadIcons[v374] = nil
            end
        end
    end
    for v375, v376 in pairs(p_u_275.DeadPlayerPositions) do
        local v377 = v375 .. "_Dead"
        local v378 = p_u_275.Icons[v377]
        if v378 and p_u_275.MinimapReference then
            local v379 = p_u_275.MinimapReference
            local v380 = v379.Part
            local v381 = v379.Size
            local v382 = v380.CFrame:PointToObjectSpace(v376)
            local v383 = v382.X
            local v384 = v382.Z
            local v385 = -v383
            local v386 = -v384
            local v387 = v385 / v381.X + 0.5
            local v388 = v386 / v381.Z + 0.5
            local v389 = p_u_275.MapImage.ImageRectOffset
            local v390 = p_u_275.MapImage.ImageRectSize
            local v391 = v387 * 1024
            local v392 = v388 * 1024
            local v393 = v391 - v389.X
            local v394 = v392 - v389.Y
            local v395 = v393 / v390.X
            local v396 = v394 / v390.Y
            if p_u_275.MapImage.Rotation ~= 0 then
                local v397 = p_u_275.MapImage.Rotation
                local v398 = math.rad(v397)
                local v399 = math.cos(v398)
                local v400 = math.sin(v398)
                local v401 = v395 - 0.5
                local v402 = v396 - 0.5
                v395 = 0.5 + (v401 * v399 - v402 * v400)
                v396 = 0.5 + (v401 * v400 + v402 * v399)
            end
            local v403 = v395 - 0.5
            local v404 = v396 - 0.5
            local v405 = v403 * v403 + v404 * v404
            local v406 = math.sqrt(v405)
            if v406 > 0.5 then
                local v407 = v403 / v406
                local v408 = v404 / v406
                v395 = 0.5 + v407 * 0.5
                v396 = 0.5 + v408 * 0.5
            end
            v378.Instance.Position = UDim2.fromScale(v395, v396)
            v378.Instance.Visible = true
        end
    end
end
function v_u_1.UpdateBombIcon(p409)
    local v410 = nil
    local v411 = p409.Team == "Counter-Terrorists"
    local v412 = v_u_3:GetTagged("Bomb")[1]
    if v412 and (v412:IsA("Model") and v412.PrimaryPart) then
        v410 = v412
    else
        local v413 = v_u_3:GetTagged("WeaponDropped")
        for _, v414 in ipairs(v413) do
            if v414:IsA("Model") and (v414.PrimaryPart and v414:GetAttribute("Weapon") == "C4") then
                v410 = v414
                break
            end
        end
    end
    if v410 then
        if not p409.Icons.Bomb then
            local v415 = v_u_21.Bomb:Clone()
            v415.Position = UDim2.fromScale(0.5, 0.5)
            v415.AnchorPoint = Vector2.new(0.5, 0.5)
            v415.Parent = p409.RadarContainer
            v415.Size = UDim2.fromOffset(14, 14)
            v415.ZIndex = v_u_25.Bomb
            v415.Name = "Bomb"
            p409.Icons.Bomb = {
                ["Instance"] = v415,
                ["Player"] = nil,
                ["Target"] = v410.PrimaryPart,
                ["Type"] = "Bomb"
            }
        end
        local v416 = p409.Icons.Bomb
        if not p409.MinimapReference then
            v416.Instance.Visible = false
            return
        end
        local v417 = v410.PrimaryPart.Position
        local v418 = p409.MinimapReference
        local v419 = v418.Part
        local v420 = v418.Size
        local v421 = v419.CFrame:PointToObjectSpace(v417)
        local v422 = v421.X
        local v423 = v421.Z
        local v424 = -v422
        local v425 = -v423
        local v426 = v424 / v420.X + 0.5
        local v427 = v425 / v420.Z + 0.5
        local v428 = p409.MapImage.ImageRectOffset
        local v429 = p409.MapImage.ImageRectSize
        local v430 = v426 * 1024
        local v431 = v427 * 1024
        local v432 = v430 - v428.X
        local v433 = v431 - v428.Y
        local v434 = v432 / v429.X
        local v435 = v433 / v429.Y
        if p409.MapImage.Rotation ~= 0 then
            local v436 = p409.MapImage.Rotation
            local v437 = math.rad(v436)
            local v438 = math.cos(v437)
            local v439 = math.sin(v437)
            local v440 = v434 - 0.5
            local v441 = v435 - 0.5
            v434 = 0.5 + (v440 * v438 - v441 * v439)
            v435 = 0.5 + (v440 * v439 + v441 * v438)
        end
        local v442 = v434 - 0.5
        local v443 = v435 - 0.5
        local v444 = v442 * v442 + v443 * v443
        local v445 = math.sqrt(v444)
        if v445 > 0.5 then
            local v446 = v442 / v445
            local v447 = v443 / v445
            v434 = 0.5 + v446 * 0.5
            v435 = 0.5 + v447 * 0.5
        end
        v416.Instance.Position = UDim2.fromScale(v434, v435)
        if v411 and not v412 then
            local v448 = v_u_113(v417, v410, p409.Character, p409.LocalPlayer)
            local v449 = tick()
            if v448 then
                if not p409.BombIsVisible then
                    p409.BombFadeStartTime = nil
                end
                p409.BombIsVisible = true
                v416.Instance.Visible = true
                if v416.Instance:IsA("ImageLabel") then
                    local v450 = v416.Instance
                    v450.ImageTransparency = 0
                    v450.ImageColor3 = v_u_26
                    return
                end
                if v416.Instance:IsA("ImageButton") then
                    local v451 = v416.Instance
                    v451.ImageTransparency = 0
                    v451.ImageColor3 = v_u_26
                    return
                end
                if v416.Instance:IsA("TextLabel") then
                    v416.Instance.TextTransparency = 0
                    return
                end
                if v416.Instance:IsA("TextButton") then
                    v416.Instance.TextTransparency = 0
                    return
                end
            else
                if p409.BombIsVisible then
                    p409.BombFadeStartTime = v449
                end
                p409.BombIsVisible = false
                if not p409.BombFadeStartTime then
                    v416.Instance.Visible = false
                    return
                end
                local v452 = (v449 - p409.BombFadeStartTime) / 8
                local v453 = math.clamp(v452, 0, 1)
                if v453 >= 1 then
                    v416.Instance.Visible = false
                    return
                end
                v416.Instance.Visible = true
                if v416.Instance:IsA("ImageLabel") then
                    v416.Instance.ImageTransparency = v453
                    return
                end
                if v416.Instance:IsA("ImageButton") then
                    v416.Instance.ImageTransparency = v453
                    return
                end
                if v416.Instance:IsA("TextLabel") then
                    v416.Instance.TextTransparency = v453
                    return
                end
                if v416.Instance:IsA("TextButton") then
                    v416.Instance.TextTransparency = v453
                    return
                end
            end
        else
            v416.Instance.Visible = true
            if v416.Instance:IsA("ImageLabel") then
                local v454 = v416.Instance
                v454.ImageTransparency = 0
                if v412 and (v411 and v445 > 0.5) then
                    v454.ImageColor3 = v_u_26
                    return
                end
            elseif v416.Instance:IsA("ImageButton") then
                local v455 = v416.Instance
                v455.ImageTransparency = 0
                if v412 and (v411 and v445 > 0.5) then
                    v455.ImageColor3 = v_u_26
                    return
                end
            else
                if v416.Instance:IsA("TextLabel") then
                    v416.Instance.TextTransparency = 0
                    return
                end
                if v416.Instance:IsA("TextButton") then
                    v416.Instance.TextTransparency = 0
                    return
                end
            end
        end
    elseif p409.Icons.Bomb then
        p409.Icons.Bomb.Instance.Visible = false
        p409.BombIsVisible = false
        p409.BombFadeStartTime = nil
    end
end
function v_u_1.UpdateQuestionMarkIcon(p456, p457, p458)
    local v459 = p456.Icons[p457]
    if v459 and p456.MinimapReference then
        local v460 = v459.Instance
        if v460 and v460:IsA("TextLabel") then
            local v461 = p456.MinimapReference
            local v462 = v461.Part
            local v463 = v461.Size
            local v464 = v462.CFrame:PointToObjectSpace(p458)
            local v465 = v464.X
            local v466 = v464.Z
            local v467 = -v465
            local v468 = -v466
            local v469 = v467 / v463.X + 0.5
            local v470 = v468 / v463.Z + 0.5
            local v471 = p456.MapImage.ImageRectOffset
            local v472 = p456.MapImage.ImageRectSize
            local v473 = v469 * 1024
            local v474 = v470 * 1024
            local v475 = v473 - v471.X
            local v476 = v474 - v471.Y
            local v477 = v475 / v472.X
            local v478 = v476 / v472.Y
            if p456.MapImage.Rotation ~= 0 then
                local v479 = p456.MapImage.Rotation
                local v480 = math.rad(v479)
                local v481 = math.cos(v480)
                local v482 = math.sin(v480)
                local v483 = v477 - 0.5
                local v484 = v478 - 0.5
                v477 = 0.5 + (v483 * v481 - v484 * v482)
                v478 = 0.5 + (v483 * v482 + v484 * v481)
            end
            local v485 = v477 - 0.5
            local v486 = v478 - 0.5
            local v487 = v485 * v485 + v486 * v486
            local v488 = math.sqrt(v487)
            if v488 > 0.5 then
                local v489 = v485 / v488
                local v490 = v486 / v488
                v477 = 0.5 + v489 * 0.5
                v478 = 0.5 + v490 * 0.5
            end
            v460.Position = UDim2.fromScale(v477, v478)
            v460.Visible = true
        end
    else
        return
    end
end
function v_u_1.UpdateSiteIcons(p491)
    for v492, v493 in pairs(p491.SiteParts) do
        local v494 = "Site_" .. v492
        local v495
        if #v493 == 0 then
            v495 = Vector3.new(0, 0, 0)
        else
            local v496 = Vector3.new(0, 0, 0)
            for _, v497 in ipairs(v493) do
                v496 = v496 + v497.Position
            end
            v495 = v496 / #v493
        end
        if p491.Icons[v494] then
            ::l10::
            local v498 = p491.Icons[v494]
            if p491.MinimapReference then
                local v499 = p491.MinimapReference
                local v500 = v499.Part
                local v501 = v499.Size
                local v502 = v500.CFrame:PointToObjectSpace(v495)
                local v503 = v502.X
                local v504 = v502.Z
                local v505 = -v503
                local v506 = -v504
                local v507 = v505 / v501.X + 0.5
                local v508 = v506 / v501.Z + 0.5
                local v509 = p491.MapImage.ImageRectOffset
                local v510 = p491.MapImage.ImageRectSize
                local v511 = p491.Settings.Zoom or 0.5
                local v512 = 0.5 / math.clamp(v511, 0.1, 1)
                local v513 = workspace:GetAttribute("Map")
                if v513 == "Mirage" and true or v513 == "Winter Mirage" then
                    if v492 == "A" then
                        local v514 = v512 * -0.02 * v510.X / 1024
                        local v515 = v512 * 0.04 * v510.Y / 1024
                        v507 = v507 + v514
                        v508 = v508 + v515
                    elseif v492 == "B" then
                        local v516 = v512 * -0.015 * v510.X / 1024
                        local v517 = v512 * -0.005 * v510.Y / 1024
                        v507 = v507 + v516
                        v508 = v508 + v517
                    end
                elseif v513 == "Vertigo" and true or v513 == "Winter Vertigo" then
                    if v492 == "A" then
                        local v518 = v512 * 0.0425 * v510.X / 1024
                        local v519 = v512 * 0.005 * v510.Y / 1024
                        v507 = v507 + v518
                        v508 = v508 + v519
                    elseif v492 == "B" then
                        local v520 = v512 * -0.01 * v510.X / 1024
                        local v521 = v512 * -0.01 * v510.Y / 1024
                        v507 = v507 + v520
                        v508 = v508 + v521
                    end
                elseif v513 == "Seaside" then
                    if v492 == "A" then
                        local v522 = v512 * -0.01 * v510.X / 1024
                        local v523 = v512 * -0.01 * v510.Y / 1024
                        v507 = v507 + v522
                        v508 = v508 + v523
                    elseif v492 == "B" then
                        local v524 = v512 * 0 * v510.X / 1024
                        local v525 = v512 * 0.02 * v510.Y / 1024
                        v507 = v507 + v524
                        v508 = v508 + v525
                    end
                end
                local v526 = v507 * 1024
                local v527 = v508 * 1024
                local v528 = v526 - v509.X
                local v529 = v527 - v509.Y
                local v530 = v528 / v510.X
                local v531 = v529 / v510.Y
                if p491.MapImage.Rotation ~= 0 then
                    local v532 = p491.MapImage.Rotation
                    local v533 = math.rad(v532)
                    local v534 = math.cos(v533)
                    local v535 = math.sin(v533)
                    local v536 = v530 - 0.5
                    local v537 = v531 - 0.5
                    v530 = 0.5 + (v536 * v534 - v537 * v535)
                    v531 = 0.5 + (v536 * v535 + v537 * v534)
                end
                local v538 = v530 - 0.5
                local v539 = v531 - 0.5
                local v540 = v538 * v538 + v539 * v539
                local v541 = math.sqrt(v540)
                if v541 > 0.5 then
                    local v542 = v538 / v541
                    local v543 = v539 / v541
                    v530 = 0.5 + v542 * 0.485
                    v531 = 0.5 + v543 * 0.485
                end
                v498.Instance.Position = UDim2.fromScale(v530, v531)
                v498.Instance.Visible = true
                local v544 = v541 > 0.5
                local v545 = v498.DefaultSize
                if v545 then
                    if v544 then
                        v498.Instance.Size = v545
                    else
                        v498.Instance.Size = UDim2.new(v545.X.Scale * v512, v545.X.Offset * v512, v545.Y.Scale * v512, v545.Y.Offset * v512)
                    end
                end
            else
                v498.Instance.Visible = false
            end
        else
            local v546 = v_u_21:FindFirstChild(v492)
            if v546 then
                local v547 = v546:Clone()
                v547.Name = v492 .. "_Icon"
                v547.Position = UDim2.fromScale(0.5, 0.5)
                v547.AnchorPoint = Vector2.new(0.5, 0.5)
                v547.ZIndex = v_u_25.Site
                v547.Visible = true
                if v547:IsA("TextLabel") then
                    v547.TextXAlignment = Enum.TextXAlignment.Center
                    v547.TextYAlignment = Enum.TextYAlignment.Center
                end
                v547.Parent = p491.RadarContainer
                local v548 = {
                    ["Instance"] = v547,
                    ["Player"] = nil,
                    ["Target"] = nil,
                    ["Type"] = "Site",
                    ["DefaultSize"] = v546.Size
                }
                p491.Icons[v494] = v548
                goto l10
            end
            warn((("Site icon template not found for: %*"):format(v492)))
        end
    end
end
function v_u_1.UpdateHostageIcons(p549)
    local v550 = v_u_3:GetTagged("Hostage")
    local v551 = {}
    for _, v552 in ipairs(v550) do
        if v552:IsA("Model") and v552.PrimaryPart then
            local v553 = v552.Name
            local v554 = "Hostage_" .. v553
            v551[v554] = true
            if not p549.Icons[v554] then
                local v555 = v_u_21:FindFirstChild("Hostage")
                if not (v555 and v555:IsA("ImageLabel")) then
                    v555 = v_u_21.Player
                end
                local v556 = v555:Clone()
                v556.Position = UDim2.fromScale(0.5, 0.5)
                v556.AnchorPoint = Vector2.new(0.5, 0.5)
                v556.Parent = p549.RadarContainer
                v556.Size = UDim2.fromOffset(30, 30)
                v556.ZIndex = v_u_25.Hostage
                v556.Name = "Hostage_" .. v553
                v556.Visible = true
                for _, v557 in ipairs(v556:GetChildren()) do
                    if v557.Name == "Direction" and v557:IsA("ImageLabel") then
                        v557.Visible = false
                    end
                end
                p549.Icons[v554] = {
                    ["Instance"] = v556,
                    ["Player"] = nil,
                    ["Target"] = v552.PrimaryPart,
                    ["Type"] = "Hostage"
                }
            end
            local v558 = p549.Icons[v554]
            if p549.MinimapReference then
                local v559 = v552:GetAttribute("CarryingPlayer")
                local v560
                if v559 then
                    local v561 = v_u_9:FindFirstChild(v559)
                    if v561 and (v561.Character and v561.Character.PrimaryPart) then
                        v560 = v561.Character.PrimaryPart.Position
                    else
                        v560 = v552.PrimaryPart.Position
                    end
                else
                    v560 = v552.PrimaryPart.Position
                end
                local v562 = p549.MinimapReference
                local v563 = v562.Part
                local v564 = v562.Size
                local v565 = v563.CFrame:PointToObjectSpace(v560)
                local v566 = v565.X
                local v567 = v565.Z
                local v568 = -v566
                local v569 = -v567
                local v570 = v568 / v564.X + 0.5
                local v571 = v569 / v564.Z + 0.5
                local v572 = p549.MapImage.ImageRectOffset
                local v573 = p549.MapImage.ImageRectSize
                local v574 = v570 * 1024
                local v575 = v571 * 1024
                local v576 = v574 - v572.X
                local v577 = v575 - v572.Y
                local v578 = v576 / v573.X
                local v579 = v577 / v573.Y
                if p549.MapImage.Rotation ~= 0 then
                    local v580 = p549.MapImage.Rotation
                    local v581 = math.rad(v580)
                    local v582 = math.cos(v581)
                    local v583 = math.sin(v581)
                    local v584 = v578 - 0.5
                    local v585 = v579 - 0.5
                    v578 = 0.5 + (v584 * v582 - v585 * v583)
                    v579 = 0.5 + (v584 * v583 + v585 * v582)
                end
                local v586 = v578 - 0.5
                local v587 = v579 - 0.5
                local v588 = v586 * v586 + v587 * v587
                local v589 = math.sqrt(v588)
                if v589 > 0.5 then
                    local v590 = v586 / v589
                    local v591 = v587 / v589
                    v578 = 0.5 + v590 * 0.5
                    v579 = 0.5 + v591 * 0.5
                end
                v558.Instance.Position = UDim2.fromScale(v578, v579)
                local v592 = v559 ~= nil
                local v593 = p549.Team
                if v592 then
                    if v593 == "Counter-Terrorists" then
                        v558.Instance.Visible = true
                    elseif v593 == "Terrorists" then
                        v558.Instance.Visible = v_u_134(v560, v552, p549.Character, p549.LocalPlayer)
                    else
                        v558.Instance.Visible = true
                    end
                else
                    v558.Instance.Visible = true
                end
            else
                v558.Instance.Visible = false
            end
        end
    end
    for v594, v595 in pairs(p549.Icons) do
        if v595.Type == "Hostage" and not v551[v594] then
            p549:RemoveIcon(v594)
        end
    end
end
function v_u_1.UpdateMinimapTexture(p596)
    if p596.MinimapReference then
        local v597 = p596.MinimapReference
        local v598 = v597.Lower or v597.Upper
        if v598 then
            p596.MapImage.Image = v598.Texture
            p596.MapImage.ImageTransparency = 0
            if v598.Texture:match("%d+") then
                local v599 = workspace:GetAttribute("Map")
                local v600 = v599 == "Vertigo" and true or v599 == "Winter Vertigo"
                local v601 = v597.Upper
                local v602 = p596.UpperMapImage
                if v600 then
                    if v601 == nil then
                        v600 = false
                    else
                        v600 = v602 ~= nil
                    end
                end
                if p596.Character and p596.Character.PrimaryPart then
                    local v603 = p596.Character.PrimaryPart.Position.Y
                    if v600 and (v602 and v601) then
                        v602.Image = v601.Texture
                        v602.ImageTransparency = v603 >= 222 and 0 or 1
                    end
                else
                    p596.MapImage.ImageTransparency = 0
                    if v600 and (v602 and v601) then
                        v602.Image = v601.Texture
                    end
                end
                if p596.Character and p596.Character.PrimaryPart then
                    local _ = p596.Settings.CentersPlayer
                    local v604 = p596.Character.PrimaryPart.Position
                    local v605 = v597.Part
                    local v606 = v605.CFrame:PointToObjectSpace(v604)
                    local v607 = v597.Size
                    local v608 = v606.X
                    local v609 = v606.Z
                    local v610 = -v608
                    local v611 = -v609
                    local v612 = v610 / v607.X + 0.5
                    local v613 = v611 / v607.Z + 0.5
                    local v614 = p596.Settings.Zoom or 0.7
                    local v615 = math.clamp(v614, 0.1, 1) * 1024 * 0.5
                    local v616 = v612 * 1024
                    local v617 = v613 * 1024
                    local v618 = v616 - v615 / 2
                    local v619 = v617 - v615 / 2
                    local v620 = 1024 - v615
                    local v621 = math.clamp(v618, 0, v620)
                    local v622 = 1024 - v615
                    local v623 = math.clamp(v619, 0, v622)
                    local v624 = v621 + v615 / 2
                    local v625 = v623 + v615 / 2
                    local v626 = v624 / 1024
                    local v627 = v625 / 1024
                    local v628 = (v626 - 0.5) * v607.X
                    local v629 = (v627 - 0.5) * v607.Z
                    local v630 = -v628
                    local v631 = -v629
                    p596.ViewCenterLocal = Vector3.new(v630, 0, v631)
                    local v632 = Vector2.new(v621, v623)
                    local v633 = Vector2.new(v615, v615)
                    p596.MapImage.ImageRectOffset = v632
                    p596.MapImage.ImageRectSize = v633
                    if v600 and v602 then
                        v602.ImageRectOffset = v632
                        v602.ImageRectSize = v633
                    end
                    local v634 = p596.IsSpectating and 90 or (not p596.Settings.Rotation and 90 or -v_u_152(v_u_22.CFrame.LookVector, v605) + 90 - 90)
                    p596.MapImage.Rotation = v634
                    if v600 and v602 then
                        v602.Rotation = v634
                        return
                    end
                else
                    local v635 = Vector2.new(0, 0)
                    local v636 = Vector2.new(1024, 1024)
                    p596.MapImage.ImageRectOffset = v635
                    p596.MapImage.ImageRectSize = v636
                    p596.MapImage.Rotation = 90
                    if v600 and v602 then
                        v602.ImageRectOffset = v635
                        v602.ImageRectSize = v636
                        v602.Rotation = 90
                    end
                    p596.ViewCenterLocal = Vector3.new(0, 0, 0)
                end
            end
        else
            return
        end
    else
        return
    end
end
function v_u_1.ApplySettings(p637)
    p637.MapImage.Size = UDim2.fromScale(1, 1)
    if p637.UpperMapImage then
        p637.UpperMapImage.Size = UDim2.fromScale(1, 1)
    end
    local v638 = p637.Settings.Scale or 1
    if v_u_20 then
        v638 = (v638 - 1) * 0.5 + 1
    end
    local v639 = v_u_23 * v638
    p637.RadarContainer.Size = UDim2.fromOffset(v639, v639)
    local v640 = UDim2.new(0, 10, 0, 10)
    local v641 = v_u_194(p637.Frame, v639, v640)
    p637.Frame.Position = v641
    p637:UpdateMinimapTexture()
end
function v_u_1.CreateRunningCircle(p642)
    if not p642.RunningCircle then
        local v643 = Instance.new("Frame")
        v643.Name = "RunningCircle"
        v643.BackgroundTransparency = 1
        v643.Size = UDim2.fromScale(1, 1)
        v643.Position = UDim2.fromScale(0.5, 0.5)
        v643.AnchorPoint = Vector2.new(0.5, 0.5)
        v643.ZIndex = v_u_25.LocalPlayer - 1
        v643.Parent = p642.RadarContainer
        local v644 = Instance.new("UIStroke")
        v644.Color = Color3.fromRGB(255, 255, 255)
        v644.Thickness = 2
        v644.Transparency = 1
        v644.Parent = v643
        local v645 = Instance.new("UICorner")
        v645.CornerRadius = UDim.new(1, 0)
        v645.Parent = v643
        p642.RunningCircle = v643
    end
end
function v_u_1.CreateKnifeCircle(p646)
    if not p646.KnifeCircle then
        local v647 = Instance.new("Frame")
        v647.Name = "KnifeCircle"
        v647.BackgroundTransparency = 1
        v647.Size = UDim2.fromScale(1, 1)
        v647.Position = UDim2.fromScale(0.5, 0.5)
        v647.AnchorPoint = Vector2.new(0.5, 0.5)
        v647.ZIndex = v_u_25.LocalPlayer - 1
        v647.Parent = p646.RadarContainer
        v647.Visible = false
        local v648 = Instance.new("UIStroke")
        v648.Color = Color3.fromRGB(255, 255, 255)
        v648.Thickness = 2
        v648.Transparency = 1
        v648.Parent = v647
        local v649 = Instance.new("UICorner")
        v649.CornerRadius = UDim.new(1, 0)
        v649.Parent = v647
        p646.KnifeCircle = v647
    end
end
function v_u_1.CreateWeaponCircle(p650)
    if not p650.WeaponCircle then
        local v651 = Instance.new("Frame")
        v651.Name = "WeaponCircle"
        v651.BackgroundTransparency = 1
        v651.Size = UDim2.fromScale(1, 1)
        v651.Position = UDim2.fromScale(0.5, 0.5)
        v651.AnchorPoint = Vector2.new(0.5, 0.5)
        v651.ZIndex = v_u_25.LocalPlayer - 1
        v651.Parent = p650.RadarContainer
        v651.Visible = false
        local v652 = Instance.new("UIStroke")
        v652.Color = Color3.fromRGB(255, 255, 255)
        v652.Thickness = 2
        v652.Transparency = 1
        v652.Parent = v651
        local v653 = Instance.new("UICorner")
        v653.CornerRadius = UDim.new(1, 0)
        v653.Parent = v651
        p650.WeaponCircle = v651
    end
end
function v_u_1.FlashRadarBorder(p_u_654)
    if v_u_27 and v_u_27.Radar then
        local v655 = v_u_27.Radar.UIStroke
        if v655 then
            if not p_u_654.OriginalBorderColor then
                p_u_654.OriginalBorderColor = v655.Color
            end
            v655.Color = Color3.fromRGB(255, 255, 255)
            if p_u_654.BorderRestoreTask then
                task.cancel(p_u_654.BorderRestoreTask)
                p_u_654.BorderRestoreTask = nil
            end
            p_u_654.BorderRestoreTask = task.delay(0.2, function()
                if v_u_27 and (v_u_27.Radar and v_u_27.Radar.UIStroke) then
                    v_u_27.Radar.UIStroke.Color = v_u_15()
                end
                p_u_654.BorderRestoreTask = nil
            end)
        end
    else
        return
    end
end
function v_u_1.ShowWeaponCircle(p_u_656)
    if not p_u_656.WeaponCircle then
        p_u_656:CreateWeaponCircle()
    end
    local v_u_657 = p_u_656.WeaponCircle
    if v_u_657 then
        local v_u_658 = v_u_657:FindFirstChildOfClass("UIStroke")
        if v_u_658 then
            local v659 = p_u_656.Settings.Scale or 1
            if v_u_20 then
                v659 = (v659 - 1) * 0.5 + 1
            end
            local v660 = v_u_23 / 2 * v659 * 2
            v_u_657.Size = UDim2.fromOffset(v660, v660)
            v_u_658.Thickness = 2
            v_u_658.Transparency = 0
            v_u_657.Visible = true
            if p_u_656.WeaponCircleHideTask then
                task.cancel(p_u_656.WeaponCircleHideTask)
                p_u_656.WeaponCircleHideTask = nil
            end
            p_u_656.WeaponCircleHideTask = task.delay(0.2, function()
                if v_u_657 and v_u_658 then
                    v_u_658.Transparency = 1
                    v_u_657.Visible = false
                end
                p_u_656.WeaponCircleHideTask = nil
            end)
        end
    else
        return
    end
end
function v_u_1.ShowKnifeCircle(p661)
    if not p661.KnifeCircle then
        p661:CreateKnifeCircle()
    end
    local v_u_662 = p661.KnifeCircle
    if v_u_662 then
        local v_u_663 = v_u_662:FindFirstChildOfClass("UIStroke")
        if v_u_663 then
            local v664 = p661.Settings.Zoom or 0.5
            local v665 = math.clamp(v664, 0.1, 1)
            local v666 = p661.Settings.Scale or 1
            if v_u_20 then
                v666 = (v666 - 1) * 0.5 + 1
            end
            local v667 = (v_u_20 and 21 or 35) * (0.5 / v665) * v666
            local v668 = v_u_23 / 2 * v666
            local v669 = math.min(v667, v668)
            local v670 = v669 * 2
            v_u_662.Size = UDim2.fromOffset(v670, v670)
            if v669 == v668 then
                v_u_663.Thickness = 2
                v_u_663.Transparency = 0
            else
                v_u_663.Thickness = 1
                v_u_663.Transparency = 0.5
            end
            v_u_662.Visible = true
            task.delay(0.2, function()
                if v_u_662 and v_u_663 then
                    v_u_663.Transparency = 1
                    v_u_662.Visible = false
                end
            end)
        end
    else
        return
    end
end
function v_u_1.UpdateRunningCircle(p_u_671)
    if p_u_671.Character and p_u_671.Character.PrimaryPart then
        local v672 = p_u_671.Character:FindFirstChildOfClass("Humanoid")
        if v672 then
            local v673 = v_u_11.GetWalkState() or false
            local v674 = v672.MoveDirection.Magnitude > 0
            if v674 then
                v674 = not v673
            end
            local v675 = v_u_11.getCurrentCharacter()
            local v676 = v675 and v675.IsJumping or false
            local v677 = v674 or v676
            if not p_u_671.RunningCircle then
                p_u_671:CreateRunningCircle()
            end
            local v678 = p_u_671.RunningCircle
            if v678 then
                local v679 = v678:FindFirstChildOfClass("UIStroke")
                if v679 then
                    local v680 = p_u_671.Settings.Zoom or 0.5
                    local v681 = math.clamp(v680, 0.1, 1)
                    local v682 = p_u_671.Settings.Scale or 1
                    if v_u_20 then
                        v682 = (v682 - 1) * 0.5 + 1
                    end
                    local v683 = (v_u_20 and 30 or 50) * (0.5 / v681) * v682
                    local v684 = v_u_23 / 2 * v682
                    local v685 = math.min(v683, v684)
                    local v686 = v685 * 2
                    v678.Size = UDim2.fromOffset(v686, v686)
                    local v687 = v685 == v684
                    if v687 then
                        v679.Thickness = 2
                    else
                        v679.Thickness = 1
                    end
                    if v677 then
                        if v687 then
                            v679.Transparency = 0
                        else
                            v679.Transparency = 0.5
                        end
                        if v676 then
                            if p_u_671.RunningCircleDelayTask then
                                task.cancel(p_u_671.RunningCircleDelayTask)
                                p_u_671.RunningCircleDelayTask = nil
                            end
                            v678.Visible = true
                        elseif v674 then
                            if p_u_671.WasRunning then
                                if not p_u_671.RunningCircleDelayTask then
                                    if v687 then
                                        v679.Transparency = 0
                                    else
                                        v679.Transparency = 0.5
                                    end
                                    v678.Visible = true
                                end
                            else
                                if p_u_671.RunningCircleDelayTask then
                                    task.cancel(p_u_671.RunningCircleDelayTask)
                                    p_u_671.RunningCircleDelayTask = nil
                                end
                                v678.Visible = false
                                v679.Transparency = 1
                                p_u_671.RunningCircleDelayTask = task.delay(0.4, function()
                                    if p_u_671.Character and p_u_671.Character.PrimaryPart then
                                        local v688 = p_u_671.Character:FindFirstChildOfClass("Humanoid")
                                        if v688 then
                                            local v689 = v_u_11.GetWalkState() or false
                                            local v690 = v688.MoveDirection.Magnitude > 0
                                            if v690 then
                                                v690 = not v689
                                            end
                                            if v690 and p_u_671.RunningCircle then
                                                local v691 = p_u_671.RunningCircle
                                                local v692 = v691:FindFirstChildOfClass("UIStroke")
                                                if v692 then
                                                    local v693 = p_u_671.Settings.Zoom or 0.5
                                                    local v694 = math.clamp(v693, 0.1, 1)
                                                    local v695 = p_u_671.Settings.Scale or 1
                                                    if v_u_20 then
                                                        v695 = (v695 - 1) * 0.5 + 1
                                                    end
                                                    local v696 = (v_u_20 and 30 or 50) * (0.5 / v694) * v695
                                                    local v697 = v_u_23 / 2 * v695
                                                    if math.min(v696, v697) == v697 then
                                                        v692.Transparency = 0
                                                    else
                                                        v692.Transparency = 0.5
                                                    end
                                                    v691.Visible = true
                                                end
                                            end
                                            p_u_671.RunningCircleDelayTask = nil
                                        else
                                            p_u_671.RunningCircleDelayTask = nil
                                        end
                                    else
                                        p_u_671.RunningCircleDelayTask = nil
                                        return
                                    end
                                end)
                            end
                        end
                    else
                        if p_u_671.RunningCircleDelayTask then
                            task.cancel(p_u_671.RunningCircleDelayTask)
                            p_u_671.RunningCircleDelayTask = nil
                        end
                        v678.Visible = false
                        v679.Transparency = 1
                    end
                    p_u_671.WasRunning = v677
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
function v_u_1.CreateDeadIconForPlayer(p_u_698, p699, p700)
    local v701 = p699.UserId .. "_Player"
    if p_u_698.Icons[v701] then
        p_u_698:RemoveIcon(v701)
    end
    local v_u_702 = p699.UserId .. "_Dead"
    if not (p_u_698.Icons[v_u_702] or p_u_698.FadedDeadIcons[v_u_702]) then
        local v703 = p699:GetAttribute("Team")
        local v704 = v703 == p_u_698.Team
        local v705 = v_u_140(p_u_698.RadarContainer, "DeadTeammate", 12)
        v705.Name = p699.Name .. "_Dead"
        v705.ImageTransparency = 0
        for _, v706 in ipairs(v705:GetChildren()) do
            if v706.Name == "Direction" and v706:IsA("ImageLabel") then
                v706.Visible = false
            end
        end
        if v704 then
            local v707 = v_u_14["Team Color"][v703]
            if v707 then
                v705.ImageColor3 = v707
            end
        else
            v705.ImageColor3 = Color3.fromRGB(255, 0, 0)
        end
        local v708 = {
            ["Instance"] = v705,
            ["Player"] = p699,
            ["Target"] = nil,
            ["Type"] = "DeadTeammate",
            ["DefaultSize"] = v_u_21.Dead.Size
        }
        p_u_698.Icons[v_u_702] = v708
        if p700 and p_u_698.MinimapReference then
            local v709 = p_u_698.MinimapReference
            local v710 = v709.Part
            local v711 = v709.Size
            local v712 = v710.CFrame:PointToObjectSpace(p700)
            local v713 = v712.X
            local v714 = v712.Z
            local v715 = -v713
            local v716 = -v714
            local v717 = v715 / v711.X + 0.5
            local v718 = v716 / v711.Z + 0.5
            local v719 = p_u_698.MapImage.ImageRectOffset
            local v720 = p_u_698.MapImage.ImageRectSize
            local v721 = v717 * 1024
            local v722 = v718 * 1024
            local v723 = v721 - v719.X
            local v724 = v722 - v719.Y
            local v725 = v723 / v720.X
            local v726 = v724 / v720.Y
            if p_u_698.MapImage.Rotation ~= 0 then
                local v727 = p_u_698.MapImage.Rotation
                local v728 = math.rad(v727)
                local v729 = math.cos(v728)
                local v730 = math.sin(v728)
                local v731 = v725 - 0.5
                local v732 = v726 - 0.5
                v725 = 0.5 + (v731 * v729 - v732 * v730)
                v726 = 0.5 + (v731 * v730 + v732 * v729)
            end
            local v733 = v725 - 0.5
            local v734 = v726 - 0.5
            local v735 = v733 * v733 + v734 * v734
            local v736 = math.sqrt(v735)
            if v736 > 0.5 then
                local v737 = v733 / v736
                local v738 = v734 / v736
                v725 = 0.5 + v737 * 0.5
                v726 = 0.5 + v738 * 0.5
            end
            v705.Position = UDim2.fromScale(v725, v726)
            v705.Visible = true
        end
        task.delay(2, function()
            local v739 = p_u_698.Icons[v_u_702]
            if v739 and (v739.Instance and v739.Instance.Parent) then
                p_u_698.FadedDeadIcons[v_u_702] = true
                local v740 = v_u_4:Create(v739.Instance, TweenInfo.new(4, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
                    ["ImageTransparency"] = 1
                })
                v740:Play()
                v740.Completed:Connect(function()
                    if p_u_698.Icons[v_u_702] then
                        p_u_698:RemoveIcon(v_u_702)
                    end
                end)
            end
        end)
    end
end
function v_u_1.Render(p741, _)
    p741:UpdateMinimapTexture()
    p741:UpdatePlayerIcons(p741.Settings.Rotation)
    p741:UpdateBombIcon()
    p741:UpdateSiteIcons()
    p741:UpdateHostageIcons()
    p741:UpdateRunningCircle()
end
function v_u_1.new(p742, p743)
    local v744 = v_u_1
    local v_u_745 = setmetatable({}, v744)
    v_u_745.Janitor = v_u_19.new()
    v_u_745.Frame = p742
    v_u_745.RadarContainer = p742.Radar
    v_u_745.MapImage = p742.Radar.Map
    v_u_745.MapImage.AnchorPoint = Vector2.new(0.5, 0.5)
    v_u_745.MapImage.Position = UDim2.fromScale(0.5, 0.5)
    v_u_745.MapImage.ZIndex = 1
    v_u_745.LocalPlayer = v_u_10
    v_u_745.Character = p743
    v_u_745.Team = v_u_10:GetAttribute("Team")
    v_u_745.MinimapReference = v_u_33()
    local v746 = workspace:GetAttribute("Map")
    if (v746 == "Vertigo" and true or v746 == "Winter Vertigo") and (v_u_745.MinimapReference and v_u_745.MinimapReference.Upper) then
        local v747 = v_u_745.MapImage:Clone()
        v747.Name = "UpperMap"
        v747.ZIndex = 2
        v747.BackgroundTransparency = 1
        v747.Parent = v_u_745.RadarContainer
        v_u_745.UpperMapImage = v747
        v_u_745.Janitor:Add(function()
            if v_u_745.UpperMapImage then
                v_u_745.UpperMapImage:Destroy()
            end
        end)
    else
        v_u_745.UpperMapImage = nil
    end
    v_u_745.Frame.Visible = true
    v_u_745.Janitor:Add(function()
        v_u_745.Frame.Visible = true
    end)
    v_u_745.Settings = v_u_28
    v_u_745.IsSpectating = false
    v_u_745.Icons = {}
    v_u_745.SiteParts = v_u_44()
    v_u_745.DeadPlayerPositions = {}
    v_u_745.FadedDeadIcons = {}
    v_u_745.EnemyVisibilityState = {}
    v_u_745.EnemyLastSeenPositions = {}
    v_u_745.RunningCircle = nil
    v_u_745.RunningCircleDelayTask = nil
    v_u_745.WasRunning = false
    v_u_745.KnifeCircle = nil
    v_u_745.WeaponCircle = nil
    v_u_745.WeaponCircleHideTask = nil
    v_u_745.OriginalBorderColor = nil
    v_u_745.BorderRestoreTask = nil
    v_u_745.BombIsVisible = false
    v_u_745.BombFadeStartTime = nil
    v_u_745:ApplySettings()
    local v_u_748 = v_u_18.broadcastRouter
    function v_u_18.broadcastRouter(p749, ...)
        local v750 = v_u_748(p749, ...)
        if p749 == "UpdatePlayerNoiseCone" then
            local v751 = { ... }
            local v752 = v751[1]
            local v753 = v751[2]
            if v753 and (v_u_745.Character and (v_u_745.Character.PrimaryPart and (v753 - v_u_745.Character.PrimaryPart.Position).Magnitude < 5)) then
                if v752 == "Melee" then
                    v_u_745:ShowKnifeCircle()
                    return v750
                end
                if v752 == "Weapon" then
                    v_u_745:ShowWeaponCircle()
                    v_u_745:FlashRadarBorder()
                end
            end
        end
        return v750
    end
    v_u_745.Janitor:Add(function()
        v_u_18.broadcastRouter = v_u_748
    end)
    local v_u_754 = 0
    v_u_745.Janitor:Add(v_u_6.RenderStepped:Connect(function(p755)
        v_u_754 = v_u_754 + p755
        if v_u_754 >= 0.004166666666666667 then
            v_u_745:Render(p755)
            v_u_754 = 0
        end
    end))
    v_u_745.Janitor:Add(v_u_10:GetAttributeChangedSignal("Team"):Connect(function()
        v_u_745:RefreshIconsOnTeamChange()
    end))
    for _, v_u_756 in ipairs(v_u_9:GetPlayers()) do
        if v_u_756 ~= v_u_745.LocalPlayer then
            v_u_745.Janitor:Add(v_u_756:GetAttributeChangedSignal("Team"):Connect(function()
                v_u_745:RefreshPlayerIcon(v_u_756)
            end))
        end
    end
    v_u_745.Janitor:Add(v_u_9.PlayerAdded:Connect(function(p_u_757)
        if p_u_757 ~= v_u_745.LocalPlayer then
            v_u_745.Janitor:Add(p_u_757:GetAttributeChangedSignal("Team"):Connect(function()
                v_u_745:RefreshPlayerIcon(p_u_757)
            end))
        end
    end))
    v_u_745.Janitor:Add(v_u_9.PlayerRemoving:Connect(function(p758)
        for v759, v760 in pairs(v_u_745.Icons) do
            if v760.Player == p758 then
                v_u_745:RemoveIcon(v759)
            end
        end
        v_u_745.DeadPlayerPositions[p758.UserId] = nil
        v_u_745.FadedDeadIcons[p758.UserId .. "_Dead"] = nil
    end))
    v_u_745.Janitor:Add(v_u_17.UI.UIPlayerKilled.Listen(function(p761)
        local v762 = p761.Victim
        local v763 = v_u_9:GetPlayerByUserId((tonumber(v762)))
        if v763 and v763 ~= v_u_10 then
            local v764 = p761.DeathPosition
            if v764 then
                v_u_745.DeadPlayerPositions[v763.UserId] = v764
                v_u_745:CreateDeadIconForPlayer(v763, v764)
            end
        else
            return
        end
    end))
    v_u_745.Janitor:Add(workspace:GetAttributeChangedSignal("Map"):Connect(function()
        v_u_745.MinimapReference = v_u_33()
        v_u_745.SiteParts = v_u_44()
        local v765 = workspace:GetAttribute("Map")
        local v766 = v765 == "Vertigo" and true or v765 == "Winter Vertigo"
        if v_u_745.UpperMapImage then
            v_u_745.UpperMapImage:Destroy()
            v_u_745.UpperMapImage = nil
        end
        for _, v767 in ipairs(v_u_745.RadarContainer:GetChildren()) do
            if v767.Name == "UpperMap" and v767:IsA("ImageLabel") then
                v767:Destroy()
            end
        end
        v_u_745.MapImage.Image = ""
        v_u_745.MapImage.ImageTransparency = 0
        v_u_745.MapImage.ImageRectOffset = Vector2.new(0, 0)
        v_u_745.MapImage.ImageRectSize = Vector2.new(0, 0)
        v_u_745.MapImage.Rotation = 0
        v_u_745.MapImage.Visible = true
        v_u_745.MapImage.Size = UDim2.fromScale(1, 1)
        if v766 and (v_u_745.MinimapReference and v_u_745.MinimapReference.Upper) then
            local v768 = v_u_745.MapImage:Clone()
            v768.Name = "UpperMap"
            v768.ZIndex = 2
            v768.Parent = v_u_745.RadarContainer
            v_u_745.UpperMapImage = v768
        else
            v_u_745.UpperMapImage = nil
        end
        v_u_745:UpdateMinimapTexture()
        for v769, _ in pairs(v_u_745.Icons) do
            v_u_745:RemoveIcon(v769)
        end
        table.clear(v_u_745.EnemyVisibilityState)
        table.clear(v_u_745.EnemyLastSeenPositions)
        table.clear(v_u_745.DeadPlayerPositions)
        table.clear(v_u_745.FadedDeadIcons)
    end))
    v_u_745.Janitor:Add(function()
        for _, v770 in pairs(v_u_745.Icons) do
            if v770.Instance and v770.Instance.Parent then
                v770.Instance:Destroy()
            end
        end
        table.clear(v_u_745.Icons)
        table.clear(v_u_745.EnemyVisibilityState)
        table.clear(v_u_745.EnemyLastSeenPositions)
        if v_u_745.UpperMapImage then
            v_u_745.UpperMapImage:Destroy()
            v_u_745.UpperMapImage = nil
        end
        if v_u_745.RadarContainer then
            for _, v771 in ipairs(v_u_745.RadarContainer:GetChildren()) do
                if v771.Name == "UpperMap" and v771:IsA("ImageLabel") then
                    v771:Destroy()
                end
            end
        end
        if v_u_745.RunningCircleDelayTask then
            task.cancel(v_u_745.RunningCircleDelayTask)
            v_u_745.RunningCircleDelayTask = nil
        end
        if v_u_745.RunningCircle then
            v_u_745.RunningCircle:Destroy()
            v_u_745.RunningCircle = nil
        end
        if v_u_745.KnifeCircle then
            v_u_745.KnifeCircle:Destroy()
            v_u_745.KnifeCircle = nil
        end
        if v_u_745.WeaponCircleHideTask then
            task.cancel(v_u_745.WeaponCircleHideTask)
            v_u_745.WeaponCircleHideTask = nil
        end
        if v_u_745.WeaponCircle then
            v_u_745.WeaponCircle:Destroy()
            v_u_745.WeaponCircle = nil
        end
        local v772 = v_u_745
        if v772.BorderRestoreTask then
            task.cancel(v772.BorderRestoreTask)
            v772.BorderRestoreTask = nil
        end
        if v_u_745.RunningCircle then
            v_u_745.RunningCircle:Destroy()
            v_u_745.RunningCircle = nil
        end
    end)
    return v_u_745
end
function v_u_1.Destroy(p773)
    p773.Janitor:Destroy()
end
function v_u_1.Initialize(_, p774)
    v_u_27 = p774
    v_u_13.CreateListener(v_u_10, "Settings.Game.Radar/Tablet.Radar Centers The Player", function(p775)
        v_u_28.CentersPlayer = p775
        if v_u_29 then
            v_u_29:ApplySettings()
        end
    end)
    v_u_13.CreateListener(v_u_10, "Settings.Game.Radar/Tablet.Radar Hud Size", function(p776)
        v_u_28.Scale = p776
        if v_u_29 then
            v_u_29:ApplySettings()
        end
    end)
    v_u_13.CreateListener(v_u_10, "Settings.Game.Radar/Tablet.Radar Is Rotating", function(p777)
        v_u_28.Rotation = p777
        if v_u_29 then
            v_u_29:ApplySettings()
        end
    end)
    v_u_13.CreateListener(v_u_10, "Settings.Game.Radar/Tablet.Radar Map Zoom", function(p778)
        v_u_28.Zoom = p778
        if v_u_29 then
            v_u_29:ApplySettings()
        end
    end)
    v_u_27.Radar.UIStroke.Color = v_u_15()
    v_u_10.CharacterAdded:Connect(function()
        v_u_27.Radar.UIStroke.Color = v_u_15()
    end)
    v_u_13.CreateListener(v_u_10, "Settings.Game.HUD.Color", function()
        if v_u_27 and (v_u_27.Radar and v_u_27.Radar.UIStroke) then
            local v779 = v_u_27.Radar.UIStroke
            local v780
            if v_u_29 then
                v780 = v_u_29.BorderRestoreTask ~= nil
            else
                v780 = false
            end
            if not v780 or v779.Color ~= Color3.fromRGB(255, 255, 255) then
                v779.Color = v_u_15()
            end
        end
    end)
end
function v_u_1.Start()
    v_u_10.CharacterAdded:Connect(function(p781)
        v_u_37(p781, v_u_10, false)
    end)
    v_u_12.ListenToSpectate:Connect(function(p782)
        if p782 then
            local v783 = p782.Character
            if v783 and v783:IsDescendantOf(workspace) then
                v_u_37(v783, p782, true)
                return
            end
        else
            local v784 = v_u_10.Character
            if v784 and v784:IsDescendantOf(workspace) then
                v_u_37(v784, v_u_10, false)
            end
        end
    end)
end
return v_u_1