local v_u_1 = {}
local v_u_2 = game:GetService("ReplicatedStorage")
local v_u_3 = game:GetService("Players")
require(v_u_2.Database.Custom.Types)
local v_u_4 = v_u_3.LocalPlayer
local v_u_5 = require(v_u_2.Components.Common.InterfaceAnimations.ActivateButton)
local v_u_6 = require(v_u_2.Controllers.DataController)
local v_u_7 = require(v_u_2.Database.Security.Remotes)
local v_u_8 = require(v_u_2.Database.Security.Router)
local v_u_9 = require(v_u_2.Interface.Screens.Gameplay.Middle.TeamSelection)
local v_u_10 = nil
local v_u_11 = nil
local function v_u_15(p12)
    local v13 = p12:GetChildren()
    for _, v14 in ipairs(v13) do
        if v14:IsA("Frame") then
            v14:Destroy()
        end
    end
end
function v_u_1.PlayerAdded(p_u_16)
    local v17 = v_u_11.Menu.VoteKick.Container
    local v18 = p_u_16.UserId
    if not v17:FindFirstChild((tostring(v18))) then
        local v19 = v_u_2.Assets.UI.VoteKick.PlayerTemplate:Clone()
        v19.Player.Avatar.Image = ("rbxthumb://type=AvatarHeadShot&id=%*&w=420&h=420"):format(p_u_16.UserId)
        v19.Player.Username.Text = "@" .. p_u_16.DisplayName
        v19.Parent = v_u_11.Menu.VoteKick.Container
        local v20 = p_u_16.UserId
        v19.Name = tostring(v20)
        v19.Button.MouseButton1Click:Connect(function()
            v_u_8.broadcastRouter("RunInterfaceSound", "UI Click")
            local v21 = v_u_7.VoteKick.CallVote.Send
            local v22 = p_u_16.UserId
            v21((tostring(v22)))
            v_u_11.Menu.VoteKick.Visible = false
        end)
    end
end
function v_u_1.OpenChooseTeam()
    local v23 = v_u_4:GetAttribute("IsSpectating")
    local v24 = v_u_4:GetAttribute("Team")
    if (v24 == "Counter-Terrorists" or v24 == "Terrorists") and true or v23 == true then
        if v23 then
            v_u_9.openFrame()
            return
        elseif v_u_4.Character then
            v_u_9.ToggleTeamSelection()
        end
    else
        return
    end
end
function v_u_1.Initialize(p25, p26)
    v_u_11 = p25
    v_u_10 = p26
    v_u_15(v_u_11.Menu.VoteKick.Container)
    for _, v27 in ipairs(v_u_3:GetPlayers()) do
        if v_u_4 ~= v27 then
            v_u_1.PlayerAdded(v27)
        end
    end
    v_u_3.PlayerAdded:Connect(function(p28)
        if v_u_4 ~= p28 then
            v_u_1.PlayerAdded(p28)
        end
    end)
    v_u_3.PlayerRemoving:Connect(function(p29)
        local v30 = v_u_11.Menu.VoteKick.Container
        local v31 = p29.UserId
        local v32 = v30:FindFirstChild((tostring(v31)))
        if v32 then
            v32:Destroy()
        end
    end)
end
function v_u_1.Start()
    v_u_5(v_u_11.Menu.VoteKick.Close)
    v_u_11.Menu.VoteKick.Close.MouseButton1Click:Connect(function()
        v_u_8.broadcastRouter("RunInterfaceSound", "UI Click")
        v_u_11.Menu.VoteKick.Visible = false
    end)
    v_u_10.Container.ChooseTeam.MouseButton1Click:Connect(function()
        v_u_1.OpenChooseTeam()
    end)
    v_u_10.Container.VoteKick.MouseButton1Click:Connect(function()
        local v33 = v_u_6.Get(v_u_4, "Level")
        local v34 = v_u_4:GetAttribute("IsSpectating") == true
        local v35 = v_u_4:GetAttribute("Team")
        v_u_8.broadcastRouter("RunInterfaceSound", "UI Click")
        if v34 and (not v35 or v35 == "Spectators") then
            v_u_8.broadcastRouter("CreateMenuNotification", "Error", "You cannot vote kick while spectating as a spectator.")
            return
        elseif v33.Level >= 3 then
            v_u_11.Menu.VoteKick.Visible = true
        else
            v_u_8.broadcastRouter("CreateMenuNotification", "Error", "You need to be level 3 to vote kick players.")
        end
    end)
end
return v_u_1