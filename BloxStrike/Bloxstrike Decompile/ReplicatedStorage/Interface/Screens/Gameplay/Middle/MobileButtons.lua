local v_u_1 = {}
local v_u_2 = game:GetService("CollectionService")
local v3 = game:GetService("ReplicatedStorage")
local v_u_4 = game:GetService("UserInputService")
local v_u_5 = game:GetService("TweenService")
local v_u_6 = game:GetService("RunService")
local v7 = game:GetService("Players")
require(v3.Database.Custom.Types)
require(script:WaitForChild("Types"))
local v_u_8 = require(v3.Controllers.CharacterController)
local v_u_9 = require(v3.Controllers.InventoryController)
local v_u_10 = require(v3.Controllers.DataController)
local v_u_11 = require(v3.Controllers.SpectateController)
local v_u_12 = require(v3.Database.Components.Libraries.Skins)
local v_u_13 = require(v3.Database.Components.GameState)
local v_u_14 = require(v3.Database.Components.Common.IsInBuyArea)
local v15 = require(v3.Components.Common.GetUserPlatform)
local v_u_16 = require(v3.Database.Security.Remotes)
local v_u_17 = require(v3.Database.Security.Router)
local v_u_18 = require(v3.Shared.Promise)
local v_u_19 = require(v3.Interface.Screens.Gameplay.Middle.TeamSelection)
local v_u_20 = require(v3.Interface.Screens.Gameplay.Middle.BuyMenu)
local v_u_21 = require(v3.Interface.Screens.Menu.Top)
local v_u_22 = require(v3.Database.Custom.GameStats.Rarities)
local v_u_23 = v7.LocalPlayer
local v_u_24 = workspace.CurrentCamera
local v_u_25 = require(v_u_23:WaitForChild("PlayerScripts"):WaitForChild("PlayerModule"):WaitForChild("CameraModule"):WaitForChild("CameraInput"))
local v_u_26 = RaycastParams.new()
v_u_26.FilterType = Enum.RaycastFilterType.Exclude
v_u_26.IgnoreWater = true
local v27 = v15()
local v_u_28 = table.find(v27, "Mobile")
if v_u_28 then
    v_u_28 = #v27 <= 1
end
local v_u_29 = nil
local v_u_30 = nil
local v_u_31 = nil
local v_u_32 = nil
local v_u_33 = nil
local v_u_34 = nil
local v_u_35 = nil
local v_u_36 = false
local v_u_37 = nil
local v_u_38 = {}
local v_u_39 = TweenInfo.new(0.1, Enum.EasingStyle.Cubic, Enum.EasingDirection.In)
local v_u_40 = { "SwapTeam", "Menu" }
local v_u_41 = {
    "Shoot",
    "Shop",
    "Reload",
    "Jump",
    "Crouch",
    "Aim",
    "Drop",
    "Interact",
    "SwapTeam",
    "Menu",
    "Configure"
}
local v_u_42 = {
    ["SwapTeam"] = true,
    ["Crouch"] = true,
    ["Reload"] = true,
    ["Jump"] = true,
    ["Shop"] = true,
    ["Menu"] = true
}
local v_u_43 = {
    ["SwapTeam"] = true,
    ["Interact"] = true,
    ["Crouch"] = true,
    ["Reload"] = true,
    ["Menu"] = true,
    ["Shop"] = true
}
local v_u_44 = {
    ["SwapTeam"] = true,
    ["Crouch"] = true,
    ["Reload"] = true,
    ["Shop"] = true,
    ["Menu"] = true,
    ["Drop"] = true
}
local function v_u_49()
    if not (v_u_24 and v_u_23.Character) then
        return nil
    end
    if v_u_23:GetAttribute("Team") ~= "Counter-Terrorists" then
        return nil
    end
    v_u_26.FilterDescendantsInstances = { v_u_23.Character, v_u_24 }
    local v45 = workspace:Raycast(v_u_24.CFrame.Position, v_u_24.CFrame.LookVector * 5, v_u_26)
    if v45 then
        local v46 = v45.Instance
        if v46 and (v46.Parent and v46.Parent:HasTag("Hostage")) or false then
            local v47 = v45.Instance.Parent
            if v47 and v47:GetAttribute("CanRescue") == true then
                local v48 = v47:GetAttribute("RescuingPlayer")
                if v48 and v48 ~= v_u_23.Name then
                    return nil
                elseif v47:GetAttribute("CarryingPlayer") then
                    return nil
                else
                    return v47
                end
            end
        end
    end
    return nil
end
local function v_u_53()
    if v_u_29 then
        local v50 = v_u_2:GetTagged("Bomb")[1]
        if v50 then
            v50 = v50:GetAttribute("CanDefuse")
        end
        local v51 = #v_u_2:GetTagged("IsHoveringInteractable") > 0
        local v52 = v_u_49() ~= nil
        if v50 then
            v_u_29.Interact.Defuse.Visible = true
            v_u_29.Interact.Use.Visible = false
            v_u_29.Interact.Visible = true
            return
        elseif v51 or v52 then
            v_u_29.Interact.Defuse.Visible = false
            v_u_29.Interact.Use.Visible = true
            v_u_29.Interact.Visible = true
        else
            v_u_29.Interact.Defuse.Visible = false
            v_u_29.Interact.Use.Visible = false
            v_u_29.Interact.Visible = false
        end
    else
        return
    end
end
local function v_u_55()
    if v_u_11.IsLocalPlayerDead() then
        v_u_29.Drop.Visible = false
        return
    else
        local v54 = v_u_9.getCurrentEquipped()
        if v54 then
            if v54.Properties.Droppable then
                if v_u_13.GetState() == "Warmup" then
                    v_u_29.Drop.Visible = false
                    return
                elseif workspace:GetAttribute("Gamemode") == "Deathmatch" then
                    v_u_29.Drop.Visible = false
                    return
                elseif v54.Properties.Class == "C4" and v54.IsPlanting then
                    v_u_29.Drop.Visible = false
                else
                    v_u_29.Drop.Visible = true
                end
            else
                v_u_29.Drop.Visible = false
                return
            end
        else
            v_u_29.Drop.Visible = false
            return
        end
    end
end
local function v_u_60()
    local v56 = {}
    if v_u_29 then
        for _, v57 in ipairs(v_u_29:GetChildren()) do
            if v57:IsA("TextButton") and v57.Name ~= "Configure" then
                local v58 = v57.Name
                local v59 = {
                    ["Position"] = {
                        ["X"] = v57.Position.X.Scale,
                        ["Y"] = v57.Position.Y.Scale
                    },
                    ["Size"] = {
                        ["X"] = v57.Size.X.Scale,
                        ["Y"] = v57.Size.Y.Scale
                    }
                }
                v56[v58] = v59
            end
        end
        v_u_16.Player.UpdateMobileButtons.Send({
            ["Value"] = v56
        })
    end
end
local function v_u_62()
    if not v_u_36 then
        v_u_36 = true
        for _, v61 in ipairs(v_u_29:GetChildren()) do
            if v61:IsA("TextButton") and v61.Name ~= "Configure" then
                v61.Active = false
            end
        end
    end
end
local function v_u_64()
    if v_u_36 then
        v_u_31 = nil
        v_u_36 = false
        v_u_35 = nil
        v_u_37 = nil
        v_u_33 = nil
        v_u_34 = nil
        for _, v63 in ipairs(v_u_29:GetChildren()) do
            if v63:IsA("TextButton") then
                v63.Active = true
            end
        end
        v_u_60()
    end
end
local function v_u_78(p65)
    if v_u_33 and v_u_35 then
        local v66 = v_u_29.AbsoluteSize
        local v67 = p65 - v_u_35
        local v68 = v_u_33.AbsoluteSize
        local v69 = Vector2.new
        local v70 = v67.X
        local v71 = v66.X - v68.X
        local v72 = math.clamp(v70, 0, v71)
        local v73 = v67.Y
        local v74 = v66.Y - v68.Y
        local v75 = v69(v72, (math.clamp(v73, 0, v74)))
        local v76 = v75.X / v66.X
        local v77 = v75.Y / v66.Y
        v_u_33.Position = UDim2.fromScale(v76, v77)
    end
end
local function v_u_97(p79)
    if v_u_34 and (v_u_37 and v_u_31) then
        local v80 = v_u_37 + (p79 - v_u_31)
        local v81 = v_u_29.AbsoluteSize
        local v82 = Vector2.new
        local v83 = v80.X
        local v84 = math.max(v83, 50)
        local v85 = v80.Y
        local v86 = v82(v84, (math.max(v85, 50)))
        local v87 = v81 * 0.8
        local v88 = Vector2.new
        local v89 = v86.X
        local v90 = v87.X
        local v91 = math.min(v89, v90)
        local v92 = v86.Y
        local v93 = v87.Y
        local v94 = v88(v91, (math.min(v92, v93)))
        local v95 = v94.X / v81.X
        local v96 = v94.Y / v81.Y
        v_u_34.Size = UDim2.fromScale(v95, v96)
    end
end
local function v_u_102(p98, p99)
    if (p98.UserInputType == Enum.UserInputType.Touch and true or p98.UserInputType == Enum.UserInputType.MouseButton1) and v_u_36 then
        local v100 = p98.Position
        local v101 = Vector2.new(v100.X, v100.Y)
        if v_u_36 then
            v_u_35 = v101 - p99.AbsolutePosition
            v_u_33 = p99
        end
    end
end
local function v_u_106(p103)
    if (p103.UserInputType == Enum.UserInputType.Touch and true or p103.UserInputType == Enum.UserInputType.MouseMovement) and v_u_36 then
        local v104 = p103.Position
        local v105 = Vector2.new(v104.X, v104.Y)
        if v_u_33 then
            v_u_78(v105)
            return
        elseif v_u_34 then
            v_u_97(v105)
        end
    else
        return
    end
end
function v_u_1.setupButton(p_u_107)
    local v_u_108 = p_u_107.Size
    p_u_107.InputBegan:Connect(function(p109)
        if p109.UserInputType == Enum.UserInputType.Touch or p109.UserInputType == Enum.UserInputType.MouseButton1 then
            if not v_u_36 and p109.UserInputState == Enum.UserInputState.Begin then
                if not v_u_42[p_u_107.Name] then
                    local v110 = p_u_107
                    if not v_u_38[v110] and p109.UserInputState == Enum.UserInputState.Begin then
                        v_u_38[v110] = p109
                    end
                end
                if v_u_38[p_u_107] == p109 then
                    local v111 = v_u_5
                    local v112 = p_u_107
                    local v113 = v_u_39
                    local v114 = {}
                    local v115 = v_u_108
                    v114.Size = UDim2.fromScale(v115.X.Scale * 0.9, v115.Y.Scale * 0.9)
                    v111:Create(v112, v113, v114):Play()
                end
            end
        end
    end)
    if not v_u_43[p_u_107.Name] then
        p_u_107.InputChanged:Connect(function(p116)
            if p116.UserInputType == Enum.UserInputType.Touch then
                if not v_u_36 then
                    if v_u_38[p_u_107] == p116 then
                        local v117 = p_u_107
                        local v118 = p116.Position
                        local v119 = v117.AbsolutePosition
                        local v120 = v117.AbsoluteSize
                        local v121
                        if v118.X >= v119.X and (v118.X <= v119.X + v120.X and v118.Y >= v119.Y) then
                            v121 = v118.Y <= v119.Y + v120.Y
                        else
                            v121 = false
                        end
                        if not v121 then
                            local v122 = p_u_107
                            if v_u_38[v122] == p116 then
                                v_u_38[v122] = nil
                            end
                            local v123 = v_u_5
                            local v124 = p_u_107
                            local v125 = v_u_39
                            local v126 = {}
                            local v127 = v_u_108
                            v126.Size = UDim2.fromScale(v127.X.Scale * 1, v127.Y.Scale * 1)
                            v123:Create(v124, v125, v126):Play()
                        end
                    end
                end
            else
                return
            end
        end)
    end
    p_u_107.InputEnded:Connect(function(p128)
        if p128.UserInputType == Enum.UserInputType.Touch or p128.UserInputType == Enum.UserInputType.MouseButton1 then
            if not v_u_36 then
                local v129 = v_u_5
                local v130 = p_u_107
                local v131 = v_u_39
                local v132 = {}
                local v133 = v_u_108
                v132.Size = UDim2.fromScale(v133.X.Scale * 1, v133.Y.Scale * 1)
                v129:Create(v130, v131, v132):Play()
                if not v_u_44[p_u_107.Name] then
                    local v134 = p_u_107
                    if v_u_38[v134] == p128 then
                        v_u_38[v134] = nil
                    end
                end
            end
        end
    end)
end
function v_u_1.setupDraggableButton(p_u_135)
    local v_u_136 = nil
    local v_u_137 = nil
    p_u_135.InputBegan:Connect(function(p138)
        if (p138.UserInputType == Enum.UserInputType.Touch and true or p138.UserInputType == Enum.UserInputType.MouseButton1) and v_u_36 then
            local v139 = p138.Position
            v_u_136 = Vector2.new(v139.X, v139.Y)
            v_u_137 = tick()
        end
    end)
    p_u_135.InputChanged:Connect(function(p140)
        if v_u_36 then
            local v141 = p140.Position
            local v142 = Vector2.new(v141.X, v141.Y)
            if v_u_137 and v_u_136 then
                local v143 = tick() - v_u_137
                local v144 = (v142 - v_u_136).Magnitude
                if v143 >= 0.5 and v144 < 10 then
                    if not (v_u_34 or v_u_33) then
                        local v145 = p_u_135
                        if v_u_36 then
                            v_u_37 = v145.AbsoluteSize
                            v_u_31 = v142
                            v_u_34 = v145
                        end
                        return
                    end
                elseif v144 >= 10 and not (v_u_33 or v_u_34) then
                    v_u_102(p140, p_u_135)
                    return
                end
            end
        end
    end)
    p_u_135.InputEnded:Connect(function(p146)
        if p146.UserInputType == Enum.UserInputType.Touch and true or p146.UserInputType == Enum.UserInputType.MouseButton1 then
            v_u_136 = nil
            v_u_137 = nil
            if v_u_36 and v_u_33 == p_u_135 and ((p146.UserInputType == Enum.UserInputType.Touch or p146.UserInputType == Enum.UserInputType.MouseButton1) and v_u_36) then
                if v_u_33 then
                    v_u_35 = nil
                    v_u_33 = nil
                elseif v_u_34 then
                    v_u_31 = nil
                    v_u_37 = nil
                    v_u_34 = nil
                end
            end
            if v_u_34 == p_u_135 then
                v_u_31 = nil
                v_u_37 = nil
                v_u_34 = nil
            end
        end
    end)
end
function v_u_1.Initialize(_, p147)
    v_u_29 = p147
    if v_u_28 then
        local v148 = v_u_29.Parent.Parent:FindFirstChild("Top")
        local v149 = v148 and v148:FindFirstChild("Bomb Defusal")
        if v149 then
            v149.Size = UDim2.new(0.6, 0, 0.75, 0)
        end
        v_u_29.Jump.InputBegan:Connect(function(p150)
            if p150.UserInputType == Enum.UserInputType.Touch or p150.UserInputType == Enum.UserInputType.MouseButton1 then
                if not v_u_36 and p150.UserInputState == Enum.UserInputState.Begin then
                    local v151 = v_u_29.Jump
                    if not v_u_38[v151] and p150.UserInputState == Enum.UserInputState.Begin then
                        v_u_38[v151] = p150
                    end
                end
                if not v_u_36 then
                    local v152 = v_u_38[v_u_29.Jump]
                    local v153
                    if v152 then
                        v153 = (not p150 or p150 == v152) and true or false
                    else
                        v153 = false
                    end
                    if v153 then
                        v_u_8.jump()
                    end
                end
            end
        end)
        local v_u_154 = v_u_29.Crouch.Size
        v_u_29.Crouch.InputBegan:Connect(function(p155)
            if p155.UserInputType == Enum.UserInputType.Touch or p155.UserInputType == Enum.UserInputType.MouseButton1 then
                if not v_u_36 and p155.UserInputState == Enum.UserInputState.Begin then
                    local v156 = v_u_29.Crouch
                    if not v_u_38[v156] and p155.UserInputState == Enum.UserInputState.Begin then
                        v_u_38[v156] = p155
                    end
                    if v_u_38[v_u_29.Crouch] == p155 then
                        local v157 = v_u_5
                        local v158 = v_u_29.Crouch
                        local v159 = v_u_39
                        local v160 = {}
                        local v161 = v_u_154
                        v160.Size = UDim2.fromScale(v161.X.Scale * 0.9, v161.Y.Scale * 0.9)
                        v157:Create(v158, v159, v160):Play()
                    end
                end
            end
        end)
        v_u_29.Crouch.InputEnded:Connect(function(p162)
            if p162.UserInputType == Enum.UserInputType.Touch or p162.UserInputType == Enum.UserInputType.MouseButton1 then
                local v163 = v_u_5
                local v164 = v_u_29.Crouch
                local v165 = v_u_39
                local v166 = {}
                local v167 = v_u_154
                v166.Size = UDim2.fromScale(v167.X.Scale * 1, v167.Y.Scale * 1)
                v163:Create(v164, v165, v166):Play()
                if not v_u_36 then
                    local v168 = v_u_38[v_u_29.Crouch]
                    local v169
                    if v168 then
                        v169 = (not p162 or p162 == v168) and true or false
                    else
                        v169 = false
                    end
                    if v169 then
                        v_u_8.crouch(not v_u_8.GetCrouchState())
                    end
                end
                local v170 = v_u_29.Crouch
                if v_u_38[v170] == p162 then
                    v_u_38[v170] = nil
                end
            end
        end)
        v_u_29.Drop.InputEnded:Connect(function(p171)
            if p171.UserInputType == Enum.UserInputType.Touch or p171.UserInputType == Enum.UserInputType.MouseButton1 then
                if not v_u_36 then
                    local v172 = v_u_38[v_u_29.Drop]
                    local v173
                    if v172 then
                        v173 = (not p171 or p171 == v172) and true or false
                    else
                        v173 = false
                    end
                    if v173 then
                        local v174 = v_u_29.Drop
                        if v_u_38[v174] == p171 then
                            v_u_38[v174] = nil
                        end
                        v_u_18.new(function(p175, p176)
                            local v177 = v_u_9.getCurrentEquipped()
                            if v177 then
                                p175(v177)
                            else
                                p176("Failed to fetch current equipped")
                            end
                        end):catch(warn):andThen(function(p178)
                            if p178 then
                                local v179 = v_u_12.GetSkinInformation(p178.Name, p178.Skin)
                                local v180 = "Skin data not found for weapon: " .. p178.Name .. " and skin: " .. p178.Skin
                                assert(v179, v180)
                                local v181 = v_u_22[v179.rarity]
                                local v182 = v181.Color.R * 255
                                local v183 = math.floor(v182)
                                local v184 = v181.Color.G * 255
                                local v185 = math.floor(v184)
                                local v186 = v181.Color.B * 255
                                local v187 = math.floor(v186)
                                if p178:drop() then
                                    v_u_17.broadcastRouter("CreateNotification", "Item Dropped", ("You dropped your <font color = \"rgb(%*, %*, %*)\"><b>%* | %*</b></font>"):format(v183, v185, v187, p178.Name, p178.Skin), 2)
                                end
                            end
                        end)
                        return
                    end
                end
                local v188 = v_u_29.Drop
                if v_u_38[v188] == p171 then
                    v_u_38[v188] = nil
                end
            end
        end)
        local v_u_189 = v_u_29.Reload.Size
        v_u_29.Reload.InputBegan:Connect(function(p190)
            if p190.UserInputType == Enum.UserInputType.Touch or p190.UserInputType == Enum.UserInputType.MouseButton1 then
                if not v_u_36 and p190.UserInputState == Enum.UserInputState.Begin then
                    local v191 = v_u_29.Reload
                    if not v_u_38[v191] and p190.UserInputState == Enum.UserInputState.Begin then
                        v_u_38[v191] = p190
                    end
                    if v_u_38[v_u_29.Reload] == p190 then
                        local v192 = v_u_5
                        local v193 = v_u_29.Reload
                        local v194 = v_u_39
                        local v195 = {}
                        local v196 = v_u_189
                        v195.Size = UDim2.fromScale(v196.X.Scale * 0.9, v196.Y.Scale * 0.9)
                        v192:Create(v193, v194, v195):Play()
                    end
                end
            end
        end)
        v_u_29.Reload.InputEnded:Connect(function(p197)
            if p197.UserInputType == Enum.UserInputType.Touch or p197.UserInputType == Enum.UserInputType.MouseButton1 then
                local v198 = v_u_5
                local v199 = v_u_29.Reload
                local v200 = v_u_39
                local v201 = {}
                local v202 = v_u_189
                v201.Size = UDim2.fromScale(v202.X.Scale * 1, v202.Y.Scale * 1)
                v198:Create(v199, v200, v201):Play()
                if not v_u_36 then
                    local v203 = v_u_38[v_u_29.Reload]
                    local v204
                    if v203 then
                        v204 = (not p197 or p197 == v203) and true or false
                    else
                        v204 = false
                    end
                    if v204 then
                        local v205 = v_u_29.Reload
                        if v_u_38[v205] == p197 then
                            v_u_38[v205] = nil
                        end
                        v_u_18.new(function(p206, p207)
                            local v208 = v_u_9.getCurrentEquipped()
                            if v208 then
                                p206(v208)
                            else
                                p207("Failed to fetch current equipped")
                            end
                        end):catch(warn):andThen(function(p209)
                            if p209 then
                                p209:reload()
                            end
                        end)
                        return
                    end
                end
                local v210 = v_u_29.Reload
                if v_u_38[v210] == p197 then
                    v_u_38[v210] = nil
                end
            end
        end)
        local v_u_211 = v_u_29.Shoot.Size
        v_u_29.Shoot.Active = true
        local v_u_212 = false
        local function v_u_224(p213, p214)
            if p213 == v_u_30 then
                if p214 or p213.UserInputState == Enum.UserInputState.End then
                    v_u_30 = nil
                    if v_u_212 then
                        v_u_212 = false
                        local v215 = v_u_5
                        local v216 = v_u_29.Shoot
                        local v217 = v_u_39
                        local v218 = {}
                        local v219 = v_u_211
                        v218.Size = UDim2.fromScale(v219.X.Scale * 1, v219.Y.Scale * 1)
                        v215:Create(v216, v217, v218):Play()
                        if not v_u_36 then
                            v_u_18.new(function(p220, p221)
                                local v222 = v_u_9.getCurrentEquipped()
                                if v222 then
                                    p220(v222)
                                else
                                    p221("Failed to fetch current equipped")
                                end
                            end):catch(warn):andThen(function(p223)
                                if p223 then
                                    if p223.Properties.Class == "Weapon" then
                                        p223.IsFireHeld = false
                                        return
                                    elseif p223.Properties.Class == "Melee" then
                                        p223.IsFireHeld = false
                                        return
                                    elseif p223.Properties.Class == "C4" then
                                        p223:cancel()
                                        return
                                    elseif p223.Properties.Slot == "Grenade" then
                                        p223:Throw("Far")
                                    end
                                else
                                    return
                                end
                            end)
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
        v_u_29.Shoot.InputBegan:Connect(function(p225)
            if p225.UserInputType == Enum.UserInputType.Touch or p225.UserInputType == Enum.UserInputType.MouseButton1 then
                if v_u_36 or v_u_30 then
                    return
                elseif p225.UserInputState == Enum.UserInputState.Begin then
                    v_u_30 = p225
                    if v_u_23:GetAttribute("IsPlayerChatting") then
                        return
                    elseif v_u_11.IsLocalPlayerDead() then
                        return
                    elseif v_u_23.Character then
                        if v_u_13.GetState() ~= "Buy Period" then
                            v_u_17.broadcastRouter("Cancel Defuse Bomb")
                            v_u_212 = true
                            local v226 = v_u_5
                            local v227 = v_u_29.Shoot
                            local v228 = v_u_39
                            local v229 = {}
                            local v230 = v_u_211
                            v229.Size = UDim2.fromScale(v230.X.Scale * 0.9, v230.Y.Scale * 0.9)
                            v226:Create(v227, v228, v229):Play()
                            v_u_18.new(function(p231, p232)
                                local v233 = v_u_9.getCurrentEquipped()
                                if v233 then
                                    p231(v233)
                                else
                                    p232("Failed to fetch current equipped")
                                end
                            end):catch(warn):andThen(function(p234)
                                if p234 then
                                    if p234.Properties.Class == "Weapon" then
                                        p234.IsFireHeld = true
                                        p234:shoot()
                                        return
                                    elseif p234.Properties.Class == "Melee" then
                                        p234.IsFireHeld = true
                                        p234:shoot()
                                        return
                                    elseif p234.Properties.Class == "C4" then
                                        p234:shoot()
                                        return
                                    elseif p234.Properties.Slot == "Grenade" then
                                        p234:StartThrow()
                                    end
                                else
                                    return
                                end
                            end)
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
        end)
        v_u_29.Shoot.InputEnded:Connect(v_u_224)
        v_u_29.Shoot.InputChanged:Connect(function(p235)
            if p235 == v_u_30 and (p235.UserInputType == Enum.UserInputType.Touch and not v_u_36) then
                v_u_25.addTouchMove(Vector2.new(p235.Delta.X, p235.Delta.Y))
            end
        end)
        local v_u_236 = v_u_29.Aim.Size
        v_u_29.Aim.Active = true
        local function v_u_248(p237, p238)
            if p237 == v_u_32 then
                if p238 or p237.UserInputState == Enum.UserInputState.End then
                    v_u_32 = nil
                    local v239 = v_u_5
                    local v240 = v_u_29.Aim
                    local v241 = v_u_39
                    local v242 = {}
                    local v243 = v_u_236
                    v242.Size = UDim2.fromScale(v243.X.Scale * 1, v243.Y.Scale * 1)
                    v239:Create(v240, v241, v242):Play()
                    if not v_u_36 then
                        v_u_18.new(function(p244, p245)
                            local v246 = v_u_9.getCurrentEquipped()
                            if v246 then
                                p244(v246)
                            else
                                p245("Failed to fetch current equipped")
                            end
                        end):catch(warn):andThen(function(p247)
                            if p247 then
                                if p247.Properties.HasScope then
                                    p247:unscope()
                                end
                            else
                                return
                            end
                        end)
                    end
                else
                    return
                end
            else
                return
            end
        end
        v_u_29.Aim.InputBegan:Connect(function(p249)
            if p249.UserInputType == Enum.UserInputType.Touch or p249.UserInputType == Enum.UserInputType.MouseButton1 then
                if v_u_36 or v_u_32 then
                    return
                elseif p249.UserInputState == Enum.UserInputState.Begin then
                    v_u_32 = p249
                    local v250 = v_u_5
                    local v251 = v_u_29.Aim
                    local v252 = v_u_39
                    local v253 = {}
                    local v254 = v_u_236
                    v253.Size = UDim2.fromScale(v254.X.Scale * 0.9, v254.Y.Scale * 0.9)
                    v250:Create(v251, v252, v253):Play()
                    v_u_18.new(function(p255, p256)
                        local v257 = v_u_9.getCurrentEquipped()
                        if v257 then
                            p255(v257)
                        else
                            p256("Failed to fetch current equipped")
                        end
                    end):catch(warn):andThen(function(p258)
                        if p258 then
                            if p258.Properties.HasScope then
                                p258:scope(true)
                                return
                            elseif p258.Properties.HasSuppressor then
                                if p258.IsSuppressed then
                                    p258:removeSuppressor()
                                else
                                    p258:addSuppressor()
                                end
                            elseif p258.Properties.ShootingOptions == "Burst" then
                                p258:updateFireMode()
                            end
                        else
                            return
                        end
                    end)
                end
            else
                return
            end
        end)
        v_u_29.Aim.InputEnded:Connect(v_u_248)
        v_u_29.Aim.InputChanged:Connect(function(p259)
            if p259 == v_u_32 and (p259.UserInputType == Enum.UserInputType.Touch and not v_u_36) then
                v_u_25.addTouchMove(Vector2.new(p259.Delta.X, p259.Delta.Y))
            end
        end)
        v_u_29.Interact.Active = true
        local v_u_260 = nil
        v_u_29.Interact.InputBegan:Connect(function(p261)
            if p261.UserInputType == Enum.UserInputType.Touch or p261.UserInputType == Enum.UserInputType.MouseButton1 then
                if v_u_36 or v_u_260 then
                    return
                elseif p261.UserInputState == Enum.UserInputState.Begin then
                    v_u_260 = p261
                    local v262 = v_u_29.Interact
                    if not v_u_38[v262] and p261.UserInputState == Enum.UserInputState.Begin then
                        v_u_38[v262] = p261
                    end
                    local v263 = v_u_2:GetTagged("Bomb")[1]
                    if v263 and (v263:GetAttribute("CanDefuse") and not v263:GetAttribute("Defused")) then
                        v_u_17.broadcastRouter("Start Defuse Bomb")
                        return
                    else
                        local v264 = v_u_49()
                        if v264 then
                            local v265 = v_u_23:GetAttribute("Team")
                            if not v_u_23:GetAttribute("IsCarryingHostage") and (not v_u_23:GetAttribute("IsRescuingHostage") and v265 == "Counter-Terrorists") then
                                local v266 = v264:GetAttribute("RescuingPlayer")
                                local v267 = v264:GetAttribute("CarryingPlayer")
                                if (not v266 or v266 == v_u_23.Name) and not v267 then
                                    v_u_17.broadcastRouter("Start Rescue Hostage")
                                    return
                                end
                            end
                        end
                        local v268 = v_u_2:GetTagged("IsHoveringInteractable")
                        if #v268 == 0 then
                            return
                        else
                            local v269 = v268[1]
                            local v270 = v269:GetAttribute("Weapon")
                            local v271 = v269:GetAttribute("Skin")
                            if v270 ~= "C4" or v_u_23:GetAttribute("Team") == "Terrorists" then
                                if v269:GetAttribute("CanPickup") then
                                    local v272 = v_u_12.GetSkinInformation(v270, v271)
                                    if v272 then
                                        local v273 = v_u_22[v272.rarity]
                                        local v274 = v273.Color.R * 255
                                        local v275 = math.floor(v274)
                                        local v276 = v273.Color.G * 255
                                        local v277 = math.floor(v276)
                                        local v278 = v273.Color.B * 255
                                        local v279 = math.floor(v278)
                                        v_u_17.broadcastRouter("CreateNotification", "Item Picked Up", ("You picked up a <font color = \"rgb(%*, %*, %*)\"><b>%* | %*</b></font>"):format(v275, v277, v279, v270, v271), 2)
                                    end
                                    v_u_16.Inventory.PickupWeapon.Send({
                                        ["Identity"] = v269.Name
                                    })
                                end
                            end
                        end
                    end
                else
                    return
                end
            else
                return
            end
        end)
        local function v_u_282(p280)
            if p280 == v_u_260 then
                v_u_260 = nil
                local v281 = v_u_29.Interact
                if v_u_38[v281] == p280 then
                    v_u_38[v281] = nil
                end
                if v_u_2:GetTagged("Bomb")[1] and v_u_23:GetAttribute("IsDefusingBomb") then
                    v_u_17.broadcastRouter("Cancel Defuse Bomb")
                    return
                elseif v_u_23:GetAttribute("IsRescuingHostage") then
                    v_u_17.broadcastRouter("Cancel Rescue Hostage")
                end
            else
                return
            end
        end
        v_u_29.Interact.InputEnded:Connect(v_u_282)
        v_u_29.Interact.InputChanged:Connect(function(p283)
            if p283 == v_u_260 and (p283.UserInputType == Enum.UserInputType.Touch and not v_u_36) then
                v_u_25.addTouchMove(Vector2.new(p283.Delta.X, p283.Delta.Y))
            end
        end)
        local v_u_284 = v_u_29.Shop.Size
        v_u_29.Shop.InputBegan:Connect(function(p285)
            if p285.UserInputType == Enum.UserInputType.Touch or p285.UserInputType == Enum.UserInputType.MouseButton1 then
                if not v_u_36 and p285.UserInputState == Enum.UserInputState.Begin then
                    local v286 = v_u_29.Shop
                    if not v_u_38[v286] and p285.UserInputState == Enum.UserInputState.Begin then
                        v_u_38[v286] = p285
                    end
                    if v_u_38[v_u_29.Shop] == p285 then
                        local v287 = v_u_5
                        local v288 = v_u_29.Shop
                        local v289 = v_u_39
                        local v290 = {}
                        local v291 = v_u_284
                        v290.Size = UDim2.fromScale(v291.X.Scale * 0.9, v291.Y.Scale * 0.9)
                        v287:Create(v288, v289, v290):Play()
                    end
                end
            end
        end)
        v_u_29.Shop.InputEnded:Connect(function(p292)
            if p292.UserInputType == Enum.UserInputType.Touch or p292.UserInputType == Enum.UserInputType.MouseButton1 then
                local v293 = v_u_5
                local v294 = v_u_29.Shop
                local v295 = v_u_39
                local v296 = {}
                local v297 = v_u_284
                v296.Size = UDim2.fromScale(v297.X.Scale * 1, v297.Y.Scale * 1)
                v293:Create(v294, v295, v296):Play()
                if not v_u_36 then
                    local v298 = v_u_38[v_u_29.Shop]
                    local v299
                    if v298 then
                        v299 = (not p292 or p292 == v298) and true or false
                    else
                        v299 = false
                    end
                    if v299 then
                        local v300 = v_u_29.Shop
                        if v_u_38[v300] == p292 then
                            v_u_38[v300] = nil
                        end
                        v_u_20.toggleFrame()
                        return
                    end
                end
                local v301 = v_u_29.Shop
                if v_u_38[v301] == p292 then
                    v_u_38[v301] = nil
                end
            end
        end)
        local v_u_302 = v_u_29.Menu.Size
        v_u_29.Menu.InputBegan:Connect(function(p303)
            if p303.UserInputType == Enum.UserInputType.Touch or p303.UserInputType == Enum.UserInputType.MouseButton1 then
                if not v_u_36 and p303.UserInputState == Enum.UserInputState.Begin then
                    local v304 = v_u_29.Menu
                    if not v_u_38[v304] and p303.UserInputState == Enum.UserInputState.Begin then
                        v_u_38[v304] = p303
                    end
                    if v_u_38[v_u_29.Menu] == p303 then
                        local v305 = v_u_5
                        local v306 = v_u_29.Menu
                        local v307 = v_u_39
                        local v308 = {}
                        local v309 = v_u_302
                        v308.Size = UDim2.fromScale(v309.X.Scale * 0.9, v309.Y.Scale * 0.9)
                        v305:Create(v306, v307, v308):Play()
                    end
                end
            end
        end)
        v_u_29.Menu.InputEnded:Connect(function(p310)
            if p310.UserInputType == Enum.UserInputType.Touch or p310.UserInputType == Enum.UserInputType.MouseButton1 then
                local v311 = v_u_5
                local v312 = v_u_29.Menu
                local v313 = v_u_39
                local v314 = {}
                local v315 = v_u_302
                v314.Size = UDim2.fromScale(v315.X.Scale * 1, v315.Y.Scale * 1)
                v311:Create(v312, v313, v314):Play()
                if not v_u_36 then
                    local v316 = v_u_38[v_u_29.Menu]
                    local v317
                    if v316 then
                        v317 = (not p310 or p310 == v316) and true or false
                    else
                        v317 = false
                    end
                    if v317 then
                        local v318 = v_u_29.Menu
                        if v_u_38[v318] == p310 then
                            v_u_38[v318] = nil
                        end
                        v_u_21.ToggleMenu()
                        return
                    end
                end
                local v319 = v_u_29.Menu
                if v_u_38[v319] == p310 then
                    v_u_38[v319] = nil
                end
            end
        end)
        local v_u_320 = v_u_29.SwapTeam.Size
        v_u_29.SwapTeam.InputBegan:Connect(function(p321)
            if p321.UserInputType == Enum.UserInputType.Touch or p321.UserInputType == Enum.UserInputType.MouseButton1 then
                if not v_u_36 and p321.UserInputState == Enum.UserInputState.Begin then
                    local v322 = v_u_29.SwapTeam
                    if not v_u_38[v322] and p321.UserInputState == Enum.UserInputState.Begin then
                        v_u_38[v322] = p321
                    end
                    if v_u_38[v_u_29.SwapTeam] == p321 then
                        local v323 = v_u_5
                        local v324 = v_u_29.SwapTeam
                        local v325 = v_u_39
                        local v326 = {}
                        local v327 = v_u_320
                        v326.Size = UDim2.fromScale(v327.X.Scale * 0.9, v327.Y.Scale * 0.9)
                        v323:Create(v324, v325, v326):Play()
                    end
                end
            end
        end)
        v_u_29.SwapTeam.InputEnded:Connect(function(p328)
            if p328.UserInputType == Enum.UserInputType.Touch or p328.UserInputType == Enum.UserInputType.MouseButton1 then
                local v329 = v_u_5
                local v330 = v_u_29.SwapTeam
                local v331 = v_u_39
                local v332 = {}
                local v333 = v_u_320
                v332.Size = UDim2.fromScale(v333.X.Scale * 1, v333.Y.Scale * 1)
                v329:Create(v330, v331, v332):Play()
                if not v_u_36 then
                    local v334 = v_u_38[v_u_29.SwapTeam]
                    local v335
                    if v334 then
                        v335 = (not p328 or p328 == v334) and true or false
                    else
                        v335 = false
                    end
                    if v335 then
                        local v336 = v_u_29.SwapTeam
                        if v_u_38[v336] == p328 then
                            v_u_38[v336] = nil
                        end
                        if v_u_23:GetAttribute("IsSpectating") then
                            v_u_19.openFrame()
                            return
                        elseif v_u_23.Character then
                            v_u_19.ToggleTeamSelection()
                        end
                    end
                end
                local v337 = v_u_29.SwapTeam
                if v_u_38[v337] == p328 then
                    v_u_38[v337] = nil
                end
            end
        end)
        v_u_29.Configure.InputBegan:Connect(function(p338)
            if p338.UserInputType == Enum.UserInputType.Touch or p338.UserInputType == Enum.UserInputType.MouseButton1 then
                local v339 = v_u_29.Configure
                if not v_u_38[v339] and p338.UserInputState == Enum.UserInputState.Begin then
                    v_u_38[v339] = p338
                end
            end
        end)
        v_u_29.Configure.InputEnded:Connect(function(p340)
            if p340.UserInputType == Enum.UserInputType.Touch or p340.UserInputType == Enum.UserInputType.MouseButton1 then
                local v341 = v_u_38[v_u_29.Configure]
                local v342
                if v341 then
                    v342 = (not p340 or p340 == v341) and true or false
                else
                    v342 = false
                end
                if v342 then
                    local v343 = v_u_29.Configure
                    if v_u_38[v343] == p340 then
                        v_u_38[v343] = nil
                    end
                    if v_u_36 then
                        v_u_64()
                    else
                        v_u_62()
                    end
                else
                    local v344 = v_u_29.Configure
                    if v_u_38[v344] == p340 then
                        v_u_38[v344] = nil
                    end
                    return
                end
            else
                return
            end
        end)
        local v_u_345 = v_u_260
        for _, v346 in ipairs(v_u_29:GetChildren()) do
            if v346:IsA("TextButton") then
                if v346.Name ~= "Shoot" and v346.Name ~= "Aim" then
                    v_u_1.setupButton(v346)
                end
                if v346.Name ~= "Configure" then
                    v_u_1.setupDraggableButton(v346)
                end
            end
        end
        v_u_6.Heartbeat:Connect(function()
            local _ = v_u_23:GetAttribute("IsSpectating") == true
            local v347 = v_u_29.Shop
            local v348 = v_u_23:GetAttribute("BuyMenu")
            if v348 then
                v348 = v_u_14(v_u_23)
            end
            v347.Visible = v348
            v_u_53()
            if v_u_11.IsLocalPlayerDead() then
                v_u_29.Reload.Visible = false
            else
                local v349 = v_u_9.getCurrentEquipped()
                if v349 then
                    if v349.Properties.Class == "Weapon" then
                        v_u_29.Reload.Visible = true
                    else
                        v_u_29.Reload.Visible = false
                    end
                else
                    v_u_29.Reload.Visible = false
                end
            end
            v_u_55()
            local v350 = v_u_9.getCurrentEquipped()
            if v350 then
                local v351 = v350.Properties.ShootingOptions == "Burst"
                local v352 = v350.Properties.HasSuppressor == true
                local v353 = v350.Properties.HasScope == true
                v_u_29.Aim.Visible = v353 or (v352 or v351)
            else
                v_u_29.Aim.Visible = false
            end
        end)
        v_u_4.InputChanged:Connect(function(p354)
            if (p354 == v_u_30 or (p354 == v_u_32 or p354 == v_u_345)) and not v_u_36 then
                v_u_25.addTouchMove(Vector2.new(p354.Delta.X, p354.Delta.Y))
            end
            v_u_106(p354)
        end)
        v_u_4.InputEnded:Connect(function(p355)
            if p355.UserInputType == Enum.UserInputType.Touch or p355.UserInputType == Enum.UserInputType.MouseButton1 then
                v_u_224(p355, true)
                v_u_248(p355, true)
                v_u_282(p355)
                for v356, v357 in pairs(v_u_38) do
                    if v357 == p355 then
                        v_u_38[v356] = nil
                    end
                end
            end
            if p355.UserInputType == Enum.UserInputType.Touch and true or p355.UserInputType == Enum.UserInputType.MouseButton1 then
                if not v_u_36 then
                    return
                end
                if v_u_33 then
                    v_u_35 = nil
                    v_u_33 = nil
                    return
                end
                if v_u_34 then
                    v_u_31 = nil
                    v_u_37 = nil
                    v_u_34 = nil
                    return
                end
            end
        end)
    else
        v_u_29.Visible = false
    end
end
function v_u_1.Start()
    v_u_29.Visible = false
    v_u_23.CharacterAdded:Connect(function()
        local v358 = v_u_23:GetAttribute("IsSpectating") == true
        v_u_29.Visible = v_u_28
        if v358 then
            return
        elseif v_u_29 then
            for _, v359 in ipairs(v_u_41) do
                local v360 = v_u_29:FindFirstChild(v359)
                if v360 then
                    v360.Visible = v359 ~= "Configure"
                end
            end
        end
    end)
    v_u_23.CharacterRemoving:Connect(function()
        local v361 = v_u_23:GetAttribute("IsSpectating") == true
        v_u_32 = nil
        if v361 and v_u_28 then
            if v_u_29 then
                for _, v362 in ipairs(v_u_41) do
                    local v363 = v_u_29:FindFirstChild(v362)
                    if v363 then
                        v363.Visible = table.find(v_u_40, v362) ~= nil
                    end
                end
            end
            v_u_29.Visible = true
        else
            v_u_29.Visible = false
        end
    end)
    v_u_23:GetAttributeChangedSignal("IsSpectating"):Connect(function()
        local v364 = v_u_23:GetAttribute("IsSpectating") == true
        if v_u_28 then
            if v364 then
                if v_u_29 then
                    for _, v365 in ipairs(v_u_41) do
                        local v366 = v_u_29:FindFirstChild(v365)
                        if v366 then
                            v366.Visible = table.find(v_u_40, v365) ~= nil
                        end
                    end
                end
                v_u_29.Visible = true
                return
            elseif v_u_23.Character then
                if v_u_29 then
                    for _, v367 in ipairs(v_u_41) do
                        local v368 = v_u_29:FindFirstChild(v367)
                        if v368 then
                            v368.Visible = v367 ~= "Configure"
                        end
                    end
                end
                v_u_29.Visible = true
            else
                v_u_29.Visible = false
            end
        elseif not v364 then
            v_u_29.Visible = false
        end
    end)
    if v_u_28 then
        if v_u_23:GetAttribute("IsSpectating") == true then
            if v_u_29 then
                for _, v369 in ipairs(v_u_41) do
                    local v370 = v_u_29:FindFirstChild(v369)
                    if v370 then
                        v370.Visible = table.find(v_u_40, v369) ~= nil
                    end
                end
            end
            v_u_29.Visible = true
            return
        end
        if v_u_23.Character then
            if v_u_29 then
                for _, v371 in ipairs(v_u_41) do
                    local v372 = v_u_29:FindFirstChild(v371)
                    if v372 then
                        v372.Visible = v371 ~= "Configure"
                    end
                end
            end
            v_u_29.Visible = true
            return
        end
    end
    v_u_10.CreateListener(v_u_23, "MobileButtons", function(p373)
        if not v_u_36 then
            for v374, v375 in pairs(p373) do
                local v376 = v_u_29:FindFirstChild(v374)
                if v376 then
                    v376.Position = UDim2.fromScale(v375.Position.X, v375.Position.Y)
                    v376.Size = UDim2.fromScale(v375.Size.X, v375.Size.Y)
                end
            end
        end
    end)
end
return v_u_1