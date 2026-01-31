local v_u_1 = {}
v_u_1.__index = v_u_1
local v_u_2 = game:GetService("CollectionService")
local v3 = game:GetService("ReplicatedStorage")
local v_u_4 = game:GetService("TweenService")
local v_u_5 = game:GetService("RunService")
local v6 = game:GetService("Workspace")
local v7 = game:GetService("Players")
require(script:WaitForChild("Types"))
local v_u_8 = v7.LocalPlayer
local v_u_9 = workspace:WaitForChild("Debris")
local v_u_10 = v6.CurrentCamera
local v_u_11 = v3:WaitForChild("Assets"):WaitForChild("CharacterAnimations")
local v_u_12 = require(script.Components.GetMovementAnimation)
local v_u_13 = require(script.Classes.CharacterAnimator)
local v_u_14 = require(v3.Controllers.InventoryController)
local v_u_15 = require(v3.Database.Components.GameState)
local v_u_16 = require(v3.Database.Security.Remotes)
local v_u_17 = require(v3.Shared.Janitor)
local v_u_18 = require(v3.Packages.Signal)
local v_u_19 = require(v_u_8.PlayerScripts:WaitForChild("PlayerModule")):GetControls()
local v_u_20 = RaycastParams.new()
v_u_20.FilterType = Enum.RaycastFilterType.Exclude
v_u_20.RespectCanCollide = true
if not v_u_8:GetAttribute("DefaultCameraOffset") then
    v_u_8:SetAttribute("DefaultCameraOffset", Vector3.new(0, -0.15, 0))
end
if not v_u_8:GetAttribute("CrouchCameraOffset") then
    v_u_8:SetAttribute("CrouchCameraOffset", Vector3.new(0, -1.4, 0))
end
local v_u_21 = {
    ["SSG 08"] = 13.6,
    ["SG 553"] = 12,
    ["AWP"] = 8,
    ["AUG"] = 12,
    ["SCAR-20"] = 8,
    ["G3SG1"] = 8
}
local function v_u_36(p22, p23, p24)
    local v25 = p22:Dot(p23) * p24
    if v25 >= 0 then
        return p22
    end
    local v26 = p22 - p23 * v25
    local v27 = v26.X
    if math.abs(v27) < 0.1 then
        local v28 = v26.Y
        local v29 = v26.Z
        v26 = Vector3.new(0, v28, v29)
    end
    local v30 = v26.Y
    if math.abs(v30) < 0.1 then
        local v31 = v26.X
        local v32 = v26.Z
        v26 = Vector3.new(v31, 0, v32)
    end
    local v33 = v26.Z
    if math.abs(v33) < 0.1 then
        local v34 = v26.X
        local v35 = v26.Y
        v26 = Vector3.new(v34, v35, 0)
    end
    return v26
end
function v_u_1.GetMaxSpeed(p37)
    if v_u_15.GetState() == "Buy Period" then
        return 0
    elseif v_u_8:GetAttribute("IsDefusingBomb") then
        return 0
    elseif v_u_8:GetAttribute("IsRescuingHostage") then
        return 0
    else
        local v38 = v_u_8:GetAttribute("IsCarryingHostage") and 0.75 or 1
        local v39 = v_u_14.getCurrentEquipped()
        if v39 and (v39.Properties.Class == "C4" and v39.IsPlanting) then
            return 0
        else
            local v40 = not (v39 and (v39.Properties and v39.Properties.WalkSpeed)) and 20 or v39.Properties.WalkSpeed
            local v41 = v39 and (v39.IsAiming and v_u_21[v39.Name])
            if v41 then
                local v42 = p37.IsClimbing and 0.5 or 1
                local v43 = p37.IsWalking and 0.52 or 1
                local v44 = p37.IsCrouching and not p37.IsJumping and 0.34 or 1
                return v41 * v43 * v42 * v44
            else
                local v45 = p37.IsCrouching and not p37.IsJumping and 0.34 or (p37.IsWalking and 0.52 or 1)
                local v46 = p37.IsClimbing and 0.5 or 1
                if p37.CanceledInertia then
                    v40 = 2.424
                elseif p37.IsJumping and not (p37.IsAirStrafing or p37.CanceledInertia) then
                    local v47 = p37.LocalVelocityOnJump.Magnitude
                    v40 = math.max(v47, 2.424)
                end
                return v40 * v45 * v46 * v38
            end
        end
    end
end
function v_u_1.ValidateHumanoidRootPart(p48)
    local v49 = p48.HumanoidRootPart
    if v49 and (v49.Parent and v49:IsDescendantOf(workspace)) then
        return v49
    else
        return nil
    end
end
function v_u_1.TakeStamina(p50, p51)
    local v52 = p50.Stamina - p51
    p50.Stamina = math.clamp(v52, 0, 100)
end
function v_u_1.ApplyFriction(p53, p54)
    if p53.IsJumping then
        return
    else
        local v55 = p53.GlobalVelocity.Magnitude
        if v55 >= 0.001 then
            local v56
            if p53.GlobalDirection.Magnitude < 0.1 then
                v56 = math.max(v55, 5)
            else
                v56 = v55
            end
            local v57 = v55 - v56 * 6 * p54
            local v58 = math.max(v57, 0)
            if v58 ~= v55 then
                if v58 == 0 then
                    p53.GlobalVelocity = Vector3.new(0, 0, 0)
                    return
                end
                p53.GlobalVelocity = p53.GlobalVelocity.Unit * v58
            end
        end
    end
end
function v_u_1.Accelerate(p59, p60, p61, p62, p63)
    local v64 = p61 - p59.GlobalVelocity:Dot(p60)
    if v64 > 0 then
        local v65 = p62 * p63 * p61
        local v66 = math.min(v65, v64)
        p59.GlobalVelocity = p59.GlobalVelocity + p60 * v66
    end
end
function v_u_1.AirAccelerate(p67, p68, p69, p70)
    local v71 = math.min(p69, 2.5)
    local v72 = v71 - p67.GlobalVelocity:Dot(p68)
    if v72 > 0 then
        local v73 = v71 * 100 * p70
        if v72 >= v73 then
            v72 = v73
        end
        p67.GlobalVelocity = p67.GlobalVelocity + p68 * v72
    end
end
function v_u_1.CheckGroundContact(p74)
    if not p74.HumanoidRootPart then
        return false, nil, nil
    end
    local v75 = RaycastParams.new()
    v75.FilterType = Enum.RaycastFilterType.Exclude
    v75.FilterDescendantsInstances = { p74.Character, v_u_10, v_u_9 }
    v75.RespectCanCollide = true
    local v76 = p74.Player:GetAttribute("Team")
    if v76 then
        v75.CollisionGroup = v76
    end
    local v77 = p74.HumanoidRootPart.Position
    for _, v78 in ipairs({
        Vector3.new(0, 0, 0),
        Vector3.new(0.8, 0, 0),
        Vector3.new(-0.8, 0, 0),
        Vector3.new(0, 0, 0.8),
        Vector3.new(0, 0, -0.8)
    }) do
        local v79 = v77 + v78
        local v80 = workspace:Raycast(v79, Vector3.new(0, -3.1, 0), v75)
        if v80 and (v80.Normal.Y > 0.7 and v80.Instance.CanCollide) then
            return true, v80.Instance, v80.Normal
        end
    end
    return false, nil, nil
end
function v_u_1.SetTargetMoveDirection(p81, p82)
    if not p82:FuzzyEq(p81.TargetMoveDirection, 0.001) then
        p81.TargetMoveDirection = p82
        p81.MoveDirectionChanged:Fire(p82)
    end
end
function v_u_1.Jump(p83)
    if v_u_15.GetState() == "Buy Period" then
        return
    elseif v_u_8:GetAttribute("IsDefusingBomb") then
        return
    else
        local v84 = v_u_14.getCurrentEquipped()
        if v84 and (v84.Properties.Class == "C4" and v84.IsPlanting) then
            return
        elseif p83.Character and (p83.Humanoid and p83.HumanoidRootPart) then
            local v85 = tick() - p83.LastJumpTick
            local v86 = tick() - p83.LastLandTick <= 0.5
            if v85 < 0.15 and (p83.LastJumpTick > 0 and (not v86 or (p83.LastAirTime or 0) < 0.15)) then
                p83.IsJumpRequested = false
                return
            else
                if not p83.IsClimbing then
                    local v87 = p83.Humanoid:GetState()
                    if v87 == Enum.HumanoidStateType.Freefall or v87 == Enum.HumanoidStateType.Jumping then
                        p83.IsJumpRequested = false
                        return
                    end
                end
                local v88 = p83.HumanoidRootPart
                if p83.IsClimbing and (p83.IsJumpRequested and not p83.JumpedOffLadder) then
                    p83.LastLadderJumpTick = tick()
                    p83.JumpedOffLadder = true
                    local v89 = Vector3.new(0, 0, 1)
                    local v90 = p83.LadderZone
                    if v90 then
                        local v91 = p83:GetLadderCFrame(v90)
                        if v91 then
                            local v92 = v88.Position
                            local v93 = v91.Position
                            local v94 = v93.X - v92.X
                            local v95 = v93.Z - v92.Z
                            local v96 = Vector3.new(v94, 0, v95)
                            if v96.Magnitude > 0.1 then
                                v89 = -v96.Unit
                            end
                        end
                    end
                    local v97 = p83.LadderClimbPercentage or 0.5
                    local v98 = -1 - v97 * 2
                    local v99 = v89.X * 12
                    local v100 = v89.Z * 12
                    local v101 = Vector3.new(v99, v98, v100)
                    print("[Ladder Debug] Jumping off ladder", "climb%:", string.format("%.2f", v97), "jumpVel:", v101)
                    p83.ClimbEnded:Fire(p83.LadderZone, true)
                    local v102
                    if v101 == v101 then
                        v102 = v101.Magnitude < 10000
                    else
                        v102 = false
                    end
                    if v102 then
                        v88.AssemblyLinearVelocity = v101
                        local v103 = v101.X
                        local v104 = v101.Z
                        p83.GlobalVelocity = Vector3.new(v103, 0, v104)
                    end
                    p83.ReadyToJump = false
                    p83.Humanoid:ChangeState(Enum.HumanoidStateType.Freefall)
                elseif not p83.IsClimbing and (not p83.IsJumping and (p83.IsJumpRequested and p83.Stamina >= 20)) then
                    p83.Humanoid.JumpPower = 19.5
                    if p83.AgainstWall then
                        p83.GlobalVelocity = Vector3.new(0, 0, 0)
                    end
                    local v105 = p83.HumanoidRootPart.AssemblyLinearVelocity.X
                    local v106 = p83.HumanoidRootPart.AssemblyLinearVelocity.Z
                    local v107 = Vector3.new(v105, 0, v106)
                    local v108 = p83.Humanoid.MoveDirection
                    if v107.Magnitude < 1 and v108.Magnitude > 0.1 then
                        local v109 = RaycastParams.new()
                        v109.FilterType = Enum.RaycastFilterType.Exclude
                        v109.FilterDescendantsInstances = { p83.Character }
                        local v110 = workspace:Raycast(p83.HumanoidRootPart.Position, v108 * 2, v109)
                        if v110 then
                            local v111 = v110.Normal.Y
                            if math.abs(v111) < 0.5 then
                                local v112 = v110.Normal.X
                                local v113 = v110.Normal.Z
                                local v114 = Vector3.new(v112, 0, v113).Unit * 400
                                local v115 = p83.HumanoidRootPart
                                local v116 = v114.X
                                local v117 = p83.HumanoidRootPart.AssemblyLinearVelocity.Y
                                local v118 = v114.Z
                                v115:ApplyImpulse((Vector3.new(v116, v117, v118)))
                            end
                        end
                    end
                    if p83.HumanoidRootPart.AssemblyLinearVelocity.Y > 5 then
                        local v119 = p83.HumanoidRootPart.AssemblyLinearVelocity
                        local v120 = p83.HumanoidRootPart
                        local v121 = v119.X
                        local v122 = v119.Z
                        v120.AssemblyLinearVelocity = Vector3.new(v121, 0, v122)
                    end
                    p83.Humanoid.Jump = true
                    p83.IsJumping = true
                    p83.LastJumpTick = tick()
                    p83.ReadyToJump = false
                    p83.IsJumpRequested = false
                    p83.Jumping:Fire()
                    p83.CharacterAnimator:play("Jump", 0.2)
                end
            end
        else
            return
        end
    end
end
function v_u_1.AddLadder(p123, p124)
    if not p123.LadderZones[p124] then
        p124.Anchored = true
        p124.CollisionGroup = "Debris"
        p124.CastShadow = false
        p124.CanCollide = false
        p124.CanTouch = false
        p124.Transparency = 1
        p123.LadderZones[p124] = {
            ["CFrame"] = p124.CFrame,
            ["Extents"] = p124.Size / 2,
            ["Part"] = p124
        }
    end
end
function v_u_1.RemoveLadder(p125, p126)
    p125.LadderZones[p126] = nil
end
function v_u_1.GetLadderCFrame(_, p127)
    if p127.Part and p127.Part.Parent then
        return p127.Part.CFrame
    else
        return nil
    end
end
function v_u_1.ForceExitLadder(p128, p129)
    if p128.IsClimbing then
        print("[Ladder Debug] ForceExitLadder reason:", p129 or "unknown")
        p128.VectorForce.Enabled = false
        p128.IsClimbing = false
        p128.LadderZone = nil
        p128.LadderClimbPercentage = 0
        p128.LastLadderJumpTick = tick()
        if p128.Humanoid then
            p128.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Climbing, false)
        end
        p128.Climbing:Fire()
    end
end
function v_u_1.GetLadderClimbPercentage(p130, p131)
    local v132 = p130:ValidateHumanoidRootPart()
    if not v132 then
        return 0
    end
    local v133 = p130:GetLadderCFrame(p131)
    if not v133 then
        return 0
    end
    local v134 = p131.Extents.Y * 2
    if v134 <= 0 then
        warn("[Character] Invalid ladder height:", v134)
        return 0.5
    end
    local v135 = v133.Position
    local v136 = p131.Extents.Y
    local v137 = v135 - Vector3.new(0, v136, 0)
    local v138 = v132.Position
    if v138 ~= v138 or v137 ~= v137 then
        warn("[Character] Invalid positions in climb calculation")
        return 0.5
    end
    local v139 = (v138.Y - v137.Y) / v134
    local v140 = math.clamp(v139, 0, 1)
    return v140 ~= v140 and 0.5 or v140
end
function v_u_1.CheckLadderOverlap(p141, p142)
    local v143 = p141:ValidateHumanoidRootPart()
    if v143 then
        local v144 = p141:GetLadderCFrame(p142)
        if v144 then
            local v145 = v143.Position
            local v146 = p142.Extents
            local v147 = v144:Inverse() * v145
            local v148 = v147.X
            local v149 = math.abs(v148)
            local v150 = v147.Z
            local v151 = math.abs(v150)
            local v152 = v147.Y >= v146.Y - 1
            local v153 = p141.Character:FindFirstChildOfClass("Humanoid")
            if v153 then
                v153 = v153.FloorMaterial ~= Enum.Material.Air
            end
            if v152 and v153 then
                return false
            else
                local v154
                if v146.X > v146.Z then
                    if v146.Z * 0.5 <= v151 then
                        v154 = v151 <= v146.Z + 2
                    else
                        v154 = false
                    end
                elseif v146.X * 0.5 <= v149 then
                    v154 = v149 <= v146.X + 2
                else
                    v154 = false
                end
                if v147.Y <= v146.Y + 0.8 + (v154 and 3 or 0.5) and v147.Y >= -(v146.Y + 0.8 + 3) then
                    if v146.X > v146.Z then
                        if v146.X + 0.8 < v149 then
                            return false
                        elseif v146.X < v149 and v151 < v146.Z * 2 then
                            return false
                        else
                            return v151 <= v146.Z + 2
                        end
                    elseif v146.Z + 0.8 < v151 then
                        return false
                    elseif v146.Z < v151 and v149 < v146.X * 2 then
                        return false
                    else
                        return v149 <= v146.X + 2
                    end
                else
                    return false
                end
            end
        else
            return false
        end
    else
        return false
    end
end
function v_u_1.FindNearestLadder(p155)
    local v156 = p155:ValidateHumanoidRootPart()
    if not v156 then
        return nil
    end
    local v157 = v156.Position
    local v158 = 0
    local v159 = (1 / 0)
    local v160 = nil
    for _, v161 in pairs(p155.LadderZones) do
        v158 = v158 + 1
        local v162 = p155:GetLadderCFrame(v161)
        if v162 then
            local v163 = v157.X - v162.Position.X
            local v164 = v157.Z - v162.Position.Z
            local v165 = Vector3.new(v163, 0, v164).Magnitude
            if v165 <= 2 and (p155:CheckLadderOverlap(v161) and v165 < v159) then
                v160 = v161
                v159 = v165
            end
        end
    end
    local _ = v158 == 0
    return v160
end
function v_u_1.MoveFunction(p166, p167, p168)
    if p166.MaxSpeed == 0 then
        return
    end
    local v169 = p166:ValidateHumanoidRootPart()
    if not v169 then
        if p166.IsClimbing then
            p166:ForceExitLadder("Invalid HumanoidRootPart at MoveFunction start")
        end
        return
    end
    local v170 = tick()
    local v171 = v170 - p166.LastMoveUpdate
    local v172 = p166:GetMaxSpeed()
    p166.GlobalDirection = Vector3.new(0, 0, 0)
    local v173 = Vector3.new(0, 0, 0)
    local v174, _, _ = p166:CheckGroundContact()
    if v174 and (p166.Humanoid:GetState() == Enum.HumanoidStateType.Freefall and v169.AssemblyLinearVelocity.Y <= 1) then
        local v175 = v169.AssemblyLinearVelocity
        local v176 = v175.X
        local v177 = v175.Z
        local v178 = Vector3.new(v176, 0, v177)
        local v179
        if v178 == v178 then
            v179 = v178.Magnitude < 10000
        else
            v179 = false
        end
        if v179 then
            v169.AssemblyLinearVelocity = v178
        end
        p166.Humanoid:ChangeState(Enum.HumanoidStateType.Running)
        p166.IsJumping = false
        p166.IsLanded = true
        p166.ReadyToJump = true
        p166.LockedAirDirection = nil
    end
    local v180 = tick() - p166.LastJumpTick
    if p166.IsJumping and (v174 and v180 >= 0.15) then
        local v181 = v169.AssemblyLinearVelocity.Y
        if v181 <= 1 then
            p166.LastAirTime = tick() - (p166.LastFreefallTick or p166.LastJumpTick)
            p166.LandingVelocityY = p166.PeakFallVelocity or v181
            p166.IsJumping = false
            p166.IsLanded = true
            p166.LandAtPosition = v169.CFrame.Position
            p166.LastLandTick = tick()
            p166.ReadyToJump = true
            p166.LockedAirDirection = nil
            p166.CharacterAnimator:stop("Jump", 0.2)
            p166.Landed:Fire()
        end
    end
    local v182 = p166.Humanoid:GetState()
    if v182 == Enum.HumanoidStateType.Freefall and true or v182 == Enum.HumanoidStateType.Jumping then
        if not p166.LastFreefallTick then
            p166.LastFreefallTick = tick()
            p166.PeakFallVelocity = 0
        end
        local v183 = v169.AssemblyLinearVelocity.Y
        if v183 < (p166.PeakFallVelocity or 0) then
            p166.PeakFallVelocity = v183
        end
    end
    local v184 = v_u_10.CFrame
    local v185 = v184.Position
    local v186, v187, v188 = v184:ToEulerAnglesXYZ()
    local v189 = CFrame.new(v185) * CFrame.fromEulerAnglesXYZ(v186, v187, v188)
    if p167.Magnitude > 0 then
        if p168 then
            p166.GlobalDirection = v189:VectorToWorldSpace(p167)
        else
            p166.GlobalDirection = p167
            p167 = v189:VectorToObjectSpace(p167)
        end
    else
        p167 = v173
    end
    local v190 = v189.LookVector.X
    local v191 = v189.LookVector.Z
    local v192 = Vector3.new(v190, 0, v191)
    local v193 = p166.LastCameraCFrame.LookVector.X
    local v194 = p166.LastCameraCFrame.LookVector.Z
    local v195 = Vector3.new(v193, 0, v194):Cross(v192).Y
    p166.LocalVelocity = v189:VectorToObjectSpace(p166.GlobalVelocity)
    local v196 = p166.LocalVelocity:Angle(p167, Vector3.new(0, 1, 0))
    local _ = v196 == v196
    v192.Unit:Angle(p166.GlobalDirection, Vector3.new(0, 1, 0))
    local v197 = p166.GlobalDirection:Angle(p166.GlobalVelocity, Vector3.new(0, 1, 0))
    math.abs(v197)
    local v198 = p167.X
    local v199 = math.abs(v198) > 0.1
    local v200 = p167.Z <= 0
    local v201 = math.abs(v195) > 0.02
    local v202 = p167.X
    local v203 = math.sign(v202)
    local v204 = math.sign(v195)
    local v205 = p166.IsJumping
    if v205 then
        if v199 then
            if v200 then
                if v201 then
                    v201 = v203 == -v204
                end
            else
                v201 = v200
            end
        else
            v201 = v199
        end
    else
        v201 = v205
    end
    p166.IsAirStrafing = v201
    local v206
    if p166.GlobalDirection.Magnitude > 0 then
        v206 = p166.GlobalDirection.Unit
    else
        v172 = 0
        v206 = Vector3.new(0, 0, 0)
    end
    if p166.IsJumping then
        local v207 = v169.AssemblyLinearVelocity
        local v208 = v207.X
        local v209 = v207.Z
        p166.GlobalVelocity = Vector3.new(v208, 0, v209)
        if v172 > 0 then
            p166:AirAccelerate(v206, v172, v171)
        end
        if p166.IsAirStrafing then
            local v210 = p166.GlobalVelocity.Magnitude
            if v210 > 0.1 then
                local v211 = v192.X
                local v212 = v192.Z
                local v213 = Vector3.new(v211, 0, v212)
                if v213.Magnitude > 0 then
                    local v214 = v213.Unit
                    local v215 = p166.GlobalVelocity.Unit
                    local v216 = 5 * v171 * 10
                    local v217 = math.min(1, v216)
                    local v218 = v215 + (v214 - v215) * v217
                    if v218.Magnitude > 0 then
                        p166.GlobalVelocity = v218.Unit * v210
                    end
                end
            end
        end
        local v219 = p166.GlobalVelocity.Magnitude
        if v219 > 24.5 then
            local v220 = 24.5 / v219
            p166.GlobalVelocity = p166.GlobalVelocity * v220
        end
        local v221 = p166.GlobalVelocity.X
        local v222 = v207.Y
        local v223 = p166.GlobalVelocity.Z
        local v224 = Vector3.new(v221, v222, v223)
        local v225
        if v224 == v224 then
            v225 = v224.Magnitude < 10000
        else
            v225 = false
        end
        if v225 then
            v169.AssemblyLinearVelocity = v224
        end
    else
        local v226
        if tick() - p166.LastLandTick < 0.5 then
            v226 = p166.IsJumpRequested
        else
            v226 = false
        end
        if not v226 then
            p166:ApplyFriction(v171)
        end
        if v172 > 0 then
            p166:Accelerate(v206, math.min(v172, 24.5), 6, v171)
        end
    end
    local v227 = p166.GlobalVelocity.X
    local v228 = p166.GlobalVelocity.Z
    local v229 = Vector3.new(v227, 0, v228).Magnitude
    local _ = p166.IsJumping or p166.IsBhopAttempt
    local v230 = 24.5
    if v230 < v229 then
        local v231 = v230 / v229
        local v232 = p166.GlobalVelocity.X * v231
        local v233 = p166.GlobalVelocity.Y
        local v234 = p166.GlobalVelocity.Z * v231
        p166.GlobalVelocity = Vector3.new(v232, v233, v234)
    end
    p166.Humanoid.WalkSpeed = p166.LocalVelocity.Magnitude
    v_u_20.FilterDescendantsInstances = { p166.Character, v_u_10, v_u_9 }
    local v235 = p166.Player:GetAttribute("Team")
    if v235 then
        v_u_20.CollisionGroup = v235
    end
    p166.AgainstWall = false
    p166.WallNormal = nil
    if p166.IsJumping then
        local v236 = v169.AssemblyLinearVelocity
        local v237 = v236.X
        local v238 = v236.Z
        local v239 = Vector3.new(v237, 0, v238)
        local v240 = v239.Magnitude
        local v241 = v169.Position
        local v242 = tick()
        if p166.LastWallNormal and v242 - p166.LastWallHitTime < 0.15 then
            local v243 = p166.LastWallNormal
            local v244 = v243.X
            local v245 = v243.Z
            local v246 = v239:Dot((Vector3.new(v244, 0, v245)))
            if v246 > 0.5 then
                local v247 = v243.X
                local v248 = v243.Z
                v236 = v236 - Vector3.new(v247, 0, v248) * v246
                local v249
                if v236 == v236 then
                    v249 = v236.Magnitude < 10000
                else
                    v249 = false
                end
                if v249 then
                    v169.AssemblyLinearVelocity = v236
                end
                local v250 = v236.X
                local v251 = v236.Z
                v239 = Vector3.new(v250, 0, v251)
                v240 = v239.Magnitude
            end
        end
        local v252 = { Vector3.new(0, 0, 0), v169.CFrame.RightVector * 1 * 0.8, -v169.CFrame.RightVector * 1 * 0.8 }
        local v253 = {}
        if v240 > 0.5 then
            local v254 = v239.Unit
            table.insert(v253, v254)
        end
        local v255 = p166.GlobalDirection.X
        local v256 = p166.GlobalDirection.Z
        local v257 = Vector3.new(v255, 0, v256)
        if v257.Magnitude > 0.1 then
            local v258 = v257.Unit
            table.insert(v253, v258)
        end
        for _, v259 in ipairs(v253) do
            for _, v260 in ipairs(v252) do
                local v261 = v241 + v260
                local v262 = v259 * (0.5 + (v240 > 0.5 and (v240 * 0.02 or 0.3) or 0.3))
                local v263 = workspace:Raycast(v261, v262, v_u_20)
                if v263 then
                    local v264 = v263.Normal
                    local v265 = v264.Y
                    if math.abs(v265) < 0.7 then
                        p166.AgainstWall = true
                        p166.WallNormal = v264
                        p166.LastWallNormal = v264
                        p166.LastWallHitTime = v242
                        local v266 = v_u_36(v236, v264, 1)
                        local v267 = v266.X
                        local v268 = v266.Z
                        local v269 = Vector3.new(v267, 0, v268)
                        if v269.Magnitude < v240 * 0.3 then
                            local v270 = v236.Y
                            v266 = Vector3.new(0, v270, 0)
                            p166.GlobalVelocity = Vector3.new(0, 0, 0)
                        else
                            p166.GlobalVelocity = v269
                        end
                        local v271
                        if v266 == v266 then
                            v271 = v266.Magnitude < 10000
                        else
                            v271 = false
                        end
                        if v271 then
                            v169.AssemblyLinearVelocity = v266
                        end
                        break
                    end
                end
            end
            if p166.AgainstWall then
                break
            end
        end
    end
    if v169 and (p166.IsCrouching and not p166.CrouchInputDown) then
        p166.CrouchHeadBlocked = workspace:Spherecast(v169.CFrame.Position, 1.5, Vector3.new(0, 1, 0), v_u_20) ~= nil
    end
    if v169 then
        if p166.IsClimbing then
            local v272 = p166.LadderZone
            if v272 then
                local v273 = p166:GetLadderCFrame(v272)
                if not v273 then
                    p166:ForceExitLadder("Ladder part removed")
                    return
                end
                local v274 = v169.Position
                local v275 = v274.Y - 2.5
                local v276 = v273.Position
                local v277 = v276.Y - v272.Extents.Y
                local v278 = v276.Y + v272.Extents.Y
                local v279 = v278 - v277
                local v280 = (v275 - v277) / v279
                local v281 = math.clamp(v280, 0, 1)
                p166.LadderClimbPercentage = v281
                local v282 = v274.X - v276.X
                local v283 = v274.Z - v276.Z
                local v284 = Vector3.new(v282, 0, v283).Magnitude
                if v284 > 50 then
                    print("[Ladder Debug] Sanity check failed - distance:", string.format("%.2f", v284))
                    p166:ForceExitLadder("Distance sanity check failed")
                    return
                end
                local v285 = v281 <= 0.15
                local v286 = v281 >= 0.98
                local v287 = v284 > 2.5
                local v288 = p166.GlobalDirection
                local v289 = v288.X
                local v290 = v288.Z
                local v291 = Vector3.new(v289, 0, v290)
                if v291.Magnitude > 0.1 then
                    v291 = v291.Unit
                end
                local v292 = v189.LookVector.X
                local v293 = v189.LookVector.Z
                local v294 = Vector3.new(v292, 0, v293)
                if v294.Magnitude > 0 then
                    v294 = v294.Unit
                end
                local v295 = v291:Dot(v294)
                local v296 = v276.X - v274.X
                local v297 = v276.Z - v274.Z
                local v298 = Vector3.new(v296, 0, v297)
                if v298.Magnitude > 0.1 and v294:Dot(v298.Unit) <= 0 then
                    v295 = -v295
                end
                local v299 = v295 > 0.1
                local v300 = v295 < -0.1
                local v301 = tick() - (p166.LastLadderAttachTick or 0) >= 0.1
                if v287 then
                    v301 = v287
                elseif not (v285 and (v300 and v301)) then
                    if v286 then
                        if not v299 then
                            v301 = v299
                        end
                    else
                        v301 = v286
                    end
                end
                if v278 + 0.5 <= v275 and true or v301 then
                    print("[Ladder Debug] Detaching", "reason:", v287 and "TooFar" or (v285 and v300 and "BottomExit" or (v286 and v299 and "TopExit" or "FeetAboveTop")), "climb%:", string.format("%.2f", v281), "dist:", string.format("%.2f", v284), "verticalInput:", string.format("%.2f", v295))
                    if v286 and v299 then
                        local v302 = v294 * 8
                        local v303 = v302.X
                        local v304 = v302.Z
                        local v305 = Vector3.new(v303, 2, v304)
                        local v306
                        if v305 == v305 then
                            v306 = v305.Magnitude < 10000
                        else
                            v306 = false
                        end
                        if v306 then
                            v169.AssemblyLinearVelocity = v305
                            p166.GlobalVelocity = v302
                        end
                    end
                    p166.ClimbEnded:Fire(v272, false)
                end
            end
        else
            local v307 = tick() - (p166.LastLadderJumpTick or 0) > (p166.JumpedOffLadder and 0.5 or 0.25) and p166:FindNearestLadder()
            if v307 then
                p166.ClimbBegan:Fire(v307)
            end
        end
    end
    local v308 = Vector3.new(0, 0, 0)
    if p166.IsClimbing and not p166.JumpedOffLadder then
        local v309 = p166.LadderZone
        p166.GlobalVelocity = Vector3.new(0, 0, 0)
        if v309 and v169 then
            local v310 = p166.GlobalDirection
            local v311 = v310.X
            local v312 = v310.Z
            local v313 = Vector3.new(v311, 0, v312)
            local v314 = v189.LookVector.X
            local v315 = v189.LookVector.Z
            local v316 = Vector3.new(v314, 0, v315)
            local v317 = v189.RightVector.X
            local v318 = v189.RightVector.Z
            local v319 = Vector3.new(v317, 0, v318)
            if v313.Magnitude > 0.1 then
                v313 = v313.Unit
            end
            local v320 = v316.Magnitude <= 0 and Vector3.new(0, 0, -1) or v316.Unit
            if v319.Magnitude > 0 then
                v319 = v319.Unit
            end
            local v321 = p166.LadderClimbPercentage or 0
            local v322 = v321 >= 0.98
            local v323 = v321 <= 0.15
            local v324 = v313:Dot(v320)
            local v325 = v313:Dot(v319)
            local v326 = v310.Magnitude > 0.1
            local v327 = p166:GetLadderCFrame(v309)
            if not v327 then
                p166:ForceExitLadder("Ladder part removed during climb")
                return
            end
            local v328 = v169.Position
            local v329 = v327.Position
            local v330 = v329.X - v328.X
            local v331 = v329.Z - v328.Z
            local v332 = Vector3.new(v330, 0, v331)
            if v332.Magnitude > 0.1 and v320:Dot(v332.Unit) <= 0 then
                v324 = -v324
            end
            local v333 = tick() - (p166.LastLadderAttachTick or 0) >= 0.1
            if v322 and (v324 > 0.1 and v333) then
                print("[Ladder Debug] Auto-detach at top", "climb%:", string.format("%.2f", v321), "verticalInput:", string.format("%.2f", v324))
                local v334 = v320 * 8
                local v335 = v334.X
                local v336 = v334.Z
                local v337 = Vector3.new(v335, 2, v336)
                local v338
                if v337 == v337 then
                    v338 = v337.Magnitude < 10000
                else
                    v338 = false
                end
                if v338 then
                    v169.AssemblyLinearVelocity = v337
                    p166.GlobalVelocity = v334
                end
                p166.ClimbEnded:Fire(v309, false)
                return
            end
            if v323 and (v324 < -0.1 and v333) then
                print("[Ladder Debug] Auto-detach at bottom", "climb%:", string.format("%.2f", v321), "verticalInput:", string.format("%.2f", v324))
                p166.ClimbEnded:Fire(v309, false)
                return
            end
            if v326 then
                if math.abs(v324) > 0.1 then
                    local v339 = 14 * v324
                    if math.abs(v325) > 0.1 then
                        v339 = v339 * 1.15
                    end
                    v308 = Vector3.new(0, v339, 0)
                end
                if math.abs(v325) > 0.1 then
                    local v340 = p166:GetLadderCFrame(v309)
                    if not v340 then
                        p166:ForceExitLadder("Ladder part removed during strafe")
                        return
                    end
                    local v341 = v340.RightVector
                    local v342 = v340:VectorToObjectSpace(v328 - v329).X
                    local v343 = v309.Extents.X * 0.8
                    local v344 = v342 + v325 * 0.5
                    if math.abs(v344) < v343 then
                        v308 = v308 + v341 * (5.6000000000000005 * v325)
                    end
                end
            end
        end
        local v345 = v169 and p166.Character.PrimaryPart
        if v345 then
            local v346
            if v308 == v308 then
                v346 = v308.Magnitude < 10000
            else
                v346 = false
            end
            if v346 then
                v345.AssemblyLinearVelocity = v308
            end
        end
    end
    local v347 = not v_u_19.activeController:GetIsJumping() and v_u_19.touchJumpController
    if v347 then
        v347 = v_u_19.touchJumpController:GetIsJumping()
    end
    if v347 and not (p166.IsJumping or p166.IsJumpRequested) then
        p166.IsJumpRequested = true
    elseif not v347 then
        p166.IsJumpRequested = false
    end
    p166:Jump()
    p166.LastCameraCFrame = v189
    p166.Humanoid:MoveTo(p166.HumanoidRootPart.Position + p166.GlobalVelocity)
    p166.LastMoveUpdate = v170
end
function v_u_1.StopMovementAnimations(p348)
    local v349 = {}
    local v350 = v_u_11:FindFirstChild("Crouch")
    if v350 then
        for _, v351 in ipairs(v350:GetDescendants()) do
            if v351:IsA("Animation") then
                v349[v351.Name] = true
            end
        end
    end
    local v352 = v_u_11:FindFirstChild("Movement")
    if v352 then
        local v353 = v352:FindFirstChild("Walking")
        if v353 then
            for _, v354 in ipairs(v353:GetDescendants()) do
                if v354:IsA("Animation") then
                    v349[v354.Name] = true
                end
            end
        end
    end
    for v355, v356 in pairs(p348.CharacterAnimator.Animations) do
        if v355 ~= "Jump" and (v349[v355] and v356.IsPlaying) then
            p348.CharacterAnimator:stop(v355, 0.2)
        end
    end
end
function v_u_1.ToggleWalkState(p357, p358)
    if p358 ~= p357.IsWalking then
        p357.IsWalking = p358
        v_u_16.Character.UpdateWalkState.Send(p357.IsWalking)
        p357.Walking:Fire(p357.IsWalking)
    end
end
function v_u_1.ToggleCrouchInput(p359, p360)
    p359.CrouchInputDown = p360
end
function v_u_1.PlantBomb(p361)
    if not p361.IsPlantingBomb then
        p361.IsPlantingBomb = true
        if p361.BombPlantTween then
            p361.BombPlantTween:Cancel()
            p361.BombPlantTween = nil
        end
        p361.BombPlantTween = p361.Janitor:Add(v_u_4:Create(p361.Humanoid, TweenInfo.new(0.75, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
            ["CameraOffset"] = Vector3.new(0, -0.9, 0) + p361.DefaultCameraOffset
        }))
        p361.BombPlantTween:Play()
    end
end
function v_u_1.CancelBombPlant(p362)
    if p362.IsPlantingBomb then
        p362.IsPlantingBomb = false
        if p362.BombPlantTween then
            p362.BombPlantTween:Cancel()
            p362.BombPlantTween = nil
        end
        p362.Janitor:Add(v_u_4:Create(p362.Humanoid, TweenInfo.new(0.35, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
            ["CameraOffset"] = p362.DefaultCameraOffset
        })):Play()
    end
end
function v_u_1.ToggleCrouchState(p363, p364)
    local v365 = v_u_14.getCurrentEquipped()
    if v365 and (v365.Properties.Class == "C4" and v365.IsPlanting) then
        return
    elseif p364 ~= p363.IsCrouching then
        local v366 = tick()
        p363.IsCrouching = p364
        v_u_16.Character.UpdateCrouchState.Send(p363.IsCrouching)
        if p363.CrouchTween then
            p363.CrouchTween:Cancel()
            p363.CrouchTween = nil
        end
        if p363.IsCrouching then
            p363.CrouchCount = p363.CrouchCount + 1
            if v366 - p363.LastCrouchTick > 0.5 then
                p363.CrouchCount = 0
            end
            local v367 = p363.CrouchCount * 0.05 + 0.15
            local v368 = math.min(v367, 0.4)
            p363.LastCrouchTick = v366
            p363.CrouchTween = p363.Janitor:Add(v_u_4:Create(p363.Humanoid, TweenInfo.new(v368, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
                ["CameraOffset"] = p363.CrouchCameraOffset + p363.DefaultCameraOffset
            }))
            p363.CrouchTween:Play()
        else
            local v369 = p363.CrouchCount * 0.05 + 0.15
            local v370 = math.min(v369, 0.4)
            p363.CrouchTween = p363.Janitor:Add(v_u_4:Create(p363.Humanoid, TweenInfo.new(v370, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
                ["CameraOffset"] = p363.DefaultCameraOffset
            }))
            p363.CrouchTween:Play()
        end
        p363.LastCrouchTick = v366
        p363.Crouching:Fire(p363.IsCrouching)
    end
end
function v_u_1.UpdateCharacterAnimations(p371, _)
    if p371.IsJumping then
        p371.CurrentMovementAnimation = nil
        p371:StopMovementAnimations()
    else
        local v372 = p371.CharacterAnimator:getAnimation("CrouchIdle")
        local v373 = v_u_12(p371.Character)
        if p371.IsCrouching then
            if p371.Humanoid.MoveDirection.Magnitude <= 0.1 then
                if not v372.IsPlaying then
                    p371.CurrentMovementAnimation = nil
                    p371:StopMovementAnimations()
                    local v374 = p371.CharacterAnimator
                    local v375 = p371.CrouchCount * 0.05 + 0.15
                    v374:play("CrouchIdle", (math.min(v375, 0.4)))
                end
                return
            end
            v373 = ("Crouch%*"):format(v373)
            if v372.IsPlaying then
                local v376 = p371.CharacterAnimator
                local v377 = p371.CrouchCount * 0.05 + 0.15
                v376:stop("CrouchIdle", (math.min(v377, 0.4)))
            end
        elseif v372.IsPlaying then
            local v378 = p371.CharacterAnimator
            local v379 = p371.CrouchCount * 0.05 + 0.15
            v378:stop("CrouchIdle", (math.min(v379, 0.4)))
        end
        local v380 = p371.CharacterAnimator:getAnimation(v373)
        if v380 then
            v380:AdjustSpeed((p371.HumanoidRootPart.AssemblyLinearVelocity * Vector3.new(1, 0, 1)).Magnitude / (p371.IsCrouching and 12 or 16))
        end
        if p371.CurrentMovementAnimation ~= v373 then
            p371.CurrentMovementAnimation = v373
            p371:StopMovementAnimations()
            if v380 then
                v380:Play(0.15)
            end
        end
    end
end
function v_u_1.new(p_u_381, p382, p383)
    local v384 = v_u_1
    local v_u_385 = setmetatable({}, v384)
    v_u_385.Janitor = v_u_17.new()
    v_u_385.DefaultCameraOffset = v_u_8:GetAttribute("DefaultCameraOffset") or Vector3.new(0, -0.15, 0)
    v_u_385.CrouchCameraOffset = v_u_8:GetAttribute("CrouchCameraOffset") or Vector3.new(0, -1.4, 0)
    v_u_385.Janitor:Add(v_u_8:GetAttributeChangedSignal("DefaultCameraOffset"):Connect(function()
        v_u_385.DefaultCameraOffset = v_u_8:GetAttribute("DefaultCameraOffset") or Vector3.new(0, -0.15, 0)
    end))
    v_u_385.Janitor:Add(v_u_8:GetAttributeChangedSignal("CrouchCameraOffset"):Connect(function()
        v_u_385.CrouchCameraOffset = v_u_8:GetAttribute("CrouchCameraOffset") or Vector3.new(0, -1.4, 0)
    end))
    v_u_385.CharacterAnimator = v_u_13.new(p_u_381)
    v_u_385.HumanoidRootPart = p382
    v_u_385.Character = p_u_381
    v_u_385.Humanoid = p383
    v_u_385.Player = v_u_8
    v_u_385.Janitor:Add(p382.AncestryChanged:Connect(function(_, p386)
        if not p386 then
            if v_u_385.IsClimbing then
                v_u_385:ForceExitLadder("HumanoidRootPart removed")
            end
            v_u_385.HumanoidRootPart = nil
        end
    end))
    v_u_385.Humanoid.WalkSpeed = 20
    v_u_385.Humanoid.AutoRotate = false
    v_u_385.Humanoid.MaxSlopeAngle = 90
    if v_u_8:GetAttribute("SV_ACCELERATE") == nil then
        v_u_8:SetAttribute("SV_ACCELERATE", 6)
    end
    if v_u_8:GetAttribute("SV_STOPSPEED") == nil then
        v_u_8:SetAttribute("SV_STOPSPEED", 5)
    end
    if v_u_8:GetAttribute("SV_FRICTION") == nil then
        v_u_8:SetAttribute("SV_FRICTION", 6)
    end
    local function v_u_388(p387)
        if p387.Name == "CollisionCapsule" then
            p387.CanCollide = false
            return
        elseif p387.Name == "HumanoidRootPart" and p387:IsA("Part") then
            p387.CanCollide = true
            p387.Size = Vector3.new(2, 2, 2)
            p387.Shape = Enum.PartType.Ball
            p387.CustomPhysicalProperties = PhysicalProperties.new(0.7, 0.3, 0, 1, 1)
            return
        elseif p387.Name == "Head" then
            p387.CanCollide = true
            return
        elseif p387.Name == "UpperTorso" or p387.Name == "LowerTorso" then
            p387.CanCollide = false
        else
            p387.CanCollide = false
        end
    end
    for _, v389 in ipairs(p_u_381:GetDescendants()) do
        if v389:IsA("BasePart") then
            v_u_388(v389)
        end
    end
    v_u_385.Janitor:Add(p_u_381.DescendantAdded:Connect(function(p390)
        if p390:IsA("BasePart") then
            v_u_388(p390)
        end
    end))
    v_u_385.Humanoid.UseJumpPower = true
    v_u_385.Humanoid.JumpPower = 19.5
    v_u_385.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Landed, false)
    v_u_385.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Climbing, false)
    v_u_385.Humanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false)
    v_u_385.Humanoid:SetStateEnabled(Enum.HumanoidStateType.GettingUp, true)
    v_u_385.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, false)
    v_u_385.Humanoid:ChangeState(Enum.HumanoidStateType.Running)
    v_u_385.GlobalVelocity = Vector3.new(0, 0, 0)
    v_u_385.LocalVelocity = Vector3.new(0, 0, 0)
    v_u_385.LocalVelocityOnJump = Vector3.new(0, 0, 0)
    v_u_385.GlobalDirection = Vector3.new(0, 0, 0)
    v_u_385.LastCameraCFrame = CFrame.new()
    v_u_385.LastMoveUpdate = 0
    v_u_385.JumpCooldownActive = false
    v_u_385.ReadyToJump = false
    v_u_385.LastJumpTick = 0
    v_u_385.JumpCount = 0
    v_u_385.LastWallHitTick = 0
    v_u_385.WallJumpCooldown = false
    v_u_385.LockedAirDirection = nil
    v_u_385.LastAirDirectionChangeTick = 0
    v_u_385.LastLandTick = 0
    v_u_385.LastFreefallTick = nil
    v_u_385.LastAirTime = 0
    v_u_385.PeakFallVelocity = 0
    v_u_385.LandingVelocityY = nil
    v_u_385.LastCrouchTick = 0
    v_u_385.CrouchCount = 0
    v_u_385.CrouchHeadBlocked = false
    v_u_385.CrouchInputDown = false
    v_u_385.CurrentMovementAnimation = nil
    v_u_385.LadderZones = {}
    v_u_385.LadderPart = nil
    v_u_385.LadderZone = nil
    v_u_385.LadderClimbPercentage = 0
    v_u_385.LastLadderJumpTick = 0
    v_u_385.LastLadderAttachTick = 0
    local _, v391, _ = v_u_10.CFrame:ToEulerAnglesYXZ()
    v_u_385.CurrentYRotation = v391
    v_u_385.TargetYRotation = v391
    local v392 = p382:FindFirstChild("RootAttachment")
    if not v392 then
        warn("[Character] RootAttachment not found - creating one")
        v392 = Instance.new("Attachment")
        v392.Name = "RootAttachment"
        v392.Parent = p382
    end
    local v393 = p382.AssemblyMass
    if v393 ~= v393 or v393 <= 0 then
        warn("[Character] Invalid initial AssemblyMass:", v393, "- using fallback")
        v393 = 10
    end
    v_u_385.VectorForce = v_u_385.Janitor:Add(Instance.new("VectorForce"))
    local v394 = v_u_385.VectorForce
    local v395 = v393 * workspace.Gravity
    v394.Force = Vector3.new(0, v395, 0)
    v_u_385.VectorForce.RelativeTo = Enum.ActuatorRelativeTo.World
    v_u_385.VectorForce.Enabled = false
    v_u_385.VectorForce.ApplyAtCenterOfMass = false
    v_u_385.VectorForce.Attachment0 = v392
    v_u_385.VectorForce.Parent = p382
    v_u_385.AlignOrientation = v_u_385.Janitor:Add(Instance.new("AlignOrientation"))
    v_u_385.AlignOrientation.Mode = Enum.OrientationAlignmentMode.OneAttachment
    v_u_385.AlignOrientation.Attachment0 = p382:FindFirstChild("RootAttachment")
    v_u_385.AlignOrientation.RigidityEnabled = true
    v_u_385.AlignOrientation.MaxTorque = (1 / 0)
    v_u_385.AlignOrientation.Responsiveness = 200
    v_u_385.AlignOrientation.CFrame = CFrame.Angles(0, v_u_385.CurrentYRotation, 0)
    v_u_385.AlignOrientation.Parent = p382
    v_u_385.JumpedOffLadder = false
    v_u_385.IsPlantingBomb = false
    v_u_385.IsCrouching = false
    v_u_385.IsClimbing = false
    v_u_385.IsJumping = false
    v_u_385.IsWalking = false
    v_u_385.IsLanded = false
    v_u_385.IsBhopAttempt = false
    v_u_385.AgainstWall = false
    v_u_385.WallNormal = nil
    v_u_385.LastWallHitTime = 0
    v_u_385.LastWallNormal = nil
    v_u_385.Stamina = 100
    v_u_385.CurrentMoveDirection = Vector3.new(0, 0, 0)
    v_u_385.TargetMoveDirection = Vector3.new(0, 0, 0)
    v_u_385.MaxSpeed = 20
    v_u_385.LastLookAngle = 0
    v_u_385.LastVerticalLook = 0
    v_u_385.LastLookAngleUpdate = 0
    v_u_385.MoveDirectionChanged = v_u_385.Janitor:Add(v_u_18.new())
    v_u_385.Crouching = v_u_385.Janitor:Add(v_u_18.new())
    v_u_385.ClimbBegan = v_u_385.Janitor:Add(v_u_18.new())
    v_u_385.ClimbEnded = v_u_385.Janitor:Add(v_u_18.new())
    v_u_385.Climbing = v_u_385.Janitor:Add(v_u_18.new())
    v_u_385.Jumping = v_u_385.Janitor:Add(v_u_18.new())
    v_u_385.Walking = v_u_385.Janitor:Add(v_u_18.new())
    v_u_385.Landed = v_u_385.Janitor:Add(v_u_18.new())
    v_u_385.Janitor:Add(function()
        if v_u_385.CharacterAnimator then
            v_u_385.CharacterAnimator:destroy()
        end
    end)
    v_u_385.Janitor:Add(v_u_385.Humanoid.StateChanged:Connect(function(p396, p397)
        local v398 = p397 == Enum.HumanoidStateType.Jumping and true or p397 == Enum.HumanoidStateType.Freefall
        local v399
        if p396 == Enum.HumanoidStateType.Freefall then
            v399 = not v398
        else
            v399 = false
        end
        if p397 == Enum.HumanoidStateType.Freefall then
            v_u_385.LastFreefallTick = tick()
            v_u_385.PeakFallVelocity = 0
        end
        if v399 then
            v_u_385.LastAirTime = tick() - (v_u_385.LastFreefallTick or 0)
            local v400 = v_u_385.HumanoidRootPart and v_u_385.HumanoidRootPart.AssemblyLinearVelocity.Y or 0
            local v401 = v_u_385
            local v402 = v_u_385.PeakFallVelocity or 0
            v401.LandingVelocityY = math.min(v400, v402)
            v_u_385.IsJumping = false
            v_u_385.IsLanded = true
            v_u_385.LandAtPosition = v_u_385.HumanoidRootPart.CFrame.Position
            v_u_385.LastLandTick = tick()
            v_u_385.ReadyToJump = true
            v_u_385.LockedAirDirection = nil
            v_u_385.CharacterAnimator:stop("Jump", 0.2)
            v_u_385.Landed:Fire()
        end
    end))
    v_u_385.OriginalMoveFunction = v_u_19.moveFunction
    v_u_385.IsDestroyed = false
    local v_u_403 = setmetatable({
        ["instance"] = v_u_385
    }, {
        ["__mode"] = "v"
    })
    v_u_385._characterRef = v_u_403
    function v_u_19.moveFunction(_, ...)
        local v404 = v_u_403.instance
        if v404 and not v404.IsDestroyed then
            v404:MoveFunction(...)
        elseif v404 and v404.OriginalMoveFunction then
            v_u_19.moveFunction = v404.OriginalMoveFunction
        end
    end
    v_u_385.Janitor:Add(function()
        if v_u_403 then
            v_u_403.instance = nil
        end
        if not v_u_385.IsDestroyed then
            v_u_385.IsDestroyed = true
            if v_u_385.OriginalMoveFunction then
                v_u_19.moveFunction = v_u_385.OriginalMoveFunction
                v_u_385.OriginalMoveFunction = nil
            end
        end
    end, true, "MoveFunctionCleanup")
    v_u_385.Janitor:Add(v_u_385.Landed:Connect(function()
        local v405 = v_u_385.LandingVelocityY or v_u_385.HumanoidRootPart.AssemblyLinearVelocity.Y
        v_u_385.CanceledInertia = false
        v_u_385.IsCrouchJumping = false
        v_u_385.JumpedOffLadder = false
        if v_u_385.HumanoidRootPart then
            local v406 = v_u_385.HumanoidRootPart.AssemblyLinearVelocity
            local v407 = v406.X
            local v408 = v406.Z
            local v409 = Vector3.new(v407, 0, v408)
            local v410 = v409.Magnitude
            if v410 > 19 then
                local v411 = 1 - (0.1 + (v410 - 19) * 0.03)
                local v412 = v409 * math.max(0.4, v411)
                v_u_385.GlobalVelocity = v412
                local v413 = v_u_385.HumanoidRootPart
                local v414 = v412.X
                local v415 = v406.Y
                local v416 = v412.Z
                v413.AssemblyLinearVelocity = Vector3.new(v414, v415, v416)
            end
        end
        if v405 <= -42 then
            local v417 = v_u_385.LastFreefallTick or v_u_385.LastJumpTick
            if v_u_385.LastLandTick - v417 >= 0.3 then
                local v418 = v_u_16.Character.FallDamage.Send
                local v419 = (v405 - -42) / -35 * 100
                v418((math.abs(v419)))
                v_u_385:TakeStamina(100)
            end
        end
        v_u_385.LandingVelocityY = nil
        v_u_385.LastFreefallTick = nil
    end), "Disconnect")
    v_u_385.Janitor:Add(v_u_385.Jumping:Connect(function()
        v_u_385.LocalVelocityOnJump = v_u_10.CFrame:VectorToObjectSpace(v_u_385.GlobalVelocity)
        v_u_385.GlobalDirectionOnJump = v_u_385.GlobalDirection
        v_u_385.ReadyToJump = false
    end), "Disconnect")
    v_u_385.Janitor:Add(v_u_385.ClimbBegan:Connect(function(p420)
        if p420 and (p420.Part and p420.Part.Parent) then
            local v421 = v_u_385:GetLadderCFrame(p420)
            if v421 then
                local v422 = v421.Position
                if v422 == v422 then
                    local v423 = v422.X
                    if math.abs(v423) <= 50000 then
                        local v424 = v422.Y
                        if math.abs(v424) <= 50000 then
                            local v425 = v422.Z
                            if math.abs(v425) <= 50000 then
                                local v426 = v_u_385:ValidateHumanoidRootPart()
                                if v426 then
                                    local v427 = v426.Position
                                    if v427 == v427 then
                                        local v428 = v427.X
                                        if math.abs(v428) <= 50000 then
                                            local v429 = v427.Y
                                            if math.abs(v429) <= 50000 then
                                                local v430 = v427.Z
                                                if math.abs(v430) <= 50000 then
                                                    v_u_385.GlobalVelocity = Vector3.new(0, 0, 0)
                                                    local v431 = v426.AssemblyLinearVelocity
                                                    if v431 == v431 then
                                                        v426.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
                                                        v426.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
                                                    else
                                                        warn("[Ladder Debug] HRP velocity was already NaN before climbing! Attempting recovery...")
                                                        v426.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
                                                        v426.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
                                                    end
                                                    if v_u_385.VectorForce.Attachment0 and v_u_385.VectorForce.Attachment0.Parent then
                                                        local v432 = v426.AssemblyMass
                                                        if v432 ~= v432 or (v432 <= 0 or v432 > 10000) then
                                                            warn("[Ladder Debug] Invalid AssemblyMass:", v432, "- using fallback")
                                                            v432 = 10
                                                        end
                                                        local v433 = v432 * workspace.Gravity
                                                        local v434 = Vector3.new(0, v433, 0)
                                                        if v434 == v434 and v434.Magnitude <= 100000 then
                                                            v_u_385.VectorForce.Force = v434
                                                            task.defer(function()
                                                                if v_u_385.IsDestroyed or not v_u_385.IsClimbing then
                                                                    return
                                                                else
                                                                    local v435 = v_u_385:ValidateHumanoidRootPart()
                                                                    if v435 then
                                                                        local v436 = v435.Position
                                                                        if v436 == v436 then
                                                                            v_u_385.VectorForce.Enabled = true
                                                                        else
                                                                            warn("[Ladder Debug] Position became NaN during defer - aborting")
                                                                            v_u_385:ForceExitLadder("Position NaN during defer")
                                                                        end
                                                                    else
                                                                        v_u_385:ForceExitLadder("HRP invalid after defer")
                                                                        return
                                                                    end
                                                                end
                                                            end)
                                                            v_u_385.LadderZone = p420
                                                            v_u_385.IsClimbing = true
                                                            v_u_385.LastLadderAttachTick = tick()
                                                            v_u_385.LadderClimbPercentage = v_u_385:GetLadderClimbPercentage(p420)
                                                            v_u_385.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Climbing, true)
                                                            local v437 = v_u_385:GetLadderClimbPercentage(p420)
                                                            local v438 = p420.Part
                                                            print("[Ladder Debug] ClimbBegan", "part:", v438 and v438.Name or "nil", "pos:", v421 and v421.Position or "nil", "climb%:", string.format("%.2f", v437), "mass:", v432, "force:", v434)
                                                            v_u_385.IsJumping = false
                                                            v_u_385.IsJumpRequested = false
                                                            v_u_385.JumpedOffLadder = false
                                                            v_u_385.Climbing:Fire()
                                                        else
                                                            warn("[Ladder Debug] Invalid counter-gravity force:", v434, "- aborting climb")
                                                        end
                                                    else
                                                        warn("[Ladder Debug] VectorForce has no valid Attachment0 - aborting climb")
                                                        return
                                                    end
                                                end
                                            end
                                        end
                                    end
                                    warn("[Ladder Debug] ClimbBegan rejected - invalid player position:", v427)
                                else
                                    warn("[Ladder Debug] ClimbBegan rejected - no valid HumanoidRootPart")
                                end
                            end
                        end
                    end
                end
                warn("[Ladder Debug] ClimbBegan rejected - invalid ladder position:", v422)
            else
                warn("[Ladder Debug] ClimbBegan rejected - could not get ladder CFrame")
            end
        else
            warn("[Ladder Debug] ClimbBegan rejected - invalid ladder zone")
            return
        end
    end), "Disconnect")
    v_u_385.Janitor:Add(v_u_385.ClimbEnded:Connect(function(p439, p440)
        local v441 = v_u_385.LadderClimbPercentage or 0
        local v442
        if v_u_385.HumanoidRootPart then
            v442 = v_u_385.HumanoidRootPart.AssemblyLinearVelocity
        else
            v442 = nil
        end
        print("[Ladder Debug] ClimbEnded", p440 and "jumpedOff" or "walkedOff", "climb%:", string.format("%.2f", v441), "velocity:", v442, "ladder:", p439 and (p439.Part and p439.Part.Name) or "nil")
        v_u_385.VectorForce.Enabled = false
        v_u_385.IsClimbing = false
        v_u_385.LadderZone = nil
        v_u_385.LadderClimbPercentage = 0
        v_u_385.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Climbing, false)
        v_u_385.LastLadderJumpTick = tick()
        if p440 then
            v_u_385.JumpedOffLadder = true
        end
        v_u_385.Climbing:Fire()
    end), "Disconnect")
    v_u_385.Janitor:Add(v_u_5.Stepped:Connect(function(_, p443)
        if v_u_385.IsDestroyed then
            return
        end
        if v_u_385.HumanoidRootPart and v_u_385.HumanoidRootPart.Parent then
            local v444 = v_u_385.HumanoidRootPart.Position
            if v444 == v444 then
                local v445 = v444.X
                if math.abs(v445) <= 50000 then
                    local v446 = v444.Y
                    if math.abs(v446) <= 50000 then
                        local v447 = v444.Z
                        if math.abs(v447) > 50000 then
                            goto l7
                        end
                        goto l4
                    end
                end
            end
            ::l7::
            warn("[Character] Detected invalid HumanoidRootPart position:", v444, "- forcing ladder exit and resetting velocity")
            if v_u_385.IsClimbing then
                v_u_385:ForceExitLadder("Invalid position detected")
            end
            if (Vector3.new(0, 0, 0)).Magnitude < 10000 then
                v_u_385.HumanoidRootPart.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
                v_u_385.GlobalVelocity = Vector3.new(0, 0, 0)
            end
        else
            ::l4::
            v_u_385:UpdateCharacterAnimations(p443)
            if v_u_385.CrouchInputDown then
                v_u_385:ToggleCrouchState(true)
            elseif not v_u_385.CrouchHeadBlocked then
                v_u_385:ToggleCrouchState(false)
            end
            if not v_u_385.IsClimbing and v_u_385.Humanoid:GetState() == Enum.HumanoidStateType.Climbing then
                v_u_385.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Climbing, false)
                v_u_385.Humanoid:ChangeState(Enum.HumanoidStateType.Running)
            end
            if v_u_385.IsClimbing and v_u_385.LadderZone then
                v_u_385.LadderClimbPercentage = v_u_385:GetLadderClimbPercentage(v_u_385.LadderZone)
            end
            if v_u_385.Stamina < 100 then
                local v448 = v_u_385
                local v449 = v_u_385.Stamina + p443 * 100
                v448.Stamina = math.min(v449, 100)
            end
            local _, v450, _ = v_u_10.CFrame:ToEulerAnglesYXZ()
            v_u_385.TargetYRotation = v450
            local v451 = v_u_385.GlobalVelocity.X
            local v452 = v_u_385.GlobalVelocity.Z
            if (Vector3.new(v451, 0, v452).Magnitude > 0.1 or v_u_385.Humanoid.MoveDirection.Magnitude > 0.1) and true or v_u_385.IsClimbing then
                local v453 = v_u_385.TargetYRotation - v_u_385.CurrentYRotation
                if v453 == v453 and math.abs(v453) ~= (1 / 0) then
                    local v454 = 0
                    while v453 > 3.141592653589793 and v454 < 10 do
                        v453 = v453 - 6.283185307179586
                        v454 = v454 + 1
                    end
                    local v455 = 0
                    while v453 < -3.141592653589793 and v455 < 10 do
                        v453 = v453 + 6.283185307179586
                        v455 = v455 + 1
                    end
                else
                    warn("[Character] Detected invalid rotation values - resetting. TargetY:", v_u_385.TargetYRotation, "CurrentY:", v_u_385.CurrentYRotation)
                    v_u_385.CurrentYRotation = v450
                    v_u_385.TargetYRotation = v450
                    v453 = 0
                end
                local v456 = p443 * 20
                local v457 = math.min(1, v456)
                v_u_385.CurrentYRotation = v_u_385.CurrentYRotation + v453 * v457
                v_u_385.AlignOrientation.RigidityEnabled = true
                v_u_385.AlignOrientation.MaxTorque = (1 / 0)
                v_u_385.AlignOrientation.Enabled = true
            else
                if v450 ~= v450 or math.abs(v450) == (1 / 0) then
                    warn("[Character] Detected invalid camera rotation - skipping stationary rotation update")
                    return
                end
                v_u_385.CurrentYRotation = v_u_385.TargetYRotation
                v_u_385.AlignOrientation.Enabled = false
                if v_u_385.HumanoidRootPart and v_u_385.HumanoidRootPart.Parent then
                    local v458 = v_u_385.HumanoidRootPart.Position
                    if v458 == v458 then
                        local v459 = v458.X
                        if math.abs(v459) < 50000 then
                            local v460 = v458.Y
                            if math.abs(v460) < 50000 then
                                local v461 = v458.Z
                                if math.abs(v461) < 50000 then
                                    v_u_385.HumanoidRootPart.CFrame = CFrame.new(v458) * CFrame.Angles(0, v_u_385.CurrentYRotation, 0)
                                end
                            end
                        end
                    end
                end
            end
            if v_u_385.CurrentYRotation == v_u_385.CurrentYRotation then
                local v462 = v_u_385.CurrentYRotation
                if math.abs(v462) < 100 then
                    v_u_385.AlignOrientation.CFrame = CFrame.Angles(0, v_u_385.CurrentYRotation, 0)
                end
            end
            local v463 = tick()
            if v463 - v_u_385.LastLookAngleUpdate >= 0.05 then
                local v464 = v_u_10.CFrame.LookVector.Y
                local v465 = v450 - v_u_385.LastLookAngle
                local v466 = math.abs(v465)
                local v467 = v464 - v_u_385.LastVerticalLook
                local v468 = math.abs(v467)
                if v466 > 0.1 or v468 > 0.1 then
                    v_u_385.LastLookAngle = v450
                    v_u_385.LastVerticalLook = v464
                    v_u_385.LastLookAngleUpdate = v463
                    v_u_16.Character.UpdateLookAngle.Send({
                        ["HorizontalAngle"] = v450,
                        ["VerticalLook"] = v464
                    })
                end
            end
        end
    end))
    local v469 = v_u_2:GetTagged("Ladder")
    for _, v470 in pairs(v469) do
        v_u_385:AddLadder(v470)
    end
    local v471 = 0
    for _ in pairs(v_u_385.LadderZones) do
        v471 = v471 + 1
    end
    v_u_385.Janitor:Add(v_u_2:GetInstanceAddedSignal("Ladder"):Connect(function(p472)
        if p472:IsA("BasePart") then
            v_u_385:AddLadder(p472)
        end
    end))
    v_u_385.Janitor:Add(v_u_2:GetInstanceRemovedSignal("Ladder"):Connect(function(p473)
        if p473:IsA("BasePart") then
            v_u_385:RemoveLadder(p473)
        end
    end))
    v_u_385._deadAttributeConnection = p_u_381:GetAttributeChangedSignal("Dead"):Connect(function()
        if p_u_381:GetAttribute("Dead") and not v_u_385.IsDestroyed then
            v_u_385:Destroy()
        end
    end)
    return v_u_385
end
function v_u_1.Destroy(p474)
    if not p474.IsDestroyed then
        p474.IsDestroyed = true
        if p474.CharacterAnimator then
            p474.CharacterAnimator:destroy()
            p474.CharacterAnimator = nil
        end
        if p474._characterRef then
            p474._characterRef.instance = nil
            p474._characterRef = nil
        end
        if p474.OriginalMoveFunction then
            v_u_19.moveFunction = p474.OriginalMoveFunction
            p474.OriginalMoveFunction = nil
        end
        if p474._deadAttributeConnection then
            p474._deadAttributeConnection:Disconnect()
            p474._deadAttributeConnection = nil
        end
        if p474.MoveDirectionChanged then
            p474.MoveDirectionChanged:Destroy()
            p474.MoveDirectionChanged = nil
        end
        if p474.Crouching then
            p474.Crouching:Destroy()
            p474.Crouching = nil
        end
        if p474.ClimbBegan then
            p474.ClimbBegan:Destroy()
            p474.ClimbBegan = nil
        end
        if p474.ClimbEnded then
            p474.ClimbEnded:Destroy()
            p474.ClimbEnded = nil
        end
        if p474.Climbing then
            p474.Climbing:Destroy()
            p474.Climbing = nil
        end
        if p474.Jumping then
            p474.Jumping:Destroy()
            p474.Jumping = nil
        end
        if p474.Walking then
            p474.Walking:Destroy()
            p474.Walking = nil
        end
        if p474.Landed then
            p474.Landed:Destroy()
            p474.Landed = nil
        end
        if p474.LadderZones then
            table.clear(p474.LadderZones)
            p474.LadderZones = nil
        end
        p474.Character = nil
        p474.HumanoidRootPart = nil
        p474.Humanoid = nil
        p474.LadderZone = nil
        p474.LadderPart = nil
        if p474.VectorForce then
            p474.VectorForce = nil
        end
        if p474.AlignOrientation then
            p474.AlignOrientation = nil
        end
        if p474.BombPlantTween then
            p474.BombPlantTween = nil
        end
        if p474.CrouchTween then
            p474.CrouchTween = nil
        end
        p474.DefaultCameraOffset = nil
        p474.CrouchCameraOffset = nil
        p474.GlobalVelocity = nil
        p474.LocalVelocity = nil
        p474.LocalVelocityOnJump = nil
        p474.GlobalDirection = nil
        p474.TargetMoveDirection = nil
        p474.CurrentMoveDirection = nil
        p474.WallNormal = nil
        p474.LastWallNormal = nil
        p474.LandingVelocityY = nil
        p474.LockedAirDirection = nil
        p474.Janitor:Destroy()
        p474.Janitor = nil
    end
end
return v_u_1