local v_u_1 = Enum.ContextActionPriority.High.Value
local v_u_2 = {
    0.10999999999999999,
    0.30000000000000004,
    0.4,
    0.5,
    0.6,
    0.7,
    0.75
}
local v_u_3 = #v_u_2
local v_u_4 = TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut)
local v5 = game:GetService("Players")
local v_u_6 = game:GetService("GuiService")
local v_u_7 = game:GetService("UserInputService")
local v_u_8 = game:GetService("ContextActionService")
local v_u_9 = game:GetService("RunService")
local v_u_10 = game:GetService("TweenService")
local v11, v12 = pcall(function()
    return UserSettings():IsUserFeatureEnabled("UserDynamicThumbstickMoveOverButtons2")
end)
local v_u_13 = v11 and v12
local v14, v15 = pcall(function()
    return UserSettings():IsUserFeatureEnabled("UserDynamicThumbstickSafeAreaUpdate")
end)
local v_u_16 = v14 and v15
local v_u_17 = v5.LocalPlayer
if not v_u_17 then
    v5:GetPropertyChangedSignal("LocalPlayer"):Wait()
    v_u_17 = v5.LocalPlayer
end
local v_u_18 = require(script.Parent:WaitForChild("BaseCharacterController"))
local v_u_19 = setmetatable({}, v_u_18)
v_u_19.__index = v_u_19
function v_u_19.new()
    local v20 = v_u_18.new()
    local v21 = v_u_19
    local v22 = setmetatable(v20, v21)
    v22.moveTouchObject = nil
    v22.moveTouchLockedIn = false
    v22.moveTouchFirstChanged = false
    v22.moveTouchStartPosition = nil
    v22.startImage = nil
    v22.endImage = nil
    v22.middleImages = {}
    v22.startImageFadeTween = nil
    v22.endImageFadeTween = nil
    v22.middleImageFadeTweens = {}
    v22.isFirstTouch = true
    v22.thumbstickFrame = nil
    v22.onRenderSteppedConn = nil
    v22.fadeInAndOutBalance = 0.5
    v22.fadeInAndOutHalfDuration = 0.3
    v22.hasFadedBackgroundInPortrait = false
    v22.hasFadedBackgroundInLandscape = false
    v22.tweenInAlphaStart = nil
    v22.tweenOutAlphaStart = nil
    return v22
end
function v_u_19.GetIsJumping(p23)
    local v24 = p23.isJumping
    p23.isJumping = false
    return v24
end
function v_u_19.Enable(p25, p26, p27)
    if p26 == nil then
        return false
    end
    local v28 = p26 and true or false
    if p25.enabled == v28 then
        return true
    end
    if v28 then
        if not p25.thumbstickFrame then
            p25:Create(p27)
        end
        p25:BindContextActions()
    else
        if v_u_13 then
            p25:UnbindContextActions()
        else
            v_u_8:UnbindAction("DynamicThumbstickAction")
        end
        p25:OnInputEnded()
    end
    p25.enabled = v28
    p25.thumbstickFrame.Visible = v28
    return nil
end
function v_u_19.OnInputEnded(p29)
    p29.moveTouchObject = nil
    p29.moveVector = Vector3.new(0, 0, 0)
    p29:FadeThumbstick(false)
end
function v_u_19.FadeThumbstick(p30, p31)
    if p31 or not p30.moveTouchObject then
        if p30.isFirstTouch then
            return
        else
            if p30.startImageFadeTween then
                p30.startImageFadeTween:Cancel()
            end
            if p30.endImageFadeTween then
                p30.endImageFadeTween:Cancel()
            end
            for v32 = 1, #p30.middleImages do
                if p30.middleImageFadeTweens[v32] then
                    p30.middleImageFadeTweens[v32]:Cancel()
                end
            end
            if p31 then
                p30.startImageFadeTween = v_u_10:Create(p30.startImage, v_u_4, {
                    ["ImageTransparency"] = 0
                })
                p30.startImageFadeTween:Play()
                p30.endImageFadeTween = v_u_10:Create(p30.endImage, v_u_4, {
                    ["ImageTransparency"] = 0.2
                })
                p30.endImageFadeTween:Play()
                for v33 = 1, #p30.middleImages do
                    p30.middleImageFadeTweens[v33] = v_u_10:Create(p30.middleImages[v33], v_u_4, {
                        ["ImageTransparency"] = v_u_2[v33]
                    })
                    p30.middleImageFadeTweens[v33]:Play()
                end
            else
                p30.startImageFadeTween = v_u_10:Create(p30.startImage, v_u_4, {
                    ["ImageTransparency"] = 1
                })
                p30.startImageFadeTween:Play()
                p30.endImageFadeTween = v_u_10:Create(p30.endImage, v_u_4, {
                    ["ImageTransparency"] = 1
                })
                p30.endImageFadeTween:Play()
                for v34 = 1, #p30.middleImages do
                    p30.middleImageFadeTweens[v34] = v_u_10:Create(p30.middleImages[v34], v_u_4, {
                        ["ImageTransparency"] = 1
                    })
                    p30.middleImageFadeTweens[v34]:Play()
                end
            end
        end
    else
        return
    end
end
function v_u_19.FadeThumbstickFrame(p35, p36, p37)
    p35.fadeInAndOutHalfDuration = p36 * 0.5
    p35.fadeInAndOutBalance = p37
    p35.tweenInAlphaStart = tick()
end
function v_u_19.InputInFrame(p38, p39)
    local v40 = p38.thumbstickFrame.AbsolutePosition
    local v41 = v40 + p38.thumbstickFrame.AbsoluteSize
    local v42 = p39.Position
    return v42.X >= v40.X and (v42.Y >= v40.Y and (v42.X <= v41.X and v42.Y <= v41.Y))
end
function v_u_19.DoFadeInBackground(p43)
    local v44 = v_u_17:FindFirstChildOfClass("PlayerGui")
    local v45 = false
    if v44 then
        if v44.CurrentScreenOrientation == Enum.ScreenOrientation.LandscapeLeft or v44.CurrentScreenOrientation == Enum.ScreenOrientation.LandscapeRight then
            v45 = p43.hasFadedBackgroundInLandscape
            p43.hasFadedBackgroundInLandscape = true
        elseif v44.CurrentScreenOrientation == Enum.ScreenOrientation.Portrait then
            v45 = p43.hasFadedBackgroundInPortrait
            p43.hasFadedBackgroundInPortrait = true
        end
    end
    if not v45 then
        p43.fadeInAndOutHalfDuration = 0.3
        p43.fadeInAndOutBalance = 0.5
        p43.tweenInAlphaStart = tick()
    end
end
function v_u_19.DoMove(p46, p47)
    local v48
    if p47.Magnitude < p46.radiusOfDeadZone then
        v48 = Vector3.new(0, 0, 0)
    else
        local v49 = p47.Unit
        local v50 = (p46.radiusOfMaxSpeed - p47.Magnitude) / p46.radiusOfMaxSpeed
        local v51 = v49 * (1 - math.max(0, v50))
        local v52 = v51.X
        local v53 = v51.Y
        v48 = Vector3.new(v52, 0, v53)
    end
    p46.moveVector = v48
end
function v_u_19.LayoutMiddleImages(p54, p55, p56)
    local v57 = p54.thumbstickSize / 2 + p54.middleSize
    local v58 = p56 - p55
    local v59 = v58.Magnitude - p54.thumbstickRingSize / 2 - p54.middleSize
    local v60 = v58.Unit
    local v61 = p54.middleSpacing * v_u_3
    local v62 = p54.middleSpacing
    if v61 < v59 then
        v62 = v59 / v_u_3
    end
    for v63 = 1, v_u_3 do
        local v64 = p54.middleImages[v63]
        local v65 = v57 + v62 * (v63 - 2)
        local v66 = v57 + v62 * (v63 - 1)
        if v65 < v59 then
            local v67 = p56 - v60 * v66
            local v68 = 1 - (v66 - v59) / v62
            local v69 = math.clamp(v68, 0, 1)
            v64.Visible = true
            v64.Position = UDim2.new(0, v67.X, 0, v67.Y)
            v64.Size = UDim2.new(0, p54.middleSize * v69, 0, p54.middleSize * v69)
        else
            v64.Visible = false
        end
    end
end
function v_u_19.MoveStick(p70, p71)
    local v72 = Vector2.new(p70.moveTouchStartPosition.X, p70.moveTouchStartPosition.Y) - p70.thumbstickFrame.AbsolutePosition
    local v73 = Vector2.new(p71.X, p71.Y) - p70.thumbstickFrame.AbsolutePosition
    p70.endImage.Position = UDim2.new(0, v73.X, 0, v73.Y)
    p70:LayoutMiddleImages(v72, v73)
end
function v_u_19.BindContextActions(p_u_74)
    local function v_u_77(p75)
        if p_u_74.moveTouchObject then
            return Enum.ContextActionResult.Pass
        end
        if not p_u_74:InputInFrame(p75) then
            return Enum.ContextActionResult.Pass
        end
        if p_u_74.isFirstTouch then
            p_u_74.isFirstTouch = false
            local v76 = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, 0)
            v_u_10:Create(p_u_74.startImage, v76, {
                ["Size"] = UDim2.new(0, 0, 0, 0)
            }):Play()
            v_u_10:Create(p_u_74.endImage, v76, {
                ["Size"] = UDim2.new(0, p_u_74.thumbstickSize, 0, p_u_74.thumbstickSize),
                ["ImageColor3"] = Color3.new(0, 0, 0)
            }):Play()
        end
        p_u_74.moveTouchLockedIn = false
        p_u_74.moveTouchObject = p75
        p_u_74.moveTouchStartPosition = p75.Position
        p_u_74.moveTouchFirstChanged = true
        p_u_74:DoFadeInBackground()
        return Enum.ContextActionResult.Pass
    end
    local function v_u_83(p78)
        if p78 ~= p_u_74.moveTouchObject then
            return Enum.ContextActionResult.Pass
        end
        if p_u_74.moveTouchFirstChanged then
            p_u_74.moveTouchFirstChanged = false
            local v79 = Vector2.new(p78.Position.X - p_u_74.thumbstickFrame.AbsolutePosition.X, p78.Position.Y - p_u_74.thumbstickFrame.AbsolutePosition.Y)
            p_u_74.startImage.Visible = true
            p_u_74.startImage.Position = UDim2.new(0, v79.X, 0, v79.Y)
            p_u_74.endImage.Visible = true
            p_u_74.endImage.Position = p_u_74.startImage.Position
            p_u_74:FadeThumbstick(true)
            p_u_74:MoveStick(p78.Position)
        end
        p_u_74.moveTouchLockedIn = true
        local v80 = Vector2.new(p78.Position.X - p_u_74.moveTouchStartPosition.X, p78.Position.Y - p_u_74.moveTouchStartPosition.Y)
        local v81 = v80.X
        if math.abs(v81) <= 0 then
            local v82 = v80.Y
            if math.abs(v82) <= 0 then
                ::l7::
                return Enum.ContextActionResult.Sink
            end
        end
        p_u_74:DoMove(v80)
        p_u_74:MoveStick(p78.Position)
        goto l7
    end
    v_u_8:BindActionAtPriority("DynamicThumbstickAction", function(_, p84, p85)
        if p84 == Enum.UserInputState.Begin then
            return v_u_77(p85)
        elseif p84 == Enum.UserInputState.Change then
            if v_u_13 then
                if p85 == p_u_74.moveTouchObject then
                    return Enum.ContextActionResult.Sink
                else
                    return Enum.ContextActionResult.Pass
                end
            else
                return v_u_83(p85)
            end
        else
            if p84 == Enum.UserInputState.End then
                if p85 == p_u_74.moveTouchObject then
                    p_u_74:OnInputEnded()
                    if p_u_74.moveTouchLockedIn then
                        return Enum.ContextActionResult.Sink
                    end
                end
                return Enum.ContextActionResult.Pass
            end
            if p84 == Enum.UserInputState.Cancel then
                p_u_74:OnInputEnded()
            end
            return
        end
    end, false, v_u_1, Enum.UserInputType.Touch)
    if v_u_13 then
        p_u_74.TouchMovedCon = v_u_7.TouchMoved:Connect(function(p86, _)
            v_u_83(p86)
        end)
    end
end
function v_u_19.UnbindContextActions(p87)
    v_u_8:UnbindAction("DynamicThumbstickAction")
    if p87.TouchMovedCon then
        p87.TouchMovedCon:Disconnect()
    end
end
function v_u_19.Create(p_u_88, p_u_89)
    if p_u_88.thumbstickFrame then
        p_u_88.thumbstickFrame:Destroy()
        p_u_88.thumbstickFrame = nil
        if p_u_88.onRenderSteppedConn then
            p_u_88.onRenderSteppedConn:Disconnect()
            p_u_88.onRenderSteppedConn = nil
        end
        if p_u_88.absoluteSizeChangedConn then
            p_u_88.absoluteSizeChangedConn:Disconnect()
            p_u_88.absoluteSizeChangedConn = nil
        end
    end
    local v_u_90 = v_u_16 and 100 or 0
    p_u_88.thumbstickFrame = Instance.new("Frame")
    p_u_88.thumbstickFrame.BorderSizePixel = 0
    p_u_88.thumbstickFrame.Name = "DynamicThumbstickFrame"
    p_u_88.thumbstickFrame.Visible = false
    p_u_88.thumbstickFrame.BackgroundTransparency = 1
    p_u_88.thumbstickFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    p_u_88.thumbstickFrame.Active = false
    p_u_88.thumbstickFrame.Size = UDim2.new(0.4, v_u_90, 0.6666666666666666, v_u_90)
    p_u_88.thumbstickFrame.Position = UDim2.new(0, -v_u_90, 0.3333333333333333, 0)
    p_u_88.startImage = Instance.new("ImageLabel")
    p_u_88.startImage.Name = "ThumbstickStart"
    p_u_88.startImage.Visible = true
    p_u_88.startImage.BackgroundTransparency = 1
    p_u_88.startImage.Image = "rbxasset://textures/ui/Input/TouchControlsSheetV2.png"
    p_u_88.startImage.ImageRectOffset = Vector2.new(1, 1)
    p_u_88.startImage.ImageRectSize = Vector2.new(144, 144)
    p_u_88.startImage.ImageColor3 = Color3.new(0, 0, 0)
    p_u_88.startImage.AnchorPoint = Vector2.new(0.5, 0.5)
    p_u_88.startImage.ZIndex = 10
    p_u_88.startImage.Parent = p_u_88.thumbstickFrame
    p_u_88.endImage = Instance.new("ImageLabel")
    p_u_88.endImage.Name = "ThumbstickEnd"
    p_u_88.endImage.Visible = true
    p_u_88.endImage.BackgroundTransparency = 1
    p_u_88.endImage.Image = "rbxasset://textures/ui/Input/TouchControlsSheetV2.png"
    p_u_88.endImage.ImageRectOffset = Vector2.new(1, 1)
    p_u_88.endImage.ImageRectSize = Vector2.new(144, 144)
    p_u_88.endImage.AnchorPoint = Vector2.new(0.5, 0.5)
    p_u_88.endImage.ZIndex = 10
    p_u_88.endImage.Parent = p_u_88.thumbstickFrame
    local function v_u_92(p91)
        if p91 then
            p_u_88.thumbstickFrame.Size = UDim2.new(1, v_u_90, 0.4, v_u_90)
            p_u_88.thumbstickFrame.Position = UDim2.new(0, -v_u_90, 0.6, 0)
        else
            p_u_88.thumbstickFrame.Size = UDim2.new(0.4, v_u_90, 0.6666666666666666, v_u_90)
            p_u_88.thumbstickFrame.Position = UDim2.new(0, -v_u_90, 0.3333333333333333, 0)
        end
    end
    for v93 = 1, v_u_3 do
        p_u_88.middleImages[v93] = Instance.new("ImageLabel")
        p_u_88.middleImages[v93].Name = "ThumbstickMiddle"
        p_u_88.middleImages[v93].Visible = false
        p_u_88.middleImages[v93].BackgroundTransparency = 1
        p_u_88.middleImages[v93].Image = "rbxasset://textures/ui/Input/TouchControlsSheetV2.png"
        p_u_88.middleImages[v93].ImageRectOffset = Vector2.new(1, 1)
        p_u_88.middleImages[v93].ImageRectSize = Vector2.new(144, 144)
        p_u_88.middleImages[v93].ImageTransparency = v_u_2[v93]
        p_u_88.middleImages[v93].AnchorPoint = Vector2.new(0.5, 0.5)
        p_u_88.middleImages[v93].ZIndex = 9
        p_u_88.middleImages[v93].Parent = p_u_88.thumbstickFrame
    end
    local function v97()
        local v94 = p_u_89.AbsoluteSize
        local v95 = v94.X
        local v96 = v94.Y
        if math.min(v95, v96) > 500 then
            p_u_88.thumbstickSize = 90
            p_u_88.thumbstickRingSize = 40
            p_u_88.middleSize = 20
            p_u_88.middleSpacing = 28
            p_u_88.radiusOfDeadZone = 4
            p_u_88.radiusOfMaxSpeed = 40
        else
            p_u_88.thumbstickSize = 45
            p_u_88.thumbstickRingSize = 20
            p_u_88.middleSize = 10
            p_u_88.middleSpacing = 14
            p_u_88.radiusOfDeadZone = 2
            p_u_88.radiusOfMaxSpeed = 20
        end
        p_u_88.startImage.Position = UDim2.new(0, p_u_88.thumbstickRingSize * 3.3 + v_u_90, 1, -p_u_88.thumbstickRingSize * 2.8 - v_u_90)
        p_u_88.startImage.Size = UDim2.new(0, p_u_88.thumbstickRingSize * 3.7, 0, p_u_88.thumbstickRingSize * 3.7)
        p_u_88.endImage.Position = p_u_88.startImage.Position
        p_u_88.endImage.Size = UDim2.new(0, p_u_88.thumbstickSize * 0.8, 0, p_u_88.thumbstickSize * 0.8)
    end
    v97()
    p_u_88.absoluteSizeChangedConn = p_u_89:GetPropertyChangedSignal("AbsoluteSize"):Connect(v97)
    local v_u_98 = nil
    local function v103()
        if v_u_98 then
            v_u_98:Disconnect()
            v_u_98 = nil
        end
        local v_u_99 = workspace.CurrentCamera
        if v_u_99 then
            local function v101()
                local v100 = v_u_99.ViewportSize
                v_u_92(v100.X < v100.Y)
            end
            v_u_98 = v_u_99:GetPropertyChangedSignal("ViewportSize"):Connect(v101)
            local v102 = v_u_99.ViewportSize
            v_u_92(v102.X < v102.Y)
        end
    end
    workspace:GetPropertyChangedSignal("CurrentCamera"):Connect(v103)
    if workspace.CurrentCamera then
        v103()
    end
    p_u_88.moveTouchStartPosition = nil
    p_u_88.startImageFadeTween = nil
    p_u_88.endImageFadeTween = nil
    p_u_88.middleImageFadeTweens = {}
    p_u_88.onRenderSteppedConn = v_u_9.RenderStepped:Connect(function()
        if p_u_88.tweenInAlphaStart == nil then
            if p_u_88.tweenOutAlphaStart ~= nil then
                local v104 = tick() - p_u_88.tweenOutAlphaStart
                local v105 = p_u_88.fadeInAndOutHalfDuration * 2 - p_u_88.fadeInAndOutHalfDuration * 2 * p_u_88.fadeInAndOutBalance
                local v106 = p_u_88.thumbstickFrame
                local v107 = v104 / v105
                v106.BackgroundTransparency = math.min(v107, 1) * 0.35 + 0.65
                if v105 < v104 then
                    p_u_88.tweenOutAlphaStart = nil
                end
            end
        else
            local v108 = tick() - p_u_88.tweenInAlphaStart
            local v109 = p_u_88.fadeInAndOutHalfDuration * 2 * p_u_88.fadeInAndOutBalance
            local v110 = p_u_88.thumbstickFrame
            local v111 = v108 / v109
            v110.BackgroundTransparency = 1 - math.min(v111, 1) * 0.35
            if v109 < v108 then
                p_u_88.tweenOutAlphaStart = tick()
                p_u_88.tweenInAlphaStart = nil
                return
            end
        end
    end)
    p_u_88.onTouchEndedConn = v_u_7.TouchEnded:connect(function(p112)
        if p112 == p_u_88.moveTouchObject then
            p_u_88:OnInputEnded()
        end
    end)
    v_u_6.MenuOpened:connect(function()
        if p_u_88.moveTouchObject then
            p_u_88:OnInputEnded()
        end
    end)
    local v_u_113 = v_u_17:FindFirstChildOfClass("PlayerGui")
    while not v_u_113 do
        v_u_17.ChildAdded:wait()
        v_u_113 = v_u_17:FindFirstChildOfClass("PlayerGui")
    end
    local v_u_114 = nil
    local v_u_115 = v_u_113.CurrentScreenOrientation == Enum.ScreenOrientation.LandscapeLeft and true or v_u_113.CurrentScreenOrientation == Enum.ScreenOrientation.LandscapeRight
    local _ = v_u_113:GetPropertyChangedSignal("CurrentScreenOrientation"):Connect(function()
        if v_u_115 and v_u_113.CurrentScreenOrientation == Enum.ScreenOrientation.Portrait or not v_u_115 and v_u_113.CurrentScreenOrientation ~= Enum.ScreenOrientation.Portrait then
            v_u_114:disconnect()
            p_u_88.fadeInAndOutHalfDuration = 2.5
            p_u_88.fadeInAndOutBalance = 0.05
            p_u_88.tweenInAlphaStart = tick()
            if v_u_115 then
                p_u_88.hasFadedBackgroundInPortrait = true
                return
            end
            p_u_88.hasFadedBackgroundInLandscape = true
        end
    end)
    p_u_88.thumbstickFrame.Parent = p_u_89
    if game:IsLoaded() then
        p_u_88.fadeInAndOutHalfDuration = 2.5
        p_u_88.fadeInAndOutBalance = 0.05
        p_u_88.tweenInAlphaStart = tick()
    else
        coroutine.wrap(function()
            game.Loaded:Wait()
            p_u_88.fadeInAndOutHalfDuration = 2.5
            p_u_88.fadeInAndOutBalance = 0.05
            p_u_88.tweenInAlphaStart = tick()
        end)()
    end
end
return v_u_19