local v_u_1 = {}
local v_u_2 = game:GetService("ReplicatedStorage")
local v_u_3 = game:GetService("TweenService")
local v_u_4 = game:GetService("Players")
require(script:WaitForChild("Types"))
local v_u_5 = require(v_u_2.Components.Common.GetTimerFormat)
local v_u_6 = require(v_u_2.Database.Components.GameState)
local v_u_7 = require(v_u_2.Controllers.CameraController)
local v_u_8 = require(v_u_2.Database.Security.Remotes)
local v_u_9 = require(v_u_2.Packages.Observers)
local v_u_10 = nil
local v_u_11 = nil
local v_u_12 = nil
local function v_u_17(p13, p14)
    local v15 = p13:GetChildren()
    for _, v16 in ipairs(v15) do
        if v16.ClassName == p14 then
            v16:Destroy()
        end
    end
end
local function v_u_22(p18)
    local v19 = v_u_11.MapVote:GetChildren()
    for _, v20 in ipairs(v19) do
        if v20:IsA("ImageButton") then
            local v21 = p18 and p18[v20.Name] or v20:GetAttribute("Amount")
            if v21 then
                v20.Main.Amount.Text = ("<font color=\"rgb(219,199,126)\">%*</font>/%*"):format(v21, #v_u_4:GetPlayers())
                v20:SetAttribute("Amount", v21)
            end
        end
    end
end
local function v_u_29(p23, p_u_24)
    local v25 = v_u_2.Database.Custom.GameStats.Maps:WaitForChild(p_u_24, 10)
    if v25 then
        local v26 = require(v25)
        if v26 and v26.Icon then
            local v_u_27 = v_u_2.Assets.UI.EndScreen.VoteTemplate:Clone()
            v_u_27.Main.Amount.Text = ("<font color=\"rgb(219,199,126)\">0</font>/%*"):format(#v_u_4:GetPlayers())
            v_u_27.Main.Icon.Image = v26.Icon
            v_u_27.Parent = v_u_11.MapVote
            v_u_27.Main.Selection.Text = p_u_24
            v_u_27:SetAttribute("Amount", 0)
            v_u_27.Title.Visible = p23 == 1
            v_u_27.Voted.Visible = false
            v_u_27.Name = p_u_24
            v_u_27.Button.MouseButton1Click:Connect(function()
                if v_u_10 ~= p_u_24 then
                    v_u_8.Map.SubmitMapVote.Send(p_u_24)
                    v_u_3:Create(v_u_27.Main.UIStroke, TweenInfo.new(0.5), {
                        ["Transparency"] = 0
                    }):Play()
                    v_u_3:Create(v_u_27.Main.UIStroke, TweenInfo.new(0.5), {
                        ["Thickness"] = 5.5
                    }):Play()
                    if v_u_10 then
                        local v28 = v_u_11.MapVote:FindFirstChild(v_u_10)
                        v_u_3:Create(v28.Main.UIStroke, TweenInfo.new(0.5), {
                            ["Transparency"] = 0.75
                        }):Play()
                        v_u_3:Create(v28.Main.UIStroke, TweenInfo.new(0.5), {
                            ["Thickness"] = 1.5
                        }):Play()
                    end
                    v_u_10 = p_u_24
                end
            end)
            v_u_27.Button.MouseEnter:Connect(function()
                v_u_3:Create(v_u_27.Main.Icon.UIScale, TweenInfo.new(0.5), {
                    ["Scale"] = 1.1
                }):Play()
            end)
            v_u_27.Button.MouseLeave:Connect(function()
                v_u_3:Create(v_u_27.Main.Icon.UIScale, TweenInfo.new(0.5), {
                    ["Scale"] = 1
                }):Play()
            end)
        else
            warn((("Map %* is missing Icon property"):format(p_u_24)))
        end
    else
        warn((("Failed to load map module for %* - map may not exist or hasn\'t replicated yet"):format(p_u_24)))
        return
    end
end
function v_u_1.CloseFrame()
    local v30 = v_u_11.Visible
    v_u_11.Visible = false
    v_u_7.setForceLockOverride("EndScreen", false)
    if require(v_u_2.Controllers.MenuSceneController).IsActive() or v_u_12.Menu.Visible then
        require(v_u_2.Interface.Screens.Menu.Top).ResetToMainMenu()
        if not v_u_12.Menu.Visible then
            v_u_7.setForceLockOverride("Menu", true)
            v_u_12.Menu.Visible = true
        end
        v_u_12.Gameplay.Visible = false
    elseif v30 then
        require(v_u_2.Interface.Screens.Gameplay.Middle.TeamSelection).openFrame()
    end
end
function v_u_1.Initialize(p31, p32)
    v_u_11 = p32
    v_u_12 = p31
    v_u_17(v_u_11.MapVote, "ImageButton")
    v_u_8.Map.StartMapVote.Listen(function(p33)
        v_u_17(v_u_11.MapVote, "ImageButton")
        v_u_10 = nil
        for v34, v35 in ipairs(p33) do
            v_u_29(v34, v35)
        end
    end)
    v_u_8.Map.UpdateMapVote.Listen(function(p36)
        v_u_22(p36)
    end)
    v_u_8.Map.EndMapVote.Listen(function(_)
        v_u_1.CloseFrame()
    end)
    v_u_9.observePlayer(function()
        v_u_22()
        return function()
            v_u_22()
        end
    end)
    v_u_9.observeAttribute(workspace, "Timer", function(p37)
        v_u_11.Top.Timer.Text = v_u_5(p37)
    end)
    if v_u_6.GetState() == "Map Voting" then
        local v38 = false
        for _, v39 in ipairs(v_u_11.MapVote:GetChildren()) do
            if v39:IsA("ImageButton") then
                v38 = true
                break
            end
        end
        if not v38 then
            v_u_8.Map.RequestMapVote.Send()
            return
        end
    end
end
return v_u_1