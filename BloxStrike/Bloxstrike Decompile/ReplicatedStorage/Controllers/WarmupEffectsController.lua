local v_u_1 = game:GetService("ReplicatedStorage")
local v_u_2 = game:GetService("TweenService")
local v_u_3 = game:GetService("Lighting")
local v_u_4 = game:GetService("Workspace")
local v5 = game:GetService("Players")
local v_u_6 = require(v_u_1.Database.Components.GameState)
local v_u_7 = require(v_u_1.Database.Security.Router)
local v_u_8 = require(v_u_1.Packages.Observers)
local v_u_9 = require(v_u_1.Interface.MenuState)
local v_u_10 = v5.LocalPlayer
local v_u_11 = {
    ["WarmupColorCorrection"] = true,
    ["FlashbangColorCorrection"] = true
}
local v12 = {}
local function v_u_16()
    local v13 = nil
    local v14 = nil
    for _, v15 in ipairs(v_u_3:GetDescendants()) do
        if v15:IsA("ColorCorrectionEffect") and not v_u_11[v15.Name] then
            if v15.Enabled then
                v13 = v13 or v15
            end
            if not v14 then
                v14 = v15
            end
        end
    end
    return v13 or v14
end
local function v_u_20()
    local v17 = v_u_4.CurrentCamera
    if not v17 then
        return nil
    end
    for _, v18 in ipairs(v17:GetChildren()) do
        if v18:IsA("Model") and v18:FindFirstChild("Stats") then
            return v18
        end
    end
    for _, v19 in ipairs(v17:GetDescendants()) do
        if v19:IsA("Model") and v19:FindFirstChild("Stats") then
            return v19
        end
    end
    return nil
end
function v12.Start()
    local v21 = v_u_1:FindFirstChild("Assets")
    local v22
    if v21 then
        v22 = v21:FindFirstChild("Warmup")
        if not (v22 and v22:IsA("Folder")) then
            v22 = nil
        end
    else
        v22 = nil
    end
    if v22 then
        local v_u_23 = v22:FindFirstChild("ColorCorrection")
        local v_u_24 = v22:FindFirstChild("ViewmodelHighlight")
        if v_u_23 and v_u_23:IsA("ColorCorrectionEffect") then
            if v_u_24 and v_u_24:IsA("Highlight") then
                local v_u_25 = 0
                local v_u_26 = nil
                local v_u_27 = false
                local v_u_28 = false
                local function v_u_69()
                    v_u_25 = v_u_25 + 1
                    if v_u_26 then
                        v_u_26()
                        v_u_26 = nil
                    end
                    v_u_25 = v_u_25 + 1
                    local v_u_29 = v_u_25
                    local v_u_30 = false
                    local v_u_31 = false
                    local v_u_32 = nil
                    local v_u_33 = nil
                    local v_u_34 = v_u_16()
                    local v_u_35 = nil
                    local v_u_36
                    if v_u_34 then
                        v_u_36 = v_u_34.Enabled or false
                    else
                        v_u_36 = false
                    end
                    local v_u_37 = v_u_34 and {
                        ["Brightness"] = v_u_34.Brightness,
                        ["Contrast"] = v_u_34.Contrast,
                        ["Saturation"] = v_u_34.Saturation,
                        ["TintColor"] = v_u_34.TintColor
                    } or nil
                    if v_u_34 then
                        v_u_34.Enabled = true
                        v_u_34.Brightness = v_u_23.Brightness
                        v_u_34.Contrast = v_u_23.Contrast
                        v_u_34.Saturation = v_u_23.Saturation
                        v_u_34.TintColor = v_u_23.TintColor
                    else
                        warn("[WarmupEffectsController] No map ColorCorrectionEffect found under Lighting; warmup CC tween skipped")
                    end
                    local function v_u_40(p38)
                        if v_u_30 then
                            return
                        elseif p38 > 0 then
                            v_u_30 = true
                            v_u_32 = os.clock()
                            v_u_33 = p38
                            if v_u_34 and v_u_37 then
                                if v_u_35 then
                                    v_u_35:Cancel()
                                    v_u_35 = nil
                                end
                                local v39 = v_u_2:Create(v_u_34, TweenInfo.new(p38, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                                    ["Brightness"] = v_u_37.Brightness,
                                    ["Contrast"] = v_u_37.Contrast,
                                    ["Saturation"] = v_u_37.Saturation,
                                    ["TintColor"] = v_u_37.TintColor
                                })
                                v_u_35 = v39
                                v39:Play()
                            end
                        end
                    end
                    local v_u_41 = nil
                    local v_u_42 = nil
                    local v_u_43 = nil
                    local v_u_44 = nil
                    local v_u_45 = nil
                    local v_u_46 = nil
                    local function v_u_51(p_u_47)
                        if v_u_41 then
                            return
                        elseif v_u_30 then
                            local v48
                            if v_u_30 and (v_u_32 and v_u_33) then
                                local v49 = v_u_33 - (os.clock() - v_u_32)
                                v48 = math.max(0, v49)
                            else
                                v48 = 0
                            end
                            if v48 <= 0 then
                                p_u_47.FillTransparency = 1
                                p_u_47.OutlineTransparency = 1
                                p_u_47:Destroy()
                                if v_u_42 == p_u_47 then
                                    v_u_42 = nil
                                end
                            else
                                local v50 = v_u_2:Create(p_u_47, TweenInfo.new(v48, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                                    ["FillTransparency"] = 1,
                                    ["OutlineTransparency"] = 1
                                })
                                v_u_41 = v50
                                v50.Completed:Connect(function()
                                    if p_u_47.Parent then
                                        p_u_47:Destroy()
                                    end
                                    if v_u_42 == p_u_47 then
                                        v_u_42 = nil
                                    end
                                end)
                                v50:Play()
                            end
                        else
                            return
                        end
                    end
                    local function v_u_55()
                        if v_u_25 == v_u_29 then
                            local v52 = v_u_4.CurrentCamera
                            if v52 then
                                local v53 = v_u_46
                                if not (v53 and v53:IsDescendantOf(v52)) then
                                    v53 = v_u_20()
                                    v_u_46 = v53
                                end
                                if v53 then
                                    local v54 = v_u_42
                                    if not v54 or v54.Parent == nil then
                                        v54 = v_u_24:Clone()
                                        v_u_42 = v54
                                        v_u_41 = nil
                                    end
                                    if v54.Parent ~= v53 then
                                        v54.Parent = v53
                                    end
                                    v54.Adornee = v53
                                    v_u_51(v54)
                                end
                            else
                                return
                            end
                        else
                            return
                        end
                    end
                    v_u_55()
                    local v_u_56 = false
                    local function v_u_62(p_u_57)
                        if v_u_43 then
                            v_u_43:Disconnect()
                            v_u_43 = nil
                        end
                        if v_u_44 then
                            v_u_44:Disconnect()
                            v_u_44 = nil
                        end
                        if v_u_45 then
                            v_u_45:Disconnect()
                            v_u_45 = nil
                        end
                        if p_u_57 then
                            v_u_43 = p_u_57.ChildAdded:Connect(function()
                                for _, v58 in ipairs(p_u_57:GetChildren()) do
                                    if v58:IsA("Model") and v58:FindFirstChild("Stats") then
                                        v_u_46 = v58
                                    end
                                end
                                v_u_55()
                            end)
                            v_u_45 = p_u_57.ChildRemoved:Connect(function(p59)
                                if v_u_46 == p59 then
                                    v_u_46 = nil
                                end
                                v_u_55()
                            end)
                            v_u_44 = p_u_57.DescendantAdded:Connect(function(p60)
                                if v_u_56 then
                                    return
                                elseif p60 ~= v_u_42 and (not p60:IsA("Highlight") or p60.Name ~= v_u_24.Name) then
                                    local v61 = v_u_20()
                                    if v61 then
                                        v_u_46 = v61
                                    end
                                    v_u_56 = true
                                    v_u_55()
                                    v_u_56 = false
                                end
                            end)
                        end
                    end
                    v_u_62(v_u_4.CurrentCamera)
                    local v_u_63 = v_u_4:GetPropertyChangedSignal("CurrentCamera"):Connect(function()
                        v_u_62(v_u_4.CurrentCamera)
                        v_u_55()
                    end)
                    local v_u_66 = v_u_4:GetAttributeChangedSignal("Timer"):Connect(function()
                        if v_u_25 == v_u_29 then
                            local v64 = v_u_4:GetAttribute("Timer")
                            if typeof(v64) == "number" then
                                if v64 > 0 then
                                    if not v_u_31 and v64 <= 2 then
                                        v_u_31 = true
                                        v_u_7.broadcastRouter("RunRoundSound", "Round Start Countdown")
                                    end
                                    if not v_u_30 and v64 <= 3 then
                                        v_u_40((math.min(3, v64)))
                                        local v65 = v_u_42
                                        if v65 then
                                            v_u_51(v65)
                                            return
                                        end
                                        v_u_55()
                                    end
                                end
                            else
                                return
                            end
                        else
                            return
                        end
                    end)
                    local v67 = v_u_4:GetAttribute("Timer")
                    if typeof(v67) == "number" then
                        if v67 > 0 and (not v_u_31 and v67 <= 2) then
                            local _ = true
                            v_u_7.broadcastRouter("RunRoundSound", "Round Start Countdown")
                        end
                        if v67 > 0 and v67 <= 3 then
                            v_u_40((math.min(3, v67)))
                            local v68 = v_u_42
                            if v68 then
                                v_u_51(v68)
                            else
                                v_u_55()
                            end
                        end
                    end
                    v_u_26 = function()
                        if v_u_35 then
                            v_u_35:Cancel()
                            v_u_35 = nil
                        end
                        if v_u_41 then
                            v_u_41:Cancel()
                            v_u_41 = nil
                        end
                        if v_u_43 then
                            v_u_43:Disconnect()
                            v_u_43 = nil
                        end
                        if v_u_44 then
                            v_u_44:Disconnect()
                            v_u_44 = nil
                        end
                        if v_u_45 then
                            v_u_45:Disconnect()
                            v_u_45 = nil
                        end
                        if v_u_63 then
                            v_u_63:Disconnect()
                            v_u_63 = nil
                        end
                        if v_u_66 then
                            v_u_66:Disconnect()
                            v_u_66 = nil
                        end
                        if v_u_42 then
                            v_u_42:Destroy()
                            v_u_42 = nil
                        end
                        if v_u_34 and v_u_37 then
                            v_u_34.Brightness = v_u_37.Brightness
                            v_u_34.Contrast = v_u_37.Contrast
                            v_u_34.Saturation = v_u_37.Saturation
                            v_u_34.TintColor = v_u_37.TintColor
                            v_u_34.Enabled = v_u_36
                        end
                    end
                end
                v_u_6.ListenToState(function(_, p70)
                    v_u_27 = p70 == "Buy Period"
                    v_u_27 = v_u_6.GetState() == "Buy Period"
                    local v71
                    if v_u_9.IsInspectActive() or v_u_9.IsCaseSceneActive() then
                        v71 = false
                    else
                        local v72 = v_u_9.GetMenuFrame()
                        if v72 and v72.Visible then
                            v71 = false
                        else
                            local v73 = v_u_10:GetAttribute("IsSpectating") == true
                            local v74 = v_u_10.Character ~= nil
                            v71 = v74 or v73
                        end
                    end
                    if v_u_27 and v71 then
                        if not v_u_28 then
                            v_u_28 = true
                            v_u_69()
                            return
                        end
                    elseif v_u_28 then
                        v_u_28 = false
                        v_u_25 = v_u_25 + 1
                        if v_u_26 then
                            v_u_26()
                            v_u_26 = nil
                        end
                    end
                end)
                v_u_9.OnScreenChanged:Connect(function()
                    v_u_27 = v_u_6.GetState() == "Buy Period"
                    local v75
                    if v_u_9.IsInspectActive() or v_u_9.IsCaseSceneActive() then
                        v75 = false
                    else
                        local v76 = v_u_9.GetMenuFrame()
                        if v76 and v76.Visible then
                            v75 = false
                        else
                            local v77 = v_u_10:GetAttribute("IsSpectating") == true
                            local v78 = v_u_10.Character ~= nil
                            v75 = v78 or v77
                        end
                    end
                    if v_u_27 and v75 then
                        if not v_u_28 then
                            v_u_28 = true
                            v_u_69()
                            return
                        end
                    elseif v_u_28 then
                        v_u_28 = false
                        v_u_25 = v_u_25 + 1
                        if v_u_26 then
                            v_u_26()
                            v_u_26 = nil
                        end
                    end
                end)
                v_u_9.OnInspectStateChanged:Connect(function()
                    v_u_27 = v_u_6.GetState() == "Buy Period"
                    local v79
                    if v_u_9.IsInspectActive() or v_u_9.IsCaseSceneActive() then
                        v79 = false
                    else
                        local v80 = v_u_9.GetMenuFrame()
                        if v80 and v80.Visible then
                            v79 = false
                        else
                            local v81 = v_u_10:GetAttribute("IsSpectating") == true
                            local v82 = v_u_10.Character ~= nil
                            v79 = v82 or v81
                        end
                    end
                    if v_u_27 and v79 then
                        if not v_u_28 then
                            v_u_28 = true
                            v_u_69()
                            return
                        end
                    elseif v_u_28 then
                        v_u_28 = false
                        v_u_25 = v_u_25 + 1
                        if v_u_26 then
                            v_u_26()
                            v_u_26 = nil
                        end
                    end
                end)
                v_u_9.OnCaseSceneStateChanged:Connect(function()
                    v_u_27 = v_u_6.GetState() == "Buy Period"
                    local v83
                    if v_u_9.IsInspectActive() or v_u_9.IsCaseSceneActive() then
                        v83 = false
                    else
                        local v84 = v_u_9.GetMenuFrame()
                        if v84 and v84.Visible then
                            v83 = false
                        else
                            local v85 = v_u_10:GetAttribute("IsSpectating") == true
                            local v86 = v_u_10.Character ~= nil
                            v83 = v86 or v85
                        end
                    end
                    if v_u_27 and v83 then
                        if not v_u_28 then
                            v_u_28 = true
                            v_u_69()
                            return
                        end
                    elseif v_u_28 then
                        v_u_28 = false
                        v_u_25 = v_u_25 + 1
                        if v_u_26 then
                            v_u_26()
                            v_u_26 = nil
                        end
                    end
                end)
                v_u_10.CharacterAdded:Connect(function()
                    v_u_27 = v_u_6.GetState() == "Buy Period"
                    local v87
                    if v_u_9.IsInspectActive() or v_u_9.IsCaseSceneActive() then
                        v87 = false
                    else
                        local v88 = v_u_9.GetMenuFrame()
                        if v88 and v88.Visible then
                            v87 = false
                        else
                            local v89 = v_u_10:GetAttribute("IsSpectating") == true
                            local v90 = v_u_10.Character ~= nil
                            v87 = v90 or v89
                        end
                    end
                    if v_u_27 and v87 then
                        if not v_u_28 then
                            v_u_28 = true
                            v_u_69()
                            return
                        end
                    elseif v_u_28 then
                        v_u_28 = false
                        v_u_25 = v_u_25 + 1
                        if v_u_26 then
                            v_u_26()
                            v_u_26 = nil
                        end
                    end
                end)
                v_u_10.CharacterRemoving:Connect(function()
                    v_u_27 = v_u_6.GetState() == "Buy Period"
                    local v91
                    if v_u_9.IsInspectActive() or v_u_9.IsCaseSceneActive() then
                        v91 = false
                    else
                        local v92 = v_u_9.GetMenuFrame()
                        if v92 and v92.Visible then
                            v91 = false
                        else
                            local v93 = v_u_10:GetAttribute("IsSpectating") == true
                            local v94 = v_u_10.Character ~= nil
                            v91 = v94 or v93
                        end
                    end
                    if v_u_27 and v91 then
                        if not v_u_28 then
                            v_u_28 = true
                            v_u_69()
                            return
                        end
                    elseif v_u_28 then
                        v_u_28 = false
                        v_u_25 = v_u_25 + 1
                        if v_u_26 then
                            v_u_26()
                            v_u_26 = nil
                        end
                    end
                end)
                v_u_8.observeAttribute(v_u_10, "IsSpectating", function()
                    v_u_27 = v_u_6.GetState() == "Buy Period"
                    local v95
                    if v_u_9.IsInspectActive() or v_u_9.IsCaseSceneActive() then
                        v95 = false
                    else
                        local v96 = v_u_9.GetMenuFrame()
                        if v96 and v96.Visible then
                            v95 = false
                        else
                            local v97 = v_u_10:GetAttribute("IsSpectating") == true
                            local v98 = v_u_10.Character ~= nil
                            v95 = v98 or v97
                        end
                    end
                    if v_u_27 and v95 then
                        if not v_u_28 then
                            v_u_28 = true
                            v_u_69()
                        end
                    elseif v_u_28 then
                        v_u_28 = false
                        v_u_25 = v_u_25 + 1
                        if v_u_26 then
                            v_u_26()
                            v_u_26 = nil
                        end
                    end
                    return function() end
                end)
                local v99
                if v_u_6.GetState() == "Buy Period" then
                    v_u_27 = true
                    v99 = v_u_27
                else
                    v_u_27 = false
                    v99 = v_u_27
                end
                local v100
                if v_u_9.IsInspectActive() or v_u_9.IsCaseSceneActive() then
                    v100 = false
                else
                    local v101 = v_u_9.GetMenuFrame()
                    if v101 and v101.Visible then
                        v100 = false
                    else
                        local v102 = v_u_10:GetAttribute("IsSpectating") == true
                        local v103 = v_u_10.Character ~= nil
                        v100 = v103 or v102
                    end
                end
                if v99 and v100 then
                    if not v_u_28 then
                        v_u_28 = true
                        v_u_69()
                    end
                elseif v_u_28 then
                    v_u_28 = false
                    v_u_25 = v_u_25 + 1
                    if v_u_26 then
                        v_u_26()
                        v_u_26 = nil
                    end
                end
            else
                warn("[WarmupEffectsController] Missing Assets.Warmup.ViewmodelHighlight (Highlight)")
            end
        else
            warn("[WarmupEffectsController] Missing Assets.Warmup.ColorCorrection (ColorCorrectionEffect)")
            return
        end
    else
        warn("[WarmupEffectsController] Missing ReplicatedStorage.Assets.Warmup")
        return
    end
end
return v12