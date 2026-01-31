local v_u_1 = {}
v_u_1.__index = v_u_1
local v2 = game:GetService("ReplicatedStorage")
local v_u_3 = game:GetService("HttpService")
game:GetService("RunService")
local v4 = game:GetService("Players")
require(script:WaitForChild("Types"))
local v_u_5 = v4.LocalPlayer
local v_u_6 = require(v2.Controllers.CameraController)
local v_u_7 = require(v2.Controllers.DataController)
local v_u_8 = require(v2.Database.Custom.Constants)
local v_u_9 = require(v2.Database.Components.Common.RemoveFromArray)
local v_u_10 = require(v2.Components.Common.VFXLibary.CreateMuzzleFlash.Camera)
local v_u_11 = require(v2.Components.Common.VFXLibary.CreateTracer)
local v_u_12 = require(v2.Classes.WeaponComponent)
local v_u_13 = require(v2.Classes.Freecam)
local v_u_14 = require(v2.Components.Weapon.Classes.Bullet)
local v_u_15 = require(v2.Shared.Janitor)
local v_u_16 = require(v2.Packages.Signal)
local v_u_17 = require(v2.Shared.Spring)
local v_u_18 = require(v2.Packages.Sift)
local v_u_19 = require(v2.Database.Security.Remotes)
local v_u_20 = workspace:WaitForChild("Characters")
local v_u_21 = workspace:WaitForChild("Debris")
local v_u_22 = workspace.CurrentCamera
local v_u_23 = RaycastParams.new()
v_u_23.FilterType = Enum.RaycastFilterType.Exclude
v_u_23.IgnoreWater = true
local v_u_24 = {
    ["Heavy Swing"] = true,
    ["BackStab"] = true,
    ["Swing1"] = true,
    ["Swing2"] = true,
    ["Inspect"] = true,
    ["Reload"] = true,
    ["Throw"] = true,
    ["Use"] = true
}
local v_u_25 = {
    ["NoSuppressorShoot"] = true,
    ["ShootRight"] = true,
    ["ShootLeft"] = true,
    ["Shoot"] = true
}
local function v_u_34(p26, p27)
    if p27:IsA("BasePart") then
        local v28 = p26.Transparencies[p27] or {
            ["Transparency"] = p27.Transparency,
            ["Textures"] = {}
        }
        for _, v29 in ipairs(p27:GetChildren()) do
            if v29:IsA("Texture") and not table.find(v28.Textures, v29) then
                local v30 = v28.Textures
                table.insert(v30, v29)
                v29.Parent = nil
            end
        end
        if p27.Transparency < 1 then
            p27.Transparency = 1
        end
        p26.Transparencies[p27] = v28
    elseif p27:IsA("Texture") then
        local v31 = p27.Parent
        if v31 and v31:IsA("BasePart") then
            local v32 = p26.Transparencies[v31] or {
                ["Transparency"] = v31.Transparency,
                ["Textures"] = {}
            }
            if not table.find(v32.Textures, p27) then
                local v33 = v32.Textures
                table.insert(v33, p27)
            end
            p27.Parent = nil
            p26.Transparencies[v31] = v32
            return
        end
    elseif p27:IsA("BillboardGui") then
        p27.Enabled = false
    end
end
function v_u_1.UpdateCameraCFrame(p35, p36)
    if not (p35.CameraPositionSpring and p35.CameraRotationSpring) then
        p35.CameraRotationSpring = v_u_17.new(1, 35, p36.LookVector)
        p35.CameraPositionSpring = v_u_17.new(1, 35, p36.Position)
    end
    p35.CameraRotationSpring:setGoal(p36.LookVector)
    p35.CameraPositionSpring:setGoal(p36.Position)
end
function v_u_1.UpdateSuppressorState(p37, p38)
    local v39 = p38.Viewmodel.Model:FindFirstChild("Silencer", true)
    if v39 and p38.Properties.HasSuppressor then
        v39.Transparency = p37.CurrentEquipped.IsSuppressed and 0 or 1
    end
end
function v_u_1.UpdateSuppressor(p40)
    if p40.WeaponComponent and p40.WeaponComponent.Viewmodel then
        local v_u_41 = p40.WeaponComponent.Viewmodel.Model:FindFirstChild("Silencer", true)
        if v_u_41 then
            local v44 = table.freeze({
                {
                    ["AnimationTrack"] = p40.WeaponComponent.Viewmodel.Animation:getAnimation("RemoveSuppressor"),
                    ["State"] = false,
                    ["Event"] = function(p42)
                        return p42:GetMarkerReachedSignal("ScrewOnEnd"):Connect(function()
                            v_u_41.Transparency = 1
                        end)
                    end
                },
                {
                    ["AnimationTrack"] = p40.WeaponComponent.Viewmodel.Animation:getAnimation("AddSuppressor"),
                    ["State"] = true,
                    ["Event"] = function(p_u_43)
                        return p_u_43:GetPropertyChangedSignal("IsPlaying"):Connect(function()
                            if p_u_43.IsPlaying then
                                task.delay(0.016666666666666666, function()
                                    v_u_41.Transparency = 0
                                end)
                            end
                        end)
                    end
                }
            })
            for _, v_u_45 in ipairs(v44) do
                if p40.WeaponComponent and p40.WeaponComponent.Janitor then
                    p40.WeaponComponent.Janitor:Add(v_u_45.Event(v_u_45.AnimationTrack))
                    p40.WeaponComponent.Janitor:Add(v_u_45.AnimationTrack.Ended:Connect(function()
                        if v_u_41.Transparency < 1 == v_u_45.State then
                            v_u_41.Transparency = v_u_45.State and 0 or 1
                        end
                    end))
                end
            end
            p40:UpdateSuppressorState(p40.WeaponComponent)
        end
    else
        return
    end
end
function v_u_1.Switch(p46, p47)
    if p46.Humanoid and p46.Humanoid.Health > 0 then
        p46.PerspectiveState = p47
        if p46.FreecamInstance then
            p46.FreecamInstance:Stop()
            p46.FreecamInstance:Destroy()
            p46.FreecamInstance = nil
        end
        if p46.PerspectiveState == "First-Person" then
            p46.TransparencyState = true
            p46:SetCharacterTransparency(p46.TransparencyState)
            v_u_22.CameraType = Enum.CameraType.Scriptable
            v_u_22.CameraSubject = p46.Humanoid
            if p46.CurrentEquipped then
                p46:SetEquipped(p46.CurrentEquipped, false)
            end
            p46:UpdateScopeState()
            v_u_6.setPerspective(true, false)
        elseif p46.PerspectiveState == "Third-Person" then
            p46.TransparencyState = false
            p46:SetCharacterTransparency(p46.TransparencyState)
            v_u_22.CameraType = Enum.CameraType.Follow
            v_u_22.CameraSubject = p46.Humanoid
            if p46.WeaponComponent then
                p46.WeaponComponent.Janitor:Destroy()
                p46.WeaponComponent = nil
            end
            v_u_6.updateCameraFOV(v_u_8.DEFAULT_CAMERA_FOV)
            v_u_6.setPerspective(false, false)
        elseif p46.PerspectiveState == "Free-Cam" then
            p46.TransparencyState = false
            p46:SetCharacterTransparency(p46.TransparencyState)
            if p46.WeaponComponent then
                p46.WeaponComponent.Janitor:Destroy()
                p46.WeaponComponent = nil
            end
            v_u_6.updateCameraFOV(v_u_8.DEFAULT_CAMERA_FOV)
            if not p46.FreecamInstance then
                p46.FreecamInstance = p46.Janitor:Add(v_u_13.new())
            end
            if p46.FreecamInstance then
                p46.FreecamInstance:Start()
            end
        end
        v_u_19.Spectate.SetSpectatePerspective.Send(p46.PerspectiveState)
    end
end
function v_u_1.SetEquipped(p48, p49, p50)
    local v51 = p48.WeaponComponent
    if v51 then
        v51 = p48.WeaponComponent.Identifier
    end
    p48.CurrentEquipped = p49
    if v51 == p49.Identifier then
        p48:UpdateSuppressorState(p48.WeaponComponent)
    else
        if p48.WeaponComponent then
            p48:SetWeaponViewmodelTransparency(false)
            p48.WeaponComponent.Janitor:Destroy()
            p48.WeaponComponent = nil
        end
        if p48.CurrentEquipped and p48.PerspectiveState == "First-Person" then
            local v52 = v_u_12.new(p48.Player, p48.CurrentEquipped.Identifier, p48.CurrentEquipped._id, 1, p48.CurrentEquipped.Name, p48.CurrentEquipped.Skin, p48.CurrentEquipped.Float, p48.CurrentEquipped.StatTrack, p48.CurrentEquipped.NameTag, p48.CurrentEquipped.Charm, p48.CurrentEquipped.Stickers)
            if v52.Properties and v52.Properties.Spread then
                v52.Bullet = v_u_14.new(v52, v52.Properties)
            end
            p48.WeaponComponent = v52
            p48.TransparencyState = true
            p48:SetCharacterTransparency(p48.TransparencyState)
            if p48.WeaponComponent and p48.WeaponComponent.Viewmodel then
                p48.WeaponComponent.Viewmodel:equip(not p50)
                if p48.WeaponComponent.Properties.HasSuppressor then
                    p48:UpdateSuppressor()
                end
            end
            p48:UpdateScopeState()
        end
        p48.CurrentEquippedChanged:Fire(p48.CurrentEquipped)
    end
end
function v_u_1.UpdateScopeState(p53)
    if p53.PerspectiveState == "First-Person" then
        if p53.CurrentEquipped then
            local v54 = p53.CurrentEquipped.Name
            local v55 = v54 == "AWP" and true or v54 == "SSG 08"
            local v56 = v54 == "AUG" and true or v54 == "SG 553"
            local v57 = p53.Player:GetAttribute("ScopeIncrement") or 0
            local v58 = v57 > 0
            if v55 then
                if p53.WeaponComponent and (p53.WeaponComponent.Viewmodel and p53.WeaponComponent.Viewmodel.Bobble) then
                    local v59 = p53.WeaponComponent.Viewmodel.Bobble.ScopeReticlePart
                    local v60 = v59 and v59:FindFirstChildOfClass("SurfaceGui")
                    if v60 then
                        v60.Enabled = false
                    end
                end
                if v58 and v57 <= 2 then
                    v_u_6.updateCameraFOV(v_u_8.DEFAULT_CAMERA_FOV - ({ 37, 60 })[v57])
                    if p53.WeaponComponent and p53.WeaponComponent.Viewmodel then
                        p53:SetWeaponViewmodelTransparency(true)
                        return
                    end
                else
                    v_u_6.updateCameraFOV(v_u_8.DEFAULT_CAMERA_FOV)
                    if p53.WeaponComponent and p53.WeaponComponent.Viewmodel then
                        p53:SetWeaponViewmodelTransparency(false)
                        return
                    end
                end
            elseif v56 then
                local v61 = p53.WeaponComponent
                if v61 then
                    v61 = p53.WeaponComponent.Viewmodel
                end
                if v61 then
                    if v58 then
                        if not v61.Hidden then
                            v61:hide()
                        end
                        if v61.Bobble and (v61.Bobble.Scope and v61.Bobble.ScopeReticlePart) then
                            v61:aim()
                        end
                        v_u_6.updateCameraFOV(v_u_8.DEFAULT_CAMERA_FOV - 15)
                    else
                        if v61.Hidden then
                            v61:unhide()
                        end
                        if v61.Bobble and (v61.Bobble.Scope and v61.Bobble.ScopeReticlePart) then
                            v61:unaim()
                        end
                        v_u_6.updateCameraFOV(v_u_8.DEFAULT_CAMERA_FOV)
                    end
                end
            else
                v_u_6.updateCameraFOV(v_u_8.DEFAULT_CAMERA_FOV)
                if p53.WeaponComponent and p53.WeaponComponent.Viewmodel then
                    p53:SetWeaponViewmodelTransparency(false)
                end
            end
        end
    else
        return
    end
end
function v_u_1.SetWeaponViewmodelTransparency(p62, p63)
    if p62.WeaponComponent and (p62.WeaponComponent.Viewmodel and p62.WeaponComponent.Viewmodel.Model) then
        local v64 = p62.WeaponComponent.Viewmodel.Model
        if not p62.WeaponTransparencyCache then
            p62.WeaponTransparencyCache = {}
        end
        for _, v65 in ipairs(v64:GetDescendants()) do
            if v65:IsA("BasePart") and (v65.Name ~= "Right Arm" and (v65.Name ~= "Left Arm" and (v65.Name ~= "HumanoidRootPart" and v65.Name ~= "ViewmodelLight"))) then
                if p63 then
                    if not p62.WeaponTransparencyCache[v65] then
                        p62.WeaponTransparencyCache[v65] = v65.Transparency
                    end
                    v65.Transparency = 1
                else
                    local v66 = p62.WeaponTransparencyCache[v65]
                    if v66 ~= nil then
                        v65.Transparency = v66
                        p62.WeaponTransparencyCache[v65] = nil
                    end
                end
            end
        end
    end
end
function v_u_1.HideDebrisWeapons(p67)
    if p67.TransparencyState then
        local v68 = p67.Player.Name
        local v69 = v_u_21:FindFirstChild(v68 .. "_Weapon")
        if v69 then
            for _, v70 in ipairs(v69:GetDescendants()) do
                v_u_34(p67, v70)
            end
        end
        local v71 = v_u_21:FindFirstChild(v68 .. "_WeaponAttachments")
        if v71 then
            for _, v72 in ipairs(v71:GetDescendants()) do
                v_u_34(p67, v72)
            end
        end
    end
end
function v_u_1.SetCharacterTransparency(p_u_73, p74)
    local v75 = p_u_73.Character:GetDescendants()
    local function v_u_79(p76)
        for _, v77 in ipairs(p76:GetDescendants()) do
            v_u_34(p_u_73, v77)
        end
        if p_u_73.TransparencyJanitor then
            p_u_73.TransparencyJanitor:Add(p76.DescendantAdded:Connect(function(p78)
                if p_u_73.TransparencyState then
                    v_u_34(p_u_73, p78)
                end
            end))
        end
    end
    if p74 then
        if not p_u_73.TransparencyJanitor then
            local v80 = p_u_73.Janitor:Add(v_u_15.new())
            p_u_73.TransparencyJanitor = v80
            v80:Add(p_u_73.Character.DescendantAdded:Connect(function(p81)
                if p_u_73.TransparencyState then
                    v_u_34(p_u_73, p81)
                end
            end))
            v80:Add(v_u_21.ChildAdded:Connect(function(p82)
                if p_u_73.TransparencyState then
                    local v83 = p_u_73.Player.Name
                    if p82.Name == v83 .. "_Weapon" or p82.Name == v83 .. "_WeaponAttachments" then
                        v_u_79(p82)
                    end
                end
            end))
        end
        for _, v84 in ipairs(v75) do
            v_u_34(p_u_73, v84)
        end
        local v85 = p_u_73.Player.Name
        local v86 = v_u_21:FindFirstChild(v85 .. "_Weapon")
        if v86 then
            v_u_79(v86)
        end
        local v87 = v_u_21:FindFirstChild(v85 .. "_WeaponAttachments")
        if v87 then
            v_u_79(v87)
            return
        end
    else
        if p_u_73.TransparencyJanitor then
            p_u_73.TransparencyJanitor:Destroy()
            p_u_73.TransparencyJanitor = nil
        end
        for v_u_88, v89 in pairs(p_u_73.Transparencies) do
            if v_u_88 and v_u_88.Parent then
                v_u_88.Transparency = v89.Transparency
                v_u_9(v89.Textures, function(_, p90)
                    p90.Parent = v_u_88
                    return true
                end)
            end
        end
        for _, v91 in ipairs(v75) do
            if v91:IsA("BillboardGui") then
                v91.Enabled = true
            end
        end
    end
end
function v_u_1.AddSpectateEvent(p92, p93)
    if p92.WeaponComponent and p92.WeaponComponent.Viewmodel then
        local v94 = p92.WeaponComponent.Viewmodel
        if v94 then
            v94 = p92.WeaponComponent.Viewmodel.Animation
        end
        if v_u_25[p93] then
            v_u_23.FilterDescendantsInstances = { p92.Player.Character, v_u_22, v_u_21 }
            local v95 = p92.WeaponComponent
            if v95 and v95.Bullet then
                local v96 = v95.Properties.AimingOptions
                local v97 = v95.IsAiming
                if v95.Bullet._updateShotSpread then
                    v95.Bullet:_updateShotSpread(v96, v97)
                end
            end
            v94:stopAnimations()
            v94:play(p93)
            v94:play("Idle")
            local v98 = workspace:Raycast(v_u_22.CFrame.Position, v_u_22.CFrame.LookVector * p92.WeaponComponent.Properties.Range, v_u_23)
            local v99 = v98 and v98.Distance or p92.WeaponComponent.Properties.Range
            if p92.WeaponComponent.Viewmodel.Model.Interactables:FindFirstChild("MuzzlePart") then
                v_u_11(v99, p92.WeaponComponent.Viewmodel.Model.Interactables.MuzzlePart.Position, v_u_22.CFrame.LookVector)
                if v_u_7.Get(v_u_5, "Settings.Video.Presets.Muzzle Flash") ~= false then
                    v_u_10(p92.WeaponComponent.Viewmodel.Model.Interactables.MuzzlePart, p92.WeaponComponent.Name, p92.WeaponComponent.Properties.HasSuppressor and p92.CurrentEquipped.IsSuppressed and "Suppressor" or nil)
                    return
                end
            end
        else
            if p93 == "Remove Suppressor" or p93 == "Add Suppressor" then
                v94:stopAnimations()
                v94:play(string.gsub(p93, " ", ""))
                v94:play("Idle")
                return
            end
            if p93 == "Cancel Plant" then
                v94:stopAnimations()
                v94:play("Idle")
                return
            end
            if p93 == "Switch Fire Mode" then
                v94:stopAnimations()
                v94:play("Switch")
                v94:play("Idle")
                return
            end
            if v_u_24[p93] then
                v94:stopAnimations()
                v94:play(p93)
                v94:play("Idle")
            end
        end
    end
end
local function v_u_117(p100, p101)
    if p100.PerspectiveState == "First-Person" then
        if p100.CurrentEquipped then
            local v102 = p100.CurrentEquipped.Name
            if v102 == "AUG" and true or v102 == "SG 553" then
                if (p100.Player:GetAttribute("ScopeIncrement") or 0) > 0 then
                    if p100.WeaponComponent and p100.WeaponComponent.Viewmodel then
                        local v103 = p100.WeaponComponent.Viewmodel
                        if v103.Bobble and v103.Bobble.IsAiming then
                            local v104 = p100.WeaponComponent
                            if v104 and v104.Bullet then
                                local v105 = v104.Bullet:getBaseSpread() or 0
                                local v106 = v105 - (p100.LastSpreadValue or 0)
                                local v107 = math.abs(v106)
                                local v108 = (p100.LastScopeUpdateTime or 0) + p101
                                if v107 < 0.01 and v108 < 0.03333333333333333 then
                                    p100.LastScopeUpdateTime = v108
                                    return
                                else
                                    p100.LastScopeUpdateTime = 0
                                    p100.LastSpreadValue = v105
                                    local v109 = v103.Bobble.ScopeReticlePart
                                    if v109 then
                                        local v110 = p100.ScopeUICache
                                        if v110 and v110.SurfaceGui == v109 then
                                            local v111 = v110.Crosshair
                                            if v111 and v111.Parent then
                                                local v112 = math.clamp(v105, 0, 2) * 2
                                                v111.Size = UDim2.fromScale(v112 + 2.5, v112 + 2.5)
                                                v111.Position = UDim2.fromScale(0.5, 0.5)
                                                return
                                            end
                                            p100.ScopeUICache = nil
                                        end
                                        local v113 = v109:FindFirstChildOfClass("SurfaceGui")
                                        if v113 then
                                            local v114 = v113:FindFirstChild("Frame")
                                            if v114 then
                                                local v115 = v114:FindFirstChild("Frame")
                                                if v115 then
                                                    p100.ScopeUICache = {
                                                        ["Crosshair"] = v115,
                                                        ["SurfaceGui"] = v113,
                                                        ["Frame"] = v114
                                                    }
                                                    local v116 = math.clamp(v105, 0, 2) * 2
                                                    v115.Size = UDim2.fromScale(v116 + 2.5, v116 + 2.5)
                                                    v115.Position = UDim2.fromScale(0.5, 0.5)
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
function v_u_1.Render(p118, p119)
    if p118.PerspectiveState ~= "Free-Cam" then
        if p118.CameraPositionSpring and p118.CameraRotationSpring then
            p118.CameraPositionSpring:update(p119)
            p118.CameraRotationSpring:update(p119)
            if p118.PerspectiveState == "First-Person" then
                v_u_22.CFrame = CFrame.lookAt(p118.CameraPositionSpring:getPosition(), p118.CameraPositionSpring:getPosition() + p118.CameraRotationSpring:getPosition())
                if p118.WeaponComponent and p118.WeaponComponent.Viewmodel then
                    p118.WeaponComponent.Viewmodel:render(p119)
                end
                local v120 = p118.WeaponComponent
                if v120 and (v120.Bullet and v120.Bullet.updateSpread) then
                    v120.Bullet:updateSpread(p119)
                end
                v_u_117(p118, p119)
            end
        end
    end
end
function v_u_1.new(p121, p122, p123)
    local v124 = v_u_1
    local v_u_125 = setmetatable({}, v124)
    v_u_125.Janitor = v_u_15.new()
    v_u_125.CurrentEquippedChanged = v_u_125.Janitor:Add(v_u_16.new())
    v_u_125.StopSpectating = v_u_125.Janitor:Add(v_u_16.new())
    v_u_125.Humanoid = p123
    v_u_125.Character = p122
    v_u_125.Player = p121
    v_u_125.CurrentPlayerTeam = p121:GetAttribute("Team")
    v_u_125.PerspectiveState = "First-Person"
    v_u_125.TransparencyState = true
    v_u_125.FreecamInstance = nil
    v_u_125.Transparencies = {}
    v_u_125.TransparencyJanitor = nil
    v_u_125.WeaponTransparencyCache = {}
    v_u_125.ScopeUICache = nil
    v_u_125.LastScopeUpdateTime = 0
    v_u_125.LastSpreadValue = 0
    v_u_125:SetCharacterTransparency(v_u_125.TransparencyState)
    v_u_125:Switch(v_u_125.PerspectiveState)
    v_u_5.ReplicationFocus = v_u_125.Humanoid
    v_u_125.Janitor:Add(function()
        v_u_5.ReplicationFocus = nil
    end)
    if v_u_125.Player:GetAttribute("CurrentEquipped") then
        v_u_125:SetEquipped(v_u_3:JSONDecode((v_u_125.Player:GetAttribute("CurrentEquipped"))), false)
    end
    v_u_125.Janitor:Add(v_u_125.Player:GetAttributeChangedSignal("CurrentEquipped"):Connect(function()
        local v126 = v_u_125.Player:GetAttribute("CurrentEquipped")
        if v126 then
            v_u_125:SetEquipped(v_u_3:JSONDecode(v126), true)
            task.defer(function()
                if v_u_125.TransparencyState and v_u_125.PerspectiveState == "First-Person" then
                    v_u_125:HideDebrisWeapons()
                end
            end)
        end
    end))
    if v_u_125.Character:GetAttribute("CameraCFrame") then
        v_u_125:UpdateCameraCFrame((v_u_125.Character:GetAttribute("CameraCFrame")))
    end
    v_u_125.Janitor:Add(v_u_125.Character:GetAttributeChangedSignal("CameraCFrame"):Connect(function()
        v_u_125:UpdateCameraCFrame((v_u_125.Character:GetAttribute("CameraCFrame")))
    end))
    if v_u_125.Player:GetAttribute("ScopeIncrement") then
        v_u_125:UpdateScopeState()
    end
    v_u_125.Janitor:Add(v_u_125.Player:GetAttributeChangedSignal("ScopeIncrement"):Connect(function()
        v_u_125:UpdateScopeState()
    end))
    if v_u_125.Humanoid.Health <= 0 then
        task.defer(function()
            v_u_125.StopSpectating:Fire()
        end)
    end
    v_u_125.Janitor:Add(v_u_125.Humanoid:GetPropertyChangedSignal("Health"):Connect(function()
        if v_u_125.Humanoid and v_u_125.Humanoid.Health <= 0 then
            v_u_125.StopSpectating:Fire()
        end
    end))
    if v_u_125.Character:GetAttribute("Dead") then
        task.defer(function()
            v_u_125.StopSpectating:Fire()
        end)
    end
    v_u_125.Janitor:Add(v_u_125.Character:GetAttributeChangedSignal("Dead"):Connect(function()
        if v_u_125.Character:GetAttribute("Dead") then
            v_u_125.StopSpectating:Fire()
        end
    end))
    v_u_125.Janitor:Add(v_u_19.UI.UIPlayerKilled.Listen(function(p127)
        local v128 = p127.Victim
        if v128 then
            local v129 = v_u_125.Player.UserId
            if tostring(v129) == v128 then
                v_u_125.StopSpectating:Fire()
            end
        end
    end))
    v_u_125.Janitor:Add(v_u_125.Character.AncestryChanged:Connect(function(_, p130)
        if not (p130 and p130:IsDescendantOf(v_u_20)) then
            v_u_125.StopSpectating:Fire()
        end
    end))
    v_u_125.Janitor:Add(function()
        v_u_125.TransparencyState = false
        if v_u_18.Dictionary.count(v_u_125.Transparencies) > 0 then
            v_u_125:SetCharacterTransparency(v_u_125.TransparencyState)
        end
        v_u_6.updateCameraFOV(v_u_8.DEFAULT_CAMERA_FOV)
    end)
    v_u_125.Janitor:Add(function()
        if v_u_125.WeaponComponent then
            v_u_125.WeaponComponent.Janitor:Destroy()
            v_u_125.WeaponComponent = nil
        end
        v_u_125.WeaponTransparencyCache = {}
        v_u_125.LastScopeUpdateTime = 0
        v_u_125.LastSpreadValue = 0
        v_u_125.ScopeUICache = nil
    end)
    v_u_125.Janitor:Add(function()
        if v_u_125.FreecamInstance then
            v_u_125.FreecamInstance:Stop()
            v_u_125.FreecamInstance:Destroy()
            v_u_125.FreecamInstance = nil
        end
    end)
    return v_u_125
end
function v_u_1.Destroy(p131)
    p131.Janitor:Destroy()
end
return v_u_1