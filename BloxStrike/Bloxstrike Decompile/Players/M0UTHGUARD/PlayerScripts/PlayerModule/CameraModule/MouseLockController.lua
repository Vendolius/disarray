local v1 = script.Parent.Parent:WaitForChild("CommonUtils")
require(v1:WaitForChild("FlagUtil"))
local v_u_2 = Enum.ContextActionPriority.Medium.Value
local v_u_3 = game:GetService("Players")
local v_u_4 = game:GetService("ContextActionService")
local v_u_5 = UserSettings().GameSettings
local v_u_6 = require(script.Parent:WaitForChild("CameraUtils"))
local v_u_7 = {}
v_u_7.__index = v_u_7
function v_u_7.new()
    local v8 = v_u_7
    local v_u_9 = setmetatable({}, v8)
    v_u_9.isMouseLocked = false
    v_u_9.savedMouseCursor = nil
    v_u_9.boundKeys = { Enum.KeyCode.LeftShift, Enum.KeyCode.RightShift }
    v_u_9.mouseLockToggledEvent = Instance.new("BindableEvent")
    local v10 = script:FindFirstChild("BoundKeys")
    if not (v10 and v10:IsA("StringValue")) then
        if v10 then
            v10:Destroy()
        end
        v10 = Instance.new("StringValue")
        assert(v10, "")
        v10.Name = "BoundKeys"
        v10.Value = "LeftShift,RightShift"
        v10.Parent = script
    end
    if v10 then
        v10.Changed:Connect(function(p11)
            v_u_9:OnBoundKeysObjectChanged(p11)
        end)
        v_u_9:OnBoundKeysObjectChanged(v10.Value)
    end
    v_u_5.Changed:Connect(function(p12)
        if p12 == "ControlMode" or p12 == "ComputerMovementMode" then
            v_u_9:UpdateMouseLockAvailability()
        end
    end)
    v_u_3.LocalPlayer:GetPropertyChangedSignal("DevEnableMouseLock"):Connect(function()
        v_u_9:UpdateMouseLockAvailability()
    end)
    v_u_3.LocalPlayer:GetPropertyChangedSignal("DevComputerMovementMode"):Connect(function()
        v_u_9:UpdateMouseLockAvailability()
    end)
    v_u_9:UpdateMouseLockAvailability()
    return v_u_9
end
function v_u_7.GetIsMouseLocked(p13)
    return p13.isMouseLocked
end
function v_u_7.GetBindableToggleEvent(p14)
    return p14.mouseLockToggledEvent.Event
end
function v_u_7.GetMouseLockOffset(_)
    return Vector3.new(1.75, 0, 0)
end
function v_u_7.UpdateMouseLockAvailability(p15)
    local v16 = v_u_3.LocalPlayer.DevEnableMouseLock
    local v17 = v_u_3.LocalPlayer.DevComputerMovementMode == Enum.DevComputerMovementMode.Scriptable
    local v18 = v16 and (v_u_5.ControlMode == Enum.ControlMode.MouseLockSwitch and v_u_5.ComputerMovementMode ~= Enum.ComputerMovementMode.ClickToMove)
    if v18 then
        v18 = not v17
    end
    if v18 ~= p15.enabled then
        p15:EnableMouseLock(v18)
    end
end
function v_u_7.OnBoundKeysObjectChanged(p19, p20)
    p19.boundKeys = {}
    for v21 in string.gmatch(p20, "[^%s,]+") do
        for _, v22 in pairs(Enum.KeyCode:GetEnumItems()) do
            if v21 == v22.Name then
                p19.boundKeys[#p19.boundKeys + 1] = v22
                break
            end
        end
    end
    p19:UnbindContextActions()
    p19:BindContextActions()
end
function v_u_7.OnMouseLockToggled(p23)
    p23.isMouseLocked = not p23.isMouseLocked
    if p23.isMouseLocked then
        local v24 = script:FindFirstChild("CursorImage")
        if v24 and (v24:IsA("StringValue") and v24.Value) then
            v_u_6.setMouseIconOverride(v24.Value)
        else
            if v24 then
                v24:Destroy()
            end
            local v25 = Instance.new("StringValue")
            assert(v25, "")
            v25.Name = "CursorImage"
            v25.Value = "rbxasset://textures/MouseLockedCursor.png"
            v25.Parent = script
            v_u_6.setMouseIconOverride("rbxasset://textures/MouseLockedCursor.png")
        end
    else
        v_u_6.restoreMouseIcon()
    end
    p23.mouseLockToggledEvent:Fire()
end
function v_u_7.DoMouseLockSwitch(p26, _, p27, _)
    if p27 ~= Enum.UserInputState.Begin then
        return Enum.ContextActionResult.Pass
    end
    p26:OnMouseLockToggled()
    return Enum.ContextActionResult.Sink
end
function v_u_7.BindContextActions(p_u_28)
    local v29 = v_u_4
    local v30 = v_u_2
    local v31 = p_u_28.boundKeys
    v29:BindActionAtPriority("MouseLockSwitchAction", function(p32, p33, p34)
        return p_u_28:DoMouseLockSwitch(p32, p33, p34)
    end, false, v30, unpack(v31))
end
function v_u_7.UnbindContextActions(_)
    v_u_4:UnbindAction("MouseLockSwitchAction")
end
function v_u_7.IsMouseLocked(p35)
    local v36 = p35.enabled
    if v36 then
        v36 = p35.isMouseLocked
    end
    return v36
end
function v_u_7.EnableMouseLock(p37, p38)
    if p38 ~= p37.enabled then
        p37.enabled = p38
        if p37.enabled then
            p37:BindContextActions()
            return
        end
        v_u_6.restoreMouseIcon()
        p37:UnbindContextActions()
        if p37.isMouseLocked then
            p37.mouseLockToggledEvent:Fire()
        end
        p37.isMouseLocked = false
    end
end
return v_u_7