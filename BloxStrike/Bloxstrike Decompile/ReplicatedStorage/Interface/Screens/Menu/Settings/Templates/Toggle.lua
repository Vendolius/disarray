local v1 = game:GetService("ReplicatedStorage")
require(script.Parent.Parent.Types)
local v_u_2 = require(v1.Shared.Janitor)
require(v1.Database.Custom.GameStats.UI.Settings.Pages)
local v_u_3 = Color3.fromRGB(255, 255, 255)
return function(p_u_4, _, p5, p6, p_u_7, p8, p_u_9, p_u_10)
    p_u_7.Name = p_u_4
    p_u_7.Title.Text = p_u_4
    p_u_7.LayoutOrder = p6
    p_u_7.Button.Selectable = false
    local v_u_11 = p8
    local v_u_12 = v_u_2.new()
    v_u_12:Add(p_u_7, "Destroy")
    local v13 = v_u_11
    p_u_7.Button.ImageLabel.Visible = v13
    local v14 = p_u_7.Button.Border.UIStroke
    local v15
    if v13 then
        v15 = Color3.fromRGB(255, 255, 255)
    else
        v15 = Color3.fromRGB(100, 100, 100)
    end
    v14.Color = v15
    p_u_7.Title.TextColor3 = v_u_3
    v_u_12:Add(p_u_7.Button.MouseButton1Click:Connect(function()
        v_u_11 = not v_u_11
        local v16 = v_u_11
        p_u_7.Button.ImageLabel.Visible = v16
        local v17 = p_u_7.Button.Border.UIStroke
        local v18
        if v16 then
            v18 = Color3.fromRGB(255, 255, 255)
        else
            v18 = Color3.fromRGB(100, 100, 100)
        end
        v17.Color = v18
        p_u_7.Title.TextColor3 = v_u_3
        p_u_9(p_u_10, p_u_4, v_u_11)
    end), "Disconnect")
    p_u_7.Parent = p5
    return function()
        v_u_12:Cleanup()
    end
end