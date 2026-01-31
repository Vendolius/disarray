local v_u_1 = {}
local v2 = game:GetService("ReplicatedStorage")
game:GetService("TweenService")
local v_u_3 = require(v2.Database.Security.Router)
local v_u_4 = require(v2.Database.Security.Remotes)
local v_u_5 = nil
function v_u_1.CreateNotification(p6, p7)
    v_u_3.broadcastRouter("RunInterfaceSound", "Notification " .. p6)
    v_u_5.TextLabel.Text = p7
    v_u_5.Visible = true
end
function v_u_1.CloseNotification()
    v_u_5.Visible = false
end
function v_u_1.Initialize(_, p8)
    v_u_5 = p8
    v_u_5.Footer.Close.MouseButton1Click:Connect(function()
        v_u_1.CloseNotification()
    end)
    v_u_3.observerRouter("CreateMenuNotification", function(p9, p10)
        v_u_1.CreateNotification(p9, p10)
        return nil
    end)
    v_u_4.UI.CreateMenuNotification.Listen(function(p11, _)
        v_u_1.CreateNotification(p11.notificationType, p11.text)
    end)
end
return v_u_1