local v_u_1 = {}
local v_u_2 = game:GetService("ContextActionService")
local v3 = game:GetService("ReplicatedStorage")
local v_u_4 = game:GetService("UserInputService")
local v5 = game:GetService("Players")
require(script:WaitForChild("Types"))
local v_u_6 = require(v3.Controllers.DataController)
local v_u_7 = require(v3.Components.Common.GetUserPlatform)
local v_u_8 = require(v3.Database.Security.Router)
local v_u_9 = require(script:WaitForChild("KeybindParser"))
local v_u_10 = script:WaitForChild("Actions")
local v_u_11 = v5.LocalPlayer
local v_u_12 = v_u_11:GetMouse()
local v_u_13 = {}
local v_u_14 = {}
local v_u_15 = {}
local v_u_16 = {
    ["ScrollWheelUp"] = nil,
    ["ScrollWheelDown"] = nil
}
local function v_u_21(p17, p18, p19)
    local v20 = v_u_15[p17]
    if v20 then
        if v_u_14[v20.Group] then
            v20.IsActive = p18 == Enum.UserInputState.Begin
            task.spawn(v20.Callback, p18, p19)
        end
    end
end
local function v_u_27(p22, p23)
    if p22 then
        local v24 = Enum.UserInputState.Begin
        local v25 = {
            ["UserInputType"] = Enum.UserInputType.MouseWheel,
            ["Delta"] = Vector3.new(0, p23, 0)
        }
        local v26 = v_u_15[p22]
        if v26 and v_u_14[v26.Group] then
            v26.IsActive = v24 == Enum.UserInputState.Begin
            task.spawn(v26.Callback, v24, v25)
        end
        task.defer(v_u_21, p22, Enum.UserInputState.End, {
            ["UserInputType"] = Enum.UserInputType.MouseWheel,
            ["Delta"] = Vector3.new(0, p23, 0)
        })
    end
end
function v_u_1.registerAction(p28)
    v_u_15[p28.Name] = {
        ["Category"] = p28.Category,
        ["Callback"] = p28.Callback,
        ["Group"] = p28.Group,
        ["Name"] = p28.Name,
        ["IsActive"] = false,
        ["Keybinds"] = {}
    }
end
function v_u_1.bindKeybinds(p_u_29, p30)
    local v31 = v_u_15[p_u_29]
    if v31 then
        v_u_2:UnbindAction(p_u_29)
        for _, v32 in ipairs(v31.Keybinds) do
            if typeof(v32) == "string" then
                if v32 == "ScrollWheelUp" then
                    v_u_16.ScrollWheelUp = nil
                elseif v32 == "ScrollWheelDown" then
                    v_u_16.ScrollWheelDown = nil
                end
            else
                v_u_13[v32] = nil
            end
        end
        local v33 = {}
        local v34 = {}
        for _, v35 in ipairs(p30) do
            if v35 then
                if typeof(v35) == "string" then
                    if v35 == "ScrollWheelUp" and not v_u_16.ScrollWheelUp then
                        table.insert(v33, v35)
                        v_u_16.ScrollWheelUp = p_u_29
                    elseif v35 == "ScrollWheelDown" and not v_u_16.ScrollWheelDown then
                        table.insert(v33, v35)
                        v_u_16.ScrollWheelDown = p_u_29
                    end
                elseif not v_u_13[v35] then
                    table.insert(v33, v35)
                    table.insert(v34, v35)
                    v_u_13[v35] = p_u_29
                end
            end
        end
        v31.Keybinds = v33
        if #v34 > 0 then
            v_u_2:BindAction(p_u_29, function(_, p36, p37)
                local v38 = v_u_15[p_u_29]
                if v38 then
                    if v_u_14[v38.Group] then
                        v38.IsActive = p36 == Enum.UserInputState.Begin
                        task.spawn(v38.Callback, p36, p37)
                    end
                end
            end, false, table.unpack(v34))
        end
    end
end
function v_u_1.loadActionsFromDatabase(p39)
    for _, v40 in pairs(p39) do
        for v41, v42 in pairs(v40) do
            local v43 = {}
            if typeof(v42) == "table" then
                local v44 = v42.Computer and v42.Computer ~= "" and v_u_9.parse(v42.Computer)
                if v44 then
                    table.insert(v43, v44)
                end
                local v45 = v42.Console and v42.Console ~= "" and v_u_9.parse(v42.Console)
                if v45 then
                    table.insert(v43, v45)
                end
            end
            if #v43 > 0 then
                v_u_1.bindKeybinds(v41, v43)
            end
        end
    end
end
function v_u_1.isActionActive(p46)
    local v47 = v_u_15[p46]
    return v47 and v47.IsActive or false
end
function v_u_1.enableGroup(p48)
    v_u_14[p48] = true
end
function v_u_1.disableGroup(p49)
    v_u_14[p49] = nil
end
function v_u_1.GetActionKeybind(p50)
    local v51 = v_u_15[p50]
    if v51 and #v51.Keybinds ~= 0 then
        local v52 = v51.Keybinds[1]
        if typeof(v52) == "string" then
            return v52
        else
            return tostring(v52):match("%.(%w+)$") or tostring(v52)
        end
    else
        return nil
    end
end
function v_u_1.Initialize()
    for _, v53 in ipairs(v_u_10:GetChildren()) do
        if v53:IsA("ModuleScript") then
            v_u_1.registerAction((require(v53)))
        end
    end
    v_u_1.enableGroup("Default")
    v_u_11.CharacterAdded:Connect(function(_)
        v_u_2:UnbindAction("jumpAction")
    end)
    v_u_6.CreateListener(v_u_11, "Settings.Keyboard/Mouse", function(p54)
        if p54 then
            v_u_1.loadActionsFromDatabase(p54)
        end
    end)
    v_u_8.observerRouter("RebindKeybinds", function()
        local v55 = v_u_6.Get(v_u_11, "Settings.Keyboard/Mouse")
        if not v55 then
            return false
        end
        v_u_1.loadActionsFromDatabase(v55)
        return true
    end)
end
function v_u_1.getActionKeybinds(p56)
    local v57 = v_u_15[p56]
    if not v57 then
        return {}
    end
    local v58 = {}
    for _, v59 in ipairs(v57.Keybinds) do
        if typeof(v59) ~= "string" then
            table.insert(v58, v59)
        end
    end
    return v58
end
function v_u_1.isActionPressed(p60, p61)
    local v62 = v_u_1.getActionKeybinds(p60)
    if #v62 == 0 then
        if not p61 or #p61 <= 0 then
            return false
        end
    else
        p61 = v62
    end
    for _, v63 in ipairs(p61) do
        if typeof(v63) == "EnumItem" then
            if v63.EnumType == Enum.KeyCode then
                if v63 == Enum.KeyCode.ButtonR2 or v63 == Enum.KeyCode.ButtonL2 then
                    if table.find(v_u_7(), "Console") then
                        local v64 = v_u_4:GetGamepadState(Enum.UserInputType.Gamepad1)
                        for _, v65 in pairs(v64) do
                            if v65.KeyCode == v63 then
                                if v65.Position.Z > 0.3 then
                                    return true
                                end
                                break
                            end
                        end
                    elseif v_u_4:IsKeyDown(v63) then
                        return true
                    end
                elseif v_u_4:IsKeyDown(v63) then
                    return true
                end
            elseif v63.EnumType == Enum.UserInputType and v_u_4:IsMouseButtonPressed(v63) then
                return true
            end
        end
    end
    return false
end
function v_u_1.Start()
    v_u_12.WheelBackward:Connect(function()
        v_u_27(v_u_16.ScrollWheelDown, -1)
    end)
    v_u_12.WheelForward:Connect(function()
        v_u_27(v_u_16.ScrollWheelUp, 1)
    end)
end
return v_u_1