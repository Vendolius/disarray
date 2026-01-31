local v1, v2 = pcall(function()
    return UserSettings():IsUserFeatureEnabled("UserVRVehicleCamera2")
end)
local v_u_3 = v1 and v2
local v_u_4 = game:GetService("VRService")
local v_u_5 = game:GetService("Players").LocalPlayer
local v_u_6 = game:GetService("Lighting")
local v_u_7 = game:GetService("RunService")
local v_u_8 = UserSettings():GetService("UserGameSettings")
local v_u_9 = require(script.Parent:WaitForChild("CameraInput"))
local v_u_10 = require(script.Parent:WaitForChild("ZoomController"))
local v11 = script.Parent.Parent:WaitForChild("CommonUtils")
local v_u_12 = require(v11:WaitForChild("FlagUtil")).getUserFlag("UserCameraInputDt")
local v_u_13 = require(script.Parent:WaitForChild("BaseCamera"))
local v_u_14 = setmetatable({}, v_u_13)
v_u_14.__index = v_u_14
function v_u_14.new()
    local v15 = v_u_13.new()
    local v16 = v_u_14
    local v17 = setmetatable(v15, v16)
    v17.gamepadZoomLevels = { 0, 7 }
    v17.headScale = 1
    v17:SetCameraToSubjectDistance(7)
    v17.VRFadeResetTimer = 0
    v17.VREdgeBlurTimer = 0
    v17.gamepadResetConnection = nil
    v17.needsReset = true
    v17.recentered = false
    v17:Reset()
    return v17
end
function v_u_14.Reset(p18)
    p18.stepRotateTimeout = 0
end
function v_u_14.GetModuleName(_)
    return "VRBaseCamera"
end
function v_u_14.GamepadZoomPress(p19)
    v_u_13.GamepadZoomPress(p19)
    p19:GamepadReset()
    p19:ResetZoom()
end
function v_u_14.GamepadReset(p20)
    p20.stepRotateTimeout = 0
    p20.needsReset = true
end
function v_u_14.ResetZoom(p21)
    v_u_10.SetZoomParameters(p21.currentSubjectDistance, 0)
    v_u_10.ReleaseSpring()
end
function v_u_14.OnEnabledChanged(p_u_22)
    v_u_13.OnEnabledChanged(p_u_22)
    if p_u_22.enabled then
        p_u_22.gamepadResetConnection = v_u_9.gamepadReset:Connect(function()
            p_u_22:GamepadReset()
        end)
        p_u_22.thirdPersonOptionChanged = v_u_4:GetPropertyChangedSignal("ThirdPersonFollowCamEnabled"):Connect(function()
            if v_u_3 then
                p_u_22:Reset()
            elseif not p_u_22:IsInFirstPerson() then
                p_u_22:Reset()
            end
        end)
        p_u_22.vrRecentered = v_u_4.UserCFrameChanged:Connect(function(p23, _)
            if p23 == Enum.UserCFrame.Floor then
                p_u_22.recentered = true
            end
        end)
    else
        if p_u_22.inFirstPerson then
            p_u_22:GamepadZoomPress()
        end
        if p_u_22.thirdPersonOptionChanged then
            p_u_22.thirdPersonOptionChanged:Disconnect()
            p_u_22.thirdPersonOptionChanged = nil
        end
        if p_u_22.vrRecentered then
            p_u_22.vrRecentered:Disconnect()
            p_u_22.vrRecentered = nil
        end
        if p_u_22.cameraHeadScaleChangedConn then
            p_u_22.cameraHeadScaleChangedConn:Disconnect()
            p_u_22.cameraHeadScaleChangedConn = nil
        end
        if p_u_22.gamepadResetConnection then
            p_u_22.gamepadResetConnection:Disconnect()
            p_u_22.gamepadResetConnection = nil
        end
        p_u_22.VREdgeBlurTimer = 0
        p_u_22:UpdateEdgeBlur(v_u_5, 1)
        local v24 = v_u_6:FindFirstChild("VRFade")
        if v24 then
            v24.Brightness = 0
        end
    end
end
function v_u_14.OnCurrentCameraChanged(p_u_25)
    v_u_13.OnCurrentCameraChanged(p_u_25)
    if p_u_25.cameraHeadScaleChangedConn then
        p_u_25.cameraHeadScaleChangedConn:Disconnect()
        p_u_25.cameraHeadScaleChangedConn = nil
    end
    local v26 = workspace.CurrentCamera
    if v26 then
        p_u_25.cameraHeadScaleChangedConn = v26:GetPropertyChangedSignal("HeadScale"):Connect(function()
            p_u_25:OnHeadScaleChanged()
        end)
        p_u_25:OnHeadScaleChanged()
    end
end
function v_u_14.OnHeadScaleChanged(p27)
    local v28 = workspace.CurrentCamera.HeadScale
    for v29, v30 in p27.gamepadZoomLevels do
        p27.gamepadZoomLevels[v29] = v30 * v28 / p27.headScale
    end
    p27:SetCameraToSubjectDistance(p27:GetCameraToSubjectDistance() * v28 / p27.headScale)
    p27.headScale = v28
end
function v_u_14.GetVRFocus(p31, p32, p33)
    local v34 = p31.lastCameraFocus or p32
    local v35 = p31.cameraTranslationConstraints.x
    local v36 = p31.cameraTranslationConstraints.y + p33
    local v37 = math.min(1, v36)
    local v38 = p31.cameraTranslationConstraints.z
    p31.cameraTranslationConstraints = Vector3.new(v35, v37, v38)
    local v39 = p31:GetCameraHeight()
    local v40 = Vector3.new(0, v39, 0)
    local v41 = CFrame.new
    local v42 = p32.x
    local v43 = v34.y
    local v44 = p32.z
    return v41(Vector3.new(v42, v43, v44):Lerp(p32 + v40, p31.cameraTranslationConstraints.y))
end
function v_u_14.StartFadeFromBlack(p45)
    if v_u_8.VignetteEnabled ~= false then
        local v46 = v_u_6:FindFirstChild("VRFade")
        if not v46 then
            v46 = Instance.new("ColorCorrectionEffect")
            v46.Name = "VRFade"
            v46.Parent = v_u_6
        end
        v46.Brightness = -1
        p45.VRFadeResetTimer = 0.1
    end
end
function v_u_14.UpdateFadeFromBlack(p47, p48)
    local v49 = v_u_6:FindFirstChild("VRFade")
    if p47.VRFadeResetTimer > 0 then
        local v50 = p47.VRFadeResetTimer - p48
        p47.VRFadeResetTimer = math.max(v50, 0)
        local v51 = v_u_6:FindFirstChild("VRFade")
        if v51 and v51.Brightness < 0 then
            local v52 = v51.Brightness + p48 * 10
            v51.Brightness = math.min(v52, 0)
            return
        end
    elseif v49 then
        v49.Brightness = 0
    end
end
function v_u_14.StartVREdgeBlur(p53, p54)
    if v_u_8.VignetteEnabled ~= false then
        local v55 = workspace.CurrentCamera:FindFirstChild("VRBlurPart")
        if not v55 then
            local v_u_56 = Instance.new("Part")
            v_u_56.Name = "VRBlurPart"
            v_u_56.Parent = workspace.CurrentCamera
            v_u_56.CanTouch = false
            v_u_56.CanCollide = false
            v_u_56.CanQuery = false
            v_u_56.Anchored = true
            v_u_56.Size = Vector3.new(0.44, 0.47, 1)
            v_u_56.Transparency = 1
            v_u_56.CastShadow = false
            v_u_7.RenderStepped:Connect(function(_)
                local v57 = v_u_4:GetUserCFrame(Enum.UserCFrame.Head)
                local v58 = workspace.CurrentCamera.CFrame * (CFrame.new(v57.p * workspace.CurrentCamera.HeadScale) * (v57 - v57.p))
                v_u_56.CFrame = v58 * CFrame.Angles(0, 3.141592653589793, 0) + v58.LookVector * (1.05 * workspace.CurrentCamera.HeadScale)
                v_u_56.Size = Vector3.new(0.44, 0.47, 1) * workspace.CurrentCamera.HeadScale
            end)
            v55 = v_u_56
        end
        local v59 = p54.PlayerGui:FindFirstChild("VRBlurScreen")
        local v60
        if v59 then
            v60 = v59:FindFirstChild("VRBlur")
        else
            v60 = nil
        end
        if not v60 then
            local v61 = v59 or (Instance.new("SurfaceGui") or Instance.new("ScreenGui"))
            v61.Name = "VRBlurScreen"
            v61.Parent = p54.PlayerGui
            v61.Adornee = v55
            v60 = Instance.new("ImageLabel")
            v60.Name = "VRBlur"
            v60.Parent = v61
            v60.Image = "rbxasset://textures/ui/VR/edgeBlur.png"
            v60.AnchorPoint = Vector2.new(0.5, 0.5)
            v60.Position = UDim2.new(0.5, 0, 0.5, 0)
            local v62 = workspace.CurrentCamera.ViewportSize.X * 2.3 / 512
            local v63 = workspace.CurrentCamera.ViewportSize.Y * 2.3 / 512
            v60.Size = UDim2.fromScale(v62, v63)
            v60.BackgroundTransparency = 1
            v60.Active = true
            v60.ScaleType = Enum.ScaleType.Stretch
        end
        v60.Visible = true
        v60.ImageTransparency = 0
        p53.VREdgeBlurTimer = 0.14
    end
end
function v_u_14.UpdateEdgeBlur(p64, p65, p66)
    local v67 = p65.PlayerGui:FindFirstChild("VRBlurScreen")
    local v68
    if v67 then
        v68 = v67:FindFirstChild("VRBlur")
    else
        v68 = nil
    end
    if v68 then
        if p64.VREdgeBlurTimer > 0 then
            p64.VREdgeBlurTimer = p64.VREdgeBlurTimer - p66
            local v69 = p65.PlayerGui:FindFirstChild("VRBlurScreen")
            local v70 = v69 and v69:FindFirstChild("VRBlur")
            if v70 then
                local v71 = p64.VREdgeBlurTimer
                v70.ImageTransparency = 1 - math.clamp(v71, 0.01, 0.14) * 7.142857142857142
                return
            end
        else
            v68.Visible = false
        end
    end
end
function v_u_14.GetCameraHeight(p72)
    return p72.inFirstPerson and 0 or 0.25881904510252074 * p72.currentSubjectDistance
end
function v_u_14.GetSubjectCFrame(p73)
    local v74 = v_u_13.GetSubjectCFrame(p73)
    local v75 = workspace.CurrentCamera
    if v75 then
        v75 = v75.CameraSubject
    end
    if not v75 then
        return v74
    end
    if v75:IsA("Humanoid") and (v75:GetState() == Enum.HumanoidStateType.Dead and v75 == p73.lastSubject) then
        v74 = p73.lastSubjectCFrame
    end
    if v74 then
        p73.lastSubjectCFrame = v74
    end
    return v74
end
function v_u_14.GetSubjectPosition(p76)
    local v77 = v_u_13.GetSubjectPosition(p76)
    local v78 = game.Workspace.CurrentCamera
    if v78 then
        v78 = v78.CameraSubject
    end
    if not v78 then
        return nil
    end
    if v78:IsA("Humanoid") then
        if v78:GetState() == Enum.HumanoidStateType.Dead and v78 == p76.lastSubject then
            v77 = p76.lastSubjectPosition
        end
    elseif v78:IsA("VehicleSeat") then
        v77 = v78.CFrame.p + v78.CFrame:vectorToWorldSpace(Vector3.new(0, 4, 0))
    end
    p76.lastSubjectPosition = v77
    return v77
end
function v_u_14.getRotation(p79, p80)
    local v81 = v_u_9.getRotation(p80)
    local v82 = 0
    if v_u_8.VRSmoothRotationEnabled then
        if v_u_12 then
            return v81.X
        else
            return v81.X * 40 * p80
        end
    else
        local v83 = v81.X
        if math.abs(v83) > 0.03 then
            if p79.stepRotateTimeout > 0 then
                p79.stepRotateTimeout = p79.stepRotateTimeout - p80
            end
            if p79.stepRotateTimeout <= 0 then
                local v84 = (v81.X < 0 and -1 or 1) * 0.5235987755982988
                p79:StartFadeFromBlack()
                p79.stepRotateTimeout = 0.25
                return v84
            end
        else
            local v85 = v81.X
            if math.abs(v85) < 0.02 then
                p79.stepRotateTimeout = 0
            end
        end
        return v82
    end
end
return v_u_14