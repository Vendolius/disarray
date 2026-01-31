local v_u_1 = {}
local v_u_2 = game:GetService("ReplicatedStorage")
local v_u_3 = game:GetService("UserInputService")
local v_u_4 = game:GetService("RunService")
local v_u_5 = game:GetService("TweenService")
local v_u_6 = game:GetService("TextService")
local v_u_7 = game:GetService("Lighting")
local v8 = game:GetService("Players")
require(v_u_2.Database.Custom.Types)
require(script:WaitForChild("Types"))
local v9 = require(v_u_2.Shared.Janitor)
local v_u_10 = require(v_u_2.Controllers.MenuSceneController)
local v_u_11 = require(v_u_2.Controllers.CaseSceneController)
local v_u_12 = require(v_u_2.Controllers.CameraController)
local v_u_13 = require(v_u_2.Controllers.InputController)
local v_u_14 = require(v_u_2.Controllers.DataController)
local v_u_15 = require(v_u_2.Classes.WeaponComponent.Classes.Viewmodel)
local v_u_16 = require(v_u_2.Components.Common.InterfaceAnimations.ActivateButton)
local v_u_17 = require(v_u_2.Database.Components.Libraries.Collections)
local v_u_18 = require(v_u_2.Database.Components.Libraries.Skins)
local v_u_19 = require(v_u_2.Database.Custom.GameStats.Rarities)
local v_u_20 = require(v_u_2.Components.Common.GetWeaponProperties)
local v_u_21 = require(v_u_2.Database.Security.Router)
local v_u_22 = require(v_u_2.Interface.MenuState)
local v_u_23 = require(v_u_2.Database.Custom.Constants)
local v_u_24 = v8.LocalPlayer
local v_u_25 = nil
local v_u_26 = v_u_24:WaitForChild("PlayerGui")
local v_u_27 = workspace.CurrentCamera
local v_u_28 = nil
local v_u_29 = v_u_2.Assets.Lighting
local v_u_30 = v_u_2.Database.Custom.GameStats.Maps
local v_u_31 = nil
local v_u_32 = nil
local v_u_33 = false
local v_u_34 = v_u_23.DEFAULT_CAMERA_FOV
local v_u_35 = nil
local v_u_36 = nil
local v_u_37 = nil
local v_u_38 = nil
local v_u_39 = nil
local v_u_40 = v9.new()
local v_u_41 = false
local v_u_42 = "Weapon"
local v_u_43 = {}
local v_u_44 = false
local v_u_45 = Vector2.zero
local v_u_46 = 0
local v_u_47 = 0
local v_u_48 = 0
local v_u_49 = 0
local v_u_50 = 40
local v_u_51 = 40
local v_u_52 = nil
local v_u_53 = {}
local v_u_54 = nil
local v_u_55 = 1
local v_u_56 = nil
local function v_u_65()
    local v57 = workspace:FindFirstChild("Map")
    if v57 then
        local v58 = v57:GetAttribute("MapName")
        if v58 and typeof(v58) == "string" then
            local v59 = v_u_30:FindFirstChild(v58)
            if v59 and v59:IsA("ModuleScript") then
                local v60 = require(v59)
                if v60.Lighting then
                    local v61 = v60.Lighting.Properties
                    if v61 then
                        v_u_25 = v61.GlobalShadows
                        v_u_7.Ambient = v61.Ambient
                        v_u_7.Brightness = v61.Brightness
                        v_u_7.ColorShift_Bottom = v61.ColorShift_Bottom
                        v_u_7.ColorShift_Top = v61.ColorShift_Top
                        v_u_7.EnvironmentDiffuseScale = v61.EnvironmentDiffuseScale
                        v_u_7.EnvironmentSpecularScale = v61.EnvironmentSpecularScale
                        v_u_7.GlobalShadows = v61.GlobalShadows
                        v_u_7.OutdoorAmbient = v61.OutdoorAmbient
                        v_u_7.ShadowSoftness = v61.ShadowSoftness
                        v_u_7.ClockTime = v61.ClockTime
                        v_u_7.GeographicLatitude = v61.GeographicLatitude
                        v_u_7.ExposureCompensation = v61.ExposureCompensation
                    end
                    for _, v62 in ipairs(v_u_7:GetChildren()) do
                        if v62.Name ~= "Menu" then
                            v62:Destroy()
                        end
                    end
                    local v63 = v60.Lighting.Assets
                    if v63 then
                        for _, v64 in ipairs(v63:GetChildren()) do
                            v64:Clone().Parent = v_u_7
                        end
                    end
                    if v_u_14.Get(v_u_24, "Settings.Video.Presets.Global Shadows") ~= false then
                        if v_u_25 ~= nil then
                            v_u_7.GlobalShadows = v_u_25
                        end
                    else
                        v_u_7.GlobalShadows = false
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
local function v_u_73(p66)
    local v67 = v_u_29:FindFirstChild(p66) or v_u_29:FindFirstChild("Menu")
    if v67 then
        local v68 = v_u_30:FindFirstChild(p66)
        if v68 and v68:IsA("ModuleScript") then
            local v69 = require(v68)
            if v69.Lighting and v69.Lighting.Properties then
                local v70 = v69.Lighting.Properties
                v_u_25 = v70.GlobalShadows
                v_u_7.Ambient = v70.Ambient
                v_u_7.Brightness = v70.Brightness
                v_u_7.ColorShift_Bottom = v70.ColorShift_Bottom
                v_u_7.ColorShift_Top = v70.ColorShift_Top
                v_u_7.EnvironmentDiffuseScale = v70.EnvironmentDiffuseScale
                v_u_7.EnvironmentSpecularScale = v70.EnvironmentSpecularScale
                v_u_7.GlobalShadows = v70.GlobalShadows
                v_u_7.OutdoorAmbient = v70.OutdoorAmbient
                v_u_7.ShadowSoftness = v70.ShadowSoftness
                v_u_7.ClockTime = v70.ClockTime
                v_u_7.GeographicLatitude = v70.GeographicLatitude
                v_u_7.ExposureCompensation = v70.ExposureCompensation
            end
        end
        for _, v71 in ipairs(v_u_7:GetChildren()) do
            if v71.Name ~= "Menu" then
                v71:Destroy()
            end
        end
        for _, v72 in ipairs(v67:GetChildren()) do
            v72:Clone().Parent = v_u_7
        end
        if v_u_14.Get(v_u_24, "Settings.Video.Presets.Global Shadows") ~= false then
            if v_u_25 ~= nil then
                v_u_7.GlobalShadows = v_u_25
            end
        else
            v_u_7.GlobalShadows = false
        end
    else
        return
    end
end
local function v_u_78()
    local v74
    if v_u_28 then
        v74 = v_u_28
    else
        local v75 = v_u_2:FindFirstChild("Assets")
        if v75 then
            v_u_28 = v75:WaitForChild("InspectScenes", 10)
        end
        v74 = v_u_28
    end
    if v74 then
        local v76 = {}
        for _, v77 in ipairs(v74:GetChildren()) do
            if v77:IsA("Model") then
                table.insert(v76, v77)
            end
        end
        if #v76 > 0 then
            return v76[math.random(1, #v76)]
        else
            return nil
        end
    else
        return nil
    end
end
local function v_u_85()
    if v_u_36 and v_u_35 then
        local v79 = v_u_35:FindFirstChild("WeaponPart")
        if v79 then
            local v80 = CFrame.Angles(0, -1.5707963267948966, 0)
            local v81 = v_u_47
            local v82 = v_u_46
            local v83 = CFrame.Angles(0, math.rad(v81), (math.rad(v82)))
            if v_u_52 then
                local v84 = v_u_36:GetPivot():ToObjectSpace(v_u_52.WorldCFrame)
                v_u_36:PivotTo(v79.CFrame * v83 * v80 * v84:Inverse())
            else
                v_u_36:PivotTo(v79.CFrame * v83 * v80)
            end
        else
            return
        end
    else
        return
    end
end
local function v_u_88()
    local v86 = {}
    for _, v87 in pairs(v_u_53) do
        table.insert(v86, v87)
    end
    if #v86 >= 2 then
        return (v86[1] - v86[2]).Magnitude
    else
        return nil
    end
end
local function v_u_93()
    v_u_22.EnterInspect()
    local v89 = v_u_22.GetMenuFrame()
    if v89 then
        v_u_33 = v_u_10.IsActive()
        if v_u_33 then
            v_u_10.HideMenuScene(true)
            v_u_10.SetMusicVolumeMultiplier(0.5, 0.5)
        end
        v_u_22.SetBlurEnabled(false)
        v89.BackgroundTransparency = 1
        local v90 = v89:FindFirstChild("Pattern")
        if v90 then
            v90.Visible = false
        end
        local v91 = v89:FindFirstChild("Top")
        if v91 then
            v91.Visible = false
        end
        for _, v92 in ipairs(v89:GetChildren()) do
            if v92:IsA("Frame") and v92.Name ~= "Top" then
                if v92.Name == "Inspect" or v92.Name == "InspectFrame" then
                    v92.Visible = true
                else
                    v92.Visible = false
                end
            end
        end
    end
end
local function v_u_101()
    local v94 = v_u_22.GetMenuFrame()
    if v94 then
        local v95 = v94:FindFirstChild("Inspect") or v94:FindFirstChild("InspectFrame")
        if v95 then
            local v96 = v95:FindFirstChild("Bottom")
            if v96 then
                local v97 = v96:FindFirstChild("Close")
                if v97 and v97:IsA("GuiButton") then
                    v_u_16(v97)
                    v97.MouseButton1Click:Connect(function()
                        v_u_1.HideInspect()
                    end)
                end
                local v98 = v96:FindFirstChild("Charm")
                if v98 then
                    local v99 = v98:FindFirstChild("Next")
                    if v99 and v99:IsA("GuiButton") then
                        v_u_16(v99)
                        v99.MouseButton1Click:Connect(function()
                            v_u_1.CycleCharmPosition()
                        end)
                    end
                    local v100 = v98:FindFirstChild("Confirm")
                    if v100 and v100:IsA("GuiButton") then
                        v_u_16(v100)
                        v100.MouseButton1Click:Connect(function()
                            v_u_21.broadcastRouter("ConfirmCharmAttachment")
                        end)
                    end
                end
            end
        else
            return
        end
    else
        return
    end
end
local function v_u_106()
    local v102 = v_u_22.GetMenuFrame()
    if v102 then
        local v103 = v102:FindFirstChild("Inspect") or v102:FindFirstChild("InspectFrame")
        if v103 then
            local v104 = v103:FindFirstChild("Bottom")
            if v104 then
                local v105 = v104:FindFirstChild("Charm")
                if v105 then
                    v105.Visible = v_u_21.broadcastRouter("HasPendingCharmAttachment") or false
                end
            end
        else
            return
        end
    else
        return
    end
end
local function v_u_122(p107)
    if v_u_35 then
        local v108 = v_u_35:FindFirstChild("WeaponPart")
        if v108 then
            local v109 = nil
            local v110 = p107.Type == "Glove"
            local v111 = p107.Type == "Charm"
            if v110 then
                local v112 = v_u_18.GetGloves(p107.Name, p107.Skin, p107.Float)
                if v112 then
                    if v112:IsA("BasePart") then
                        v109 = Instance.new("Model")
                        v109.Name = p107.Name
                        v112.Parent = v109
                        v109.PrimaryPart = v112
                    else
                        v109 = v112
                    end
                end
            elseif v111 then
                v109 = v_u_18.GetCharmModel(p107.Skin, p107.Pattern or 1) or v109
            else
                v109 = v_u_18.GetCharacterModel(p107.Name, p107.Skin, p107.Float, p107.StatTrack, p107.NameTag, p107.Charm, p107.Stickers)
            end
            if v109 then
                v109.Name = "InspectWeapon"
                v_u_36 = v109
                v_u_52 = v109:FindFirstChild("InspectPivot", true)
                if v_u_52 then
                    warn((("[InspectController]: Found InspectPivot at %*"):format((v_u_52:GetFullName()))))
                else
                    warn((("[InspectController]: No InspectPivot found for %*"):format(p107.Name)))
                end
                local v113 = v109:FindFirstChild("CharmBase", true)
                for _, v114 in ipairs(v109:GetDescendants()) do
                    if v114:IsA("BasePart") then
                        local v115
                        if v113 then
                            v115 = v114:IsDescendantOf(v113)
                        else
                            v115 = v113
                        end
                        if v111 then
                            if v109.PrimaryPart == v114 then
                                v114.CanCollide = false
                                v114.CanQuery = false
                                v114.CanTouch = false
                                v114.Anchored = true
                            else
                                v114.CanCollide = false
                                v114.CanQuery = false
                                v114.CanTouch = false
                                v114.Anchored = false
                            end
                        elseif v115 then
                            v114.Anchored = false
                        else
                            v114.CanCollide = v114:IsA("MeshPart") and true or false
                            v114.CanQuery = false
                            v114.CanTouch = false
                            v114.Anchored = true
                        end
                    end
                end
                if v110 and (p107.Name == "T Glove" or p107.Name == "CT Glove") then
                    local v116 = {}
                    for _, v117 in ipairs(v109:GetChildren()) do
                        if v117:IsA("BasePart") then
                            table.insert(v116, v117)
                        end
                    end
                    if #v116 >= 2 then
                        local v118 = v109:FindFirstChild("RightGlove") or v116[1]
                        for _, v119 in ipairs(v116) do
                            if v119 ~= v118 then
                                v119:Destroy()
                            end
                        end
                    end
                end
                v109.Parent = v_u_35
                local v120 = CFrame.Angles(0, -1.5707963267948966, 0)
                if v_u_52 then
                    local v121 = v109:GetPivot():ToObjectSpace(v_u_52.WorldCFrame)
                    v109:PivotTo(v108.CFrame * v120 * v121:Inverse())
                else
                    v109:PivotTo(v108.CFrame * v120)
                end
            else
                warn(("[InspectController]: Failed to get model for \"%*\""):format(p107.Name), p107)
                return
            end
        else
            warn("[InspectController]: Inspect scene missing WeaponPart")
            return
        end
    else
        return
    end
end
local function v_u_135(p_u_123)
    if v_u_37 then
        v_u_37:destroy()
        v_u_37 = nil
    end
    if v_u_38 then
        v_u_38:Destroy()
        v_u_38 = nil
    end
    v_u_13.enableGroup("Gameplay")
    local v124 = v_u_24:GetAttribute("Team") == "Counter-Terrorists" and "CT" or "T"
    local v125 = v_u_10.CreateStandaloneCharacter(v124)
    if v125 then
        v_u_38 = v125
        local v126 = p_u_123.Charm
        if v_u_21.broadcastRouter("HasPendingCharmAttachment") and type(v126) == "table" then
            v126 = {
                ["_id"] = v126._id
            }
            local v127 = v_u_55
            v126.Position = tostring(v127)
        end
        local v_u_128 = {
            ["Player"] = v_u_24,
            ["Character"] = v125,
            ["StatTrack"] = p_u_123.StatTrack,
            ["Stickers"] = p_u_123.Stickers,
            ["NameTag"] = p_u_123.NameTag,
            ["Float"] = p_u_123.Float,
            ["Charm"] = v126
        }
        local v129, v130 = pcall(function()
            return v_u_15.new(v_u_128, p_u_123.Name, p_u_123.Skin)
        end)
        if v129 and v130 then
            v_u_37 = v130
            if v_u_37 then
                v_u_37:equip(false)
                if v_u_37.Model then
                    if v_u_37.Model.Parent ~= v_u_27 then
                        v_u_37.Model.Parent = v_u_27
                    end
                    if v_u_37.Hidden then
                        v_u_37:unhide()
                    end
                    task.defer(function()
                        if v_u_37 and v_u_37.Model then
                            for _, v131 in ipairs(v_u_37.Model:GetDescendants()) do
                                if v131:IsA("BasePart") then
                                    if v131.Name ~= "HumanoidRootPart" and (v131.Name ~= "ViewmodelLight" and (v131.Name ~= "MuzzlePart" and v131.Name ~= "MuzzlePartL")) and v131.Name ~= "MuzzlePartR" then
                                        local v132 = v131:GetAttribute("HiddenTransparency")
                                        if v132 == nil then
                                            v132 = nil
                                        else
                                            v131:SetAttribute("HiddenTransparency", nil)
                                        end
                                        local v133
                                        if v132 == nil then
                                            v133 = v131:GetAttribute("_CaseScenePrevTransparency")
                                            if v133 == nil then
                                                v133 = v132
                                            else
                                                v131:SetAttribute("_CaseScenePrevTransparency", nil)
                                            end
                                        else
                                            v133 = v132
                                        end
                                        local v134
                                        if v133 == nil then
                                            v134 = v131:GetAttribute("_InspectPrevTransparency")
                                            if v134 == nil then
                                                v134 = v133
                                            else
                                                v131:SetAttribute("_InspectPrevTransparency", nil)
                                            end
                                        else
                                            v134 = v133
                                        end
                                        if v134 == nil then
                                            if v131.Transparency >= 1 and (v131.Name == "Right Arm" or v131.Name == "Left Arm") then
                                                v131.Transparency = 0
                                            end
                                        else
                                            v131.Transparency = v134
                                        end
                                    end
                                elseif v131:IsA("SurfaceGui") then
                                    if v131:GetAttribute("_InspectPrevSurfaceGuiEnabled") then
                                        v131.Enabled = true
                                        v131:SetAttribute("_InspectPrevSurfaceGuiEnabled", nil)
                                    end
                                    if v131:GetAttribute("_CaseScenePrevSurfaceGuiEnabled") then
                                        v131.Enabled = true
                                        v131:SetAttribute("_CaseScenePrevSurfaceGuiEnabled", nil)
                                    end
                                    if not v131.Enabled then
                                        v131.Enabled = true
                                    end
                                end
                            end
                        end
                    end)
                end
            end
        else
            warn("[InspectController]: Failed to create viewmodel")
            if v_u_37 then
                v_u_37:destroy()
                v_u_37 = nil
            end
            if v_u_38 then
                v_u_38:Destroy()
                v_u_38 = nil
            end
            v_u_13.enableGroup("Gameplay")
        end
    else
        warn("[InspectController]: Failed to create standalone character for viewmodel")
        return
    end
end
local function v_u_138(p136)
    if v_u_42 == p136 then
        return
    else
        local v137 = v_u_39
        if v137 then
            if v_u_42 == "Weapon" then
                if v_u_36 then
                    v_u_36:Destroy()
                    v_u_36 = nil
                end
                v_u_52 = nil
            elseif v_u_42 == "Viewmodel" then
                if v_u_37 then
                    v_u_37:destroy()
                    v_u_37 = nil
                end
                if v_u_38 then
                    v_u_38:Destroy()
                    v_u_38 = nil
                end
                v_u_13.enableGroup("Gameplay")
            end
            v_u_42 = p136
            if p136 == "Weapon" then
                v_u_122(v137)
                v_u_51 = 40
                v_u_13.enableGroup("Gameplay")
            elseif p136 == "Viewmodel" then
                v_u_13.disableGroup("Gameplay")
                v_u_135(v137)
                v_u_51 = v_u_34
            end
        else
            return
        end
    end
end
local function v_u_152(p139, p140, p141)
    local v142 = p140:FindFirstChild("HoverFrame")
    local v143 = p140:FindFirstChild("SelectFrame")
    local v144 = p140:FindFirstChild("ImageLabel")
    local v145
    if v_u_42 == p139 then
        v145 = p139 ~= "Info"
    else
        v145 = false
    end
    if v145 then
        local v146 = {
            ["BackgroundTransparency"] = 1
        }
        if v142 then
            v_u_5:Create(v142, TweenInfo.new(0.2), v146):Play()
        end
        local v147 = {
            ["BackgroundTransparency"] = 0
        }
        if v143 then
            v_u_5:Create(v143, TweenInfo.new(0.2), v147):Play()
        end
        if v144 then
            local v148 = {
                ["ImageColor3"] = Color3.fromRGB(0, 0, 0)
            }
            if v144 then
                v_u_5:Create(v144, TweenInfo.new(0.2), v148):Play()
                return
            end
        end
    else
        local v149 = {
            ["BackgroundTransparency"] = 1
        }
        if v143 then
            v_u_5:Create(v143, TweenInfo.new(0.2), v149):Play()
        end
        if v144 then
            local v150 = {
                ["ImageColor3"] = Color3.fromRGB(255, 255, 255)
            }
            if v144 then
                v_u_5:Create(v144, TweenInfo.new(0.2), v150):Play()
            end
        end
        local v151 = {
            ["BackgroundTransparency"] = p141 and 0 or 1
        }
        if v142 then
            v_u_5:Create(v142, TweenInfo.new(0.2), v151):Play()
        end
    end
end
local function v_u_157(p153, p154)
    for v155, v156 in pairs(p153) do
        if v156 and v156:IsA("GuiButton") then
            v_u_152(v155, v156, v155 == p154)
        end
    end
end
local function v_u_168(p158, p159)
    local v160 = v_u_27.ViewportSize.Y * 0.025
    local v161 = math.floor(v160)
    local v162 = math.min(v161, 32)
    local v163 = math.max(8, v162)
    local v164 = Enum.Font.Gotham
    local v165 = 0
    for _, v166 in ipairs(p159) do
        if v166 and (v166:IsA("TextLabel") and v166.Text ~= "") then
            v166.TextScaled = false
            local v167 = v_u_6:GetTextSize(v166.Text:gsub("<[^>]*>", ""), v163, v164, Vector2.new((1 / 0), (1 / 0)))
            if v165 < v167.X then
                v165 = v167.X
            end
            v166.TextSize = v163
            v166.TextWrapped = false
        end
    end
    if v165 > 0 then
        p158.Size = UDim2.new(0.05, v165, p158.Size.Y.Scale, p158.Size.Y.Offset)
    end
end
local function v_u_191(p169, p170, p171)
    local v_u_172 = p169:FindFirstChild("Information")
    if v_u_172 then
        if p171 then
            local v173 = v_u_172.Parent.AbsolutePosition.X
            local v174 = p171.AbsolutePosition.X + p171.AbsoluteSize.X / 2 - v173
            v_u_172.Position = UDim2.new(0, v174 + v_u_172.AbsoluteSize.X / 2, v_u_172.Position.Y.Scale, v_u_172.Position.Y.Offset)
        end
        v_u_172.Visible = true
        local v175 = v_u_18.GetSkinInformation(p170.Name, p170.Skin)
        local v176 = "Factory New"
        if v175 then
            v176 = v_u_18.GetWearNameForFloat(v175, p170.Float or 0) or v176
        end
        local v_u_177 = v_u_172:FindFirstChild("Exterior")
        if v_u_177 then
            v_u_177.RichText = true
            v_u_177.Text = ("<b><font color=\"rgb(175,175,175)\">Exterior</font></b>: <font color=\"rgb(255,255,255)\">%*</font>"):format(v176)
        end
        local v_u_178 = v_u_172:FindFirstChild("Tradeable")
        if v_u_178 then
            v_u_178.RichText = true
            v_u_178.Text = ("<b><font color=\"rgb(175,175,175)\">Tradeable</font></b>: <font color=\"rgb(255,255,255)\">%*</font>"):format(p170.IsTradeable and "Yes" or "No")
        end
        local v_u_179 = v_u_172:FindFirstChild("Serial")
        if v_u_179 then
            v_u_179.RichText = true
            local v180
            if p170.Serial then
                local v181 = p170.Serial
                v180 = "#" .. tostring(v181)
            else
                v180 = "N/A"
            end
            v_u_179.Text = ("<b><font color=\"rgb(175,175,175)\">Serial</font></b>: <font color=\"rgb(255,255,255)\">%*</font>"):format(v180)
        end
        local v_u_182 = v_u_172:FindFirstChild("Pattern")
        if v_u_182 then
            if p170.Type == "Charm" then
                v_u_182.Visible = true
                v_u_182.RichText = true
                local v183 = p170.Pattern or 0
                v_u_182.Text = ("<b><font color=\"rgb(175,175,175)\">Pattern</font></b>: <font color=\"rgb(255,255,255)\">%*</font>"):format((tostring(v183)))
            else
                v_u_182.Visible = false
            end
        end
        local v_u_184 = v_u_172:FindFirstChild("Float")
        if v_u_184 then
            v_u_184.RichText = true
            v_u_184.Text = ("<b><font color=\"rgb(175,175,175)\">Float</font></b>: <font color=\"rgb(255,255,255)\">%*</font>"):format((string.format("%.14f", p170.Float or 0)))
        end
        task.defer(function()
            local v185 = {}
            if v_u_177 then
                local v186 = v_u_177
                table.insert(v185, v186)
            end
            if v_u_178 then
                local v187 = v_u_178
                table.insert(v185, v187)
            end
            if v_u_179 then
                local v188 = v_u_179
                table.insert(v185, v188)
            end
            if v_u_182 and v_u_182.Visible then
                local v189 = v_u_182
                table.insert(v185, v189)
            end
            if v_u_184 then
                local v190 = v_u_184
                table.insert(v185, v190)
            end
            v_u_168(v_u_172, v185)
        end)
    end
end
local function v_u_196()
    if v_u_22.IsCaseSceneActive() then
        return true
    end
    if v_u_22.GetScreenBeforeCaseScene() == "Store" then
        return true
    end
    if v_u_22.GetCurrentScreen() == "Store" then
        return true
    end
    local v192 = v_u_26:FindFirstChild("MainGui")
    if v192 then
        local v193 = v192:FindFirstChild("Menu")
        local v194 = v193 and v193:FindFirstChild("Store")
        if v194 then
            local v195 = v194:FindFirstChild("CaseContent")
            if v195 and v195:GetAttribute("WasVisibleBeforeInspect") == true then
                return true
            end
        end
    end
    return false
end
local function v_u_202(p_u_197, p_u_198, p_u_199, p_u_200)
    v_u_40:Add(p_u_197.MouseEnter:Connect(function()
        v_u_152(p_u_198, p_u_197, true)
        if p_u_198 == "Info" and (p_u_200 and (v_u_39 and not v_u_196())) then
            v_u_191(p_u_200, v_u_39, p_u_197)
        end
    end), "Disconnect", "InspectButton_Enter_" .. p_u_198)
    v_u_40:Add(p_u_197.MouseLeave:Connect(function()
        v_u_152(p_u_198, p_u_197, false)
        local v201 = p_u_198 == "Info" and (p_u_200 and p_u_200:FindFirstChild("Information"))
        if v201 then
            v201.Visible = false
        end
    end), "Disconnect", "InspectButton_Leave_" .. p_u_198)
    if p_u_198 ~= "Info" then
        v_u_40:Add(p_u_197.MouseButton1Click:Connect(function()
            if v_u_42 ~= p_u_198 then
                v_u_138(p_u_198)
                v_u_157(p_u_199, p_u_198)
            end
        end), "Disconnect", "InspectButton_Click_" .. p_u_198)
    end
end
local function v_u_213(p203, p204)
    local v205 = p203:FindFirstChild("Bottom")
    if v205 then
        v205 = v205:FindFirstChild("Frame")
    end
    if v205 then
        local v206 = p204.Type == "Weapon" and true or p204.Type == "Melee"
        if not v206 and p204.Name then
            local v207, v208 = pcall(v_u_20, p204.Name)
            if v207 and (v208 and v208.Class) then
                v206 = v208.Class == "Weapon" and true or v208.Class == "Melee"
            end
        end
        local v209 = {
            ["Info"] = v205:FindFirstChild("Info"),
            ["Viewmodel"] = v205:FindFirstChild("Viewmodel"),
            ["Weapon"] = v205:FindFirstChild("Weapon")
        }
        local v210 = v_u_196()
        for v211, v212 in pairs(v209) do
            if v212 and v212:IsA("GuiButton") then
                if v211 == "Info" then
                    v212.Visible = not v210
                else
                    v212.Visible = v206
                end
                v_u_152(v211, v212, false)
                v_u_202(v212, v211, v209, p203)
            end
        end
    end
end
local function v_u_232(p214)
    local v215 = v_u_26:FindFirstChild("MainGui")
    if v215 then
        local v216 = v215:FindFirstChild("Menu")
        if v216 then
            local v217 = v216:FindFirstChild("Inspect") or v216:FindFirstChild("InspectFrame")
            if v217 then
                v_u_213(v217, p214)
                local v218 = v_u_196() and v217:FindFirstChild("Information")
                if v218 then
                    v218.Visible = false
                end
                local v219 = v_u_18.GetSkinInformation(p214.Name, p214.Skin)
                local v220 = v217:FindFirstChild("WeaponName")
                if v220 and v220:IsA("TextLabel") then
                    local v221 = v219 and v219.type == "Melee" and "\226\152\133 " or ""
                    local v222 = " | " .. p214.Skin
                    local v223 = v222 and v222 == "Vanilla" and "" or v222
                    v220.Text = v221 .. p214.Name .. v223
                end
                if v219 then
                    local v_u_224 = v219.collection
                    local v225 = v217:FindFirstChild("CollectionName")
                    if v225 and v225:IsA("TextLabel") then
                        v225.Text = v_u_224 or ""
                    end
                    local v_u_226 = v217:FindFirstChild("CollectionIcon")
                    if v_u_226 and (v_u_226:IsA("ImageLabel") and v_u_224) then
                        local v227 = v_u_17.GetCollectionByName(v_u_224)
                        if v227 then
                            v_u_226.Image = v227.imageAssetId
                            v_u_17.ObserveAvailableCollections(function(p228)
                                for _, v229 in ipairs(p228) do
                                    if v229.name == v_u_224 then
                                        v_u_226.Image = v229.imageAssetId
                                        return
                                    end
                                end
                            end)
                        else
                            v_u_226.Image = ""
                        end
                    end
                    local v230 = v217:FindFirstChild("Rarity")
                    local v231 = v230 and (v230:IsA("Frame") and (v219.rarity and v_u_19[v219.rarity]))
                    if v231 then
                        v230.BackgroundColor3 = v231.Color
                    end
                end
            end
        else
            return
        end
    else
        return
    end
end
local function v_u_236()
    v_u_43 = {}
    for _, v233 in ipairs(v_u_27:GetChildren()) do
        if v233:IsA("Model") and (v233.Name ~= "InspectScene" and (not v_u_37 or v_u_37.Model ~= v233)) then
            for _, v234 in ipairs(v233:GetDescendants()) do
                if v234:IsA("BasePart") then
                    if v234.Transparency < 1 then
                        v234:SetAttribute("_InspectPrevTransparency", v234.Transparency)
                        v234.Transparency = 1
                    end
                elseif v234:IsA("SurfaceGui") and v234.Enabled then
                    v234:SetAttribute("_InspectPrevSurfaceGuiEnabled", true)
                    v234.Enabled = false
                end
            end
            local v235 = v_u_43
            table.insert(v235, v233)
        end
    end
end
local function v_u_240()
    for _, v237 in ipairs(v_u_43) do
        if v237 and v237.Parent then
            for _, v238 in ipairs(v237:GetDescendants()) do
                if v238:IsA("BasePart") then
                    local v239 = v238:GetAttribute("_InspectPrevTransparency")
                    if v239 ~= nil then
                        v238.Transparency = v239
                        v238:SetAttribute("_InspectPrevTransparency", nil)
                    end
                elseif v238:IsA("SurfaceGui") and v238:GetAttribute("_InspectPrevSurfaceGuiEnabled") ~= nil then
                    v238.Enabled = true
                    v238:SetAttribute("_InspectPrevSurfaceGuiEnabled", nil)
                end
            end
        end
    end
    v_u_43 = {}
end
local function v_u_253()
    local v241 = v_u_22.GetMenuFrame()
    if v241 and v241.Visible then
        local v242 = v241:FindFirstChild("Inspect") or v241:FindFirstChild("InspectFrame")
        if v242 and v242:IsA("GuiObject") then
            v242.Visible = false
        end
        if v_u_33 then
            v_u_10.ShowMenuScene()
            v_u_10.SetMusicVolumeMultiplier(1, 0.5)
        end
        v_u_33 = false
        local v243 = v_u_22.GetScreenBeforeInspect()
        v_u_22.ExitInspect()
        local v244 = v241:FindFirstChild("Top")
        if v244 then
            v244.Visible = true
        end
        if v243 then
            local v245 = v241:FindFirstChild(v243)
            if v245 then
                for _, v246 in ipairs(v241:GetChildren()) do
                    if v246:IsA("Frame") and (v246.Name ~= "Top" and (v246.Name ~= v243 and (v246.Name ~= "Inspect" and v246.Name ~= "InspectFrame"))) then
                        v246.Visible = false
                    end
                end
                v245.Visible = true
                if v_u_22.IsCaseSceneActive() and v243 == "Store" then
                    v_u_22.SetBlurEnabled(false)
                    v241.BackgroundTransparency = 1
                    local v247 = v241:FindFirstChild("Pattern")
                    if v247 then
                        v247.Visible = false
                        return
                    end
                else
                    local v248
                    if v243 == "Dashboard" then
                        v248 = false
                    else
                        v248 = v243 ~= "Play"
                    end
                    v_u_22.SetBlurEnabled(v248)
                    v241.BackgroundTransparency = v248 and 0.15 or 1
                    local v249 = v241:FindFirstChild("Pattern")
                    if v249 then
                        v249.Visible = not v248
                        return
                    end
                end
            end
        else
            for _, v250 in ipairs(v241:GetChildren()) do
                if v250:IsA("Frame") and (v250.Name ~= "Top" and (v250.Name ~= "Dashboard" and (v250.Name ~= "Inspect" and v250.Name ~= "InspectFrame"))) then
                    v250.Visible = false
                end
            end
            local v251 = v241:FindFirstChild("Dashboard")
            if v251 then
                v251.Visible = true
            end
            v_u_22.SetBlurEnabled(false)
            v241.BackgroundTransparency = 1
            local v252 = v241:FindFirstChild("Pattern")
            if v252 then
                v252.Visible = true
            end
        end
    else
        v_u_33 = false
        v_u_22.ExitInspect()
    end
end
function v_u_1.ShowInspect(p254)
    if v_u_41 then
        v_u_1.HideInspect()
    end
    if v_u_21.broadcastRouter("HasPendingCharmAttachment") then
        v_u_56 = p254
        v_u_55 = 1
    else
        v_u_56 = nil
    end
    v_u_39 = p254
    v_u_42 = "Weapon"
    v_u_93()
    v_u_236()
    v_u_106()
    v_u_232(p254)
    if v_u_31 then
        if v_u_31 and v_u_31.Parent ~= workspace then
            v_u_31.Parent = workspace
        end
        v_u_35 = v_u_31
        if v_u_32 then
            v_u_73(v_u_32)
        end
        local v_u_255
        if v_u_35 then
            v_u_255 = v_u_35:FindFirstChild("CamPart")
        else
            v_u_255 = nil
        end
        if v_u_255 then
            local v256
            if v_u_35 then
                v256 = v_u_35:FindFirstChild("WeaponPart")
            else
                v256 = nil
            end
            if v256 then
                v_u_122(p254)
                v_u_46 = 0
                v_u_47 = 0
                v_u_48 = 0
                v_u_49 = 0
                v_u_50 = 40
                v_u_51 = 40
                v_u_27.CameraType = Enum.CameraType.Scriptable
                v_u_27.CFrame = v_u_255.CFrame
                v_u_27.Focus = v_u_255.CFrame
                v_u_12.updateCameraFOV(40)
                v_u_12.setForceLockOverride("Inspect", true)
                v_u_40:Add(v_u_4.RenderStepped:Connect(function(p257)
                    local v258 = p257 * 8
                    local v259 = math.min(1, v258)
                    v_u_50 = v_u_50 + (v_u_51 - v_u_50) * v259
                    if v_u_35 and v_u_255 then
                        v_u_27.CameraType = Enum.CameraType.Scriptable
                        v_u_27.CFrame = v_u_255.CFrame
                        v_u_27.Focus = v_u_255.CFrame
                        v_u_27.FieldOfView = v_u_50
                    end
                    if v_u_42 == "Weapon" and v_u_3.GamepadEnabled then
                        local v260 = v_u_3:GetGamepadState(Enum.UserInputType.Gamepad1)
                        local v261 = v260 and v260.Thumbstick1
                        if v261 then
                            local v262 = v261.Position
                            if v262.Magnitude > 0.1 then
                                local v263 = Vector2.new(v262.X * 0.5 * 60 * p257, v262.Y * 0.5 * 60 * p257)
                                v_u_49 = v_u_49 + v263.X * 0.5
                                v_u_48 = v_u_48 + v263.Y * 0.5
                                local v264 = v_u_48
                                v_u_48 = math.clamp(v264, -80, 80)
                            end
                        end
                    end
                    if v_u_42 == "Viewmodel" and v_u_37 then
                        v_u_37:render(p257)
                    elseif v_u_42 == "Weapon" then
                        local v265 = p257 * 10
                        local v266 = math.min(1, v265)
                        v_u_46 = v_u_46 + (v_u_48 - v_u_46) * v266
                        v_u_47 = v_u_47 + (v_u_49 - v_u_47) * v266
                        v_u_85()
                    end
                end), "Disconnect", "CameraUpdate")
                v_u_40:Add(v_u_3.InputBegan:Connect(function(p267, _)
                    if p267.UserInputType == Enum.UserInputType.MouseButton1 then
                        v_u_44 = true
                        v_u_45 = Vector2.new(p267.Position.X, p267.Position.Y)
                    end
                    local v268 = v_u_13.getActionKeybinds("Inspect")
                    if table.find(v268, p267.KeyCode) then
                        if v_u_24:GetAttribute("IsPlayerChatting") then
                            return
                        end
                        if v_u_42 == "Viewmodel" and (v_u_37 and v_u_37.Animation) then
                            v_u_37.Animation:stopAnimations()
                            v_u_37.Animation:play("Idle")
                            v_u_37.Animation:play("Inspect")
                        end
                    end
                    if p267.UserInputType == Enum.UserInputType.Touch then
                        v_u_53[p267] = Vector2.new(p267.Position.X, p267.Position.Y)
                        local v269 = 0
                        for _ in pairs(v_u_53) do
                            v269 = v269 + 1
                        end
                        if v269 == 1 then
                            v_u_44 = true
                            v_u_45 = Vector2.new(p267.Position.X, p267.Position.Y)
                        end
                        v_u_54 = v_u_88()
                    end
                end), "Disconnect", "InputBegan")
                v_u_40:Add(v_u_3.InputChanged:Connect(function(p270, _)
                    if p270.UserInputType == Enum.UserInputType.MouseMovement and v_u_44 then
                        local v271 = Vector2.new(p270.Position.X, p270.Position.Y)
                        local v272 = v271 - v_u_45
                        v_u_49 = v_u_49 + v272.X * 0.5
                        v_u_48 = v_u_48 + v272.Y * 0.5
                        local v273 = v_u_48
                        v_u_48 = math.clamp(v273, -80, 80)
                        v_u_45 = v271
                    end
                    if p270.UserInputType == Enum.UserInputType.Touch then
                        local v274 = Vector2.new(p270.Position.X, p270.Position.Y)
                        v_u_53[p270] = v274
                        local v275 = 0
                        for _ in pairs(v_u_53) do
                            v275 = v275 + 1
                        end
                        if v275 == 1 and v_u_44 then
                            local v276 = v274 - v_u_45
                            v_u_49 = v_u_49 + v276.X * 0.5
                            v_u_48 = v_u_48 + v276.Y * 0.5
                            local v277 = v_u_48
                            v_u_48 = math.clamp(v277, -80, 80)
                            v_u_45 = v274
                        end
                        if v275 >= 2 then
                            local v278 = v_u_88()
                            if v278 and v_u_54 then
                                local v279 = (v278 - v_u_54) * 0.01
                                if v_u_42 ~= "Viewmodel" then
                                    local v280 = v_u_51 - v279 * 2
                                    v_u_51 = math.clamp(v280, 20, 70)
                                end
                            end
                            v_u_54 = v278
                        end
                    end
                    if p270.UserInputType == Enum.UserInputType.MouseWheel then
                        local v281 = p270.Position.Z
                        if v_u_42 == "Viewmodel" then
                            return
                        end
                        local v282 = v_u_51 - v281 * 2
                        v_u_51 = math.clamp(v282, 20, 70)
                    end
                end), "Disconnect", "InputChanged")
                v_u_40:Add(v_u_3.InputEnded:Connect(function(p283, _)
                    if p283.UserInputType == Enum.UserInputType.MouseButton1 then
                        v_u_44 = false
                    end
                    if p283.UserInputType == Enum.UserInputType.Touch then
                        v_u_53[p283] = nil
                        local v284 = 0
                        for _ in pairs(v_u_53) do
                            v284 = v284 + 1
                        end
                        if v284 == 0 then
                            v_u_44 = false
                        end
                        v_u_54 = v_u_88()
                    end
                end), "Disconnect", "InputEnded")
                v_u_40:Add(function()
                    if v_u_36 then
                        v_u_36:Destroy()
                        v_u_36 = nil
                    end
                    if v_u_35 and v_u_35 == v_u_31 then
                        v_u_35.Parent = v_u_2
                        v_u_35 = nil
                    elseif v_u_35 then
                        v_u_35:Destroy()
                        v_u_35 = nil
                    end
                    v_u_44 = false
                    v_u_53 = {}
                    v_u_54 = nil
                    v_u_46 = 0
                    v_u_47 = 0
                    v_u_48 = 0
                    v_u_49 = 0
                    v_u_50 = 40
                    v_u_51 = 40
                    v_u_52 = nil
                end, true, "InspectCleanup")
                v_u_41 = true
            else
                warn("[InspectController]: Inspect scene missing WeaponPart")
                if v_u_35 then
                    v_u_35.Parent = v_u_2
                    v_u_35 = nil
                end
                v_u_65()
                v_u_253()
            end
        else
            warn("[InspectController]: Inspect scene missing CamPart")
            if v_u_35 then
                v_u_35.Parent = v_u_2
                v_u_35 = nil
            end
            v_u_65()
            v_u_253()
            return
        end
    else
        warn("[InspectController]: No preloaded inspect scene available")
        v_u_253()
        return
    end
end
function v_u_1.HideInspect(p285)
    if v_u_41 then
        v_u_40:Cleanup()
        if v_u_37 then
            v_u_37:destroy()
            v_u_37 = nil
        end
        if v_u_38 then
            v_u_38:Destroy()
            v_u_38 = nil
        end
        v_u_13.enableGroup("Gameplay")
        if v_u_36 then
            v_u_36:Destroy()
            v_u_36 = nil
        end
        v_u_52 = nil
        if v_u_22.IsCaseSceneActive() then
            v_u_11.ApplyCaseSceneLighting()
        else
            v_u_65()
        end
        v_u_27.CameraType = Enum.CameraType.Custom
        v_u_12.updateCameraFOV(v_u_23.DEFAULT_CAMERA_FOV)
        v_u_12.setForceLockOverride("Inspect", false)
        if p285 then
            v_u_22.ExitInspect()
            v_u_33 = false
        else
            v_u_253()
        end
        v_u_240()
        v_u_56 = nil
        v_u_55 = 1
        v_u_41 = false
    end
end
function v_u_1.IsActive()
    return v_u_41
end
function v_u_1.ToggleInspect(p286)
    if v_u_41 then
        v_u_1.HideInspect()
    elseif p286 then
        v_u_1.ShowInspect(p286)
    end
end
function v_u_1.CycleCharmPosition()
    if v_u_41 and v_u_56 then
        v_u_55 = v_u_55 % 4 + 1
        local v287 = v_u_55
        v_u_1.RefreshWeaponWithCharm((tostring(v287)))
    end
end
function v_u_1.RefreshWeaponWithCharm(p288)
    if v_u_41 and (v_u_35 and v_u_56) then
        local v289 = v_u_35
        local v290 = v_u_56
        if v289:FindFirstChild("WeaponPart") then
            local v291 = v_u_46
            local v292 = v_u_47
            local v293 = v_u_48
            local v294 = v_u_49
            local v295 = v290.Charm
            local v296 = type(v295) == "table" and {
                ["_id"] = v295._id,
                ["Position"] = p288
            } or p288
            if v_u_42 == "Weapon" then
                if v_u_36 then
                    v_u_36:Destroy()
                    v_u_36 = nil
                end
                local v297 = v_u_18.GetCharacterModel(v290.Name, v290.Skin, v290.Float, v290.StatTrack, v290.NameTag, v296, v290.Stickers)
                if not v297 then
                    warn((("[InspectController]: Failed to refresh weapon model for charm position %*"):format(p288)))
                    return
                end
                v297.Name = "InspectWeapon"
                v_u_36 = v297
                v_u_52 = v297:FindFirstChild("InspectPivot", true)
                local v298 = v297:FindFirstChild("CharmBase", true)
                for _, v299 in ipairs(v297:GetDescendants()) do
                    if v299:IsA("BasePart") then
                        local v300
                        if v298 then
                            v300 = v299:IsDescendantOf(v298)
                        else
                            v300 = v298
                        end
                        if v300 then
                            v299.Anchored = false
                        else
                            v299.CanCollide = v299:IsA("MeshPart") and true or false
                            v299.CanQuery = false
                            v299.CanTouch = false
                            v299.Anchored = true
                        end
                    end
                end
                v297.Parent = v289
                v_u_46 = v291
                v_u_47 = v292
                v_u_48 = v293
                v_u_49 = v294
                v_u_85()
            end
            if v_u_37 and v_u_38 then
                v_u_37.Charm = v296
                v_u_37:construct(v_u_38, nil)
            end
        end
    else
        return
    end
end
function v_u_1.GetCurrentCharmPosition()
    return v_u_55
end
function v_u_1.Initialize()
    v_u_14.CreateListener(v_u_24, "Settings.Video.Presets.Global Shadows", function()
        if v_u_14.Get(v_u_24, "Settings.Video.Presets.Global Shadows") ~= false then
            if v_u_25 ~= nil then
                v_u_7.GlobalShadows = v_u_25
            end
        else
            v_u_7.GlobalShadows = false
        end
    end)
    local v301 = v_u_78()
    if v301 then
        v_u_32 = v301.Name
        v_u_31 = v301
        if v_u_31 then
            v_u_31.Name = "InspectScene"
            v_u_31.Parent = v_u_2
        end
    else
        warn("[InspectController]: No inspect scene found to preload in ReplicatedStorage.Assets.InspectScenes")
    end
    v_u_3.InputBegan:Connect(function(p302, p303)
        if not p303 then
            if p302.KeyCode == Enum.KeyCode.Escape and v_u_41 then
                v_u_1.HideInspect()
            end
        end
    end)
    v_u_24.CharacterAdded:Connect(function()
        if v_u_41 then
            v_u_1.HideInspect()
        end
    end)
    v_u_21.observerRouter("WeaponInspect", function(p304, p305, p306, p307, p308, p309, p310, p311, p312, p313, p314, p315)
        if not require(v_u_2.Controllers.EndScreenController).IsActive() then
            local v316 = {
                ["_id"] = p313 or "inspect_" .. p304 .. "_" .. p305,
                ["Name"] = p304,
                ["Skin"] = p305,
                ["Float"] = p306,
                ["StatTrack"] = p307,
                ["NameTag"] = p308,
                ["Charm"] = p309,
                ["Stickers"] = p310,
                ["Type"] = p311,
                ["Pattern"] = p312,
                ["Serial"] = p314,
                ["IsTradeable"] = p315
            }
            v_u_1.ShowInspect(v316)
        end
    end)
    v_u_21.observerRouter("WeaponInspectClose", function()
        v_u_1.HideInspect()
    end)
    v_u_21.observerRouter("WeaponInspectCloseForGameEnd", function()
        v_u_1.HideInspect(true)
    end)
    v_u_21.observerRouter("IsInspectActive", function()
        return v_u_1.IsActive()
    end)
    v_u_21.observerRouter("GetCurrentCharmPosition", function()
        return v_u_55
    end)
end
function v_u_1.Start()
    v_u_101()
end
return v_u_1