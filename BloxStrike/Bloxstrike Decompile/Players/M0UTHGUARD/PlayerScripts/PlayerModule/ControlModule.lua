local v_u_1 = {}
v_u_1.__index = v_u_1
local v_u_2 = game:GetService("Players")
local v_u_3 = game:GetService("RunService")
local v_u_4 = game:GetService("UserInputService")
local v_u_5 = game:GetService("GuiService")
local v_u_6 = game:GetService("Workspace")
local v_u_7 = UserSettings():GetService("UserGameSettings")
local v_u_8 = game:GetService("VRService")
script.Parent:WaitForChild("CommonUtils")
local v_u_9 = require(script:WaitForChild("Keyboard"))
local v_u_10 = require(script:WaitForChild("Gamepad"))
local v_u_11 = require(script:WaitForChild("DynamicThumbstick"))
local v12, v13 = pcall(function()
    return UserSettings():IsUserFeatureEnabled("UserDynamicThumbstickSafeAreaUpdate")
end)
local v_u_14 = v12 and v13
local v_u_15 = require(script:WaitForChild("TouchThumbstick"))
local v_u_16 = require(script:WaitForChild("ClickToMoveController"))
local v_u_17 = require(script:WaitForChild("TouchJump"))
local v_u_18 = require(script:WaitForChild("VehicleController"))
local v_u_19 = Enum.ContextActionPriority.Medium.Value
local v_u_20 = {
    [Enum.TouchMovementMode.DPad] = v_u_11,
    [Enum.DevTouchMovementMode.DPad] = v_u_11,
    [Enum.TouchMovementMode.Thumbpad] = v_u_11,
    [Enum.DevTouchMovementMode.Thumbpad] = v_u_11,
    [Enum.TouchMovementMode.Thumbstick] = v_u_15,
    [Enum.DevTouchMovementMode.Thumbstick] = v_u_15,
    [Enum.TouchMovementMode.DynamicThumbstick] = v_u_11,
    [Enum.DevTouchMovementMode.DynamicThumbstick] = v_u_11,
    [Enum.TouchMovementMode.Default] = v_u_11,
    [Enum.ComputerMovementMode.Default] = v_u_9,
    [Enum.ComputerMovementMode.KeyboardMouse] = v_u_9,
    [Enum.DevComputerMovementMode.KeyboardMouse] = v_u_9,
    [Enum.DevComputerMovementMode.Scriptable] = nil,
    [Enum.ComputerMovementMode.ClickToMove] = v_u_16,
    [Enum.DevComputerMovementMode.ClickToMove] = v_u_16
}
local v_u_21 = {
    [Enum.UserInputType.Keyboard] = v_u_9,
    [Enum.UserInputType.MouseButton1] = v_u_9,
    [Enum.UserInputType.MouseButton2] = v_u_9,
    [Enum.UserInputType.MouseButton3] = v_u_9,
    [Enum.UserInputType.MouseWheel] = v_u_9,
    [Enum.UserInputType.MouseMovement] = v_u_9,
    [Enum.UserInputType.Gamepad1] = v_u_10,
    [Enum.UserInputType.Gamepad2] = v_u_10,
    [Enum.UserInputType.Gamepad3] = v_u_10,
    [Enum.UserInputType.Gamepad4] = v_u_10
}
local v_u_22 = nil
function v_u_1.new()
    local v23 = v_u_1
    local v_u_24 = setmetatable({}, v23)
    v_u_24.controllers = {}
    v_u_24.activeControlModule = nil
    v_u_24.activeController = nil
    v_u_24.touchJumpController = nil
    v_u_24.moveFunction = v_u_2.LocalPlayer.Move
    v_u_24.humanoid = nil
    v_u_24.lastInputType = Enum.UserInputType.None
    v_u_24.controlsEnabled = true
    v_u_24.humanoidSeatedConn = nil
    v_u_24.vehicleController = nil
    v_u_24.touchControlFrame = nil
    v_u_24.currentTorsoAngle = 0
    v_u_24.inputMoveVector = Vector3.new(0, 0, 0)
    v_u_24.vehicleController = v_u_18.new(v_u_19)
    v_u_2.LocalPlayer.CharacterAdded:Connect(function(p25)
        v_u_24:OnCharacterAdded(p25)
    end)
    v_u_2.LocalPlayer.CharacterRemoving:Connect(function(p26)
        v_u_24:OnCharacterRemoving(p26)
    end)
    if v_u_2.LocalPlayer.Character then
        v_u_24:OnCharacterAdded(v_u_2.LocalPlayer.Character)
    end
    v_u_3:BindToRenderStep("ControlScriptRenderstep", Enum.RenderPriority.Input.Value, function(p27)
        v_u_24:OnRenderStepped(p27)
    end)
    v_u_4.LastInputTypeChanged:Connect(function(p28)
        v_u_24:OnLastInputTypeChanged(p28)
    end)
    v_u_7:GetPropertyChangedSignal("TouchMovementMode"):Connect(function()
        v_u_24:OnTouchMovementModeChange()
    end)
    v_u_2.LocalPlayer:GetPropertyChangedSignal("DevTouchMovementMode"):Connect(function()
        v_u_24:OnTouchMovementModeChange()
    end)
    v_u_7:GetPropertyChangedSignal("ComputerMovementMode"):Connect(function()
        v_u_24:OnComputerMovementModeChange()
    end)
    v_u_2.LocalPlayer:GetPropertyChangedSignal("DevComputerMovementMode"):Connect(function()
        v_u_24:OnComputerMovementModeChange()
    end)
    v_u_24.playerGui = nil
    v_u_24.touchGui = nil
    v_u_24.playerGuiAddedConn = nil
    v_u_5:GetPropertyChangedSignal("TouchControlsEnabled"):Connect(function()
        v_u_24:UpdateTouchGuiVisibility()
        v_u_24:UpdateActiveControlModuleEnabled()
    end)
    if not v_u_4.TouchEnabled then
        v_u_24:OnLastInputTypeChanged(v_u_4:GetLastInputType())
        return v_u_24
    end
    v_u_24.playerGui = v_u_2.LocalPlayer:FindFirstChildOfClass("PlayerGui")
    if not v_u_24.playerGui then
        v_u_24.playerGuiAddedConn = v_u_2.LocalPlayer.ChildAdded:Connect(function(p29)
            if p29:IsA("PlayerGui") then
                v_u_24.playerGui = p29
                v_u_24:CreateTouchGuiContainer()
                v_u_24.playerGuiAddedConn:Disconnect()
                v_u_24.playerGuiAddedConn = nil
                v_u_24:OnLastInputTypeChanged(v_u_4:GetLastInputType())
            end
        end)
        return v_u_24
    end
    v_u_24:CreateTouchGuiContainer()
    v_u_24:OnLastInputTypeChanged(v_u_4:GetLastInputType())
    return v_u_24
end
function v_u_1.GetMoveVector(p30)
    return not p30.activeController and Vector3.new(0, 0, 0) or p30.activeController:GetMoveVector()
end
function v_u_1.GetEstimatedVRTorsoFrame(p31)
    local v32 = v_u_8:GetUserCFrame(Enum.UserCFrame.Head)
    local _, v33, _ = v32:ToEulerAnglesYXZ()
    local v34 = -v33
    if v_u_8:GetUserCFrameEnabled(Enum.UserCFrame.RightHand) and v_u_8:GetUserCFrameEnabled(Enum.UserCFrame.LeftHand) then
        local v35 = v_u_8:GetUserCFrame(Enum.UserCFrame.LeftHand)
        local v36 = v_u_8:GetUserCFrame(Enum.UserCFrame.RightHand)
        local v37 = v32.Position - v35.Position
        local v38 = v32.Position - v36.Position
        local v39 = v37.X
        local v40 = v37.Z
        local v41 = -math.atan2(v39, v40)
        local v42 = v38.X
        local v43 = v38.Z
        local v44 = (-math.atan2(v42, v43) - v41 + 12.566370614359172) % 6.283185307179586
        if v44 > 3.141592653589793 then
            v44 = v44 - 6.283185307179586
        end
        local v45 = (v41 + v44 / 2 + 12.566370614359172) % 6.283185307179586
        if v45 > 3.141592653589793 then
            v45 = v45 - 6.283185307179586
        end
        local v46 = (v34 - p31.currentTorsoAngle + 12.566370614359172) % 6.283185307179586
        if v46 > 3.141592653589793 then
            v46 = v46 - 6.283185307179586
        end
        local v47 = (v45 - p31.currentTorsoAngle + 12.566370614359172) % 6.283185307179586
        if v47 > 3.141592653589793 then
            v47 = v47 - 6.283185307179586
        end
        local v48
        if v47 > -1.5707963267948966 then
            v48 = v47 < 1.5707963267948966
        else
            v48 = false
        end
        if not v48 then
            v47 = v46
        end
        local v49 = math.min(v47, v46)
        local v50 = math.max(v47, v46)
        local v51 = 0
        if v49 > 0 then
            v50 = v49
        elseif v50 >= 0 then
            v50 = v51
        end
        p31.currentTorsoAngle = v50 + p31.currentTorsoAngle
    else
        p31.currentTorsoAngle = v34
    end
    return CFrame.new(v32.Position) * CFrame.fromEulerAnglesYXZ(0, -p31.currentTorsoAngle, 0)
end
function v_u_1.GetActiveController(p52)
    return p52.activeController
end
function v_u_1.UpdateActiveControlModuleEnabled(p_u_53)
    local function v54()
        if p_u_53.touchControlFrame and (p_u_53.activeControlModule == v_u_16 or (p_u_53.activeControlModule == v_u_15 or p_u_53.activeControlModule == v_u_11)) then
            if not p_u_53.controllers[v_u_17] then
                p_u_53.controllers[v_u_17] = v_u_17.new()
            end
            p_u_53.touchJumpController = p_u_53.controllers[v_u_17]
            p_u_53.touchJumpController:Enable(true, p_u_53.touchControlFrame)
        elseif p_u_53.touchJumpController then
            p_u_53.touchJumpController:Enable(false)
        end
        if p_u_53.activeControlModule == v_u_16 then
            p_u_53.activeController:Enable(true, v_u_2.LocalPlayer.DevComputerMovementMode == Enum.DevComputerMovementMode.UserChoice, p_u_53.touchJumpController)
            return
        elseif p_u_53.touchControlFrame then
            p_u_53.activeController:Enable(true, p_u_53.touchControlFrame)
        else
            p_u_53.activeController:Enable(true)
        end
    end
    if p_u_53.activeController then
        if p_u_53.controlsEnabled then
            if v_u_5.TouchControlsEnabled or (not v_u_4.TouchEnabled or p_u_53.activeControlModule ~= v_u_16 and (p_u_53.activeControlModule ~= v_u_15 and p_u_53.activeControlModule ~= v_u_11)) then
                v54()
            else
                p_u_53.activeController:Enable(false)
                if p_u_53.touchJumpController then
                    p_u_53.touchJumpController:Enable(false)
                end
                if p_u_53.moveFunction then
                    p_u_53.moveFunction(v_u_2.LocalPlayer, Vector3.new(0, 0, 0), true)
                end
            end
        else
            p_u_53.activeController:Enable(false)
            if p_u_53.touchJumpController then
                p_u_53.touchJumpController:Enable(false)
            end
            if p_u_53.moveFunction then
                p_u_53.moveFunction(v_u_2.LocalPlayer, Vector3.new(0, 0, 0), true)
            end
            return
        end
    else
        return
    end
end
function v_u_1.Enable(p55, p56)
    local v57 = p56 == nil and true or p56
    if p55.controlsEnabled == v57 then
        return
    else
        p55.controlsEnabled = v57
        if p55.activeController then
            p55:UpdateActiveControlModuleEnabled()
        end
    end
end
function v_u_1.Disable(p58)
    p58:Enable(false)
end
function v_u_1.SelectComputerMovementModule(_)
    if v_u_4.KeyboardEnabled or v_u_4.GamepadEnabled then
        local v59 = v_u_2.LocalPlayer.DevComputerMovementMode
        local v60
        if v59 == Enum.DevComputerMovementMode.UserChoice then
            v60 = v_u_21[v_u_22]
            if v_u_7.ComputerMovementMode == Enum.ComputerMovementMode.ClickToMove and v60 == v_u_9 then
                v60 = v_u_16
            end
        else
            v60 = v_u_20[v59]
            if not v60 and v59 ~= Enum.DevComputerMovementMode.Scriptable then
                warn("No character control module is associated with DevComputerMovementMode ", v59)
            end
        end
        if v60 then
            return v60, true
        elseif v59 == Enum.DevComputerMovementMode.Scriptable then
            return nil, true
        else
            return nil, false
        end
    else
        return nil, false
    end
end
function v_u_1.SelectTouchModule(_)
    if not v_u_4.TouchEnabled then
        return nil, false
    end
    local v61 = v_u_2.LocalPlayer.DevTouchMovementMode
    local v62
    if v61 == Enum.DevTouchMovementMode.UserChoice then
        local v63 = v_u_7.TouchMovementMode
        if v63 == Enum.TouchMovementMode.ClickToMove then
            v62 = v_u_11
        else
            v62 = v_u_20[v63] or v_u_11
        end
    else
        if v61 == Enum.DevTouchMovementMode.Scriptable then
            return nil, true
        end
        if v61 == Enum.DevTouchMovementMode.ClickToMove then
            v62 = v_u_11
        else
            v62 = v_u_20[v61] or v_u_11
        end
    end
    return v62, true
end
local function v_u_66()
    local v64 = v_u_4:GetGamepadState(Enum.UserInputType.Gamepad1)
    for _, v65 in pairs(v64) do
        if v65.KeyCode == Enum.KeyCode.Thumbstick2 then
            return v65.Position
        end
    end
    return Vector3.new(0, 0, 0)
end
function v_u_1.calculateRawMoveVector(p67, p68, p69)
    local v70 = v_u_6.CurrentCamera
    if not v70 then
        return p69
    end
    local v71 = v70.CFrame
    if v_u_8.VREnabled and p68.RootPart then
        v_u_8:GetUserCFrame(Enum.UserCFrame.Head)
        local v72 = p67:GetEstimatedVRTorsoFrame()
        if (v70.Focus.Position - v71.Position).Magnitude < 3 then
            v71 = v71 * v72
        else
            v71 = v70.CFrame * (v72.Rotation + v72.Position * v70.HeadScale)
        end
    end
    if p68:GetState() ~= Enum.HumanoidStateType.Swimming then
        local _, _, _, v77, v74, v75, _, _, v76, _, _, v77 = v71:GetComponents()
        if v76 >= 1 or v76 <= -1 then
            v75 = -v74 * math.sign(v76)
        end
        local v78 = v77 * v77 + v75 * v75
        local v79 = math.sqrt(v78)
        local v80 = (v77 * p69.X + v75 * p69.Z) / v79
        local v81 = (v77 * p69.Z - v75 * p69.X) / v79
        return Vector3.new(v80, 0, v81)
    end
    if not v_u_8.VREnabled then
        return v71:VectorToWorldSpace(p69)
    end
    local v82 = p69.X
    local v83 = p69.Z
    local v84 = Vector3.new(v82, 0, v83)
    if v84.Magnitude < 0.01 then
        return Vector3.new(0, 0, 0)
    end
    local v85 = -v_u_66().Y * 1.3962634015954636
    local v86 = -v84.X
    local v87 = -v84.Z
    local v88 = math.atan2(v86, v87)
    local _, v89, _ = v71:ToEulerAnglesYXZ()
    local v90 = v88 + v89
    return CFrame.fromEulerAnglesYXZ(v85, v90, 0).LookVector
end
function v_u_1.OnRenderStepped(p91, p92)
    if p91.activeController and (p91.activeController.enabled and p91.humanoid) then
        local v93 = p91.activeController:GetMoveVector()
        local v94 = p91.activeController:IsMoveVectorCameraRelative()
        local v95 = p91:GetClickToMoveController()
        if p91.activeController == v95 then
            v95:OnRenderStepped(p92)
        elseif v93.magnitude > 0 then
            v95:CleanupPath()
        else
            v95:OnRenderStepped(p92)
            v93 = v95:GetMoveVector()
            v94 = v95:IsMoveVectorCameraRelative()
        end
        if p91.vehicleController then
            local v96
            v93, v96 = p91.vehicleController:Update(v93, v94, p91.activeControlModule == v_u_10)
        end
        if v94 then
            v93 = p91:calculateRawMoveVector(p91.humanoid, v93)
        end
        p91.inputMoveVector = v93
        if v_u_8.VREnabled then
            v93 = p91:updateVRMoveVector(v93)
        end
        p91.moveFunction(v_u_2.LocalPlayer, v93, false)
    end
end
function v_u_1.updateVRMoveVector(p97, p98)
    local v99 = workspace.CurrentCamera
    local v100 = (v99.Focus.Position - v99.CFrame.Position).Magnitude < 5
    if p98.Magnitude ~= 0 or (not v100 or (not v_u_8.AvatarGestures or (not p97.humanoid or p97.humanoid.Sit))) then
        return p98
    end
    local v101 = v_u_8:GetUserCFrame(Enum.UserCFrame.Head)
    local v102 = v101.Rotation + v101.Position * v99.HeadScale
    local v103 = -0.7 * p97.humanoid.RootPart.Size.Y / 2
    local v104 = (v99.CFrame * v102 * CFrame.new(0, v103, 0)).Position - p97.humanoid.RootPart.CFrame.Position
    local v105 = v104.x
    local v106 = v104.z
    return Vector3.new(v105, 0, v106)
end
function v_u_1.OnHumanoidSeated(p107, p108, p109)
    if p108 then
        if p109 and p109:IsA("VehicleSeat") then
            if not p107.vehicleController then
                p107.vehicleController = p107.vehicleController.new(v_u_19)
            end
            p107.vehicleController:Enable(true, p109)
            return
        end
    elseif p107.vehicleController then
        p107.vehicleController:Enable(false, p109)
    end
end
function v_u_1.OnCharacterAdded(p_u_110, p111)
    p_u_110.humanoid = p111:FindFirstChildOfClass("Humanoid")
    while not p_u_110.humanoid do
        p111.ChildAdded:wait()
        p_u_110.humanoid = p111:FindFirstChildOfClass("Humanoid")
    end
    p_u_110:UpdateTouchGuiVisibility()
    if p_u_110.humanoidSeatedConn then
        p_u_110.humanoidSeatedConn:Disconnect()
        p_u_110.humanoidSeatedConn = nil
    end
    p_u_110.humanoidSeatedConn = p_u_110.humanoid.Seated:Connect(function(p112, p113)
        p_u_110:OnHumanoidSeated(p112, p113)
    end)
end
function v_u_1.OnCharacterRemoving(p114, _)
    p114.humanoid = nil
    p114:UpdateTouchGuiVisibility()
end
function v_u_1.UpdateTouchGuiVisibility(p115)
    if p115.touchGui then
        local v116 = p115.humanoid
        if v116 then
            v116 = v_u_5.TouchControlsEnabled
        end
        p115.touchGui.Enabled = v116 and true or false
    end
end
function v_u_1.SwitchToController(p117, p118)
    if p118 then
        if not p117.controllers[p118] then
            p117.controllers[p118] = p118.new(v_u_19)
        end
        if p117.activeController ~= p117.controllers[p118] then
            if p117.activeController then
                p117.activeController:Enable(false)
            end
            p117.activeController = p117.controllers[p118]
            p117.activeControlModule = p118
            p117:UpdateActiveControlModuleEnabled()
        end
    else
        if p117.activeController then
            p117.activeController:Enable(false)
        end
        p117.activeController = nil
        p117.activeControlModule = nil
    end
end
function v_u_1.OnLastInputTypeChanged(p119, p120)
    if v_u_22 == p120 then
        warn("LastInputType Change listener called with current type.")
    end
    v_u_22 = p120
    if v_u_22 == Enum.UserInputType.Touch then
        local v121, v122 = p119:SelectTouchModule()
        if v122 then
            while not p119.touchControlFrame do
                wait()
            end
            p119:SwitchToController(v121)
        end
    elseif v_u_21[v_u_22] ~= nil then
        local v123 = p119:SelectComputerMovementModule()
        if v123 then
            p119:SwitchToController(v123)
        end
    end
    p119:UpdateTouchGuiVisibility()
end
function v_u_1.OnComputerMovementModeChange(p124)
    local v125, v126 = p124:SelectComputerMovementModule()
    if v126 then
        p124:SwitchToController(v125)
    end
end
function v_u_1.OnTouchMovementModeChange(p127)
    local v128, v129 = p127:SelectTouchModule()
    if v129 then
        while not p127.touchControlFrame do
            wait()
        end
        p127:SwitchToController(v128)
    end
end
function v_u_1.CreateTouchGuiContainer(p130)
    if p130.touchGui then
        p130.touchGui:Destroy()
    end
    p130.touchGui = Instance.new("ScreenGui")
    p130.touchGui.Name = "TouchGui"
    p130.touchGui.ResetOnSpawn = false
    p130.touchGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    p130:UpdateTouchGuiVisibility()
    if v_u_14 then
        p130.touchGui.ClipToDeviceSafeArea = false
    end
    p130.touchControlFrame = Instance.new("Frame")
    p130.touchControlFrame.Name = "TouchControlFrame"
    p130.touchControlFrame.Size = UDim2.new(1, 0, 1, 0)
    p130.touchControlFrame.BackgroundTransparency = 1
    p130.touchControlFrame.Parent = p130.touchGui
    p130.touchGui.Parent = p130.playerGui
end
function v_u_1.GetClickToMoveController(p131)
    if not p131.controllers[v_u_16] then
        p131.controllers[v_u_16] = v_u_16.new(v_u_19)
    end
    return p131.controllers[v_u_16]
end
return v_u_1.new()