local v1 = {}
local v_u_2 = game:GetService("TweenService")
local v3 = game:GetService("RunService")
local v4 = game:GetService("Players")
local v_u_5 = TweenInfo.new(0.2, Enum.EasingStyle.Linear, Enum.EasingDirection.Out)
local v_u_6 = {}
local v_u_7 = {}
local v_u_8 = {}
local v_u_9 = {}
local v_u_10 = {}
local function v_u_15(p11)
    local v12 = p11:FindFirstChild("RightShoulder", true)
    local v13 = p11:FindFirstChild("LeftShoulder", true)
    local v14 = p11:FindFirstChild("RootJoint", true)
    return v12, v13, p11:FindFirstChild("Waist", true), p11:FindFirstChild("Neck", true), v14
end
function v1.updateKinematics(p16, p17, p18)
    local v19, v20, v21, v22, v23 = v_u_15(p17)
    if v19 and (v20 and (v21 and v22)) then
        if not v_u_6[p16] then
            v_u_6[p16] = {
                v19.C0,
                v20.C0,
                v21.C0,
                v22.C0,
                v23 and v23.C0 or nil
            }
        end
        v_u_2:Create(v19, v_u_5, {
            ["C0"] = v_u_6[p16][1] * CFrame.Angles(1.0471975511965976 * p18.LookVector.Y * 0.5, 0, 0)
        }):Play()
        v_u_2:Create(v20, v_u_5, {
            ["C0"] = v_u_6[p16][2] * CFrame.Angles(1.0471975511965976 * p18.LookVector.Y * 0.5, 0, 0)
        }):Play()
        v_u_2:Create(v21, v_u_5, {
            ["C0"] = v_u_6[p16][3] * CFrame.Angles(1.0471975511965976 * p18.LookVector.Y * 0.6, 0, 0)
        }):Play()
        v_u_2:Create(v22, v_u_5, {
            ["C0"] = v_u_6[p16][4] * CFrame.Angles(1.0471975511965976 * p18.LookVector.Y, 0, 0)
        }):Play()
    end
end
function v1.setTargetRotation(p24, p25)
    v_u_7[p24] = p25
    if v_u_8[p24] == nil then
        v_u_8[p24] = p25
    end
    local v26 = p24.Character
    if v26 and not v_u_6[p24] then
        local v27, v28, v29, v30, v31 = v_u_15(v26)
        if v27 and (v28 and (v29 and v30)) then
            v_u_6[p24] = {
                v27.C0,
                v28.C0,
                v29.C0,
                v30.C0,
                v31 and v31.C0 or nil
            }
        end
    end
end
function v1.setVerticalLook(p32, p33)
    v_u_9[p32] = p33
    if v_u_10[p32] == nil then
        v_u_10[p32] = p33
    end
end
function v1.cleanup(p34)
    local v35 = v_u_6[p34]
    v_u_6[p34] = nil
    v_u_7[p34] = nil
    v_u_8[p34] = nil
    v_u_9[p34] = nil
    v_u_10[p34] = nil
    if v35 and p34.Character then
        local v36, v37, v38, v39, v40 = v_u_15(p34.Character)
        if not (v36 and (v37 and (v38 and v39))) then
            return
        end
        v_u_2:Create(v36, v_u_5, {
            ["C0"] = v35[1]
        }):Play()
        v_u_2:Create(v37, v_u_5, {
            ["C0"] = v35[2]
        }):Play()
        v_u_2:Create(v38, v_u_5, {
            ["C0"] = v35[3]
        }):Play()
        v_u_2:Create(v39, v_u_5, {
            ["C0"] = v35[4]
        }):Play()
        if v40 and v35[5] then
            v40.C0 = v35[5]
        end
    end
end
v3.RenderStepped:Connect(function(p41)
    local v42 = p41 * 15
    local v43 = math.min(1, v42)
    for v44, v45 in pairs(v_u_7) do
        local v46 = v44.Character
        if v46 then
            local v47
            if v_u_8[v44] == nil then
                v47 = v45
            else
                v47 = v_u_8[v44]
            end
            local v48 = v45 - v47
            while v48 > 3.141592653589793 do
                v48 = v48 - 6.283185307179586
            end
            while v48 < -3.141592653589793 do
                v48 = v48 + 6.283185307179586
            end
            local v49 = v47 + v48 * v43
            v_u_8[v44] = v49
            local v50, v51, v52, v53, v54 = v_u_15(v46)
            local v55 = v_u_6[v44]
            local v56
            if v55 then
                v56 = v55[5]
            else
                v56 = v55
            end
            if v54 and v56 then
                v54.C0 = CFrame.new(v56.Position) * CFrame.Angles(0, v49, 0)
            end
            local v57 = v_u_9[v44]
            if v57 ~= nil and (v55 and (v50 and (v51 and (v52 and v53)))) then
                local v58
                if v_u_10[v44] == nil then
                    v58 = v57
                else
                    v58 = v_u_10[v44]
                end
                local v59 = v58 + (v57 - v58) * v43
                v_u_10[v44] = v59
                v50.C0 = v55[1] * CFrame.Angles(v59 * 1.0471975511965976 * 0.5, 0, 0)
                v51.C0 = v55[2] * CFrame.Angles(v59 * 1.0471975511965976 * 0.5, 0, 0)
                v52.C0 = v55[3] * CFrame.Angles(v59 * 1.0471975511965976 * 0.6, 0, 0)
                v53.C0 = v55[4] * CFrame.Angles(v59 * 1.0471975511965976, 0, 0)
            end
        end
    end
end)
v4.PlayerRemoving:Connect(function(p60)
    v_u_6[p60] = nil
    v_u_7[p60] = nil
    v_u_8[p60] = nil
    v_u_9[p60] = nil
    v_u_10[p60] = nil
end)
return v1