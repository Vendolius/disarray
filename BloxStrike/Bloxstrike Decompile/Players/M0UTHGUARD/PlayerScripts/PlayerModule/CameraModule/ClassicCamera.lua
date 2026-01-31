Vector2.new(0, 0)
local v_u_1 = 0
local v_u_2 = CFrame.fromOrientation(-0.2617993877991494, 0, 0)
local v3 = script.Parent.Parent:WaitForChild("CommonUtils")
local v4 = require(v3:WaitForChild("FlagUtil"))
local v_u_5 = v4.getUserFlag("UserCameraInputDt")
local v_u_6 = v4.getUserFlag("UserFixCameraFPError")
local v_u_7 = game:GetService("Players")
local v_u_8 = require(script.Parent:WaitForChild("CameraInput"))
local v_u_9 = require(script.Parent:WaitForChild("CameraUtils"))
local v_u_10 = require(script.Parent:WaitForChild("BaseCamera"))
local v_u_11 = setmetatable({}, v_u_10)
v_u_11.__index = v_u_11
function v_u_11.new()
    local v12 = v_u_10.new()
    local v13 = v_u_11
    local v14 = setmetatable(v12, v13)
    v14.isFollowCamera = false
    v14.isCameraToggle = false
    v14.lastUpdate = tick()
    v14.cameraToggleSpring = v_u_9.Spring.new(5, 0)
    return v14
end
function v_u_11.GetCameraToggleOffset(p15, p16)
    if not p15.isCameraToggle then
        return Vector3.new()
    end
    local v17 = p15.currentSubjectDistance
    if v_u_8.getTogglePan() then
        local v18 = p15.cameraToggleSpring
        local v19 = v_u_9.map(v17, 0, p15.FIRST_PERSON_DISTANCE_THRESHOLD, 0, 1)
        v18.goal = math.clamp(v19, 0, 1)
    else
        p15.cameraToggleSpring.goal = 0
    end
    local v20 = v_u_9.map(v17, 0, 64, 0, 1)
    local v21 = math.clamp(v20, 0, 1) + 1
    local v22 = p15.cameraToggleSpring:step(p16) * v21
    return Vector3.new(0, v22, 0)
end
function v_u_11.SetCameraMovementMode(p23, p24)
    v_u_10.SetCameraMovementMode(p23, p24)
    p23.isFollowCamera = p24 == Enum.ComputerCameraMovementMode.Follow
    p23.isCameraToggle = p24 == Enum.ComputerCameraMovementMode.CameraToggle
end
function v_u_11.Update(p25, p26)
    local v27 = tick()
    local v28 = v27 - p25.lastUpdate
    if v_u_5 then
        v28 = p26
    end
    local v29 = workspace.CurrentCamera
    local v30 = v29.CFrame
    local v31 = v29.Focus
    local v32
    if p25.resetCameraAngle then
        local v33 = p25:GetHumanoidRootPart()
        if v33 then
            v32 = (v33.CFrame * v_u_2).lookVector
        else
            v32 = v_u_2.lookVector
        end
        p25.resetCameraAngle = false
    else
        v32 = nil
    end
    local v34 = v_u_7.LocalPlayer
    local v35 = p25:GetHumanoid()
    local v36 = v29.CameraSubject
    local v37
    if v36 then
        v37 = v36:IsA("VehicleSeat")
    else
        v37 = v36
    end
    local v38
    if v36 then
        v38 = v36:IsA("SkateboardPlatform")
    else
        v38 = v36
    end
    local v39
    if v35 then
        v39 = v35:GetState() == Enum.HumanoidStateType.Climbing
    else
        v39 = v35
    end
    if p25.lastUpdate == nil or v28 > 1 then
        p25.lastCameraTransform = nil
    end
    local v40 = v_u_8.getRotation(v28)
    p25:StepZoom()
    local v41 = p25:GetCameraHeight()
    if v40 ~= Vector2.new() then
        v_u_1 = 0
        p25.lastUserPanCamera = tick()
    end
    local v42 = v27 - p25.lastUserPanCamera < 2
    local v43 = p25:GetSubjectPosition()
    if v43 and (v34 and v29) then
        local v44 = p25:GetCameraToSubjectDistance()
        local v45 = v44 < 0 and 0 or v44
        if p25:GetIsMouseLocked() and not p25:IsInFirstPerson() then
            local v46 = p25:CalculateNewLookCFrameFromArg(v32, v40)
            local v47 = p25:GetMouseLockOffset()
            if v35 then
                v47 = v47 + v35.CameraOffset
            end
            local v48 = v47.X * v46.RightVector + v47.Y * v46.UpVector + v47.Z * v46.LookVector
            if v_u_9.IsFiniteVector3(v48) then
                v43 = v43 + v48
            end
        elseif v40 == Vector2.new() and p25.lastCameraTransform then
            local v49 = p25:IsInFirstPerson()
            if (v37 or (v38 or p25.isFollowCamera and v39)) and (p25.lastUpdate and (v35 and v35.Torso)) then
                if v49 then
                    if p25.lastSubjectCFrame and (v37 or v38) and v36:IsA("BasePart") then
                        local v50 = -v_u_9.GetAngleBetweenXZVectors(p25.lastSubjectCFrame.lookVector, v36.CFrame.lookVector)
                        if v_u_9.IsFinite(v50) then
                            v40 = v40 + Vector2.new(v50, 0)
                        end
                        v_u_1 = 0
                    end
                elseif not v42 then
                    local v51 = v35.Torso.CFrame.lookVector
                    local v52 = v_u_1 + 3.839724354387525 * v28
                    v_u_1 = math.clamp(v52, 0, 4.363323129985824)
                    local v53 = v_u_1 * v28
                    local v54 = math.clamp(v53, 0, 1)
                    local v55 = p25:IsInFirstPerson() and not (p25.isFollowCamera and p25.isClimbing) and 1 or v54
                    local v56 = v_u_9.GetAngleBetweenXZVectors(v51, p25:GetCameraLookVector())
                    if v_u_9.IsFinite(v56) and math.abs(v56) > 0.0001 then
                        v40 = v40 + Vector2.new(v56 * v55, 0)
                    end
                end
            elseif p25.isFollowCamera and not (v49 or v42) then
                local v57 = -(p25.lastCameraTransform.p - v43)
                local v58 = v_u_9.GetAngleBetweenXZVectors(v57, p25:GetCameraLookVector())
                if v_u_9.IsFinite(v58) and (math.abs(v58) > 0.0001 and math.abs(v58) > 0.4 * v28) then
                    v40 = v40 + Vector2.new(v58, 0)
                end
            end
        end
        local v59, v60
        if p25.isFollowCamera then
            local v61 = p25:CalculateNewLookVectorFromArg(v32, v40)
            v59 = CFrame.new(v43)
            local v62 = v59.p - v45 * v61
            if v45 <= 0 then
                v60 = CFrame.lookAlong(v59.p, v61)
            elseif v_u_6 then
                v60 = CFrame.lookAlong(v62, v61)
            else
                v60 = CFrame.new(v62, v59.p) + Vector3.new(0, v41, 0)
            end
        else
            v59 = CFrame.new(v43)
            local v63 = v59.p
            local v64 = p25:CalculateNewLookVectorFromArg(v32, v40)
            local v65 = v63 - v45 * v64
            if v45 <= 0 then
                v60 = CFrame.lookAlong(v63, v64)
            elseif v_u_6 then
                v60 = CFrame.lookAlong(v65, v64)
            else
                v60 = CFrame.new(v65, v63)
            end
        end
        local v66 = p25:GetCameraToggleOffset(v28)
        v31 = v59 + v66
        v30 = v60 + v66
        p25.lastCameraTransform = v30
        p25.lastCameraFocus = v31
        if (v37 or v38) and v36:IsA("BasePart") then
            p25.lastSubjectCFrame = v36.CFrame
        else
            p25.lastSubjectCFrame = nil
        end
    end
    p25.lastUpdate = v27
    return v30, v31
end
return v_u_11