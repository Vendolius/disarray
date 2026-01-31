local v_u_1 = {}
v_u_1.__index = v_u_1
local v_u_2 = {
    "CameraMinZoomDistance",
    "CameraMaxZoomDistance",
    "CameraMode",
    "DevCameraOcclusionMode",
    "DevComputerCameraMode",
    "DevTouchCameraMode",
    "DevComputerMovementMode",
    "DevTouchMovementMode",
    "DevEnableMouseLock"
}
local v_u_3 = {
    "ComputerCameraMovementMode",
    "ComputerMovementMode",
    "ControlMode",
    "GamepadCameraSensitivity",
    "MouseSensitivity",
    "RotationType",
    "TouchCameraMovementMode",
    "TouchMovementMode"
}
local v_u_4 = game:GetService("Players")
local v_u_5 = game:GetService("RunService")
local v_u_6 = game:GetService("UserInputService")
local v_u_7 = game:GetService("VRService")
local v_u_8 = UserSettings():GetService("UserGameSettings")
local v9 = script.Parent:WaitForChild("CommonUtils")
local v_u_10 = require(v9:WaitForChild("ConnectionUtil"))
local v11 = require(v9:WaitForChild("FlagUtil"))
local v_u_12 = require(script:WaitForChild("CameraUtils"))
local v_u_13 = require(script:WaitForChild("CameraInput"))
local v_u_14 = require(script:WaitForChild("ClassicCamera"))
local v_u_15 = require(script:WaitForChild("OrbitalCamera"))
local v_u_16 = require(script:WaitForChild("LegacyCamera"))
local v_u_17 = require(script:WaitForChild("VehicleCamera"))
local v_u_18 = require(script:WaitForChild("VRCamera"))
local v_u_19 = require(script:WaitForChild("VRVehicleCamera"))
local v_u_20 = require(script:WaitForChild("Invisicam"))
local v_u_21 = require(script:WaitForChild("Poppercam"))
local v_u_22 = require(script:WaitForChild("TransparencyController"))
local v_u_23 = require(script:WaitForChild("MouseLockController"))
local v_u_24 = {}
local v_u_25 = {}
if not v_u_4.LocalPlayer then
    return {}
end
local v26 = v_u_4.LocalPlayer
assert(v26, "Strict typing check")
local v27 = v_u_4.LocalPlayer:WaitForChild("PlayerScripts")
v27:RegisterTouchCameraMovementMode(Enum.TouchCameraMovementMode.Default)
v27:RegisterTouchCameraMovementMode(Enum.TouchCameraMovementMode.Follow)
v27:RegisterTouchCameraMovementMode(Enum.TouchCameraMovementMode.Classic)
v27:RegisterComputerCameraMovementMode(Enum.ComputerCameraMovementMode.Default)
v27:RegisterComputerCameraMovementMode(Enum.ComputerCameraMovementMode.Follow)
v27:RegisterComputerCameraMovementMode(Enum.ComputerCameraMovementMode.Classic)
v27:RegisterComputerCameraMovementMode(Enum.ComputerCameraMovementMode.CameraToggle)
local v_u_28 = v11.getUserFlag("UserRespectLegacyCameraOptions")
v11.getUserFlag("UserPlayerConnectionMemoryLeak")
function v_u_1.new()
    local v29 = {
        ["activeTransparencyController"] = v_u_22.new(),
        ["connectionUtil"] = v_u_10.new()
    }
    local v30 = v_u_1
    local v_u_31 = setmetatable(v29, v30)
    v_u_31.activeCameraController = nil
    v_u_31.activeOcclusionModule = nil
    v_u_31.activeMouseLockController = nil
    v_u_31.currentComputerCameraMovementMode = nil
    v_u_31.cameraSubjectChangedConn = nil
    v_u_31.cameraTypeChangedConn = nil
    v_u_31.renderStepName = "cameraRenderUpdate"
    for _, v32 in pairs(v_u_4:GetPlayers()) do
        v_u_31:OnPlayerAdded(v32)
    end
    v_u_31.connectionUtil:trackConnection("Players.PlayerAdded", v_u_4.PlayerAdded:Connect(function(p33)
        v_u_31:OnPlayerAdded(p33)
    end))
    v_u_31.connectionUtil:trackConnection("Players.PlayerRemoving", v_u_4.PlayerRemoving:Connect(function(p34)
        v_u_31:OnPlayerRemoving(p34)
    end))
    v_u_31.activeTransparencyController:Enable(true)
    if not v_u_6.TouchEnabled then
        v_u_31.activeMouseLockController = v_u_23.new()
        local v35 = v_u_31.activeMouseLockController
        assert(v35, "Strict typing check")
        local v36 = v_u_31.activeMouseLockController:GetBindableToggleEvent()
        if v36 then
            v_u_31.connectionUtil:trackConnection("MouseLockToggleEvent", v36:Connect(function()
                v_u_31:OnMouseLockToggled()
            end))
        end
    end
    if v_u_28 then
        v_u_31:ActivateCameraController()
    else
        v_u_31:ActivateCameraController(v_u_31:GetCameraControlChoice())
    end
    v_u_31:ActivateOcclusionModule(v_u_4.LocalPlayer.DevCameraOcclusionMode)
    v_u_31:OnCurrentCameraChanged()
    v_u_5:BindToRenderStep(v_u_31.renderStepName, Enum.RenderPriority.Camera.Value, function(p37)
        v_u_31:Update(p37)
    end)
    for _, v_u_38 in pairs(v_u_2) do
        v_u_31.connectionUtil:trackConnection(("LocalPlayer.%*"):format(v_u_38), v_u_4.LocalPlayer:GetPropertyChangedSignal(v_u_38):Connect(function()
            v_u_31:OnLocalPlayerCameraPropertyChanged(v_u_38)
        end))
    end
    for _, v_u_39 in pairs(v_u_3) do
        v_u_31.connectionUtil:trackConnection(("UserGameSettings.%*"):format(v_u_39), v_u_8:GetPropertyChangedSignal(v_u_39):Connect(function()
            v_u_31:OnUserGameSettingsPropertyChanged(v_u_39)
        end))
    end
    v_u_31.connectionUtil:trackConnection("Workspace.CurrentCamera", game.Workspace:GetPropertyChangedSignal("CurrentCamera"):Connect(function()
        v_u_31:OnCurrentCameraChanged()
    end))
    return v_u_31
end
function v_u_1.GetCameraMovementModeFromSettings(_)
    if v_u_4.LocalPlayer.CameraMode == Enum.CameraMode.LockFirstPerson then
        return v_u_12.ConvertCameraModeEnumToStandard(Enum.ComputerCameraMovementMode.Classic)
    else
        local v40, v41
        if v_u_6.TouchEnabled then
            v40 = v_u_12.ConvertCameraModeEnumToStandard(v_u_4.LocalPlayer.DevTouchCameraMode)
            v41 = v_u_12.ConvertCameraModeEnumToStandard(v_u_8.TouchCameraMovementMode)
        else
            v40 = v_u_12.ConvertCameraModeEnumToStandard(v_u_4.LocalPlayer.DevComputerCameraMode)
            v41 = v_u_12.ConvertCameraModeEnumToStandard(v_u_8.ComputerCameraMovementMode)
        end
        if v40 == Enum.DevComputerCameraMovementMode.UserChoice then
            return v41
        else
            return v40
        end
    end
end
function v_u_1.ActivateOcclusionModule(p42, p43)
    local v44
    if p43 == Enum.DevCameraOcclusionMode.Zoom then
        v44 = v_u_21
    else
        if p43 ~= Enum.DevCameraOcclusionMode.Invisicam then
            warn("CameraScript ActivateOcclusionModule called with unsupported mode")
            return
        end
        v44 = v_u_20
    end
    p42.occlusionMode = p43
    if p42.activeOcclusionModule and p42.activeOcclusionModule:GetOcclusionMode() == p43 then
        if not p42.activeOcclusionModule:GetEnabled() then
            p42.activeOcclusionModule:Enable(true)
        end
    else
        local v45 = p42.activeOcclusionModule
        p42.activeOcclusionModule = v_u_25[v44]
        if not p42.activeOcclusionModule then
            p42.activeOcclusionModule = v44.new()
            if p42.activeOcclusionModule then
                v_u_25[v44] = p42.activeOcclusionModule
            end
        end
        if p42.activeOcclusionModule then
            if p42.activeOcclusionModule:GetOcclusionMode() ~= p43 then
                warn("CameraScript ActivateOcclusionModule mismatch: ", p42.activeOcclusionModule:GetOcclusionMode(), "~=", p43)
            end
            if v45 then
                if v45 == p42.activeOcclusionModule then
                    warn("CameraScript ActivateOcclusionModule failure to detect already running correct module")
                else
                    v45:Enable(false)
                end
            end
            if p43 == Enum.DevCameraOcclusionMode.Invisicam then
                if v_u_4.LocalPlayer.Character then
                    p42.activeOcclusionModule:CharacterAdded(v_u_4.LocalPlayer.Character, v_u_4.LocalPlayer)
                end
            else
                for _, v46 in pairs(v_u_4:GetPlayers()) do
                    if v46 and v46.Character then
                        p42.activeOcclusionModule:CharacterAdded(v46.Character, v46)
                    end
                end
                p42.activeOcclusionModule:OnCameraSubjectChanged(game.Workspace.CurrentCamera.CameraSubject)
            end
            p42.activeOcclusionModule:Enable(true)
        end
    end
end
function v_u_1.ShouldUseVehicleCamera(p47)
    local v48 = workspace.CurrentCamera
    if not v48 then
        return false
    end
    local v49 = v48.CameraType
    local v50 = v48.CameraSubject
    local v51 = v49 == Enum.CameraType.Custom and true or v49 == Enum.CameraType.Follow
    local v52 = v50 and v50:IsA("VehicleSeat") or false
    local v53 = p47.occlusionMode ~= Enum.DevCameraOcclusionMode.Invisicam
    if v52 then
        if not v51 then
            v53 = v51
        end
    else
        v53 = v52
    end
    return v53
end
function v_u_1.ActivateCameraController(p54, p55, p56)
    if v_u_28 then
        p56 = workspace.CurrentCamera.CameraType
        p55 = p54:GetCameraMovementModeFromSettings()
    end
    local v57 = nil
    if v_u_28 and true or p56 ~= nil then
        if p56 == Enum.CameraType.Scriptable then
            if p54.activeCameraController then
                p54.activeCameraController:Enable(false)
                p54.activeCameraController = nil
            end
            return
        end
        if p56 == Enum.CameraType.Custom then
            p55 = p54:GetCameraMovementModeFromSettings()
        elseif p56 == Enum.CameraType.Track then
            p55 = Enum.ComputerCameraMovementMode.Classic
        elseif p56 == Enum.CameraType.Follow then
            p55 = Enum.ComputerCameraMovementMode.Follow
        elseif p56 == Enum.CameraType.Orbital then
            p55 = Enum.ComputerCameraMovementMode.Orbital
        elseif p56 == Enum.CameraType.Attach or (p56 == Enum.CameraType.Watch or p56 == Enum.CameraType.Fixed) then
            v57 = v_u_16
        else
            warn("CameraScript encountered an unhandled Camera.CameraType value: ", p56)
        end
    end
    if not v57 then
        if v_u_7.VREnabled then
            v57 = v_u_18
        elseif p55 == Enum.ComputerCameraMovementMode.Classic or (p55 == Enum.ComputerCameraMovementMode.Follow or (p55 == Enum.ComputerCameraMovementMode.Default or p55 == Enum.ComputerCameraMovementMode.CameraToggle)) then
            v57 = v_u_14
        else
            if p55 ~= Enum.ComputerCameraMovementMode.Orbital then
                warn("ActivateCameraController did not select a module.")
                return
            end
            v57 = v_u_15
        end
    end
    if p54:ShouldUseVehicleCamera() then
        if v_u_7.VREnabled then
            v57 = v_u_19
        else
            v57 = v_u_17
        end
    end
    local v58
    if v_u_24[v57] then
        v58 = v_u_24[v57]
        if v58.Reset then
            v58:Reset()
        end
    else
        v58 = v57.new()
        v_u_24[v57] = v58
    end
    if p54.activeCameraController then
        if p54.activeCameraController == v58 then
            if not p54.activeCameraController:GetEnabled() then
                p54.activeCameraController:Enable(true)
            end
        else
            p54.activeCameraController:Enable(false)
            p54.activeCameraController = v58
            p54.activeCameraController:Enable(true)
        end
    elseif v58 ~= nil then
        p54.activeCameraController = v58
        local v59 = p54.activeCameraController
        assert(v59, "Strict typing check")
        p54.activeCameraController:Enable(true)
    end
    if p54.activeCameraController then
        if v_u_28 then
            p54.activeCameraController:SetCameraMovementMode(p55)
            p54.activeCameraController:SetCameraType(p56)
            return
        end
        if p55 ~= nil then
            p54.activeCameraController:SetCameraMovementMode(p55)
            return
        end
        if p56 ~= nil then
            p54.activeCameraController:SetCameraType(p56)
        end
    end
end
function v_u_1.OnCameraSubjectChanged(p60)
    local v61 = workspace.CurrentCamera
    local v62
    if v61 then
        v62 = v61.CameraSubject
    else
        v62 = nil
    end
    if p60.activeTransparencyController then
        p60.activeTransparencyController:SetSubject(v62)
    end
    if p60.activeOcclusionModule then
        p60.activeOcclusionModule:OnCameraSubjectChanged(v62)
    end
    local v63 = nil
    local v64
    if v61 then
        v64 = v61.CameraType
    else
        v64 = nil
    end
    p60:ActivateCameraController(v63, v64)
end
function v_u_1.OnCameraTypeChanged(p65, p66)
    if p66 == Enum.CameraType.Scriptable and v_u_6.MouseBehavior == Enum.MouseBehavior.LockCenter then
        v_u_12.restoreMouseBehavior()
    end
    p65:ActivateCameraController(nil, p66)
end
function v_u_1.OnCurrentCameraChanged(p_u_67)
    local v_u_68 = game.Workspace.CurrentCamera
    if v_u_68 then
        if p_u_67.cameraSubjectChangedConn then
            p_u_67.cameraSubjectChangedConn:Disconnect()
        end
        if p_u_67.cameraTypeChangedConn then
            p_u_67.cameraTypeChangedConn:Disconnect()
        end
        p_u_67.cameraSubjectChangedConn = v_u_68:GetPropertyChangedSignal("CameraSubject"):Connect(function()
            p_u_67:OnCameraSubjectChanged()
        end)
        p_u_67.cameraTypeChangedConn = v_u_68:GetPropertyChangedSignal("CameraType"):Connect(function()
            p_u_67:OnCameraTypeChanged(v_u_68.CameraType)
        end)
        p_u_67:OnCameraSubjectChanged()
        p_u_67:OnCameraTypeChanged(v_u_68.CameraType)
    end
end
function v_u_1.OnLocalPlayerCameraPropertyChanged(p69, p70)
    if p70 == "CameraMode" then
        if v_u_4.LocalPlayer.CameraMode ~= Enum.CameraMode.LockFirstPerson then
            if v_u_4.LocalPlayer.CameraMode == Enum.CameraMode.Classic then
                local v71 = p69:GetCameraMovementModeFromSettings()
                p69:ActivateCameraController(v_u_12.ConvertCameraModeEnumToStandard(v71))
            else
                warn("Unhandled value for property player.CameraMode: ", v_u_4.LocalPlayer.CameraMode)
            end
        end
        if not p69.activeCameraController or p69.activeCameraController:GetModuleName() ~= "ClassicCamera" then
            p69:ActivateCameraController(v_u_12.ConvertCameraModeEnumToStandard(Enum.DevComputerCameraMovementMode.Classic))
        end
        if p69.activeCameraController then
            p69.activeCameraController:UpdateForDistancePropertyChange()
            return
        end
    else
        if p70 == "DevComputerCameraMode" or p70 == "DevTouchCameraMode" then
            local v72 = p69:GetCameraMovementModeFromSettings()
            p69:ActivateCameraController(v_u_12.ConvertCameraModeEnumToStandard(v72))
            return
        end
        if p70 == "DevCameraOcclusionMode" then
            p69:ActivateOcclusionModule(v_u_4.LocalPlayer.DevCameraOcclusionMode)
            return
        end
        if p70 == "CameraMinZoomDistance" or p70 == "CameraMaxZoomDistance" then
            if p69.activeCameraController then
                p69.activeCameraController:UpdateForDistancePropertyChange()
                return
            end
        else
            if p70 == "DevTouchMovementMode" then
                return
            end
            if p70 == "DevComputerMovementMode" then
                return
            end
            local _ = p70 == "DevEnableMouseLock"
        end
    end
end
function v_u_1.OnUserGameSettingsPropertyChanged(p73, p74)
    if p74 == "ComputerCameraMovementMode" then
        local v75 = p73:GetCameraMovementModeFromSettings()
        p73:ActivateCameraController(v_u_12.ConvertCameraModeEnumToStandard(v75))
    end
end
function v_u_1.Update(p76, p77)
    if p76.activeCameraController then
        p76.activeCameraController:UpdateMouseBehavior()
        local v78, v79 = p76.activeCameraController:Update(p77)
        if p76.activeOcclusionModule then
            v78, v79 = p76.activeOcclusionModule:Update(p77, v78, v79)
        end
        local v80 = game.Workspace.CurrentCamera
        v80.CFrame = v78
        v80.Focus = v79
        if p76.activeTransparencyController then
            p76.activeTransparencyController:Update(p77)
        end
        if v_u_13.getInputEnabled() then
            v_u_13.resetInputForFrameEnd()
        end
    end
end
function v_u_1.GetCameraControlChoice(_)
    local v81 = not v_u_28
    assert(v81, "CameraModule:GetCameraControlChoice should not be called when FFlagUserRespectLegacyCameraOptions is enabled")
    if v_u_6:GetLastInputType() == Enum.UserInputType.Touch or v_u_6.TouchEnabled then
        if v_u_4.LocalPlayer.DevTouchCameraMode == Enum.DevTouchCameraMovementMode.UserChoice then
            return v_u_12.ConvertCameraModeEnumToStandard(v_u_8.TouchCameraMovementMode)
        else
            return v_u_12.ConvertCameraModeEnumToStandard(v_u_4.LocalPlayer.DevTouchCameraMode)
        end
    else
        if v_u_4.LocalPlayer.DevComputerCameraMode ~= Enum.DevComputerCameraMovementMode.UserChoice then
            return v_u_12.ConvertCameraModeEnumToStandard(v_u_4.LocalPlayer.DevComputerCameraMode)
        end
        local v82 = v_u_12.ConvertCameraModeEnumToStandard(v_u_8.ComputerCameraMovementMode)
        return v_u_12.ConvertCameraModeEnumToStandard(v82)
    end
end
function v_u_1.OnCharacterAdded(p83, p84, p85)
    if p83.activeOcclusionModule then
        p83.activeOcclusionModule:CharacterAdded(p84, p85)
    end
end
function v_u_1.OnCharacterRemoving(p86, p87, p88)
    if p86.activeOcclusionModule then
        p86.activeOcclusionModule:CharacterRemoving(p87, p88)
    end
end
function v_u_1.OnPlayerAdded(p_u_89, p_u_90)
    p_u_89.connectionUtil:trackConnection(("%*CharacterAdded"):format(p_u_90.UserId), p_u_90.CharacterAdded:Connect(function(p91)
        p_u_89:OnCharacterAdded(p91, p_u_90)
    end))
    p_u_89.connectionUtil:trackConnection(("%*CharacterRemoving"):format(p_u_90.UserId), p_u_90.CharacterRemoving:Connect(function(p92)
        p_u_89:OnCharacterRemoving(p92, p_u_90)
    end))
end
function v_u_1.OnPlayerRemoving(p93, p94)
    p93.connectionUtil:disconnect((("%*CharacterAdded"):format(p94.UserId)))
    p93.connectionUtil:disconnect((("%*CharacterRemoving"):format(p94.UserId)))
end
function v_u_1.OnMouseLockToggled(p95)
    if p95.activeMouseLockController then
        local v96 = p95.activeMouseLockController:GetIsMouseLocked()
        local v97 = p95.activeMouseLockController:GetMouseLockOffset()
        if p95.activeCameraController then
            p95.activeCameraController:SetIsMouseLocked(v96)
            p95.activeCameraController:SetMouseLockOffset(v97)
        end
    end
end
v_u_1.new()
return {}