local v_u_1 = {}
local v2 = game:GetService("ReplicatedStorage")
local v_u_3 = game:GetService("UserInputService")
local v_u_4 = game:GetService("TweenService")
local v_u_5 = game:GetService("Players")
local v_u_6 = v_u_5.LocalPlayer
local v_u_7 = require(v2.Database.Security.Remotes)
local v_u_8 = require(v2.Components.Common.GetUserPlatform)
local v_u_9 = nil
local v_u_10 = nil
local v_u_11 = false
function v_u_1.UpdateAmount(p12, p13, p14)
    v_u_9.Option[p12].Amount.Text = ("%*"):format(p13)
    if v_u_6.UserId == tonumber(p14) then
        local v15 = p12 == "Yes" and "rgb(90, 186, 55)" or "rgb(255,49,49)"
        v_u_9.Result.TextLabel.Text = ("You voted: <font color=\"%*\">%*</font>"):format(v15, (string.upper(p12)))
        v_u_9.Result.Visible = true
    end
end
function v_u_1.UpdateFrame(p16, p17)
    local v18 = v_u_5:GetPlayerByUserId(p16)
    local v19 = v_u_5:GetPlayerByUserId(p17)
    if v18 then
        v_u_9.Player.Text = ("Kick player: %*? "):format(v18.Name)
        v_u_9.Frame.Title.Text = ("Vote By: %*"):format(v19 and v19.Name or "Unknown")
        v_u_9.Option.Yes.Amount.Text = "0"
        v_u_9.Option.No.Amount.Text = "0"
    end
end
function v_u_1.OpenFrame(p20)
    v_u_9.Position = UDim2.fromScale(-0.08, 0.525)
    v_u_9:SetAttribute("IsVoteKickActive", true)
    v_u_9.Result.Visible = false
    v_u_10 = p20
    v_u_9.Visible = true
    v_u_11 = false
    if v_u_6.UserId == p20 then
        v_u_9.Result.TextLabel.Text = "You are being vote kicked."
        v_u_9.Result.Visible = true
    end
    v_u_4:Create(v_u_9, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        ["Position"] = UDim2.fromScale(0.08, 0.525)
    }):Play()
end
function v_u_1.CloseFrame()
    v_u_9:SetAttribute("IsVoteKickActive", false)
    v_u_9.Result.Visible = false
    v_u_10 = nil
    v_u_11 = false
    local v21 = v_u_4:Create(v_u_9, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        ["Position"] = UDim2.fromScale(-0.08, 0.525)
    })
    v21.Completed:Once(function()
        v_u_9.Visible = false
    end)
    v21:Play()
end
function v_u_1.CastVote(p22)
    if not v_u_10 or v_u_6.UserId ~= v_u_10 then
        if not v_u_11 then
            local v23 = p22 == "Yes" and v_u_7.VoteKick.VoteYes or v_u_7.VoteKick.VoteNo
            v_u_11 = true
            local v24 = v23.Send
            local v25 = {}
            local v26 = v_u_6.UserId
            v25.Voter = tostring(v26)
            v25.Amount = 0
            return v24(v25)
        end
    end
end
function v_u_1.Initialize(_, p27)
    v_u_9 = p27
    v_u_9:SetAttribute("IsVoteKickActive", false)
    if not table.find(v_u_8(), "Mobile") then
        v_u_7.VoteKick.VoteNo.Listen(function(p28)
            v_u_1.UpdateAmount("No", p28.Amount, p28.Voter)
        end)
        v_u_7.VoteKick.VoteYes.Listen(function(p29)
            v_u_1.UpdateAmount("Yes", p29.Amount, p29.Voter)
        end)
        v_u_7.VoteKick.StartVote.Listen(function(p30)
            local v31 = p30.TargetUserId
            local v32 = tonumber(v31)
            local v33 = p30.VoterUserId
            local v34 = tonumber(v33)
            v_u_1.UpdateFrame(v32, v34)
            v_u_1.OpenFrame(v32)
        end)
        v_u_7.VoteKick.EndVote.Listen(function()
            if v_u_9.Visible then
                v_u_1.CloseFrame()
            end
        end)
        v_u_3.InputBegan:Connect(function(p35, p36)
            if p36 then
                return
            elseif v_u_9.Visible then
                if v_u_3:GetFocusedTextBox() then
                    return
                elseif p35.UserInputType == Enum.UserInputType.Keyboard then
                    if p35.KeyCode == Enum.KeyCode.K then
                        v_u_1.CastVote("Yes")
                        return
                    elseif p35.KeyCode == Enum.KeyCode.L then
                        v_u_1.CastVote("No")
                    end
                else
                    return
                end
            else
                return
            end
        end)
    end
end
return v_u_1