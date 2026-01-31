local v1 = {}
game:GetService("ReplicatedStorage")
local v_u_2 = game:GetService("HapticService")
local v3 = game:GetService("RunService")
require(script:WaitForChild("Types"))
local v_u_4 = {}
function v1.vibrate(p5, p6, p7)
    if v_u_4[p5] then
        local v8 = v_u_4[p5]
        if v8.Length < p7 then
            v8.Length = p7
        end
        if v8.Intensity < p6 then
            v8.Intensity = p6
            return
        end
    else
        v_u_4[p5] = {
            ["Intensity"] = p6,
            ["Length"] = p7
        }
    end
end
v3.RenderStepped:Connect(function(p9)
    for v10, v11 in pairs(v_u_4) do
        v11.Length = v11.Length - p9
        if v_u_2:IsMotorSupported(Enum.UserInputType.Gamepad1, v10) then
            v_u_2:SetMotor(Enum.UserInputType.Gamepad1, v10, v11.Intensity)
        end
        if v11.Length <= 0 then
            v_u_2:SetMotor(Enum.UserInputType.Gamepad1, v10, 0)
            if v_u_4[v10] then
                v_u_4[v10] = nil
            end
        end
    end
end)
return v1