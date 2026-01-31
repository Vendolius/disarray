local v_u_1 = {}
v_u_1.__index = v_u_1
local v2 = game:GetService("ReplicatedStorage")
local v_u_3 = game:GetService("RunService")
local v4 = game:GetService("Players")
local v_u_5 = game:GetService("UserInputService")
require(script:WaitForChild("Types"))
local v_u_6 = require(v2.Database.Security.Remotes)
local v_u_7 = require(v2.Database.Security.Router)
local v_u_8 = require(v2.Shared.Janitor)
local v_u_9 = require(v2.Packages.Signal)
local v_u_10 = require(v2.Controllers.SpectateController)
local v_u_11 = require(v2.Controllers.InputController)
local v12 = require(v2.Components.Common.GetUserPlatform)
local v_u_13 = v4.LocalPlayer
local v_u_14 = table.find(v12(), "Mobile")
if v_u_14 then
    v_u_14 = #v12() <= 1
end
local v_u_15 = nil
local v_u_16 = Color3.fromRGB(219, 159, 47)
local v_u_17 = Color3.fromRGB(43, 172, 43)
local v_u_18 = Color3.fromRGB(182, 45, 45)
local v_u_19 = nil
local v_u_20 = nil
local function v_u_24(p21)
    if v_u_11 and (v_u_11.isActionActive and v_u_11.isActionActive("Use")) then
        return true
    end
    if p21 and #p21 > 0 then
        for _, v22 in ipairs(p21) do
            if typeof(v22) == "EnumItem" then
                local v23 = v22.EnumType
                if v23 == Enum.KeyCode then
                    if v_u_5:IsKeyDown(v22) then
                        return true
                    end
                elseif v23 == Enum.UserInputType and v_u_5:IsMouseButtonPressed(v22) then
                    return true
                end
            end
        end
    end
    return false
end
function v_u_1.InitializeProgressBar(p25)
    if p25.Frame and p25.Frame.ProgressBar then
        local v26 = p25.Frame.ProgressBar
        local v27 = v26:FindFirstChild("LeftGradient")
        local v28 = v26:FindFirstChild("RightGradient")
        local v29 = v27:FindFirstChild("ProgressBarImage")
        local v30 = v28:FindFirstChild("ProgressBarImage")
        local v31 = v29:FindFirstChild("UIGradient")
        local v32 = v30:FindFirstChild("UIGradient")
        p25.LeftProgressImage = v29
        p25.RightProgressImage = v30
        p25.LeftGradient = v31
        p25.RightGradient = v32
        v29.ImageColor3 = v_u_18
        v30.ImageColor3 = v_u_18
        v29.ImageTransparency = 0
        v30.ImageTransparency = 0
        v27.Visible = true
        v28.Visible = true
        v29.Visible = true
        v30.Visible = true
        v31.Transparency = NumberSequence.new({
            NumberSequenceKeypoint.new(0, 0),
            NumberSequenceKeypoint.new(0.5, 0),
            NumberSequenceKeypoint.new(0.501, 1),
            NumberSequenceKeypoint.new(1, 1)
        })
        v32.Transparency = NumberSequence.new({
            NumberSequenceKeypoint.new(0, 0),
            NumberSequenceKeypoint.new(0.5, 0),
            NumberSequenceKeypoint.new(0.501, 1),
            NumberSequenceKeypoint.new(1, 1)
        })
        v31.Rotation = 0
        v32.Rotation = 0
    else
        warn("DefuseBomb: Frame or ProgressBar not found")
    end
end
function v_u_1.UpdateProgressBar(p33, p34)
    if p33.Frame and p33.Frame.ProgressBar then
        if p33.LeftGradient and p33.RightGradient then
            if p33.LeftProgressImage and p33.RightProgressImage then
                local v35 = math.clamp(p34, 0, 1)
                local v36 = math.clamp(v35, 0, 1)
                local v37
                if v36 <= 0.5 then
                    v37 = v_u_18:Lerp(v_u_16, v36 * 2)
                else
                    v37 = v_u_16:Lerp(v_u_17, (v36 - 0.5) * 2)
                end
                p33.LeftProgressImage.ImageColor3 = v37
                p33.RightProgressImage.ImageColor3 = v37
                local v38 = v35 * 180
                p33.RightGradient.Rotation = 360 - v38
                p33.LeftGradient.Rotation = v38 + 180
                p33:AnimateBomb(v35)
                if p33.Frame.UIGradient then
                    local v39 = math.clamp(v35, 0, 1)
                    local v40
                    if v39 <= 0.5 then
                        v40 = v_u_18:Lerp(v_u_16, v39 * 2)
                    else
                        v40 = v_u_16:Lerp(v_u_17, (v39 - 0.5) * 2)
                    end
                    local v41 = v40:Lerp(Color3.new(0, 0, 0), 0.3)
                    p33.Frame.UIGradient.Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, v40), ColorSequenceKeypoint.new(1, v41) })
                end
                local v42 = math.clamp(v35, 0, 1)
                local v43
                if v42 <= 0.5 then
                    v43 = v_u_18:Lerp(v_u_16, v42 * 2)
                else
                    v43 = v_u_16:Lerp(v_u_17, (v42 - 0.5) * 2)
                end
                local v44 = v43:Lerp(Color3.new(0, 0, 0), 0.2)
                if p33.Frame.Frame1 then
                    p33.Frame.Frame1.BackgroundColor3 = v44
                end
                if p33.Frame.Frame2 then
                    p33.Frame.Frame2.BackgroundColor3 = v44
                end
            end
        else
            return
        end
    else
        return
    end
end
function v_u_1.AnimateBomb(p45, p46)
    if p45.Frame and p45.Frame.ProgressBar then
        local v47 = p45.Frame.ProgressBar:FindFirstChild("Bomb")
        if v47 then
            local v48 = tick() * (p46 * 0.5 + 0.5) * 3.141592653589793 * 2
            local v49 = math.sin(v48)
            local v50 = Vector2.new(0.5, 0.45)
            local v51 = v49 * 0.05 + 1
            local v52 = UDim2.new(v50.X * v51, 0, v50.Y * v51, 0)
            local v53 = Color3.fromRGB(255, 200, 0):Lerp(Color3.fromRGB(255, 255, 255), (v49 + 1) / 2)
            v47.Size = v52
            v47.ImageColor3 = v53
        end
    else
        return
    end
end
function v_u_1.UpdateTimer(p54, p55)
    if p54.Frame and p54.Frame.Timer then
        local v56 = p54.Frame.Timer
        local v57 = p55 / 60
        local v58 = math.floor(v57)
        local v59 = p55 % 60
        local v60 = math.floor(v59)
        local v61 = (v59 - v60) * 1000
        local v62 = math.floor(v61)
        v56.Text = string.format("%02d:%02d.%03d", v58, v60, v62)
        p54.Frame.Timer.TextStrokeColor3 = Color3.new(0, 0, 0)
        p54.Frame.Timer.TextColor3 = Color3.new(1, 1, 1)
        p54.Frame.Timer.TextStrokeTransparency = 0
    end
end
function v_u_1.UpdateTitle(p63)
    if p63.Frame and p63.Frame.Title then
        p63.Frame.Title.Text = string.format("%s is defusing the bomb %s a kit.", p63.PlayerName, p63.HasDefuseKit and "with" or "without")
        p63.Frame.Title.TextStrokeColor3 = Color3.new(0, 0, 0)
        p63.Frame.Title.TextColor3 = Color3.new(1, 1, 1)
        p63.Frame.Title.TextStrokeTransparency = 0
    end
end
function v_u_1.StartDefuse(p_u_64, p65)
    local v66 = v_u_13:GetAttribute("IsSpectating")
    local v67 = v_u_10.GetCurrentSpectateInstance()
    local v68 = p65 or (v66 and (v67 and v67.Player) or v_u_13)
    if p_u_64.IsDefusing and p_u_64.PlayerName == v68.Name then
        return
    else
        local v69 = game:GetService("CollectionService"):GetTagged("Bomb")[1]
        if v69 and v69:GetAttribute("Defused") then
            return
        elseif not (v69 and v69:GetAttribute("Exploding")) then
            p_u_64.HasDefuseKit = v68:GetAttribute("HasDefuseKit")
            p_u_64.PlayerName = v68.Name
            p_u_64.DefuseTime = p_u_64.HasDefuseKit and 5 or 10
            local v70 = v68:GetAttribute("DefuseStartTime")
            if v70 and (v66 or v68 ~= v_u_13) then
                local v71 = workspace:GetServerTimeNow()
                if v70 <= v71 and v71 - v70 <= p_u_64.DefuseTime then
                    p_u_64.DefuseStartTime = v70
                else
                    p_u_64.DefuseStartTime = v71
                end
            else
                p_u_64.DefuseStartTime = workspace:GetServerTimeNow()
            end
            p_u_64.DefuseProgress = 0
            p_u_64.IsDefusing = true
            p_u_64.UseKeybinds = nil
            if p_u_64.Frame then
                p_u_64.Frame.Visible = true
            end
            p_u_64:UpdateProgressBar(0)
            p_u_64:UpdateTimer(p_u_64.DefuseTime)
            p_u_64:UpdateTitle()
            p_u_64.Janitor:Add(v_u_3.Heartbeat:Connect(function()
                if p_u_64.IsDefusing and not p_u_64.IsFinished then
                    local v72 = v_u_13:GetAttribute("IsSpectating")
                    local v73 = v_u_10.GetCurrentSpectateInstance()
                    if v72 then
                        if v73 then
                            v72 = p_u_64.PlayerName ~= v_u_13.Name
                        else
                            v72 = v73
                        end
                    end
                    if v72 and v73 then
                        local v74 = v73.Player
                        if not v74:GetAttribute("IsDefusingBomb") then
                            if p_u_64.DefuseProgress >= 0.95 then
                                p_u_64:FinishDefuse()
                            else
                                p_u_64:CancelDefuse()
                            end
                        end
                        local v75 = v74:GetAttribute("DefuseStartTime")
                        if v75 then
                            local v76 = workspace:GetServerTimeNow()
                            if v75 < p_u_64.DefuseStartTime and (v75 <= v76 and v76 - v75 <= p_u_64.DefuseTime) then
                                p_u_64.DefuseStartTime = v75
                            end
                        end
                    elseif not (v_u_14 or v_u_24(p_u_64.UseKeybinds)) then
                        if v_u_13:GetAttribute("IsDefusingBomb") then
                            p_u_64:CancelDefuse()
                        else
                            p_u_64:CancelDefuse()
                        end
                    end
                    local v77 = workspace:GetServerTimeNow() - p_u_64.DefuseStartTime
                    local v78 = p_u_64
                    local v79 = v77 / p_u_64.DefuseTime
                    v78.DefuseProgress = math.min(v79, 1)
                    local v80 = p_u_64.DefuseTime - v77
                    local v81 = math.max(v80, 0)
                    p_u_64:UpdateProgressBar(p_u_64.DefuseProgress)
                    p_u_64:UpdateTimer(v81)
                    if p_u_64.DefuseProgress >= 1 and not (p_u_64.IsFinished or v72) then
                        p_u_64:FinishDefuse()
                    end
                else
                    return
                end
            end), "Disconnect", "ProgressConnection")
            if not v66 or v68 == v_u_13 then
                v_u_6.C4.StartDefuse.Send()
            end
            p_u_64.DefuseStarted:Fire()
        end
    end
end
function v_u_1.CancelDefuse(p_u_82)
    if p_u_82.IsDefusing then
        local v83 = v_u_13:GetAttribute("IsSpectating")
        local v84 = v_u_10.GetCurrentSpectateInstance()
        if v83 then
            if v84 then
                v84 = p_u_82.PlayerName ~= v_u_13.Name
            end
        else
            v84 = v83
        end
        p_u_82.IsDefusing = false
        p_u_82.IsFinished = true
        p_u_82:UpdateProgressBar(0)
        if p_u_82.Frame then
            p_u_82.Frame.Visible = false
        end
        if not v84 then
            v_u_6.C4.CancelDefuse.Send()
        end
        p_u_82.DefuseCancelled:Fire()
        task.defer(function()
            p_u_82:Destroy()
        end)
    end
end
function v_u_1.FinishDefuse(p_u_85)
    if p_u_85.IsDefusing and not p_u_85.IsFinished then
        local v86 = v_u_13:GetAttribute("IsSpectating")
        local v87 = v_u_10.GetCurrentSpectateInstance()
        if v86 then
            if v87 then
                v87 = p_u_85.PlayerName ~= v_u_13.Name
            end
        else
            v87 = v86
        end
        p_u_85.IsFinished = true
        p_u_85.IsDefusing = false
        if not v87 then
            v_u_6.C4.Defused.Send()
        end
        p_u_85.DefuseFinished:Fire()
        task.delay(0.5, function()
            p_u_85:Destroy()
        end)
    end
end
function v_u_1.new(p88)
    local v89 = v_u_1
    local v90 = setmetatable({}, v89)
    v90.Janitor = v_u_8.new()
    v90.Frame = p88
    v90.RightProgressImage = nil
    v90.LeftProgressImage = nil
    v90.RightGradient = nil
    v90.LeftGradient = nil
    v90.DefuseTime = 10
    v90.HasDefuseKit = false
    v90.DefuseStartTime = 0
    v90.DefuseProgress = 0
    v90.IsDefusing = false
    v90.IsFinished = false
    v90.PlayerName = ""
    v90.DefuseCancelled = v90.Janitor:Add(v_u_9.new())
    v90.DefuseFinished = v90.Janitor:Add(v_u_9.new())
    v90.DefuseStarted = v90.Janitor:Add(v_u_9.new())
    if v90.Frame then
        v90.Frame.Visible = false
    end
    v90:InitializeProgressBar()
    return v90
end
function v_u_1.Destroy(p91)
    if v_u_20 == p91 then
        v_u_20 = nil
    end
    if p91.Frame then
        p91.Frame.Visible = false
    end
    p91.Janitor:Destroy()
end
function v_u_1.Initialize(_, p92)
    v_u_19 = p92
    v_u_7.observerRouter("Start Defuse Bomb", function()
        if v_u_15 and workspace:GetServerTimeNow() < v_u_15 then
            return nil
        end
        local v93 = game:GetService("CollectionService"):GetTagged("Bomb")[1]
        if v93 and v93:GetAttribute("Exploding") then
            return nil
        end
        if not v_u_20 then
            v_u_20 = v_u_1.new(v_u_19)
        end
        if v_u_20 then
            v_u_20:StartDefuse()
        end
        return nil
    end)
    v_u_7.observerRouter("Cancel Defuse Bomb", function()
        if v_u_20 then
            v_u_20:CancelDefuse()
            v_u_20 = nil
        end
        return nil
    end)
    local v_u_94 = nil
    local function v_u_100()
        local v95 = v_u_13:GetAttribute("IsSpectating")
        local v96 = v_u_10.GetCurrentSpectateInstance()
        if v95 and v96 then
            local v97 = v96.Player
            local v98 = v97:GetAttribute("IsDefusingBomb")
            local v99 = game:GetService("CollectionService"):GetTagged("Bomb")[1]
            if v99 and v99:GetAttribute("Defused") then
                if v_u_20 then
                    v_u_20:CancelDefuse()
                    v_u_20 = nil
                end
                return
            end
            if v98 then
                if not v_u_20 then
                    v_u_20 = v_u_1.new(v_u_19)
                end
                if v_u_20 then
                    v_u_20:StartDefuse(v97)
                    return
                end
            elseif v_u_20 then
                v_u_20:CancelDefuse()
                v_u_20 = nil
                return
            end
        elseif v_u_20 and not v_u_13:GetAttribute("IsDefusingBomb") then
            v_u_20:CancelDefuse()
            v_u_20 = nil
        end
    end
    v_u_13:GetAttributeChangedSignal("IsSpectating"):Connect(function()
        v_u_100()
    end)
    local function v_u_102()
        if v_u_94 then
            v_u_94:Disconnect()
            v_u_94 = nil
        end
        local v101 = v_u_10.GetCurrentSpectateInstance()
        if v101 then
            v_u_94 = v101.Player:GetAttributeChangedSignal("IsDefusingBomb"):Connect(function()
                v_u_100()
            end)
            v_u_100()
        end
    end
    v_u_10.ListenToSpectate:Connect(function(_)
        v_u_102()
    end)
    task.wait(0.1)
    v_u_102()
end
function v_u_1.SetDefuseBlockedUntil(p103)
    v_u_15 = p103
end
return v_u_1