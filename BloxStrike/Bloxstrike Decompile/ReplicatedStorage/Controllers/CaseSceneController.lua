local v_u_1 = {}
local v_u_2 = game:GetService("ContextActionService")
local v_u_3 = game:GetService("ReplicatedStorage")
local v_u_4 = game:GetService("UserInputService")
local v_u_5 = game:GetService("TweenService")
local v_u_6 = game:GetService("Lighting")
local v_u_7 = game:GetService("RunService")
local v_u_8 = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("MainGui")
require(script:WaitForChild("Types"))
local v_u_9 = require(script:WaitForChild("SceneRegistry"))
local v10 = require(v_u_3.Shared.Janitor)
local v_u_11 = require(v_u_3.Controllers.MenuSceneController)
local v_u_12 = require(v_u_3.Controllers.CameraController)
local v_u_13 = require(v_u_3.Database.Security.Router)
local v_u_14 = require(v_u_3.Interface.MenuState)
local v_u_15 = require(v_u_3.Database.Custom.Constants)
local v_u_16 = workspace.CurrentCamera
local v_u_17 = false
local v_u_18 = nil
local v_u_19 = nil
local v_u_20 = nil
local v_u_21 = nil
local v_u_22 = v10.new()
local v_u_23 = false
local v_u_24 = nil
local v_u_25 = {}
local v_u_26 = false
local v_u_27 = nil
local v_u_28 = nil
local v_u_29 = 0
local v_u_30 = nil
local v_u_31 = {}
local v_u_32 = nil
local v_u_33 = nil
local function v_u_34(...) end
local v_u_35 = false
local v_u_36 = nil
local v_u_37 = nil
local v_u_38 = nil
local v_u_39 = 0
local v_u_40 = 1
local v_u_41 = 0
local v_u_42 = nil
local v_u_43 = false
local v_u_44 = false
local function v_u_50()
    v_u_14.EnterCaseScene()
    local v45 = v_u_14.GetMenuFrame()
    if v45 then
        v_u_17 = v_u_11.IsActive()
        if v_u_17 then
            v_u_11.HideMenuScene(true, true)
            v_u_11.SetMusicVolumeMultiplier(0.5, 0.5)
        end
        v_u_14.SetBlurEnabled(false)
        v45.BackgroundTransparency = 1
        local v46 = v45:FindFirstChild("Pattern")
        if v46 then
            v46.Visible = false
        end
        local v47 = v45:FindFirstChild("Top")
        if v47 then
            v47.Visible = false
        end
        local v48 = v45:FindFirstChild("Store")
        if v48 then
            v48.Visible = true
        end
        for _, v49 in v45:GetChildren() do
            if v49:IsA("Frame") and (v49.Name ~= "Top" and (v49.Name ~= "Store" and v49.Name ~= "OpenCase")) then
                v49.Visible = false
            end
        end
    end
end
local function v_u_54(p51)
    for _, v52 in p51:GetDescendants() do
        if v52:IsA("BasePart") then
            if v52.Transparency < 1 then
                v52:SetAttribute("_CaseScenePrevTransparency", v52.Transparency)
                v52.Transparency = 1
            end
        elseif v52:IsA("SurfaceGui") and v52.Enabled then
            v52:SetAttribute("_CaseScenePrevSurfaceGuiEnabled", true)
            v52.Enabled = false
        end
    end
    local v53 = v_u_25
    table.insert(v53, p51)
end
local function v_u_57()
    v_u_25 = {}
    local v55 = v_u_20 and v_u_20.AssetFolder or nil
    for _, v56 in v_u_16:GetChildren() do
        if v56:IsA("Model") and v56.Name ~= v55 then
            v_u_54(v56)
        end
    end
end
local function v_u_61()
    for _, v58 in v_u_25 do
        if v58 and v58.Parent then
            for _, v59 in v58:GetDescendants() do
                if v59:IsA("BasePart") then
                    local v60 = v59:GetAttribute("_CaseScenePrevTransparency")
                    if v60 ~= nil then
                        v59.Transparency = v60
                        v59:SetAttribute("_CaseScenePrevTransparency", nil)
                    end
                elseif v59:IsA("SurfaceGui") and v59:GetAttribute("_CaseScenePrevSurfaceGuiEnabled") ~= nil then
                    v59.Enabled = true
                    v59:SetAttribute("_CaseScenePrevSurfaceGuiEnabled", nil)
                end
            end
        end
    end
    v_u_25 = {}
end
local function v_u_71()
    local v62 = v_u_14.GetMenuFrame()
    if v62 and v62.Visible then
        local v63 = v_u_14.GetScreenBeforeCaseScene()
        local v64 = v_u_17
        v_u_17 = false
        v_u_14.ExitCaseScene()
        if v64 then
            v_u_11.ShowMenuScene()
            v_u_11.SetMusicVolumeMultiplier(1, 0.5)
        else
            v_u_11.ApplyMapLighting()
        end
        local v65 = v62:FindFirstChild("Top")
        if v65 then
            v65.Visible = true
        end
        if v63 then
            local v66 = v62:FindFirstChild(v63)
            if v66 then
                v66.Visible = true
                local v67
                if v63 == "Dashboard" then
                    v67 = false
                else
                    v67 = v63 ~= "Play"
                end
                v_u_14.SetBlurEnabled(v67)
                v62.BackgroundTransparency = v67 and 0.15 or 1
                local v68 = v62:FindFirstChild("Pattern")
                if v68 then
                    v68.Visible = not v67
                    return
                end
            end
        else
            local v69 = v62:FindFirstChild("Dashboard")
            if v69 then
                v69.Visible = true
            end
            v_u_14.SetBlurEnabled(false)
            v62.BackgroundTransparency = 1
            local v70 = v62:FindFirstChild("Pattern")
            if v70 then
                v70.Visible = true
            end
        end
    else
        v_u_17 = false
        v_u_14.ExitCaseScene()
        v_u_11.ApplyMapLighting()
    end
end
local function v_u_79(p72, p73)
    local v74 = p72:FindFirstChild("CaseMod")
    if v74 and v74:GetAttribute("IsDynamicModel") then
        v74:Destroy()
    end
    local v75 = v_u_3.Assets:FindFirstChild("CaseModels")
    if v75 then
        local v76 = v75:FindFirstChild(p73)
        if v76 then
            local v77 = v76:Clone()
            v77.Name = "CaseMod"
            v77:SetAttribute("IsDynamicModel", true)
            local v78 = p72:FindFirstChild("CasePivot")
            if v78 then
                v77:PivotTo(v78.CFrame)
                v77.Parent = p72
                return v77
            else
                warn("[CaseSceneController]: CasePivot not found in CaseScene")
                v77.Parent = p72
                return v77
            end
        else
            warn("[CaseSceneController]: Case model not found for case: " .. p73)
            return nil
        end
    else
        warn("[CaseSceneController]: CaseModels folder not found in ReplicatedStorage.Assets")
        return nil
    end
end
local function v_u_85(p80, p81)
    local v82
    if p81.InteractionType == "Drag" then
        v82 = p80:FindFirstChild("Pack")
    else
        v82 = p80:FindFirstChild("CaseMod")
    end
    if not v82 then
        return nil
    end
    local v83 = v82:FindFirstChildOfClass("AnimationController")
    if not v83 then
        return nil
    end
    local v84 = v83:FindFirstChildOfClass("Animator")
    if not v84 then
        v84 = Instance.new("Animator")
        v84.Parent = v83
    end
    return v84
end
local function v_u_95(p86, p87, p88)
    local v89
    if p87.InteractionType == "Click" and p88 then
        local v90 = p88:FindFirstChildOfClass("AnimationController")
        v89 = not v90 or v90:FindFirstChildOfClass("Animator")
        if not v89 then
            v89 = Instance.new("Animator")
            v89.Parent = v90
        end
    else
        v89 = nil
    end
    local v91 = v89 or v_u_85(p86, p87)
    if v91 then
        v_u_32 = v91
        for v92, v93 in p87.Animations do
            if v93 then
                local v94 = Instance.new("Animation")
                v94.AnimationId = v93
                v_u_31[v92] = v91:LoadAnimation(v94)
                v94:Destroy()
            end
        end
    else
        warn("[CaseSceneController]: No animator found for scene")
    end
end
local function v_u_99(p96, p97)
    if p96 then
        for _, v98 in p96:GetDescendants() do
            if v98:IsA("Beam") or v98:IsA("ParticleEmitter") then
                v98.Enabled = p97
            end
        end
    end
end
local function v_u_101()
    local v100 = v_u_18
    if v100 then
        v100 = v_u_18:FindFirstChild("CaseMod")
    end
    if v100 then
        v_u_99(v100:FindFirstChild("IdleEffect"), true)
        v_u_99(v100:FindFirstChild("OpeningEffect"), false)
        v_u_99(v100:FindFirstChild("EffectsPart"), true)
    end
end
local function v_u_103()
    local v102 = v_u_18
    if v102 then
        v102 = v_u_18:FindFirstChild("CaseMod")
    end
    if v102 then
        v_u_99(v102:FindFirstChild("IdleEffect"), false)
        v_u_99(v102:FindFirstChild("OpeningEffect"), false)
        v_u_99(v102:FindFirstChild("EffectsPart"), false)
    end
end
local function v_u_108(p104, p105)
    for v106, v_u_107 in p105 do
        v_u_22:Add((p104:GetMarkerReachedSignal(v106):Connect(function()
            v_u_13.broadcastRouter("RunStoreSound", v_u_107)
        end)))
    end
end
local function v_u_115()
    if v_u_31.CaseFall and v_u_31.CloseIdle then
        v_u_101()
        local v109 = v_u_31.CaseFall
        local v110 = v_u_20 and v_u_20.AnimationKeyframeSounds
        if v110 then
            v110 = v_u_20.AnimationKeyframeSounds.CaseFall
        end
        if v110 then
            v_u_108(v109, v110)
        else
            local v_u_111 = v_u_20 and (v_u_20.Sounds and v_u_20.Sounds.Drop) or "Case Fall"
            v_u_22:Add((v109:GetMarkerReachedSignal("Dropped"):Connect(function()
                v_u_13.broadcastRouter("RunStoreSound", v_u_111)
            end)))
        end
        v_u_22:Add((v109:GetMarkerReachedSignal(v110 and v110.Drop and "Drop" or "Dropped"):Connect(function()
            local v112 = v_u_18 and v_u_18:FindFirstChild("DropParticle")
            if v112 then
                for _, v113 in v112:GetChildren() do
                    if v113:IsA("ParticleEmitter") then
                        local v114 = v113:GetAttribute("EmitCount")
                        if typeof(v114) == "number" and v114 > 0 then
                            v113:Emit(v114)
                        end
                    end
                end
            end
        end)))
        v109:Play()
        v_u_31.CloseIdle.Looped = true
        v_u_31.CloseIdle:Play()
    end
end
local function v_u_120()
    if v_u_31.CaseOpening then
        if v_u_31.CloseIdle then
            v_u_31.CloseIdle:Stop()
        end
        local v116 = v_u_31.CaseOpening
        local v117 = v_u_20 and v_u_20.AnimationKeyframeSounds
        if v117 then
            v117 = v_u_20.AnimationKeyframeSounds.CaseOpening
        end
        if v117 then
            v_u_108(v116, v117)
        else
            local v118 = v_u_20 and (v_u_20.Sounds and v_u_20.Sounds.Opening) or "Case Opening"
            v_u_13.broadcastRouter("RunStoreSound", v118)
        end
        local v119 = v_u_18
        if v119 then
            v119 = v_u_18:FindFirstChild("CaseMod")
        end
        if v119 then
            v_u_99(v119:FindFirstChild("OpeningEffect"), true)
            v_u_99(v119:FindFirstChild("IdleEffect"), false)
        end
        v116:Play()
        if v_u_31.OpenIdle then
            v_u_31.OpenIdle.Looped = true
            v_u_31.OpenIdle:Play()
        end
    end
end
local function v_u_122()
    for _, v121 in v_u_31 do
        if v121.IsPlaying then
            v121:Stop()
        end
    end
    if v_u_33 then
        v_u_33:Stop()
        v_u_33:Destroy()
        v_u_33 = nil
    end
end
local function v_u_130()
    v_u_34("finishCharmOpeningAndStartRoll called")
    if v_u_33 then
        v_u_33:Stop()
    end
    v_u_38 = nil
    if v_u_42 then
        v_u_42.Enabled = false
    end
    local v123 = v_u_8:FindFirstChild("CameraPerspective")
    if v123 then
        v123.Interactable = true
    end
    local v_u_124 = v_u_31.PackOpening
    v_u_34("  packOpeningTrack:", v_u_124 and "exists" or "nil")
    v_u_34("  CharmDragCallback:", v_u_36 and "exists" or "nil")
    if v_u_124 then
        local v125 = not (v_u_20 and (v_u_20.Sounds and v_u_20.Sounds.DragLoop)) and "Charm Drag Loop" or v_u_20.Sounds.DragLoop
        v_u_13.broadcastRouter("RunStoreSound", v125)
        if not v_u_124.IsPlaying then
            v_u_124:Play()
        end
        v_u_124:AdjustSpeed(1)
        v_u_124.Looped = false
        local v126 = v_u_124.Length - v_u_124.TimePosition - 0.1
        local v127 = math.max(0, v126)
        task.delay(v127, function()
            if v_u_124.IsPlaying then
                v_u_124:AdjustSpeed(0)
                v_u_124.TimePosition = v_u_124.Length * 0.99
                if v_u_36 then
                    local v128 = v_u_36
                    v_u_36 = nil
                    v128()
                end
            end
        end)
    else
        v_u_34("  No packOpeningTrack, calling callback directly")
        if v_u_36 then
            local v129 = v_u_36
            v_u_36 = nil
            v_u_34("  Calling CharmDragCallback")
            v129()
        end
    end
end
local function v_u_139(p131, p132)
    local v133 = v_u_31.PackOpening
    if v133 then
        local v134 = math.clamp(p131, 0, 1)
        local v135
        if v_u_41 > 0 then
            v135 = v_u_41
        else
            v135 = v133.Length
        end
        local v136 = v135 * v134
        if not v133.IsPlaying then
            v133:Play()
            v133:AdjustSpeed(0)
        end
        v133.TimePosition = v136
        if v134 >= 1 then
            v_u_35 = false
            v_u_130()
        end
        if v_u_33 and p132 then
            local v137 = not v_u_38 and 0 or (p132 - v_u_38).Magnitude
            v_u_38 = p132
            if v137 > 0.001 then
                v_u_39 = tick()
                if not v_u_33.IsPlaying then
                    v_u_33:Play()
                end
                local v138 = v137 * 20
                v_u_33.PlaybackSpeed = math.clamp(v138, 0, 0.7) + 0.8
            end
        end
    end
end
local function v_u_170(p140)
    if v_u_18 then
        local v_u_141 = v_u_18:FindFirstChild("Pack")
        if v_u_141 then
            local v_u_142 = v_u_141:FindFirstChild("Drag")
            if v_u_142 then
                local v_u_143 = v_u_142:FindFirstChildOfClass("DragDetector")
                if v_u_143 then
                    v_u_2:UnbindAction("Fire")
                    v_u_2:UnbindAction("Secondary Fire")
                    v_u_43 = true
                    v_u_36 = p140
                    v_u_35 = false
                    v_u_37 = v_u_142.Position
                    v_u_40 = v_u_143.MaxDragTranslation.Magnitude
                    if v_u_40 <= 0 then
                        v_u_40 = 1
                    end
                    local v_u_144 = v_u_31.PackOpening
                    if v_u_144 then
                        local v_u_145 = not (v_u_20 and (v_u_20.DragSettings and v_u_20.DragSettings.EndKeyframe)) and "DragEndPoint" or v_u_20.DragSettings.EndKeyframe
                        local v146, v147 = pcall(function()
                            return v_u_144:GetTimeOfKeyframe(v_u_145)
                        end)
                        if v146 and v147 then
                            v_u_41 = v147
                        else
                            v_u_41 = v_u_144.Length
                            warn("[CaseSceneController]: " .. v_u_145 .. " keyframe not found, using full animation length")
                        end
                    end
                    v_u_143.Enabled = true
                    local v148 = v_u_8:FindFirstChild("CameraPerspective")
                    if v148 then
                        v148.Interactable = false
                    end
                    local v149 = v_u_142:FindFirstChildOfClass("SurfaceGui")
                    if v149 then
                        v149.Enabled = true
                        v_u_42 = v149
                        local v150 = v149:FindFirstChildOfClass("Frame")
                        local v_u_151 = v150 and v150:FindFirstChildOfClass("ImageLabel")
                        if v_u_151 then
                            v_u_22:Add(v150.MouseEnter:Connect(function()
                                v_u_44 = true
                                v_u_151.ImageTransparency = 1
                            end), "Disconnect", "CharmImageHoverEnter")
                            v_u_22:Add(v150.MouseLeave:Connect(function()
                                v_u_44 = false
                                v_u_151.ImageTransparency = 0
                            end), "Disconnect", "CharmImageHoverLeave")
                            local v_u_152 = 0
                            v_u_22:Add(v_u_7.RenderStepped:Connect(function(p153)
                                if not v_u_44 then
                                    v_u_152 = v_u_152 + p153 * 2
                                    local v154 = v_u_152
                                    v_u_151.ImageTransparency = (math.sin(v154) + 1) / 2 * 0.2
                                end
                            end), "Disconnect", "CharmImageBreathing")
                        end
                    end
                    v_u_22:Add(v_u_143.DragStart:Connect(function()
                        v_u_35 = true
                        v_u_38 = v_u_142.Position
                        v_u_39 = tick()
                        if not v_u_33 then
                            local v155 = not (v_u_20 and (v_u_20.Sounds and v_u_20.Sounds.DragStart)) and "Charm Drag Start" or v_u_20.Sounds.DragStart
                            local v156 = require(v_u_3.Database.Audio.Store)[v155]
                            if v156 and (v156.Identifiers and v156.Identifiers[1]) then
                                local v157 = Instance.new("Sound")
                                v157.Name = "DragProgress"
                                v157.SoundId = "rbxassetid://" .. v156.Identifiers[1]
                                v157.Volume = v156.Properties.Volume or 1
                                v157.Looped = true
                                v157.PlaybackSpeed = 0.8
                                v157.Parent = v_u_141
                                v_u_33 = v157
                                v_u_22:Add(v157, "Destroy")
                            end
                        end
                    end), "Disconnect", "CharmDragStart")
                    v_u_22:Add(v_u_7.Heartbeat:Connect(function()
                        if v_u_35 and (v_u_33 and (v_u_33.IsPlaying and tick() - v_u_39 > 0.05)) then
                            v_u_33:Stop()
                        end
                    end), "Disconnect", "CharmDragSoundCheck")
                    v_u_22:Add(v_u_143.DragContinue:Connect(function()
                        if v_u_35 and v_u_37 then
                            local v158 = (v_u_142.Position - v_u_37).Magnitude / v_u_40
                            local v159 = math.clamp(v158, 0, 1)
                            if (not (v_u_20 and (v_u_20.DragSettings and v_u_20.DragSettings.Threshold)) and 0.5 or v_u_20.DragSettings.Threshold) <= v159 then
                                v_u_35 = false
                                v_u_143.Enabled = false
                                if v_u_37 then
                                    v_u_142.Position = v_u_37
                                end
                                v_u_130()
                            else
                                v_u_139(v159, v_u_142.Position)
                            end
                        else
                            return
                        end
                    end), "Disconnect", "CharmDragContinue")
                    v_u_22:Add(v_u_143.DragEnd:Connect(function()
                        if v_u_35 and v_u_37 then
                            v_u_35 = false
                            if v_u_33 then
                                v_u_33:Stop()
                            end
                            local v160 = (v_u_142.Position - v_u_37).Magnitude / v_u_40
                            local v161 = math.clamp(v160, 0, 1)
                            v_u_142.Position = v_u_37
                            local v162
                            if v_u_20 and (v_u_20.DragSettings and v_u_20.DragSettings.Threshold) then
                                local v163 = v_u_20.DragSettings.Threshold
                                v162 = math.max(v163, 0.8)
                            else
                                v162 = 0.8
                            end
                            if v162 <= v161 then
                                v_u_143.Enabled = false
                                v_u_130()
                            else
                                local v164 = v_u_31.PackOpening
                                if v164 then
                                    v164.TimePosition = 0
                                end
                                v_u_38 = nil
                            end
                        else
                            return
                        end
                    end), "Disconnect", "CharmDragEnd")
                    v_u_22:Add(v_u_4.InputBegan:Connect(function(p165, p166)
                        if v_u_23 and v_u_24 == "Unboxing" then
                            local v167 = p165.UserInputType == Enum.UserInputType.Gamepad1
                            local v168 = p165.UserInputType == Enum.UserInputType.Keyboard
                            if not (v168 and p166) then
                                if v167 then
                                    v167 = p165.KeyCode == Enum.KeyCode.ButtonX and true or p165.KeyCode == Enum.KeyCode.ButtonA
                                end
                                if v168 then
                                    v168 = p165.KeyCode == Enum.KeyCode.Return and true or p165.KeyCode == Enum.KeyCode.Space
                                end
                                if v167 or v168 then
                                    v_u_143.Enabled = false
                                    if v_u_35 then
                                        v_u_35 = false
                                        if v_u_37 then
                                            v_u_142.Position = v_u_37
                                        end
                                    end
                                    if v_u_33 then
                                        v_u_33:Stop()
                                    end
                                    local v169 = not (v_u_20 and (v_u_20.Sounds and v_u_20.Sounds.DragStart)) and "Charm Drag Start" or v_u_20.Sounds.DragStart
                                    v_u_13.broadcastRouter("RunStoreSound", v169)
                                    v_u_130()
                                end
                            end
                        else
                            return
                        end
                    end), "Disconnect", "CharmControllerSkip")
                else
                    warn("[CaseSceneController]: DragDetector not found on Drag part")
                end
            else
                warn("[CaseSceneController]: Drag part not found in Pack")
                return
            end
        else
            warn("[CaseSceneController]: Pack not found in CharmScene")
            return
        end
    else
        return
    end
end
function v_u_1.ShowCaseScene(p171, p172)
    v_u_34("ShowCaseScene called")
    v_u_34("  caseType:", p171 or "nil")
    v_u_34("  caseName:", p172 or "nil")
    v_u_34("  IsCaseSceneActive:", v_u_23)
    if v_u_23 then
        v_u_34("  BLOCKED: Scene already active")
        return
    else
        local v173 = v_u_9.GetSceneForCaseType(p171 or "Case")
        v_u_34("  sceneName:", v173)
        local v_u_174 = v_u_9.GetConfig(v173)
        if v_u_174 then
            v_u_34("  config.AssetFolder:", v_u_174.AssetFolder)
            v_u_34("  config.InteractionType:", v_u_174.InteractionType)
            v_u_19 = v173
            v_u_20 = v_u_174
            v_u_21 = p172
            local v175 = workspace:FindFirstChild(v_u_174.AssetFolder)
            if v175 then
                v_u_18 = v175
                local v176 = v_u_174.InteractionType == "Drag" and v175:FindFirstChild("Pack")
                if v176 then
                    local v177 = v176:FindFirstChild("Drag")
                    local v178 = v177 and v177:FindFirstChildOfClass("SurfaceGui")
                    if v178 then
                        v178.Enabled = false
                    end
                end
                v_u_24 = "Inspecting"
                local v179
                if v_u_18 then
                    local v180 = v_u_18:FindFirstChild("Camera")
                    if v180 then
                        v179 = v180:FindFirstChild("Inspecting")
                    else
                        v179 = nil
                    end
                else
                    v179 = nil
                end
                if v179 then
                    v_u_16.CameraType = Enum.CameraType.Scriptable
                    v_u_16.CFrame = v179.CFrame
                    v_u_16.Focus = v179.CFrame
                    v_u_50()
                    if not v_u_17 then
                        v_u_11.ApplyMenuSceneLighting()
                    end
                    local v181 = v175:FindFirstChild("CaseFog", true)
                    if v181 and v181:IsA("Atmosphere") then
                        for _, v182 in v_u_6:GetChildren() do
                            if v182:IsA("Atmosphere") then
                                v182:Destroy()
                            end
                        end
                        v181:Clone().Parent = v_u_6
                    end
                    v_u_57()
                    v_u_22:Add(v_u_16.ChildAdded:Connect(function(p183)
                        if p183:IsA("Model") and p183.Name ~= v_u_174.AssetFolder then
                            v_u_54(p183)
                        end
                    end), "Disconnect", "ViewmodelListener")
                    local v184
                    if p172 and v_u_174.InteractionType == "Click" then
                        v184 = v_u_79(v175, p172)
                    else
                        v184 = nil
                    end
                    v_u_95(v175, v_u_174, v184)
                    if v_u_174.InteractionType == "Click" then
                        v_u_115()
                    end
                    v_u_12.setFOVLock("CaseScene", true, 50)
                    v_u_12.setForceLockOverride("CaseScene", true)
                    v_u_7:BindToRenderStep("CaseSceneCameraUpdate", Enum.RenderPriority.Camera.Value + 10, function()
                        if v_u_18 then
                            v_u_16.CameraType = Enum.CameraType.Scriptable
                            if v_u_26 and (v_u_27 and v_u_28) then
                                local v185 = (tick() - v_u_29) / 0.8
                                local v186 = math.min(v185, 1)
                                v_u_16.CFrame = v_u_27:Lerp(v_u_28, (v_u_5:GetValue(v186, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)))
                                v_u_16.Focus = v_u_16.CFrame
                                if v186 >= 1 then
                                    v_u_26 = false
                                    v_u_16.CFrame = v_u_28
                                    if v_u_30 then
                                        local v187 = v_u_30
                                        v_u_30 = nil
                                        v187()
                                    end
                                    v_u_27 = nil
                                    v_u_28 = nil
                                    return
                                end
                            else
                                local v188 = v_u_24
                                local v189
                                if v_u_18 then
                                    local v190 = v_u_18:FindFirstChild("Camera")
                                    if v190 then
                                        if v188 == "Inspecting" then
                                            v189 = v190:FindFirstChild("Inspecting")
                                        elseif v188 == "Unboxing" then
                                            v189 = v190:FindFirstChild("Unboxing")
                                        else
                                            v189 = nil
                                        end
                                    else
                                        v189 = nil
                                    end
                                else
                                    v189 = nil
                                end
                                if v189 then
                                    v_u_16.CFrame = v189.CFrame
                                    v_u_16.Focus = v189.CFrame
                                end
                            end
                        end
                    end)
                    v_u_22:Add(function()
                        v_u_7:UnbindFromRenderStep("CaseSceneCameraUpdate")
                    end, true, "CameraUpdate")
                    v_u_22:Add(function()
                        v_u_34("CaseSceneCleanup running")
                        v_u_24 = nil
                        v_u_26 = false
                        v_u_27 = nil
                        v_u_28 = nil
                        v_u_30 = nil
                        v_u_103()
                        if v_u_43 then
                            v_u_13.broadcastRouter("RebindKeybinds")
                            v_u_43 = false
                        end
                        v_u_35 = false
                        v_u_36 = nil
                        v_u_37 = nil
                        v_u_38 = nil
                        v_u_39 = 0
                        v_u_40 = 1
                        v_u_41 = 0
                        v_u_42 = nil
                        v_u_44 = false
                        if v_u_18 then
                            local v191 = v_u_18:FindFirstChild("CaseMod")
                            if v191 and v191:GetAttribute("IsDynamicModel") then
                                v191:Destroy()
                            end
                        end
                        v_u_122()
                        v_u_31 = {}
                        v_u_32 = nil
                        v_u_34("CaseSceneCleanup complete")
                    end, true, "CaseSceneCleanup")
                    v_u_23 = true
                    v_u_34("ShowCaseScene complete, IsCaseSceneActive = true")
                else
                    warn("[CaseSceneController]: Scene missing Camera.Inspecting")
                    v_u_18 = nil
                    v_u_19 = nil
                    v_u_20 = nil
                    v_u_24 = nil
                end
            else
                warn("[CaseSceneController]: Scene not found in workspace: " .. v_u_174.AssetFolder)
                v_u_19 = nil
                v_u_20 = nil
                v_u_21 = nil
                return
            end
        else
            warn("[CaseSceneController]: No config found for scene: " .. v173)
            v_u_34("  BLOCKED: No config found")
            return
        end
    end
end
function v_u_1.TransitionToUnboxing(p_u_192)
    v_u_34("TransitionToUnboxing called")
    v_u_34("  IsCaseSceneActive:", v_u_23)
    v_u_34("  CurrentScene:", v_u_18 and "exists" or "nil")
    v_u_34("  CurrentSceneConfig:", v_u_20 and "exists" or "nil")
    v_u_34("  CurrentCaseSceneState:", v_u_24 or "nil")
    v_u_34("  callback:", p_u_192 and "provided" or "nil")
    if v_u_23 and (v_u_18 and v_u_20) then
        if v_u_24 == "Unboxing" then
            v_u_34("  BLOCKED: Already in Unboxing state")
            return
        else
            local v193
            if v_u_18 then
                local v194 = v_u_18:FindFirstChild("Camera")
                if v194 then
                    v193 = v194:FindFirstChild("Unboxing")
                else
                    v193 = nil
                end
            else
                v193 = nil
            end
            if v193 then
                v_u_34("  InteractionType:", v_u_20.InteractionType)
                if v_u_20.InteractionType == "Click" then
                    v_u_34("  Playing opening animations and starting camera lerp")
                    v_u_120()
                    local v195 = v_u_24
                    local v196
                    if v_u_18 then
                        local v197 = v_u_18:FindFirstChild("Camera")
                        if v197 then
                            if v195 == "Inspecting" then
                                v196 = v197:FindFirstChild("Inspecting")
                            elseif v195 == "Unboxing" then
                                v196 = v197:FindFirstChild("Unboxing")
                            else
                                v196 = nil
                            end
                        else
                            v196 = nil
                        end
                    else
                        v196 = nil
                    end
                    local v198
                    if v196 then
                        v198 = v196.CFrame
                    else
                        v198 = v_u_16.CFrame
                    end
                    v_u_26 = true
                    v_u_27 = v198
                    v_u_28 = v193.CFrame
                    v_u_29 = tick()
                    v_u_30 = p_u_192
                else
                    v_u_34("  Starting camera lerp, will setup drag detector after")
                    local function v199()
                        v_u_34("  Camera lerp complete, setting up drag detector")
                        v_u_170(p_u_192)
                    end
                    local v200 = v_u_24
                    local v201
                    if v_u_18 then
                        local v202 = v_u_18:FindFirstChild("Camera")
                        if v202 then
                            if v200 == "Inspecting" then
                                v201 = v202:FindFirstChild("Inspecting")
                            elseif v200 == "Unboxing" then
                                v201 = v202:FindFirstChild("Unboxing")
                            else
                                v201 = nil
                            end
                        else
                            v201 = nil
                        end
                    else
                        v201 = nil
                    end
                    local v203
                    if v201 then
                        v203 = v201.CFrame
                    else
                        v203 = v_u_16.CFrame
                    end
                    v_u_26 = true
                    v_u_27 = v203
                    v_u_28 = v193.CFrame
                    v_u_29 = tick()
                    v_u_30 = v199
                end
                v_u_24 = "Unboxing"
                v_u_34("  TransitionToUnboxing complete, CurrentCaseSceneState = Unboxing")
            else
                warn("[CaseSceneController]: Scene missing Camera.Unboxing")
                v_u_34("  BLOCKED: Missing Camera.Unboxing")
            end
        end
    else
        v_u_34("  BLOCKED: Scene not active or missing config")
        return
    end
end
function v_u_1.TransitionToInspecting(p204)
    if v_u_23 and v_u_18 then
        if v_u_24 == "Inspecting" then
            return
        else
            local v205
            if v_u_18 then
                local v206 = v_u_18:FindFirstChild("Camera")
                if v206 then
                    v205 = v206:FindFirstChild("Inspecting")
                else
                    v205 = nil
                end
            else
                v205 = nil
            end
            if v205 then
                local v207 = v_u_24
                local v208
                if v_u_18 then
                    local v209 = v_u_18:FindFirstChild("Camera")
                    if v209 then
                        if v207 == "Inspecting" then
                            v208 = v209:FindFirstChild("Inspecting")
                        elseif v207 == "Unboxing" then
                            v208 = v209:FindFirstChild("Unboxing")
                        else
                            v208 = nil
                        end
                    else
                        v208 = nil
                    end
                else
                    v208 = nil
                end
                local v210
                if v208 then
                    v210 = v208.CFrame
                else
                    v210 = v_u_16.CFrame
                end
                v_u_26 = true
                v_u_27 = v210
                v_u_28 = v205.CFrame
                v_u_29 = tick()
                v_u_30 = p204
                v_u_24 = "Inspecting"
            else
                warn("[CaseSceneController]: Scene missing Camera.Inspecting")
            end
        end
    else
        return
    end
end
function v_u_1.HideCaseScene(p211)
    v_u_34("HideCaseScene called")
    v_u_34("  IsCaseSceneActive:", v_u_23)
    v_u_34("  skipFrameRestore:", p211 or false)
    if v_u_23 then
        v_u_34("  Running CaseSceneJanitor:Cleanup()")
        v_u_22:Cleanup()
        v_u_16.CameraType = Enum.CameraType.Custom
        v_u_12.setFOVLock("CaseScene", false)
        v_u_12.updateCameraFOV(v_u_15.DEFAULT_CAMERA_FOV)
        local v212 = require(v_u_3.Controllers.SpectateController).GetCurrentSpectateInstance()
        if v212 then
            v212:UpdateScopeState()
        end
        v_u_12.setForceLockOverride("CaseScene", false)
        if p211 then
            v_u_14.ExitCaseScene()
            v_u_17 = false
        else
            v_u_71()
        end
        v_u_61()
        v_u_18 = nil
        v_u_19 = nil
        v_u_20 = nil
        v_u_21 = nil
        v_u_23 = false
        v_u_24 = nil
        v_u_34("HideCaseScene complete, IsCaseSceneActive = false")
    else
        v_u_34("  BLOCKED: Scene not active")
    end
end
function v_u_1.IsActive()
    return v_u_23
end
function v_u_1.GetCurrentState()
    return v_u_24
end
function v_u_1.GetSceneName()
    return v_u_19
end
function v_u_1.GetSceneConfig()
    return v_u_20
end
function v_u_1.ApplyCaseSceneLighting()
    if v_u_23 and v_u_18 then
        v_u_11.ApplyMenuSceneLighting()
        local v213 = v_u_18:FindFirstChild("CaseFog", true)
        if v213 and v213:IsA("Atmosphere") then
            for _, v214 in v_u_6:GetChildren() do
                if v214:IsA("Atmosphere") then
                    v214:Destroy()
                end
            end
            v213:Clone().Parent = v_u_6
        end
    else
        return
    end
end
function v_u_1.WaitForOpeningAnimation()
    local v215 = v_u_31.CaseOpening
    if v215 then
        if v215.IsPlaying then
            v215.Stopped:Wait()
        end
    end
end
function v_u_1.Initialize()
    local v_u_216 = v_u_3:FindFirstChild("Assets")
    if v_u_216 then
        local function v222(p217)
            local v218 = v_u_216:FindFirstChild(p217)
            if not v218 then
                return
            end
            local v219 = nil
            for _, v220 in v218:GetChildren() do
                if v220:IsA("Model") then
                    v219 = v220
                    break
                end
            end
            if v219 then
                local v221 = v219:Clone()
                v221.Name = p217
                v221.Parent = workspace
            else
                warn("[CaseSceneController]: No model found in Assets." .. p217)
            end
        end
        for _, v223 in v_u_9.GetAllSceneNames() do
            local v224 = v_u_9.GetConfig(v223)
            if v224 then
                v222(v224.AssetFolder)
            end
        end
        v_u_4.InputBegan:Connect(function(p225, p226)
            if not p226 then
                if p225.KeyCode == Enum.KeyCode.Escape and v_u_23 then
                    v_u_1.HideCaseScene()
                end
            end
        end)
        v_u_13.observerRouter("CaseSceneShow", function(p227, p228)
            v_u_1.ShowCaseScene(p227, p228)
        end)
        v_u_13.observerRouter("CaseSceneUnboxing", function(p229)
            v_u_1.TransitionToUnboxing(p229)
        end)
        v_u_13.observerRouter("CaseSceneClose", function()
            v_u_1.HideCaseScene()
        end)
        v_u_13.observerRouter("CaseSceneCloseForGameEnd", function()
            v_u_1.HideCaseScene(true)
        end)
    else
        warn("[CaseSceneController]: Assets folder not found in ReplicatedStorage")
    end
end
function v_u_1.Start() end
v_u_13.observerRouter("IsCaseSceneRolling", function()
    local v230 = v_u_1.IsActive()
    if v230 then
        v230 = v_u_1.GetCurrentState() == "Unboxing"
    end
    return v230
end)
return v_u_1