local v1 = game:GetService("ReplicatedStorage")
require(script.Parent.Parent.Types)
local v_u_2 = require(v1.Shared.Janitor)
require(v1.Database.Custom.GameStats.UI.Settings.Pages)
return function(p_u_3, _, p4, p5, p_u_6, p7, p_u_8, p_u_9)
    p_u_6.Name = p_u_3
    p_u_6.Title.Text = p_u_3
    p_u_6.LayoutOrder = p5
    local v_u_10 = p7
    local v_u_11 = v_u_2.new()
    v_u_11:Add(p_u_6, "Destroy")
    local v12 = v_u_10
    v_u_10 = math.floor(v12)
    local v13 = p_u_6.Frame.TextBox
    local v14 = v_u_10
    local v15 = math.floor(v14)
    v13.Text = tostring(v15)
    v_u_11:Add(p_u_6.Frame.TextBox.FocusLost:Connect(function()
        local v16 = p_u_6.Frame.TextBox.Text
        local v17 = tonumber(v16)
        if v17 then
            v_u_10 = math.floor(v17)
            local v18 = p_u_6.Frame.TextBox
            local v19 = v_u_10
            local v20 = math.floor(v19)
            v18.Text = tostring(v20)
            p_u_8(p_u_9, p_u_3, v_u_10)
        else
            local v21 = p_u_6.Frame.TextBox
            local v22 = v_u_10
            local v23 = math.floor(v22)
            v21.Text = tostring(v23)
        end
    end), "Disconnect")
    p_u_6.Parent = p4
    return function()
        v_u_11:Cleanup()
    end
end