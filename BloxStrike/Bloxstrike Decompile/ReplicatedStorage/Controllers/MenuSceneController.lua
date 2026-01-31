local v_u_1 = {}
local v_u_2 = game:GetService("ReplicatedStorage")
local v_u_3 = game:GetService("RunService")
local v_u_4 = game:GetService("TweenService")
local v_u_5 = game:GetService("Lighting")
local v6 = game:GetService("Players")
require(script:WaitForChild("Types"))
local v_u_7 = require(v_u_2.Packages.Observers)
local v8 = require(v_u_2.Shared.Janitor)
local v_u_9 = require(v_u_2.Controllers.DataController)
local v_u_10 = require(v_u_2.Controllers.CameraController)
local v_u_11 = nil
local v_u_12 = require(v_u_2.Classes.Sound)
local v_u_13 = require(v_u_2.Database.Custom.Constants)
local v_u_14 = v6.LocalPlayer
local v_u_15 = v_u_14:WaitForChild("PlayerGui")
local v_u_16 = workspace.CurrentCamera
local v_u_17 = nil
local v_u_18 = v_u_2.Assets.Lighting
local v_u_19 = v_u_2.Database.Custom.GameStats.Maps
local v_u_20 = v_u_2.Assets.Characters
local v_u_21 = {
    ["CT"] = {
        ["Entrance"] = "rbxassetid://140448509508633",
        ["Idle"] = "rbxassetid://137360078752983"
    },
    ["T"] = {
        ["Entrance"] = "rbxassetid://100747011940776",
        ["Idle"] = "rbxassetid://99540873384647"
    }
}
local v_u_22 = {
    ["CT"] = {
        ["Character"] = "IDF",
        ["Weapon"] = "M4A1-S",
        ["Glove"] = "CT Glove"
    },
    ["T"] = {
        ["Character"] = "Anarchist",
        ["Weapon"] = "AK-47",
        ["Glove"] = "T Glove"
    }
}
local v_u_23 = {
    ["Right Arm"] = "RightGlove",
    ["Left Arm"] = "LeftGlove"
}
local v_u_24 = {
    ["Right Arm"] = "RightHand",
    ["Left Arm"] = "LeftHand"
}
local v_u_25 = nil
local v_u_26 = nil
local v_u_27 = nil
local v_u_28 = v8.new()
local v_u_29 = false
local v_u_30 = nil
local v_u_31 = nil
local v_u_32 = 1
local v_u_33 = nil
local function v_u_37()
    if v_u_31 and v_u_31.Parent then
        local v34 = (v_u_9.Get(v_u_14, "Settings.Audio.Audio.Main Menu Ambience Volume") or 100) / 100
        local v35 = (v_u_9.Get(v_u_14, "Settings.Audio.Audio.Master Volume") or 100) / 100
        local v36 = v_u_32
        v_u_31.Volume = (v_u_31:GetAttribute("BaseVolume") or v_u_31.Volume) * v34 * v35 * v36
    end
end
local v_u_38 = nil
local function v_u_47()
    local v39 = workspace:FindFirstChild("Map")
    if v39 then
        local v40 = v39:GetAttribute("MapName")
        if v40 and typeof(v40) == "string" then
            local v41 = v_u_19:FindFirstChild(v40)
            if v41 and v41:IsA("ModuleScript") then
                local v42 = require(v41)
                if v42.Lighting then
                    local v43 = v42.Lighting.Properties
                    if v43 then
                        v_u_38 = v43.GlobalShadows
                        v_u_5.Ambient = v43.Ambient
                        v_u_5.Brightness = v43.Brightness
                        v_u_5.ColorShift_Bottom = v43.ColorShift_Bottom
                        v_u_5.ColorShift_Top = v43.ColorShift_Top
                        v_u_5.EnvironmentDiffuseScale = v43.EnvironmentDiffuseScale
                        v_u_5.EnvironmentSpecularScale = v43.EnvironmentSpecularScale
                        v_u_5.GlobalShadows = v43.GlobalShadows
                        v_u_5.OutdoorAmbient = v43.OutdoorAmbient
                        v_u_5.ShadowSoftness = v43.ShadowSoftness
                        v_u_5.ClockTime = v43.ClockTime
                        v_u_5.GeographicLatitude = v43.GeographicLatitude
                        v_u_5.ExposureCompensation = v43.ExposureCompensation
                    end
                    for _, v44 in ipairs(v_u_5:GetChildren()) do
                        if v44.Name ~= "Menu" then
                            v44:Destroy()
                        end
                    end
                    local v45 = v42.Lighting.Assets
                    if v45 then
                        for _, v46 in ipairs(v45:GetChildren()) do
                            v46:Clone().Parent = v_u_5
                        end
                    end
                    if v_u_9.Get(v_u_14, "Settings.Video.Presets.Global Shadows") ~= false then
                        if v_u_38 ~= nil then
                            v_u_5.GlobalShadows = v_u_38
                        end
                    else
                        v_u_5.GlobalShadows = false
                    end
                else
                    return
                end
            else
                return
            end
        else
            return
        end
    else
        return
    end
end
local function v_u_55(p48)
    local v49 = v_u_18:FindFirstChild(p48)
    if v49 then
        local v50 = v_u_19:FindFirstChild(p48)
        if v50 and v50:IsA("ModuleScript") then
            local v51 = require(v50)
            if v51.Lighting and v51.Lighting.Properties then
                local v52 = v51.Lighting.Properties
                v_u_38 = v52.GlobalShadows
                v_u_5.Ambient = v52.Ambient
                v_u_5.Brightness = v52.Brightness
                v_u_5.ColorShift_Bottom = v52.ColorShift_Bottom
                v_u_5.ColorShift_Top = v52.ColorShift_Top
                v_u_5.EnvironmentDiffuseScale = v52.EnvironmentDiffuseScale
                v_u_5.EnvironmentSpecularScale = v52.EnvironmentSpecularScale
                v_u_5.GlobalShadows = v52.GlobalShadows
                v_u_5.OutdoorAmbient = v52.OutdoorAmbient
                v_u_5.ShadowSoftness = v52.ShadowSoftness
                v_u_5.ClockTime = v52.ClockTime
                v_u_5.GeographicLatitude = v52.GeographicLatitude
                v_u_5.ExposureCompensation = v52.ExposureCompensation
            end
        end
        for _, v53 in ipairs(v_u_5:GetChildren()) do
            if v53.Name ~= "Menu" then
                v53:Destroy()
            end
        end
        for _, v54 in ipairs(v49:GetChildren()) do
            v54:Clone().Parent = v_u_5
        end
        if v_u_9.Get(v_u_14, "Settings.Video.Presets.Global Shadows") ~= false then
            if v_u_38 ~= nil then
                v_u_5.GlobalShadows = v_u_38
            end
        else
            v_u_5.GlobalShadows = false
        end
    else
        warn((("[MenuSceneController]: No lighting found for scene \"%*\""):format(p48)))
        return
    end
end
local function v_u_69()
    local v56 = require(v_u_2.Interface.MenuState)
    if v_u_11 and v_u_11.IsActive() then
        return false
    end
    if v56.IsInspectActive() then
        return false
    end
    if workspace:FindFirstChild("InspectScene") then
        return false
    end
    local v57 = v_u_15:FindFirstChild("MainGui")
    if v57 then
        local v58 = v57:FindFirstChild("Gameplay")
        if v58 then
            v58 = v58:FindFirstChild("Middle")
        end
        if v58 then
            v58 = v58:FindFirstChild("TeamSelection")
        end
        if v58 and v58.Visible then
            return false
        end
    end
    local v59 = v_u_14:GetAttribute("IsSpectating")
    local v60 = v_u_14:GetAttribute("Team")
    local v61 = require(v_u_2.Database.Components.GameState).GetState()
    if v61 == "Game Ending" or v61 == "Map Voting" then
        if v60 == "Counter-Terrorists" or v60 == "Terrorists" then
            return false
        end
        local v62 = v_u_14.Character
        local v63
        if v62 and v62:IsDescendantOf(workspace) then
            local v64 = v62:FindFirstChild("Humanoid")
            v63 = v64 and v64.Health > 0 and true or false
        else
            v63 = false
        end
        return not v63
    end
    if v60 == "Counter-Terrorists" or v60 == "Terrorists" then
        return false
    end
    local v65 = v_u_14.Character
    local v66
    if v65 and v65:IsDescendantOf(workspace) then
        local v67 = v65:FindFirstChild("Humanoid")
        v66 = v67 and v67.Health > 0 and true or false
    else
        v66 = false
    end
    local v68 = not v66
    if v68 then
        v68 = not v59
    end
    return v68
end
local function v_u_96(p70, p71, p72)
    local v73 = require(v_u_2.Database.Components.Libraries.Skins)
    local v74 = nil
    local v75 = nil
    local v76 = nil
    if p72 then
        local v77 = p71 == "CT" and "Counter-Terrorists" or "Terrorists"
        v_u_9.WaitForDataLoaded(v_u_14)
        local v78 = v_u_9.Get(v_u_14, "Loadout")
        if v78 and (type(v78) == "table" and v78[v77]) then
            local v79 = v78[v77]
            if v79 and (type(v79) == "table" and v79.Equipped) then
                local v80 = v79.Equipped["Equipped Gloves"]
                if v80 and (v80 ~= "" and type(v80) == "string") then
                    local v81 = v_u_9.Get(v_u_14, "Inventory")
                    if v81 and type(v81) == "table" then
                        for _, v82 in ipairs(v81) do
                            if v82 and v82._id == v80 then
                                v74 = v82.Name
                                v75 = v82.Skin
                                v76 = v82.Float
                                p70:SetAttribute("EquippedGloves", game:GetService("HttpService"):JSONEncode({
                                    ["SkinIdentifier"] = v80
                                }))
                                break
                            end
                        end
                    end
                end
            end
        end
    end
    local v83 = v74 or v_u_22[p71].Glove
    local v84
    if v75 and (v76 and v83) then
        v84 = v73.GetGloves(v83, v75, v76)
    else
        v84 = nil
    end
    local v85 = v84 or v_u_2:WaitForChild("Assets"):WaitForChild("Weapons"):FindFirstChild(v83)
    if v85 then
        local v86 = p70:FindFirstChild("CharacterArmor")
        if not v86 then
            v86 = Instance.new("Folder")
            v86.Name = "CharacterArmor"
            v86.Parent = p70
        end
        local v87
        if v84 then
            v87 = v84:GetChildren()
        else
            if not v85 then
                warn((("[MenuSceneController]: No glove model or folder available for \"%*\""):format(v83)))
                return
            end
            v87 = v85:GetChildren()
        end
        for _, v88 in ipairs(v87) do
            if v88:IsA("BasePart") then
                local v89 = v_u_24[v88.Name]
                if v89 then
                    local v90 = p70:FindFirstChild(v89)
                    if v90 then
                        local v91 = v88:Clone()
                        v91.Name = v_u_23[v88.Name]
                        v91.CastShadow = false
                        v91.CanCollide = false
                        v91.CanTouch = false
                        v91.Anchored = false
                        v91.CanQuery = false
                        v91.CFrame = v90.CFrame * CFrame.Angles(-1.5707963267948966, 0, 0)
                        local v92 = v90.Size.X * 1.1
                        local v93 = v90.Size.Z
                        local v94 = v90.Size.Y
                        v91.Size = Vector3.new(v92, v93, v94) * 1.1
                        v91.Parent = v86
                        local v95 = Instance.new("Motor6D")
                        v95.Name = "GloveAttachment"
                        v95.Part0 = v90
                        v95.Part1 = v91
                        v95.C0 = CFrame.new(0, 0, -0.025)
                        v95.C1 = v91.PivotOffset * CFrame.Angles(1.5707963267948966, 0, 0)
                        v95.Parent = v91
                    end
                end
            end
        end
        if v84 and v84.Name == "" then
            v84:Destroy()
        end
    else
        warn((("[MenuSceneController]: Glove folder not found for \"%*\""):format(v83)))
    end
end
local function v_u_125(p97, p98, p99)
    local v100 = require(v_u_2.Database.Components.Libraries.Skins)
    local v101 = nil
    local v102 = nil
    local v103 = nil
    local v104 = nil
    local v105 = nil
    if p99 then
        local v106 = p98 == "CT" and "Counter-Terrorists" or "Terrorists"
        local v107 = p98 == "CT" and "M4A1-S" or "AK-47"
        v_u_9.WaitForDataLoaded(v_u_14)
        local v108 = v_u_9.Get(v_u_14, "Loadout")
        local v109 = v_u_9.Get(v_u_14, "Inventory")
        if v108 and (type(v108) == "table" and v108[v106]) then
            local v110 = v108[v106]
            if v110 and (type(v110) == "table" and v110.Loadout) then
                local v111 = v110.Loadout.Rifles
                if v111 and v111.Options then
                    local v112 = v111.Options
                    if type(v112) == "table" and (v109 and type(v109) == "table") then
                        for _, v113 in ipairs(v111.Options) do
                            if v113 and (v113 ~= "" and type(v113) == "string") then
                                for _, v114 in ipairs(v109) do
                                    if v114 and (v114._id == v113 and v114.Name == v107) then
                                        v101 = v114.Name
                                        v102 = v114.Skin
                                        v103 = v114.Float
                                        v104 = v114.StatTrack
                                        v105 = v114.NameTag
                                        break
                                    end
                                end
                                if v101 then
                                    break
                                end
                            end
                        end
                    end
                end
            end
        end
    end
    local v115 = v101 or v_u_22[p98].Weapon
    if v115 then
        local v116
        if v102 and (typeof(v102) == "string" and (v102 ~= "" and v115)) then
            v116 = v100.GetCharacterModel(v115, v102, v103, v104, v105)
        else
            v116 = nil
        end
        local v117 = v116 or v100.GetBaseWeaponModel(v115, "Character")
        if v117 then
            v117.Name = v115
            local v118 = p97:FindFirstChild("RightHand")
            if v118 then
                if not v117.PrimaryPart then
                    local v119 = v117:FindFirstChild("Weapon")
                    if v119 then
                        v119 = v119:FindFirstChild("Insert")
                    end
                    if not v119 then
                        warn("[MenuSceneController]: Weapon model has no PrimaryPart or Insert")
                        v117:Destroy()
                        return
                    end
                    v117.PrimaryPart = v119
                end
                for _, v120 in ipairs(v117:GetDescendants()) do
                    if v120:IsA("BasePart") then
                        v120.CanCollide = false
                        v120.CanQuery = false
                        v120.CanTouch = false
                        v120.Anchored = false
                        v120.Massless = true
                    end
                end
                v117.Parent = p97
                local v121 = Instance.new("Motor6D")
                v121.Name = "WeaponAttachment"
                v121.Part0 = v118
                v121.Part1 = v117.PrimaryPart
                v121.Parent = v118
                if v115 == "AK-47" then
                    v121.C0 = CFrame.new(-0.251, 0.806, -0.406) * CFrame.Angles(0, -1.5707963267948966, 1.5707963267948966)
                    return v117
                end
                local v122 = v117:FindFirstChild("Properties")
                if v122 then
                    local v123 = v122:FindFirstChild("C0")
                    if v123 then
                        v121.C0 = v123.Value
                    end
                    local v124 = v122:FindFirstChild("C1")
                    if v124 then
                        v121.C1 = v124.Value
                    end
                end
                return v117
            end
            warn("[MenuSceneController]: Character missing RightHand")
            v117:Destroy()
        else
            warn((("[MenuSceneController]: Failed to get weapon model for \"%*\""):format(v115)))
        end
    else
        warn("[MenuSceneController]: No weapon name available")
        return
    end
end
local function v_u_139(p126)
    local v127 = p126:FindFirstChild("PlayerPart")
    if v127 then
        local v128 = math.random(1, 2) == 1 and "CT" or "T"
        local v129 = v_u_22[v128]
        local v130 = v_u_21[v128]
        local v131 = v_u_20:FindFirstChild(v129.Character)
        if v131 then
            local v132 = v131:Clone()
            v132.Name = "MenuCharacter"
            v_u_26 = v132
            v_u_27 = v128
            if v132:FindFirstChild("HumanoidRootPart") then
                v132:PivotTo(v127.CFrame)
            end
            v132.Parent = p126
            v_u_125(v132, v128, true)
            v_u_96(v132, v128, true)
            local v133 = v132:FindFirstChild("Humanoid")
            if v133 then
                local v134 = v133:FindFirstChildOfClass("Animator")
                if not v134 then
                    v134 = Instance.new("Animator")
                    v134.Parent = v133
                end
                local v135 = Instance.new("Animation")
                v135.AnimationId = v130.Entrance
                local v136 = Instance.new("Animation")
                v136.AnimationId = v130.Idle
                local v137 = v134:LoadAnimation(v135)
                local v_u_138 = v134:LoadAnimation(v136)
                v_u_28:Add(v135, "Destroy", "EntranceAnimation")
                v_u_28:Add(v136, "Destroy", "IdleAnimation")
                v_u_28:Add(v137, "Stop", "EntranceTrack")
                v_u_28:Add(v_u_138, "Stop", "IdleTrack")
                v137.Priority = Enum.AnimationPriority.Action
                v137:Play()
                v137.Stopped:Once(function()
                    if v_u_29 and v_u_138 then
                        v_u_138.Looped = true
                        v_u_138.Priority = Enum.AnimationPriority.Idle
                        v_u_138:Play()
                    end
                end)
                v_u_28:Add(function()
                    if v_u_26 then
                        v_u_26:Destroy()
                        v_u_26 = nil
                        v_u_27 = nil
                    end
                end, true, "MenuCharacterCleanup")
            else
                warn("[MenuSceneController]: Character missing Humanoid")
            end
        else
            warn((("[MenuSceneController]: Character \"%*\" not found"):format(v129.Character)))
            return
        end
    else
        return
    end
end
function v_u_1.ShowMenuScene()
    if v_u_29 then
        v_u_10.updateCameraFOV(50)
        v_u_10.setMouseEnabled(true)
        return
    elseif workspace:FindFirstChild("InspectScene") then
        return
    else
        local v140 = require(v_u_2.Interface.MenuState)
        if v140.IsInspectActive() then
            return
        elseif v140.IsCaseSceneActive() then
            return
        else
            local v141
            if v_u_17 then
                v141 = v_u_17
            else
                local v142 = v_u_2:FindFirstChild("Assets")
                if v142 then
                    v_u_17 = v142:WaitForChild("MenuScenes", 10)
                end
                v141 = v_u_17
            end
            local v143
            if v141 then
                local v144 = v141:GetChildren()
                if #v144 > 0 then
                    v143 = v144[math.random(1, #v144)]
                else
                    v143 = nil
                end
            else
                v143 = nil
            end
            if v143 then
                local v145 = v143:Clone()
                v145.Parent = workspace
                v_u_25 = v145
                v_u_55(v143.Name)
                local v_u_146 = v145:FindFirstChild("CamPart")
                if v_u_146 then
                    v_u_16.CameraType = Enum.CameraType.Scriptable
                    v_u_16.CFrame = v_u_146.CFrame
                    v_u_16.Focus = v_u_146.CFrame
                    v_u_10.updateCameraFOV(50)
                    v_u_10.setMouseEnabled(true)
                    v_u_28:Add(v_u_3.RenderStepped:Connect(function()
                        if v_u_25 and v_u_146 then
                            v_u_16.CFrame = v_u_146.CFrame
                            v_u_16.Focus = v_u_146.CFrame
                        end
                    end), "Disconnect", "CameraUpdate")
                    v_u_28:Add(function()
                        if v_u_25 then
                            v_u_25:Destroy()
                            v_u_25 = nil
                        end
                    end, true, "MenuSceneCleanup")
                    v_u_29 = true
                    v_u_139(v145)
                    if not (v_u_31 and v_u_31.IsPlaying) then
                        local v147 = (v_u_9.Get(v_u_14, "Settings.Audio.Audio.Main Menu Ambience Volume") or 100) / 100
                        local v148 = v_u_12.new("Main Menu")
                        v_u_30 = v148
                        local v_u_149 = v148:play({
                            ["Name"] = "Main Menu Music",
                            ["Parent"] = v_u_15
                        }, v147)
                        v_u_31 = v_u_149
                        if v_u_149 then
                            local v150 = (v_u_9.Get(v_u_14, "Settings.Audio.Audio.Master Volume") or 100) / 100
                            local v151 = v_u_149.Volume
                            if v147 > 0 and v150 > 0 then
                                v151 = v151 / (v147 * v150) or v151
                            end
                            v_u_149:SetAttribute("BaseVolume", v151)
                            v_u_149:SetAttribute("AmbienceVolumeMultiplier", v147)
                            if v_u_32 ~= 1 then
                                v_u_149.Volume = v_u_149.Volume * v_u_32
                            end
                            v_u_149.Destroying:Once(function()
                                if v_u_31 == v_u_149 then
                                    v_u_31 = nil
                                end
                            end)
                        end
                    end
                else
                    warn("[MenuSceneController]: Menu scene missing CamPart")
                    v145:Destroy()
                    v_u_25 = nil
                    v_u_47()
                end
            else
                v_u_10.setMouseEnabled(true)
                return
            end
        end
    end
end
function v_u_1.HideMenuScene(p152, p153)
    if v_u_29 then
        if require(v_u_2.Interface.MenuState).IsInspectActive() or workspace:FindFirstChild("InspectScene") then
            p153 = true
            p152 = true
        end
        v_u_28:Cleanup()
        if not p153 then
            v_u_47()
        end
        if not p153 then
            v_u_16.CameraType = Enum.CameraType.Custom
            v_u_10.updateCameraFOV(v_u_13.DEFAULT_CAMERA_FOV)
        end
        v_u_29 = false
        if not p152 then
            if v_u_31 then
                v_u_31:Stop()
                v_u_31 = nil
            end
            if v_u_30 then
                v_u_30:destroy()
                v_u_30 = nil
            end
        end
    end
end
function v_u_1.IsActive()
    return v_u_29
end
function v_u_1.StopMenuMusic()
    if v_u_31 then
        v_u_31:Stop()
        v_u_31 = nil
    end
    if v_u_30 then
        v_u_30:destroy()
        v_u_30 = nil
    end
end
function v_u_1.IsMusicPlaying()
    local v154
    if v_u_31 == nil then
        v154 = false
    else
        v154 = v_u_31.IsPlaying
    end
    return v154
end
function v_u_1.SetMusicVolumeMultiplier(p155, p156)
    v_u_32 = p155
    if v_u_31 then
        if v_u_33 then
            v_u_33:Cancel()
            v_u_33 = nil
        end
        local v157 = v_u_31:GetAttribute("BaseVolume") or 0.1
        local v158 = (v_u_9.Get(v_u_14, "Settings.Audio.Audio.Main Menu Ambience Volume") or 100) / 100
        local v159 = (v_u_9.Get(v_u_14, "Settings.Audio.Audio.Master Volume") or 100) / 100
        local v160 = v157 * v158 * v159 * v_u_32
        if p156 and p156 > 0 then
            local v161 = v_u_4:Create(v_u_31, TweenInfo.new(p156, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                ["Volume"] = v160
            })
            v_u_33 = v161
            v161:Play()
        else
            v_u_31.Volume = v160
        end
    else
        return
    end
end
function v_u_1.ApplyMapLighting()
    v_u_47()
end
function v_u_1.ApplyMenuSceneLighting()
    local v162
    if v_u_17 then
        v162 = v_u_17
    else
        local v163 = v_u_2:FindFirstChild("Assets")
        if v163 then
            v_u_17 = v163:WaitForChild("MenuScenes", 10)
        end
        v162 = v_u_17
    end
    local v164
    if v162 then
        local v165 = v162:GetChildren()
        if #v165 > 0 then
            v164 = v165[math.random(1, #v165)]
        else
            v164 = nil
        end
    else
        v164 = nil
    end
    if v164 then
        v_u_55(v164.Name)
        v_u_5.GlobalShadows = true
    end
end
function v_u_1.GetMenuCharacter()
    return v_u_26
end
function v_u_1.CreateStandaloneCharacter(p166)
    local v167 = p166 or (math.random(1, 2) == 1 and "CT" or "T")
    local v168 = v_u_22[v167]
    local v169 = v_u_20:FindFirstChild(v168.Character)
    if not v169 then
        warn((("[MenuSceneController]: Character \"%*\" not found"):format(v168.Character)))
        return nil
    end
    local v170 = v169:Clone()
    v170.Name = "StandaloneCharacter"
    v170.Parent = v_u_2
    v_u_96(v170, v167, true)
    return v170
end
function v_u_1.Initialize()
    v_u_9.CreateListener(v_u_14, "Settings.Video.Presets.Global Shadows", function()
        if v_u_9.Get(v_u_14, "Settings.Video.Presets.Global Shadows") ~= false then
            if v_u_38 ~= nil then
                v_u_5.GlobalShadows = v_u_38
            end
        else
            v_u_5.GlobalShadows = false
        end
    end)
    v_u_9.CreateListener(v_u_14, "Settings.Audio.Audio.Main Menu Ambience Volume", v_u_37)
    v_u_9.CreateListener(v_u_14, "Settings.Audio.Audio.Master Volume", v_u_37)
    if v_u_69() then
        v_u_1.ShowMenuScene()
    end
    task.defer(function()
        if not v_u_11 then
            v_u_11 = require(v_u_2.Controllers.EndScreenController)
        end
    end)
    v_u_14.CharacterAdded:Connect(function(p171)
        v_u_1.StopMenuMusic()
        v_u_1.HideMenuScene()
        local v172 = p171:FindFirstChildOfClass("Humanoid")
        if not v172 then
            local v173 = tick()
            repeat
                task.wait(0.1)
                v172 = p171:FindFirstChildOfClass("Humanoid")
            until v172 or tick() - v173 > 5
        end
        if v172 then
            v172.Died:Connect(function()
                task.delay(0.1, function()
                    if v_u_69() then
                        v_u_1.ShowMenuScene()
                    end
                end)
            end)
        end
    end)
    v_u_14.CharacterRemoving:Connect(function()
        task.delay(0.1, function()
            if v_u_69() then
                v_u_1.ShowMenuScene()
            end
        end)
    end)
    v_u_7.observeAttribute(v_u_14, "IsSpectating", function(p174)
        if p174 then
            v_u_1.HideMenuScene()
        elseif v_u_69() then
            v_u_1.ShowMenuScene()
        end
        return function()
            if v_u_69() then
                v_u_1.ShowMenuScene()
            end
        end
    end)
    v_u_7.observeAttribute(v_u_14, "Team", function(p175)
        if p175 == "Counter-Terrorists" or p175 == "Terrorists" then
            v_u_1.HideMenuScene()
        elseif v_u_69() then
            v_u_1.ShowMenuScene()
        end
        return function()
            task.delay(0.1, function()
                if v_u_69() then
                    v_u_1.ShowMenuScene()
                end
            end)
        end
    end)
    local function v_u_181()
        if v_u_26 and v_u_27 then
            local v176 = v_u_26:FindFirstChild("RightHand")
            local v177 = v176 and v176:FindFirstChild("WeaponAttachment")
            if v177 then
                local v178 = v177.Part1
                if v178 and v178.Parent then
                    v178:Destroy()
                end
                v177:Destroy()
            end
            local v179 = v_u_26:FindFirstChild("CharacterArmor")
            if v179 then
                for _, v180 in ipairs(v179:GetChildren()) do
                    if v180:IsA("BasePart") and v180:FindFirstChild("GloveAttachment") then
                        v180:Destroy()
                    end
                end
            end
            v_u_125(v_u_26, v_u_27, true)
            v_u_96(v_u_26, v_u_27, true)
        end
    end
    local v_u_182 = v_u_9.CreateListener(v_u_14, "Loadout", function()
        v_u_181()
    end)
    v_u_28:Add(function()
        v_u_9.RemoveListener(v_u_14, "Loadout", v_u_182)
    end, true, "LoadoutListener")
    local v183 = require(v_u_2.Database.Components.GameState)
    local v_u_184 = require(v_u_2.Controllers.SpectateController)
    v183.ListenToState(function(_, p185)
        if p185 == "Game Ending" or p185 == "Map Voting" then
            if v_u_14:GetAttribute("IsSpectating") then
                v_u_184.Stop(false, true)
            end
            if v_u_69() then
                v_u_1.ShowMenuScene()
            end
        end
    end)
end
function v_u_1.Start() end
return v_u_1