local v1 = game:GetService("Players")
local v_u_2 = game:GetService("UserInputService")
local v_u_3 = game:GetService("VRService")
local v_u_4 = UserSettings():GetService("UserGameSettings")
local v5 = script.Parent.Parent:WaitForChild("CommonUtils")
local v_u_6 = require(v5:WaitForChild("ConnectionUtil"))
local v7 = require(v5:WaitForChild("FlagUtil"))
local v_u_8 = require(script.Parent:WaitForChild("CameraUtils"))
local v_u_9 = require(script.Parent:WaitForChild("ZoomController"))
local v_u_10 = require(script.Parent:WaitForChild("CameraToggleStateController"))
local v_u_11 = require(script.Parent:WaitForChild("CameraInput"))
local v_u_12 = require(script.Parent:WaitForChild("CameraUI"))
local v_u_13 = v1.LocalPlayer
local v14, v15 = pcall(function()
    return UserSettings():IsUserFeatureEnabled("UserFixGamepadMaxZoom")
end)
local v_u_16 = v14 and v15
local v_u_17 = v7.getUserFlag("UserFixCameraCameraCharacterUpdates")
Vector2.new(0, 0)
local v_u_18 = {
    ["CHARACTER_ADDED"] = "CHARACTER_ADDED",
    ["CAMERA_MODE_CHANGED"] = "CAMERA_MODE_CHANGED",
    ["CAMERA_MIN_DISTANCE_CHANGED"] = "CAMERA_MIN_DISTANCE_CHANGED",
    ["CAMERA_MAX_DISTANCE_CHANGED"] = "CAMERA_MAX_DISTANCE_CHANGED"
}
local v_u_19 = {}
v_u_19.__index = v_u_19
function v_u_19.new()
    local v20 = v_u_19
    local v21 = setmetatable({}, v20)
    v21._connections = v_u_6.new()
    v21.gamepadZoomLevels = { 0, 10, 20 }
    v21.FIRST_PERSON_DISTANCE_THRESHOLD = 1
    v21.cameraType = nil
    v21.cameraMovementMode = nil
    v21.lastCameraTransform = nil
    v21.lastUserPanCamera = tick()
    v21.humanoidRootPart = nil
    v21.humanoidCache = {}
    v21.lastSubject = nil
    v21.lastSubjectPosition = Vector3.new(0, 5, 0)
    v21.lastSubjectCFrame = CFrame.new(v21.lastSubjectPosition)
    local v22 = v_u_13.CameraMinZoomDistance
    local v23 = v_u_13.CameraMaxZoomDistance
    v21.currentSubjectDistance = math.clamp(12.5, v22, v23)
    v21.inFirstPerson = false
    v21.inMouseLockedMode = false
    v21.portraitMode = false
    v21.isSmallTouchScreen = false
    v21.resetCameraAngle = true
    v21.enabled = false
    if not v_u_17 then
        v21.PlayerGui = nil
    end
    v21.cameraChangedConn = nil
    v21.viewportSizeChangedConn = nil
    v21.shouldUseVRRotation = false
    v21.VRRotationIntensityAvailable = false
    v21.lastVRRotationIntensityCheckTime = 0
    v21.lastVRRotationTime = 0
    v21.vrRotateKeyCooldown = {}
    v21.cameraTranslationConstraints = Vector3.new(1, 1, 1)
    v21.humanoidJumpOrigin = nil
    v21.trackingHumanoid = nil
    v21.cameraFrozen = false
    v21.subjectStateChangedConn = nil
    v21.gamepadZoomPressConnection = nil
    v21.mouseLockOffset = Vector3.new(0, 0, 0)
    v_u_4:SetCameraYInvertVisible()
    v_u_4:SetGamepadCameraSensitivityVisible()
    return v21
end
function v_u_19.GetModuleName(_)
    return "BaseCamera"
end
function v_u_19._setUpConfigurations(p_u_24)
    p_u_24._connections:trackConnection(v_u_18.CHARACTER_ADDED, v_u_13.CharacterAdded:Connect(function(p25)
        p_u_24:OnCharacterAdded(p25)
    end))
    if v_u_17 then
        p_u_24.humanoidRootPart = nil
    elseif v_u_13.Character then
        p_u_24:OnCharacterAdded(v_u_13.Character)
    end
    p_u_24._connections:trackConnection(v_u_18.CAMERA_MODE_CHANGED, v_u_13:GetPropertyChangedSignal("CameraMode"):Connect(function()
        p_u_24:OnPlayerCameraPropertyChange()
    end))
    p_u_24._connections:trackConnection(v_u_18.CAMERA_MIN_DISTANCE_CHANGED, v_u_13:GetPropertyChangedSignal("CameraMinZoomDistance"):Connect(function()
        p_u_24:OnPlayerCameraPropertyChange()
    end))
    p_u_24._connections:trackConnection(v_u_18.CAMERA_MAX_DISTANCE_CHANGED, v_u_13:GetPropertyChangedSignal("CameraMaxZoomDistance"):Connect(function()
        p_u_24:OnPlayerCameraPropertyChange()
    end))
    p_u_24:OnPlayerCameraPropertyChange()
end
function v_u_19.OnCharacterAdded(p_u_26, p27)
    p_u_26.resetCameraAngle = p_u_26.resetCameraAngle or p_u_26:GetEnabled()
    p_u_26.humanoidRootPart = nil
    if not v_u_17 and v_u_2.TouchEnabled then
        p_u_26.PlayerGui = v_u_13:WaitForChild("PlayerGui")
        for _, v28 in ipairs(p27:GetChildren()) do
            if v28:IsA("Tool") then
                p_u_26.isAToolEquipped = true
            end
        end
        p_u_26._connections:trackConnection("char.ChildAdded", p27.ChildAdded:Connect(function(p29)
            if p29:IsA("Tool") then
                p_u_26.isAToolEquipped = true
            end
        end))
        p_u_26._connections:trackConnection("char.ChildRemoved", p27.ChildRemoved:Connect(function(p30)
            if p30:IsA("Tool") then
                p_u_26.isAToolEquipped = false
            end
        end))
    end
end
function v_u_19.GetHumanoidRootPart(p31)
    local v32 = (not p31.humanoidRootPart and v_u_13.Character and true or false) and v_u_13.Character:FindFirstChildOfClass("Humanoid")
    if v32 then
        p31.humanoidRootPart = v32.RootPart
    end
    return p31.humanoidRootPart
end
function v_u_19.GetBodyPartToFollow(_, p33, _)
    if p33:GetState() == Enum.HumanoidStateType.Dead then
        local v34 = p33.Parent
        if v34 and v34:IsA("Model") then
            return v34:FindFirstChild("Head") or p33.RootPart
        end
    end
    return p33.RootPart
end
function v_u_19.GetSubjectCFrame(p35)
    local v36 = p35.lastSubjectCFrame
    local v37 = workspace.CurrentCamera
    if v37 then
        v37 = v37.CameraSubject
    end
    if not v37 then
        return v36
    end
    if v37:IsA("Humanoid") then
        local v38 = v37:GetState() == Enum.HumanoidStateType.Dead
        local v39 = v37.CameraOffset
        if p35:GetIsMouseLocked() then
            v39 = Vector3.new()
        end
        local v40 = v37.RootPart
        if v38 and (v37.Parent and v37.Parent:IsA("Model")) then
            v40 = v37.Parent:FindFirstChild("Head") or v40
        end
        if v40 and v40:IsA("BasePart") then
            local v41
            if v37.RigType == Enum.HumanoidRigType.R15 then
                if v37.AutomaticScalingEnabled then
                    v41 = Vector3.new(0, 1.5, 0)
                    local v42 = v37.RootPart
                    if v40 == v42 then
                        local v43 = (v42.Size.Y - (Vector3.new(2, 2, 1)).Y) / 2
                        v41 = v41 + Vector3.new(0, v43, 0)
                    end
                else
                    v41 = Vector3.new(0, 2, 0)
                end
            else
                v41 = Vector3.new(0, 1.5, 0)
            end
            v36 = v40.CFrame * CFrame.new((v38 and Vector3.new(0, 0, 0) or v41) + v39)
        end
    elseif v37:IsA("BasePart") then
        v36 = v37.CFrame
    elseif v37:IsA("Model") then
        if v37.PrimaryPart then
            v36 = v37:GetPrimaryPartCFrame()
        else
            v36 = CFrame.new()
        end
    end
    if v36 then
        p35.lastSubjectCFrame = v36
    end
    return v36
end
function v_u_19.GetSubjectVelocity(_)
    local v44 = workspace.CurrentCamera
    if v44 then
        v44 = v44.CameraSubject
    end
    if not v44 then
        return Vector3.new(0, 0, 0)
    end
    if v44:IsA("BasePart") then
        return v44.Velocity
    end
    if v44:IsA("Humanoid") then
        local v45 = v44.RootPart
        if v45 then
            return v45.Velocity
        end
    else
        local v46 = v44:IsA("Model") and v44.PrimaryPart
        if v46 then
            return v46.Velocity
        end
    end
    return Vector3.new(0, 0, 0)
end
function v_u_19.GetSubjectRotVelocity(_)
    local v47 = workspace.CurrentCamera
    if v47 then
        v47 = v47.CameraSubject
    end
    if not v47 then
        return Vector3.new(0, 0, 0)
    end
    if v47:IsA("BasePart") then
        return v47.RotVelocity
    end
    if v47:IsA("Humanoid") then
        local v48 = v47.RootPart
        if v48 then
            return v48.RotVelocity
        end
    else
        local v49 = v47:IsA("Model") and v47.PrimaryPart
        if v49 then
            return v49.RotVelocity
        end
    end
    return Vector3.new(0, 0, 0)
end
function v_u_19.StepZoom(p50)
    local v51 = p50.currentSubjectDistance
    local v52 = v_u_11.getZoomDelta()
    if math.abs(v52) > 0 then
        local v53
        if v52 > 0 then
            local v54 = v51 + v52 * (v51 * 0.5 + 1)
            local v55 = p50.FIRST_PERSON_DISTANCE_THRESHOLD
            v53 = math.max(v54, v55)
        else
            local v56 = (v51 + v52) / (1 - v52 * 0.5)
            v53 = math.max(v56, 0)
        end
        p50:SetCameraToSubjectDistance(v53 < p50.FIRST_PERSON_DISTANCE_THRESHOLD and 0 or v53)
    end
    return v_u_9.GetZoomRadius()
end
function v_u_19.GetSubjectPosition(p57)
    local v58 = p57.lastSubjectPosition
    local v59 = game.Workspace.CurrentCamera
    if v59 then
        v59 = v59.CameraSubject
    end
    if not v59 then
        return nil
    end
    if v59:IsA("Humanoid") then
        local v60 = v59:GetState() == Enum.HumanoidStateType.Dead
        local v61 = v59.CameraOffset
        if p57:GetIsMouseLocked() then
            v61 = Vector3.new()
        end
        local v62 = v59.RootPart
        if v60 and (v59.Parent and v59.Parent:IsA("Model")) then
            v62 = v59.Parent:FindFirstChild("Head") or v62
        end
        if v62 and v62:IsA("BasePart") then
            local v63
            if v59.RigType == Enum.HumanoidRigType.R15 then
                if v59.AutomaticScalingEnabled then
                    v63 = Vector3.new(0, 1.5, 0)
                    if v62 == v59.RootPart then
                        local v64 = v59.RootPart.Size.Y / 2 - (Vector3.new(2, 2, 1)).Y / 2
                        v63 = v63 + Vector3.new(0, v64, 0)
                    end
                else
                    v63 = Vector3.new(0, 2, 0)
                end
            else
                v63 = Vector3.new(0, 1.5, 0)
            end
            v58 = v62.CFrame.p + v62.CFrame:vectorToWorldSpace((v60 and Vector3.new(0, 0, 0) or v63) + v61)
        end
    elseif v59:IsA("VehicleSeat") then
        v58 = v59.CFrame.p + v59.CFrame:vectorToWorldSpace(Vector3.new(0, 5, 0))
    elseif v59:IsA("SkateboardPlatform") then
        v58 = v59.CFrame.p + Vector3.new(0, 5, 0)
    elseif v59:IsA("BasePart") then
        v58 = v59.CFrame.p
    elseif v59:IsA("Model") then
        if v59.PrimaryPart then
            v58 = v59:GetPrimaryPartCFrame().p
        else
            v58 = v59:GetModelCFrame().p
        end
    end
    p57.lastSubject = v59
    p57.lastSubjectPosition = v58
    return v58
end
function v_u_19.OnViewportSizeChanged(p65)
    local v66 = game.Workspace.CurrentCamera.ViewportSize
    p65.portraitMode = v66.X < v66.Y
    local v67 = v_u_2.TouchEnabled
    if v67 then
        v67 = v66.Y < 500 and true or v66.X < 700
    end
    p65.isSmallTouchScreen = v67
end
function v_u_19.OnCurrentCameraChanged(p_u_68)
    if v_u_2.TouchEnabled then
        if p_u_68.viewportSizeChangedConn then
            p_u_68.viewportSizeChangedConn:Disconnect()
            p_u_68.viewportSizeChangedConn = nil
        end
        local v69 = game.Workspace.CurrentCamera
        if v69 then
            p_u_68:OnViewportSizeChanged()
            p_u_68.viewportSizeChangedConn = v69:GetPropertyChangedSignal("ViewportSize"):Connect(function()
                p_u_68:OnViewportSizeChanged()
            end)
        end
    end
    if p_u_68.cameraSubjectChangedConn then
        p_u_68.cameraSubjectChangedConn:Disconnect()
        p_u_68.cameraSubjectChangedConn = nil
    end
    local v70 = game.Workspace.CurrentCamera
    if v70 then
        p_u_68.cameraSubjectChangedConn = v70:GetPropertyChangedSignal("CameraSubject"):Connect(function()
            p_u_68:OnNewCameraSubject()
        end)
        p_u_68:OnNewCameraSubject()
    end
end
function v_u_19.OnPlayerCameraPropertyChange(p71)
    p71:SetCameraToSubjectDistance(p71.currentSubjectDistance)
end
function v_u_19.InputTranslationToCameraAngleChange(_, p72, p73)
    return p72 * p73
end
function v_u_19.GamepadZoomPress(p74)
    local v75 = p74:GetCameraToSubjectDistance()
    local v76 = v_u_13.CameraMaxZoomDistance
    for v77 = #p74.gamepadZoomLevels, 1, -1 do
        local v78 = p74.gamepadZoomLevels[v77]
        if v76 >= v78 then
            if v78 < v_u_13.CameraMinZoomDistance then
                v78 = v_u_13.CameraMinZoomDistance
                if v_u_16 and v76 == v78 then
                    break
                end
            end
            if not v_u_16 and v76 == v78 then
                break
            end
            if v78 + (v76 - v78) / 2 < v75 then
                p74:SetCameraToSubjectDistance(v78)
                return
            end
            v76 = v78
        end
    end
    p74:SetCameraToSubjectDistance(p74.gamepadZoomLevels[#p74.gamepadZoomLevels])
end
function v_u_19.Enable(p79, p80)
    if p79.enabled ~= p80 then
        p79.enabled = p80
        p79:OnEnabledChanged()
    end
end
function v_u_19.OnEnabledChanged(p_u_81)
    if p_u_81.enabled then
        p_u_81:_setUpConfigurations()
        v_u_11.setInputEnabled(true)
        p_u_81.gamepadZoomPressConnection = v_u_11.gamepadZoomPress:Connect(function()
            p_u_81:GamepadZoomPress()
        end)
        if v_u_13.CameraMode == Enum.CameraMode.LockFirstPerson then
            p_u_81.currentSubjectDistance = 0
            if not p_u_81.inFirstPerson then
                p_u_81:EnterFirstPerson()
            end
        end
        if p_u_81.cameraChangedConn then
            p_u_81.cameraChangedConn:Disconnect()
            p_u_81.cameraChangedConn = nil
        end
        p_u_81.cameraChangedConn = workspace:GetPropertyChangedSignal("CurrentCamera"):Connect(function()
            p_u_81:OnCurrentCameraChanged()
        end)
        p_u_81:OnCurrentCameraChanged()
    else
        p_u_81._connections:disconnectAll()
        v_u_11.setInputEnabled(false)
        if p_u_81.gamepadZoomPressConnection then
            p_u_81.gamepadZoomPressConnection:Disconnect()
            p_u_81.gamepadZoomPressConnection = nil
        end
        p_u_81:Cleanup()
    end
end
function v_u_19.GetEnabled(p82)
    return p82.enabled
end
function v_u_19.Cleanup(p83)
    if p83.subjectStateChangedConn then
        p83.subjectStateChangedConn:Disconnect()
        p83.subjectStateChangedConn = nil
    end
    if p83.viewportSizeChangedConn then
        p83.viewportSizeChangedConn:Disconnect()
        p83.viewportSizeChangedConn = nil
    end
    if p83.cameraChangedConn then
        p83.cameraChangedConn:Disconnect()
        p83.cameraChangedConn = nil
    end
    p83.lastCameraTransform = nil
    p83.lastSubjectCFrame = nil
    v_u_8.restoreMouseBehavior()
end
function v_u_19.UpdateMouseBehavior(p84)
    local v85 = v_u_4.ComputerMovementMode == Enum.ComputerMovementMode.ClickToMove
    if p84.isCameraToggle and v85 == false then
        v_u_12.setCameraModeToastEnabled(true)
        v_u_11.enableCameraToggleInput()
        v_u_10(p84.inFirstPerson)
        return
    else
        v_u_12.setCameraModeToastEnabled(false)
        v_u_11.disableCameraToggleInput()
        if p84.inFirstPerson or p84.inMouseLockedMode then
            v_u_8.setRotationTypeOverride(Enum.RotationType.CameraRelative)
            v_u_8.setMouseBehaviorOverride(Enum.MouseBehavior.LockCenter)
            return
        else
            v_u_8.restoreRotationType()
            if v_u_11.getRotationActivated() then
                v_u_8.setMouseBehaviorOverride(Enum.MouseBehavior.LockCurrentPosition)
            else
                v_u_8.restoreMouseBehavior()
            end
        end
    end
end
function v_u_19.UpdateForDistancePropertyChange(p86)
    p86:SetCameraToSubjectDistance(p86.currentSubjectDistance)
end
function v_u_19.SetCameraToSubjectDistance(p87, p88)
    local v89 = p87.currentSubjectDistance
    if v_u_13.CameraMode == Enum.CameraMode.LockFirstPerson then
        p87.currentSubjectDistance = 0
        if not p87.inFirstPerson then
            p87:EnterFirstPerson()
        end
    else
        local v90 = v_u_13.CameraMinZoomDistance
        local v91 = v_u_13.CameraMaxZoomDistance
        local v92 = math.clamp(p88, v90, v91)
        if v92 < 1 then
            p87.currentSubjectDistance = 0
            if not p87.inFirstPerson then
                p87:EnterFirstPerson()
            end
        else
            p87.currentSubjectDistance = v92
            if p87.inFirstPerson then
                p87:LeaveFirstPerson()
            end
        end
    end
    local v93 = v_u_9.SetZoomParameters
    local v94 = p87.currentSubjectDistance
    local v95 = p88 - v89
    v93(v94, (math.sign(v95)))
    return p87.currentSubjectDistance
end
function v_u_19.SetCameraType(p96, p97)
    p96.cameraType = p97
end
function v_u_19.GetCameraType(p98)
    return p98.cameraType
end
function v_u_19.SetCameraMovementMode(p99, p100)
    p99.cameraMovementMode = p100
end
function v_u_19.GetCameraMovementMode(p101)
    return p101.cameraMovementMode
end
function v_u_19.SetIsMouseLocked(p102, p103)
    p102.inMouseLockedMode = p103
end
function v_u_19.GetIsMouseLocked(p104)
    return p104.inMouseLockedMode
end
function v_u_19.SetMouseLockOffset(p105, p106)
    p105.mouseLockOffset = p106
end
function v_u_19.GetMouseLockOffset(p107)
    return p107.mouseLockOffset
end
function v_u_19.InFirstPerson(p108)
    return p108.inFirstPerson
end
function v_u_19.EnterFirstPerson(p109)
    p109.inFirstPerson = true
    p109:UpdateMouseBehavior()
end
function v_u_19.LeaveFirstPerson(p110)
    p110.inFirstPerson = false
    p110:UpdateMouseBehavior()
end
function v_u_19.GetCameraToSubjectDistance(p111)
    return p111.currentSubjectDistance
end
function v_u_19.GetMeasuredDistanceToFocus(_)
    local v112 = game.Workspace.CurrentCamera
    if v112 then
        return (v112.CoordinateFrame.p - v112.Focus.p).magnitude
    else
        return nil
    end
end
function v_u_19.GetCameraLookVector(_)
    return game.Workspace.CurrentCamera and game.Workspace.CurrentCamera.CFrame.LookVector or Vector3.new(0, 0, 1)
end
function v_u_19.CalculateNewLookCFrameFromArg(p113, p114, p115)
    local v116 = p114 or p113:GetCameraLookVector()
    local v117 = v116.Y
    local v118 = math.asin(v117)
    local v119 = p115.Y
    local v120 = v118 + -1.3962634015954636
    local v121 = v118 + 1.3962634015954636
    local v122 = math.clamp(v119, v120, v121)
    local v123 = Vector2.new(p115.X, v122)
    local v124 = CFrame.new(Vector3.new(0, 0, 0), v116)
    return CFrame.Angles(0, -v123.X, 0) * v124 * CFrame.Angles(-v123.Y, 0, 0)
end
function v_u_19.CalculateNewLookVectorFromArg(p125, p126, p127)
    return p125:CalculateNewLookCFrameFromArg(p126, p127).LookVector
end
function v_u_19.CalculateNewLookVectorVRFromArg(p128, p129)
    local v130 = ((p128:GetSubjectPosition() - game.Workspace.CurrentCamera.CFrame.p) * Vector3.new(1, 0, 1)).unit
    local v131 = Vector2.new(p129.X, 0)
    local v132 = CFrame.new(Vector3.new(0, 0, 0), v130)
    return ((CFrame.Angles(0, -v131.X, 0) * v132 * CFrame.Angles(-v131.Y, 0, 0)).LookVector * Vector3.new(1, 0, 1)).unit
end
function v_u_19.GetHumanoid(p133)
    local v134 = v_u_13
    if v134 then
        v134 = v_u_13.Character
    end
    if not v134 then
        return nil
    end
    local v135 = p133.humanoidCache[v_u_13]
    if v135 and v135.Parent == v134 then
        return v135
    end
    p133.humanoidCache[v_u_13] = nil
    local v136 = v134:FindFirstChildOfClass("Humanoid")
    if v136 then
        p133.humanoidCache[v_u_13] = v136
    end
    return v136
end
function v_u_19.GetHumanoidPartToFollow(_, p137, p138)
    if p138 == Enum.HumanoidStateType.Dead then
        local v139 = p137.Parent
        if v139 then
            return v139:FindFirstChild("Head") or p137.Torso
        else
            return p137.Torso
        end
    else
        return p137.Torso
    end
end
function v_u_19.OnNewCameraSubject(p140)
    if p140.subjectStateChangedConn then
        p140.subjectStateChangedConn:Disconnect()
        p140.subjectStateChangedConn = nil
    end
end
function v_u_19.IsInFirstPerson(p141)
    return p141.inFirstPerson
end
function v_u_19.Update(_, _)
    error("BaseCamera:Update() This is a virtual function that should never be getting called.", 2)
end
function v_u_19.GetCameraHeight(p142)
    return (not v_u_3.VREnabled or p142.inFirstPerson) and 0 or 0.25881904510252074 * p142.currentSubjectDistance
end
return v_u_19