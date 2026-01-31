local v_u_1 = game:GetService("ContextActionService")
local v_u_2 = game:GetService("UserInputService")
local v3 = game:GetService("Players")
local v4 = game:GetService("RunService")
local v_u_5 = UserSettings():GetService("UserGameSettings")
local v_u_6 = game:GetService("VRService")
local v7 = script.Parent.Parent:WaitForChild("CommonUtils")
local v_u_8 = require(v7:WaitForChild("FlagUtil")).getUserFlag("UserCameraInputDt")
local v_u_9 = v3.LocalPlayer
local v_u_10 = Enum.ContextActionPriority.Medium.Value
local v_u_11 = Vector2.new(1, 0.77) * 0.06981317007977318
local v_u_12 = Vector2.new(1, 0.77) * 0.008726646259971648
local v_u_13 = Vector2.new(1, 0.77) * 0.12217304763960307
local v_u_14 = Vector2.new(1, 0.66) * 0.017453292519943295
if v_u_8 then
    v_u_11 = v_u_11 * 60
end
local v15, v16 = pcall(function()
    return UserSettings():IsUserFeatureEnabled("UserResetTouchStateOnMenuOpen")
end)
local v_u_17 = v15 and v16
local v18, v19 = pcall(function()
    return UserSettings():IsUserFeatureEnabled("UserClearPanOnCameraDisable")
end)
local v_u_20 = v18 and v19
local v_u_21 = Instance.new("BindableEvent")
local v_u_22 = Instance.new("BindableEvent")
local v_u_23 = v_u_21.Event
local v_u_24 = v_u_22.Event
v_u_2.InputBegan:Connect(function(p25, p26)
    if not p26 and p25.UserInputType == Enum.UserInputType.MouseButton2 then
        v_u_21:Fire()
    end
end)
v_u_2.InputEnded:Connect(function(p27, _)
    if p27.UserInputType == Enum.UserInputType.MouseButton2 then
        v_u_22:Fire()
    end
end)
local function v_u_31(p28)
    local v29 = (math.abs(p28) - 0.1) / 0.9 * 2
    local v30 = (math.exp(v29) - 1) / 6.38905609893065
    return math.sign(p28) * math.clamp(v30, 0, 1)
end
local function v_u_36(p32)
    local v33 = workspace.CurrentCamera
    if not v33 then
        return p32
    end
    local v34 = v33.CFrame:ToEulerAnglesYXZ()
    if p32.Y * v34 >= 0 then
        return p32
    end
    local v35 = (1 - (math.abs(v34) * 2 / 3.141592653589793) ^ 0.75) * 0.75 + 0.25
    return Vector2.new(1, v35) * p32
end
local function v_u_43(p37)
    local v38 = v_u_9:FindFirstChildOfClass("PlayerGui")
    if v38 then
        v38 = v38:FindFirstChild("TouchGui")
    end
    local v39
    if v38 then
        v39 = v38:FindFirstChild("TouchControlFrame")
    else
        v39 = v38
    end
    if v39 then
        v39 = v39:FindFirstChild("DynamicThumbstickFrame")
    end
    if not v39 then
        return false
    end
    if not v38.Enabled then
        return false
    end
    local v40 = v39.AbsolutePosition
    local v41 = v40 + v39.AbsoluteSize
    local v42
    if p37.X >= v40.X and (p37.Y >= v40.Y and p37.X <= v41.X) then
        v42 = p37.Y <= v41.Y
    else
        v42 = false
    end
    return v42
end
local v_u_44 = 0.016666666666666666
v4.Stepped:Connect(function(_, p45)
    v_u_44 = p45
end)
local v46 = {}
local v_u_47 = {}
local v_u_48 = 0
local v_u_49 = 1
local v_u_50 = {
    ["Thumbstick2"] = Vector2.new()
}
local v_u_51 = {
    ["Left"] = 0,
    ["Right"] = 0,
    ["I"] = 0,
    ["O"] = 0
}
local v_u_52 = {
    ["Movement"] = Vector2.new(),
    ["Wheel"] = 0,
    ["Pan"] = Vector2.new(),
    ["Pinch"] = 0
}
local v_u_53 = {
    ["Move"] = Vector2.new(),
    ["Pinch"] = 0
}
local v_u_54 = Instance.new("BindableEvent")
v46.gamepadZoomPress = v_u_54.Event
local v_u_55 = v_u_6.VREnabled and Instance.new("BindableEvent") or nil
if v_u_6.VREnabled then
    v46.gamepadReset = v_u_55.Event
end
function v46.getRotationActivated()
    return v_u_48 > 0 and true or v_u_50.Thumbstick2.Magnitude > 0
end
function v46.addTouchMove(p56)
    local v57 = v_u_53
    v57.Move = v57.Move + p56
end
function v46.setTouchSensitivity(p58)
    v_u_49 = math.clamp(p58 or 1, 0.1, 10)
end
function v46.getRotation(p59, p60)
    local v61 = Vector2.new(1, v_u_5:GetCameraYInvertValue())
    local v62
    if v_u_8 then
        v62 = Vector2.new(v_u_51.Right - v_u_51.Left, 0) * p59
    else
        v62 = Vector2.new(v_u_51.Right - v_u_51.Left, 0) * v_u_44
    end
    local v63 = v_u_50.Thumbstick2 * v_u_5.GamepadCameraSensitivity
    if v_u_8 then
        v63 = v63 * p59
    end
    local v64 = v_u_52.Movement
    local v65 = v_u_52.Pan
    local v66 = v_u_36(v_u_53.Move)
    if p60 then
        v62 = Vector2.new()
    end
    return (v62 * 2.0943951023931953 + v63 * v_u_11 + v64 * v_u_12 + v65 * v_u_13 + v66 * v_u_14 * v_u_49) * v61
end
function v46.getZoomDelta()
    local v67 = v_u_51.O - v_u_51.I
    local v68 = -v_u_52.Wheel + v_u_52.Pinch
    local v69 = -v_u_53.Pinch
    return v67 * 0.1 + v68 * 1 + v69 * 0.04
end
local function v_u_72(_, _, p70)
    local v71 = p70.Position
    v_u_50[p70.KeyCode.Name] = Vector2.new(v_u_31(v71.X), -v_u_31(v71.Y))
    return Enum.ContextActionResult.Pass
end
local function v_u_75(_, p73, p74)
    v_u_51[p74.KeyCode.Name] = p73 == Enum.UserInputState.Begin and 1 or 0
end
local function v_u_77(_, p76, _)
    if p76 == Enum.UserInputState.Begin then
        v_u_54:Fire()
    end
end
local function v_u_79(_, p78, _)
    if p78 == Enum.UserInputState.Begin then
        v_u_55:Fire()
    end
end
local function v_u_84()
    local v80 = {
        v_u_50,
        v_u_51,
        v_u_52,
        v_u_53
    }
    for _, v81 in pairs(v80) do
        for v82, v83 in pairs(v81) do
            if type(v83) == "boolean" then
                v81[v82] = false
            else
                v81[v82] = v81[v82] * 0
            end
        end
    end
    if v_u_20 then
        v_u_48 = 0
    end
end
local v_u_85 = {}
local v_u_86 = nil
local v_u_87 = nil
local function v_u_93(p88, p89)
    local v90 = p88.UserInputType == Enum.UserInputType.Touch
    assert(v90)
    local v91 = p88.UserInputState == Enum.UserInputState.Begin
    assert(v91)
    if v_u_86 == nil and (v_u_43(p88.Position) and not p89) then
        v_u_86 = p88
    else
        if not p89 then
            local v92 = v_u_48 + 1
            v_u_48 = math.max(0, v92)
        end
        v_u_85[p88] = p89
    end
end
local function v_u_98(p94, _)
    local v95 = p94.UserInputType == Enum.UserInputType.Touch
    assert(v95)
    local v96 = p94.UserInputState == Enum.UserInputState.End
    assert(v96)
    if p94 == v_u_86 then
        v_u_86 = nil
    end
    if v_u_85[p94] == false then
        v_u_87 = nil
        local v97 = v_u_48 - 1
        v_u_48 = math.max(0, v97)
    end
    v_u_85[p94] = nil
end
local function v_u_110(p99, p100)
    local v101 = p99.UserInputType == Enum.UserInputType.Touch
    assert(v101)
    local v102 = p99.UserInputState == Enum.UserInputState.Change
    assert(v102)
    if p99 == v_u_86 then
        return
    else
        if v_u_85[p99] == nil then
            v_u_85[p99] = p100
        end
        local v103 = {}
        for v104, v105 in pairs(v_u_85) do
            if not v105 then
                table.insert(v103, v104)
            end
        end
        if #v103 == 1 and v_u_85[p99] == false then
            local v106 = p99.Delta
            local v107 = v_u_53
            v107.Move = v107.Move + Vector2.new(v106.X, v106.Y)
        end
        if #v103 == 2 then
            local v108 = (v103[1].Position - v103[2].Position).Magnitude
            if v_u_87 then
                local v109 = v_u_53
                v109.Pinch = v109.Pinch + (v108 - v_u_87)
            end
            v_u_87 = v108
        else
            v_u_87 = nil
        end
    end
end
local function v_u_111()
    v_u_85 = {}
    v_u_86 = nil
    v_u_87 = nil
    if v_u_17 then
        v_u_48 = 0
    end
end
local function v_u_116(p112, p113, p114, p115)
    if not p115 then
        v_u_52.Wheel = p112
        v_u_52.Pan = p113
        v_u_52.Pinch = -p114
    end
end
local function v_u_120(p117, p118)
    if p117.UserInputType == Enum.UserInputType.Touch then
        v_u_93(p117, p118)
    elseif p117.UserInputType == Enum.UserInputType.MouseButton2 and not p118 then
        local v119 = v_u_48 + 1
        v_u_48 = math.max(0, v119)
    end
end
local function v_u_124(p121, p122)
    if p121.UserInputType == Enum.UserInputType.Touch then
        v_u_110(p121, p122)
    elseif p121.UserInputType == Enum.UserInputType.MouseMovement then
        local v123 = p121.Delta
        v_u_52.Movement = Vector2.new(v123.X, v123.Y)
    end
end
local function v_u_128(p125, p126)
    if p125.UserInputType == Enum.UserInputType.Touch then
        v_u_98(p125, p126)
    elseif p125.UserInputType == Enum.UserInputType.MouseButton2 then
        local v127 = v_u_48 - 1
        v_u_48 = math.max(0, v127)
    end
end
local v_u_129 = false
function v46.setInputEnabled(p130)
    if v_u_129 ~= p130 then
        v_u_129 = p130
        v_u_84()
        v_u_111()
        if v_u_129 then
            v_u_1:BindActionAtPriority("RbxCameraThumbstick", v_u_72, false, v_u_10, Enum.KeyCode.Thumbstick2)
            v_u_1:BindActionAtPriority("RbxCameraKeypress", v_u_75, false, v_u_10, Enum.KeyCode.I, Enum.KeyCode.O)
            if v_u_6.VREnabled then
                v_u_1:BindAction("RbxCameraGamepadReset", v_u_79, false, Enum.KeyCode.ButtonL3)
            end
            v_u_1:BindAction("RbxCameraGamepadZoom", v_u_77, false, Enum.KeyCode.ButtonR3)
            local v131 = v_u_47
            local v132 = v_u_2.InputBegan
            local v133 = v_u_120
            table.insert(v131, v132:Connect(v133))
            local v134 = v_u_47
            local v135 = v_u_2.InputChanged
            local v136 = v_u_124
            table.insert(v134, v135:Connect(v136))
            local v137 = v_u_47
            local v138 = v_u_2.InputEnded
            local v139 = v_u_128
            table.insert(v137, v138:Connect(v139))
            local v140 = v_u_47
            local v141 = v_u_2.PointerAction
            local v142 = v_u_116
            table.insert(v140, v141:Connect(v142))
            if v_u_17 then
                local v143 = v_u_47
                local v144 = game:GetService("GuiService").MenuOpened
                local v145 = v_u_111
                table.insert(v143, v144:connect(v145))
                return
            end
        else
            v_u_1:UnbindAction("RbxCameraThumbstick")
            v_u_1:UnbindAction("RbxCameraMouseMove")
            v_u_1:UnbindAction("RbxCameraMouseWheel")
            v_u_1:UnbindAction("RbxCameraKeypress")
            v_u_1:UnbindAction("RbxCameraGamepadZoom")
            if v_u_6.VREnabled then
                v_u_1:UnbindAction("RbxCameraGamepadReset")
            end
            for _, v146 in pairs(v_u_47) do
                v146:Disconnect()
            end
            v_u_47 = {}
        end
    end
end
function v46.getInputEnabled()
    return v_u_129
end
function v46.resetInputForFrameEnd()
    v_u_52.Movement = Vector2.new()
    v_u_53.Move = Vector2.new()
    v_u_53.Pinch = 0
    v_u_52.Wheel = 0
    v_u_52.Pan = Vector2.new()
    v_u_52.Pinch = 0
end
v_u_2.WindowFocused:Connect(v_u_84)
v_u_2.WindowFocusReleased:Connect(v_u_84)
local v_u_147 = false
local v_u_148 = false
local v_u_149 = 0
function v46.getHoldPan()
    return v_u_147
end
function v46.getTogglePan()
    return v_u_148
end
function v46.getPanning()
    return v_u_148 or v_u_147
end
function v46.setTogglePan(p150)
    v_u_148 = p150
end
local v_u_151 = false
local v_u_152 = nil
local v_u_153 = nil
function v46.enableCameraToggleInput()
    if not v_u_151 then
        v_u_151 = true
        v_u_147 = false
        v_u_148 = false
        if v_u_152 then
            v_u_152:Disconnect()
        end
        if v_u_153 then
            v_u_153:Disconnect()
        end
        v_u_152 = v_u_23:Connect(function()
            v_u_147 = true
            v_u_149 = tick()
        end)
        v_u_153 = v_u_24:Connect(function()
            v_u_147 = false
            if tick() - v_u_149 < 0.3 and (v_u_148 or v_u_2:GetMouseDelta().Magnitude < 2) then
                v_u_148 = not v_u_148
            end
        end)
    end
end
function v46.disableCameraToggleInput()
    if v_u_151 then
        v_u_151 = false
        if v_u_152 then
            v_u_152:Disconnect()
            v_u_152 = nil
        end
        if v_u_153 then
            v_u_153:Disconnect()
            v_u_153 = nil
        end
    end
end
return v46