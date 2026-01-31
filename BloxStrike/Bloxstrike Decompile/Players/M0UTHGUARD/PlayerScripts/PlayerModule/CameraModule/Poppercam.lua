local v1 = script.Parent.Parent:WaitForChild("CommonUtils")
local v2 = game:GetService("Players")
local v3 = require(v1:WaitForChild("FlagUtil"))
local v_u_4 = require(script.Parent:WaitForChild("ZoomController"))
local v_u_5 = v2.LocalPlayer
local v_u_6 = v3.getUserFlag("UserFixCameraFPError")
local v_u_7 = {}
v_u_7.__index = v_u_7
local v_u_8 = CFrame.new()
function v_u_7.new()
    local v9 = v_u_7
    return setmetatable({
        ["lastCFrame"] = nil
    }, v9)
end
function v_u_7.Step(p10, p11, p12)
    local v13 = p10.lastCFrame or p12
    p10.lastCFrame = p12
    local v_u_14 = p12.Position
    local _, _, _, v15, v16, v17, v18, v19, v20, v21, v22, v23 = p12:GetComponents()
    local v_u_24 = CFrame.new(0, 0, 0, v15, v16, v17, v18, v19, v20, v21, v22, v23)
    local v25 = v13.p
    local _, _, _, v26, v27, v28, v29, v30, v31, v32, v33, v34 = v13:GetComponents()
    local v35 = CFrame.new(0, 0, 0, v26, v27, v28, v29, v30, v31, v32, v33, v34)
    local v_u_36 = (v_u_14 - v25) / p11
    local v37, v38 = (v_u_24 * v35:inverse()):ToAxisAngle()
    local v_u_39 = v37 * v38 / p11
    return {
        ["extrapolate"] = function(p40)
            local v41 = v_u_36 * p40 + v_u_14
            local v42 = v_u_39 * p40
            local v43 = v42.Magnitude
            local v44
            if v43 > 0.00001 then
                v44 = CFrame.fromAxisAngle(v42, v43)
            else
                v44 = v_u_8
            end
            return v44 * v_u_24 + v41
        end,
        ["posVelocity"] = v_u_36,
        ["rotVelocity"] = v_u_39
    }
end
function v_u_7.Reset(p45)
    p45.lastCFrame = nil
end
local v_u_46 = require(script.Parent:WaitForChild("BaseOcclusion"))
local v_u_47 = setmetatable({}, v_u_46)
v_u_47.__index = v_u_47
function v_u_47.new()
    local v48 = v_u_46.new()
    local v49 = v_u_47
    local v50 = setmetatable(v48, v49)
    v50.focusExtrapolator = v_u_7.new()
    return v50
end
function v_u_47.GetOcclusionMode(_)
    return Enum.DevCameraOcclusionMode.Zoom
end
function v_u_47.Enable(p51, _)
    p51.focusExtrapolator:Reset()
end
function v_u_47.Update(p52, p53, p54, p55, _)
    if v_u_5.CameraMode == Enum.CameraMode.LockFirstPerson then
        return p54, p55
    end
    local v56
    if v_u_6 then
        v56 = CFrame.lookAlong(p55.p, -p54.LookVector) * CFrame.new(0, 0, 0, -1, 0, 0, 0, 1, 0, 0, 0, -1)
    else
        v56 = CFrame.new(p55.p, p54.p) * CFrame.new(0, 0, 0, -1, 0, 0, 0, 1, 0, 0, 0, -1)
    end
    local v57 = p52.focusExtrapolator:Step(p53, v56)
    local v58 = v_u_4.Update(p53, v56, v57)
    return v56 * CFrame.new(0, 0, v58), p55
end
function v_u_47.CharacterAdded(_, _, _) end
function v_u_47.CharacterRemoving(_, _, _) end
function v_u_47.OnCameraSubjectChanged(_, _) end
return v_u_47