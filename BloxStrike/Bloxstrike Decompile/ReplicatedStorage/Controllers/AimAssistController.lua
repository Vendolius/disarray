local v1 = {}
local v2 = game:GetService("ReplicatedStorage")
local v_u_3 = game:GetService("Workspace")
local v_u_4 = game:GetService("Players")
local v_u_5 = v_u_4.LocalPlayer
local v_u_6 = require(v2.Controllers.DataController)
local v_u_7 = require(v2.Components.Common.VFXLibary.FlashEffect)
local v8 = require(v2.Components.Common.GetUserPlatform)
local v9 = require(v2.Database.Custom.Constants)
local v_u_10
if table.find(v8(), "Mobile") == nil then
    v_u_10 = false
else
    v_u_10 = #v8() <= 1
end
local v_u_11 = v_u_3.CurrentCamera
local v_u_12 = table.find(v9.AIM_ASSIST_WHITELIST, v_u_5.UserId) ~= nil
local v_u_13 = false
local v_u_14 = v_u_12 and v9.AIM_ASSIST_CONFIGS.DEVELOPER or v9.AIM_ASSIST_CONFIGS.PLAYER
local function v_u_46(p15, p16, p17)
    local function v40(p18, p19, p20, p21, p22)
        local v23 = 0
        local v24 = p19.X
        local v25, v26
        if math.abs(v24) < 0.0001 then
            if p18.X < p20.X or p18.X > p21.X then
                return false
            end
            v25 = p22
            v26 = v23
        else
            local v27 = 1 / p19.X
            v25 = (p20.X - p18.X) * v27
            v26 = (p21.X - p18.X) * v27
            if v26 >= v25 then
                local v28 = v25
                v25 = v26
                v26 = v28
            end
            if v23 >= v26 then
                v26 = v23
            end
            if v25 >= p22 then
                v25 = p22
            end
            if v25 < v26 then
                return false
            end
        end
        local v29 = p19.Y
        if math.abs(v29) < 0.0001 then
            if p18.Y < p20.Y or p18.Y > p21.Y then
                return false
            end
        else
            local v30 = 1 / p19.Y
            local v31 = (p20.Y - p18.Y) * v30
            local v32 = (p21.Y - p18.Y) * v30
            if v32 >= v31 then
                local v33 = v31
                v31 = v32
                v32 = v33
            end
            if v26 >= v32 then
                v32 = v26
            end
            if v31 >= v25 then
                v31 = v25
            end
            if v31 < v32 then
                return false
            end
            v25 = v31
            v26 = v32
        end
        local v34 = p19.Z
        if math.abs(v34) < 0.0001 then
            if p18.Z < p20.Z or p18.Z > p21.Z then
                return false
            end
        else
            local v35 = 1 / p19.Z
            local v36 = (p20.Z - p18.Z) * v35
            local v37 = (p21.Z - p18.Z) * v35
            if v37 >= v36 then
                local v38 = v36
                v36 = v37
                v37 = v38
            end
            if v26 >= v37 then
                v37 = v26
            end
            if v36 >= v25 then
                v36 = v25
            end
            if v36 < v37 then
                return false
            end
            v26 = v37
        end
        local v39
        if v26 >= 0 then
            v39 = v26 <= p22
        else
            v39 = false
        end
        return v39
    end
    local v41 = v_u_3:FindFirstChild("Debris")
    if not v41 then
        return false
    end
    for _, v42 in ipairs(v41:GetChildren()) do
        if v42.Name:match("^VoxelSmoke_") and v42:IsA("Folder") then
            for _, v43 in ipairs(v42:GetChildren()) do
                if v43:IsA("BasePart") and v43.Name == "SmokeVoxel" then
                    local v44 = v43.Size
                    local v45 = v43.Position
                    if v40(p15, p16, v45 - v44 / 2, v45 + v44 / 2, p17) then
                        return true
                    end
                end
            end
        end
    end
    return false
end
local function v_u_52(p47, p48)
    if not (p47 and p48) then
        return false
    end
    local v49 = p47:GetAttribute("Team")
    local v50 = p48:GetAttribute("Team")
    if not (v49 and v50) then
        return false
    end
    if v49 == v50 then
        return false
    end
    local v51 = {
        ["Counter-Terrorists"] = true,
        ["Terrorists"] = true
    }
    return v51[v49] and v51[v50] and true or false
end
local function v_u_60(p53, p54)
    if not (p53 and p53.PrimaryPart) then
        return false
    end
    local v55 = not (p53 and p53.PrimaryPart) and Vector3.new(0, 0, 0) or p53.PrimaryPart.Position
    local v56 = (v55 - p54).Unit
    local v57 = (v55 - p54).Magnitude
    if v_u_46(p54, v56, v57) then
        return false
    end
    local v58 = RaycastParams.new()
    v58.FilterType = Enum.RaycastFilterType.Exclude
    v58.FilterDescendantsInstances = { v_u_5.Character }
    local v59 = v_u_3:Raycast(p54, v56 * v57, v58)
    return not v59 and true or (p53:IsAncestorOf(v59.Instance) and true or false)
end
local function v_u_76(p61)
    local v62 = 0
    local v63 = nil
    for _, v64 in ipairs(v_u_4:GetPlayers()) do
        if v64 ~= v_u_5 and v_u_52(v_u_5, v64) then
            local v65 = v64.Character
            if v65 and v65.PrimaryPart then
                local v66 = v65:FindFirstChildOfClass("Humanoid")
                if v66 and (v66.Health > 0 and v65:GetAttribute("Dead") ~= true) then
                    local v67 = not (v65 and v65.PrimaryPart) and Vector3.new(0, 0, 0) or v65.PrimaryPart.Position
                    local v68 = p61.Position
                    local v69 = (v67 - v68).Magnitude
                    if v_u_14.TargetSelection.MaxDistance >= v69 then
                        local v70 = p61.Position
                        local v71 = p61.LookVector:Dot((v67 - v70).Unit)
                        local v72 = math.clamp(v71, -1, 1)
                        local v73 = math.acos(v72)
                        if v_u_14.TargetSelection.MaxAngle >= v73 and v_u_60(v65, v68) then
                            local v74 = v73 / v_u_14.TargetSelection.MaxAngle
                            local v75 = 1 / (v69 + 1) * (1 - v74)
                            if v62 < v75 then
                                v63 = v65
                                v62 = v75
                            end
                        end
                    end
                end
            end
        end
    end
    return v63
end
local function v_u_90(p77, p78)
    if v_u_14.Friction.Enabled and p78 then
        if v_u_11 and p78.PrimaryPart then
            local v79 = not (p78 and p78.PrimaryPart) and Vector3.new(0, 0, 0) or p78.PrimaryPart.Position
            local v80 = p77.Position
            local v81, v82 = v_u_11:WorldToViewportPoint(v79)
            if v82 and v81.Z >= 0 then
                local v83 = v_u_11.ViewportSize / 2
                local v84 = Vector2.new(v83.X, v83.Y)
                local v85 = (Vector2.new(v81.X, v81.Y) - v84).Magnitude
                local v86 = (v79 - v80).Magnitude
                local v87 = 2 / v86 * v83.Y * 2
                local v88 = v_u_14.Friction.BubbleRadius * (v83.Y / v86) * 2
                if v88 + v87 / 2 < v85 then
                    return v_u_14.Friction.MaxSensitivity
                else
                    local v89 = v85 - v87 / 2
                    if math.max(0, v89) <= v88 then
                        return v_u_14.Friction.MinSensitivity
                    else
                        return v_u_14.Friction.MaxSensitivity
                    end
                end
            else
                return v_u_14.Friction.MaxSensitivity
            end
        else
            return v_u_14.Friction.MaxSensitivity
        end
    else
        return v_u_14.Friction.MaxSensitivity
    end
end
function v1.IsEnabled()
    return v_u_13
end
function v1.SetEnabled(p91)
    v_u_13 = p91
end
function v1.GetBestTarget()
    if v_u_10 or v_u_12 then
        if v_u_13 and v_u_14.TargetSelection.Enabled then
            if v_u_7.IsFlashed() then
                return nil
            elseif v_u_11 and v_u_5.Character then
                return v_u_76(v_u_11.CFrame)
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
function v1.GetFrictionMultiplier()
    if not (v_u_10 or v_u_12) then
        return v_u_14.Friction.MaxSensitivity
    end
    if not (v_u_13 and v_u_14.Friction.Enabled) then
        return v_u_14.Friction.MaxSensitivity
    end
    if v_u_7.IsFlashed() then
        return v_u_14.Friction.MaxSensitivity
    end
    if not (v_u_11 and v_u_5.Character) then
        return v_u_14.Friction.MaxSensitivity
    end
    local v92 = v_u_11.CFrame
    return v_u_90(v92, (v_u_76(v92)))
end
local function v_u_109(p93)
    local v94 = p93.Position
    local v95 = v_u_14.Magnetism.MaxDistance
    local v96 = RaycastParams.new()
    v96.FilterType = Enum.RaycastFilterType.Exclude
    v96.FilterDescendantsInstances = { v_u_5.Character }
    local v97 = v_u_14.Magnetism.MaxAngleHorizontal / 2
    local v98 = v_u_14.Magnetism.MaxAngleVertical / 2
    for v99 = -1, 1 do
        for v100 = -1, 1 do
            local v101 = v99 * v97
            local v102 = v100 * v98
            local v103 = (p93 * CFrame.Angles(v102, v101, 0)).LookVector
            local v104 = v_u_3:Raycast(v94, v103 * v95, v96)
            if v104 then
                local v105 = v104.Instance:FindFirstAncestorOfClass("Model")
                if v105 and v105:FindFirstChildOfClass("Humanoid") then
                    local v106 = v_u_4:GetPlayerFromCharacter(v105)
                    if v106 and v_u_52(v_u_5, v106) then
                        local v107 = v105:FindFirstChildOfClass("Humanoid")
                        if v107 and (v107.Health > 0 and v105:GetAttribute("Dead") ~= true) then
                            local v108 = (v104.Position - v94).Magnitude
                            if v108 <= v95 and not v_u_46(v94, v103, v108) then
                                return v105
                            end
                        end
                    end
                end
            end
        end
    end
    return nil
end
local function v_u_140(p110, p111, p112)
    if p111 and p111.PrimaryPart then
        local v113 = not (p111 and p111.PrimaryPart) and Vector3.new(0, 0, 0) or p111.PrimaryPart.Position
        local v114 = p110.Position
        local v115 = p110.LookVector
        if (v113 - v114).Magnitude > v_u_14.Magnetism.MaxDistance then
            return Vector2.zero
        else
            local v116 = (v113 - v114).Unit
            local v117 = v115.X
            local v118 = v115.Z
            local v119 = Vector3.new(v117, 0, v118).Unit
            local v120 = v116.X
            local v121 = v116.Z
            local v122 = v119:Dot(Vector3.new(v120, 0, v121).Unit)
            local v123 = math.clamp(v122, -1, 1)
            local v124 = math.acos(v123)
            local v125 = -v115.Y
            local v126 = math.asin(v125)
            local v127 = -v116.Y
            local v128 = math.asin(v127) - v126
            local v129 = math.abs(v128)
            if v129 > 1.5707963267948966 then
                v129 = 3.141592653589793 - v129
            end
            if v_u_14.Magnetism.MaxAngleHorizontal < v124 then
                return Vector2.zero
            elseif v_u_14.Magnetism.MaxAngleVertical < v129 then
                return Vector2.zero
            elseif v124 <= v_u_14.Magnetism.StopThreshold then
                return Vector2.zero
            elseif v124 > 1.5707963267948966 then
                return Vector2.zero
            else
                local v130 = -v115.X
                local v131 = -v115.Z
                local v132 = math.atan2(v130, v131)
                local v133 = -v116.X
                local v134 = -v116.Z
                local v135 = math.atan2(v133, v134) - v132
                if v135 > 3.141592653589793 then
                    v135 = v135 - 6.283185307179586
                elseif v135 < -3.141592653589793 then
                    v135 = v135 + 6.283185307179586
                end
                local v136 = math.abs(v135)
                if v136 < 0.001 then
                    return Vector2.zero
                else
                    local v137 = v_u_14.Magnetism.PullStrength * p112
                    local v138 = math.min(v137, v136)
                    local v139 = v135 > 0 and 1 or -1
                    if v139 == v139 then
                        return Vector2.new(v139 * v138, 0)
                    else
                        return Vector2.zero
                    end
                end
            end
        end
    else
        return Vector2.zero
    end
end
function v1.GetMagnetismRotation(p141)
    if v_u_10 or v_u_12 then
        if v_u_13 and v_u_14.Magnetism.Enabled then
            if v_u_7.IsFlashed() then
                return Vector2.zero
            elseif v_u_11 and v_u_5.Character then
                local v142 = p141 or 0.016666666666666666
                local v143 = v_u_11.CFrame
                local v144 = v_u_76(v143) or v_u_109(v143)
                if v144 then
                    return v_u_140(v143, v144, v142)
                else
                    return Vector2.zero
                end
            else
                return Vector2.zero
            end
        else
            return Vector2.zero
        end
    else
        return Vector2.zero
    end
end
function v1.GetRecoilAssistMultiplier()
    if not (v_u_10 or v_u_12) then
        return 0
    end
    if not (v_u_13 and v_u_14.RecoilAssist.Enabled) then
        return 0
    end
    if v_u_7.IsFlashed() then
        return 0
    end
    if v_u_14.RecoilAssist.RequiresTarget then
        if not (v_u_11 and v_u_5.Character) then
            return 0
        end
        if not v_u_76(v_u_11.CFrame) then
            return 0
        end
    end
    return v_u_14.RecoilAssist.ReductionAmount
end
function v1.Initialize()
    v_u_13 = v_u_10 or v_u_12
    v_u_6.CreateListener(v_u_5, "Settings.Game.Other.Mobile Aim Assist", function(p145)
        v_u_13 = p145 ~= false
    end)
end
return v1