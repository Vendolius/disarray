local v_u_1 = require(script.Parent:WaitForChild("CameraUtils"))
local v_u_2 = require(script.Parent:WaitForChild("CameraInput"))
local v_u_3 = game:GetService("Players")
local v_u_4 = require(script.Parent:WaitForChild("BaseCamera"))
local v_u_5 = setmetatable({}, v_u_4)
v_u_5.__index = v_u_5
function v_u_5.new()
    local v6 = v_u_4.new()
    local v7 = v_u_5
    local v8 = setmetatable(v6, v7)
    v8.lastUpdate = tick()
    v8.changedSignalConnections = {}
    v8.refAzimuthRad = nil
    v8.curAzimuthRad = nil
    v8.minAzimuthAbsoluteRad = nil
    v8.maxAzimuthAbsoluteRad = nil
    v8.useAzimuthLimits = nil
    v8.curElevationRad = nil
    v8.minElevationRad = nil
    v8.maxElevationRad = nil
    v8.curDistance = nil
    v8.minDistance = nil
    v8.maxDistance = nil
    v8.gamepadDollySpeedMultiplier = 1
    v8.lastUserPanCamera = tick()
    v8.externalProperties = {}
    v8.externalProperties.InitialDistance = 25
    v8.externalProperties.MinDistance = 10
    v8.externalProperties.MaxDistance = 100
    v8.externalProperties.InitialElevation = 35
    v8.externalProperties.MinElevation = 35
    v8.externalProperties.MaxElevation = 35
    v8.externalProperties.ReferenceAzimuth = -45
    v8.externalProperties.CWAzimuthTravel = 90
    v8.externalProperties.CCWAzimuthTravel = 90
    v8.externalProperties.UseAzimuthLimits = false
    v8:LoadNumberValueParameters()
    return v8
end
function v_u_5.LoadOrCreateNumberValueParameter(p_u_9, p_u_10, p11, p_u_12)
    local v13 = script:FindFirstChild(p_u_10)
    if v13 and v13:IsA(p11) then
        p_u_9.externalProperties[p_u_10] = v13.Value
    else
        if p_u_9.externalProperties[p_u_10] == nil then
            return
        end
        v13 = Instance.new(p11)
        v13.Name = p_u_10
        v13.Parent = script
        v13.Value = p_u_9.externalProperties[p_u_10]
    end
    if p_u_12 then
        if p_u_9.changedSignalConnections[p_u_10] then
            p_u_9.changedSignalConnections[p_u_10]:Disconnect()
        end
        p_u_9.changedSignalConnections[p_u_10] = v13.Changed:Connect(function(p14)
            p_u_9.externalProperties[p_u_10] = p14
            p_u_12(p_u_9)
        end)
    end
end
function v_u_5.SetAndBoundsCheckAzimuthValues(p15)
    local v16 = p15.externalProperties.ReferenceAzimuth
    local v17 = math.rad(v16)
    local v18 = p15.externalProperties.CWAzimuthTravel
    local v19 = math.rad(v18)
    p15.minAzimuthAbsoluteRad = v17 - math.abs(v19)
    local v20 = p15.externalProperties.ReferenceAzimuth
    local v21 = math.rad(v20)
    local v22 = p15.externalProperties.CCWAzimuthTravel
    local v23 = math.rad(v22)
    p15.maxAzimuthAbsoluteRad = v21 + math.abs(v23)
    p15.useAzimuthLimits = p15.externalProperties.UseAzimuthLimits
    if p15.useAzimuthLimits then
        local v24 = p15.curAzimuthRad
        local v25 = p15.minAzimuthAbsoluteRad
        p15.curAzimuthRad = math.max(v24, v25)
        local v26 = p15.curAzimuthRad
        local v27 = p15.maxAzimuthAbsoluteRad
        p15.curAzimuthRad = math.min(v26, v27)
    end
end
function v_u_5.SetAndBoundsCheckElevationValues(p28)
    local v29 = p28.externalProperties.MinElevation
    local v30 = math.max(v29, -80)
    local v31 = p28.externalProperties.MaxElevation
    local v32 = math.min(v31, 80)
    local v33 = math.min(v30, v32)
    p28.minElevationRad = math.rad(v33)
    local v34 = math.max(v30, v32)
    p28.maxElevationRad = math.rad(v34)
    local v35 = p28.curElevationRad
    local v36 = p28.minElevationRad
    p28.curElevationRad = math.max(v35, v36)
    local v37 = p28.curElevationRad
    local v38 = p28.maxElevationRad
    p28.curElevationRad = math.min(v37, v38)
end
function v_u_5.SetAndBoundsCheckDistanceValues(p39)
    p39.minDistance = p39.externalProperties.MinDistance
    p39.maxDistance = p39.externalProperties.MaxDistance
    local v40 = p39.curDistance
    local v41 = p39.minDistance
    p39.curDistance = math.max(v40, v41)
    local v42 = p39.curDistance
    local v43 = p39.maxDistance
    p39.curDistance = math.min(v42, v43)
end
function v_u_5.LoadNumberValueParameters(p44)
    p44:LoadOrCreateNumberValueParameter("InitialElevation", "NumberValue", nil)
    p44:LoadOrCreateNumberValueParameter("InitialDistance", "NumberValue", nil)
    p44:LoadOrCreateNumberValueParameter("ReferenceAzimuth", "NumberValue", p44.SetAndBoundsCheckAzimuthValue)
    p44:LoadOrCreateNumberValueParameter("CWAzimuthTravel", "NumberValue", p44.SetAndBoundsCheckAzimuthValues)
    p44:LoadOrCreateNumberValueParameter("CCWAzimuthTravel", "NumberValue", p44.SetAndBoundsCheckAzimuthValues)
    p44:LoadOrCreateNumberValueParameter("MinElevation", "NumberValue", p44.SetAndBoundsCheckElevationValues)
    p44:LoadOrCreateNumberValueParameter("MaxElevation", "NumberValue", p44.SetAndBoundsCheckElevationValues)
    p44:LoadOrCreateNumberValueParameter("MinDistance", "NumberValue", p44.SetAndBoundsCheckDistanceValues)
    p44:LoadOrCreateNumberValueParameter("MaxDistance", "NumberValue", p44.SetAndBoundsCheckDistanceValues)
    p44:LoadOrCreateNumberValueParameter("UseAzimuthLimits", "BoolValue", p44.SetAndBoundsCheckAzimuthValues)
    local v45 = p44.externalProperties.ReferenceAzimuth
    p44.curAzimuthRad = math.rad(v45)
    local v46 = p44.externalProperties.InitialElevation
    p44.curElevationRad = math.rad(v46)
    p44.curDistance = p44.externalProperties.InitialDistance
    p44:SetAndBoundsCheckAzimuthValues()
    p44:SetAndBoundsCheckElevationValues()
    p44:SetAndBoundsCheckDistanceValues()
end
function v_u_5.GetModuleName(_)
    return "OrbitalCamera"
end
function v_u_5.SetInitialOrientation(p47, p48)
    if p48 and p48.RootPart then
        local v49 = p48.RootPart
        assert(v49, "")
        local v50 = (p48.RootPart.CFrame.LookVector - Vector3.new(0, 0.23, 0)).Unit
        local v51 = v_u_1.GetAngleBetweenXZVectors(v50, p47:GetCameraLookVector())
        local v52 = p47:GetCameraLookVector().Y
        local v53 = math.asin(v52)
        local v54 = v50.Y
        local v55 = v53 - math.asin(v54)
        v_u_1.IsFinite(v51)
        v_u_1.IsFinite(v55)
    else
        warn("OrbitalCamera could not set initial orientation due to missing humanoid")
    end
end
function v_u_5.GetCameraToSubjectDistance(p56)
    return p56.curDistance
end
function v_u_5.SetCameraToSubjectDistance(p57, p58)
    if v_u_3.LocalPlayer then
        local v59 = p57.minDistance
        local v60 = p57.maxDistance
        p57.currentSubjectDistance = math.clamp(p58, v59, v60)
        local v61 = p57.currentSubjectDistance
        local v62 = p57.FIRST_PERSON_DISTANCE_THRESHOLD
        p57.currentSubjectDistance = math.max(v61, v62)
    end
    p57.inFirstPerson = false
    p57:UpdateMouseBehavior()
    return p57.currentSubjectDistance
end
function v_u_5.CalculateNewLookVector(p63, p64, p65)
    local v66 = p64 or p63:GetCameraLookVector()
    local v67 = v66.Y
    local v68 = math.asin(v67)
    local v69 = p65.Y
    local v70 = v68 - 1.3962634015954636
    local v71 = v68 - -1.3962634015954636
    local v72 = math.clamp(v69, v70, v71)
    local v73 = Vector2.new(p65.X, v72)
    local v74 = CFrame.new(Vector3.new(0, 0, 0), v66)
    return (CFrame.Angles(0, -v73.X, 0) * v74 * CFrame.Angles(-v73.Y, 0, 0)).LookVector
end
function v_u_5.Update(p75, p76)
    local v77 = tick()
    local v78 = v77 - p75.lastUpdate
    local v79 = v_u_2.getRotation(p76) ~= Vector2.new()
    local v80 = workspace.CurrentCamera
    local v81 = v80.CFrame
    local v82 = v80.Focus
    local v83 = v_u_3.LocalPlayer
    local v84
    if v80 then
        v84 = v80.CameraSubject
    else
        v84 = v80
    end
    local v85
    if v84 then
        v85 = v84:IsA("VehicleSeat")
    else
        v85 = v84
    end
    local v86
    if v84 then
        v86 = v84:IsA("SkateboardPlatform")
    else
        v86 = v84
    end
    if p75.lastUpdate == nil or v78 > 1 then
        p75.lastCameraTransform = nil
    end
    if v79 then
        p75.lastUserPanCamera = tick()
    end
    local v87 = p75:GetSubjectPosition()
    if v87 and (v83 and v80) then
        if p75.gamepadDollySpeedMultiplier ~= 1 then
            p75:SetCameraToSubjectDistance(p75.currentSubjectDistance * p75.gamepadDollySpeedMultiplier)
        end
        v82 = CFrame.new(v87)
        local v88 = v_u_2.getRotation(p76)
        p75.curAzimuthRad = p75.curAzimuthRad - v88.X
        if p75.useAzimuthLimits then
            local v89 = p75.curAzimuthRad
            local v90 = p75.minAzimuthAbsoluteRad
            local v91 = p75.maxAzimuthAbsoluteRad
            p75.curAzimuthRad = math.clamp(v89, v90, v91)
        else
            local v92
            if p75.curAzimuthRad == 0 then
                v92 = 0
            else
                local v93 = p75.curAzimuthRad
                local v94 = math.sign(v93)
                local v95 = p75.curAzimuthRad
                v92 = v94 * (math.abs(v95) % 6.283185307179586) or 0
            end
            p75.curAzimuthRad = v92
        end
        local v96 = p75.curElevationRad + v88.Y
        local v97 = p75.minElevationRad
        local v98 = p75.maxElevationRad
        p75.curElevationRad = math.clamp(v96, v97, v98)
        local v99 = v87 + p75.currentSubjectDistance * (CFrame.fromEulerAnglesYXZ(-p75.curElevationRad, p75.curAzimuthRad, 0) * Vector3.new(0, 0, 1))
        v81 = CFrame.new(v99, v87)
        p75.lastCameraTransform = v81
        p75.lastCameraFocus = v82
        if (v85 or v86) and v84:IsA("BasePart") then
            p75.lastSubjectCFrame = v84.CFrame
        else
            p75.lastSubjectCFrame = nil
        end
    end
    p75.lastUpdate = v77
    return v81, v82
end
return v_u_5