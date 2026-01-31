local v_u_1 = {}
v_u_1.__index = v_u_1
local v_u_2 = game:GetService("ReplicatedStorage")
local v_u_3 = game:GetService("ReplicatedFirst")
local v_u_4 = game:GetService("HttpService")
local v_u_5 = game:GetService("RunService")
require(script:WaitForChild("Types"))
local v_u_6 = require(v_u_2.Controllers.DataController)
local v_u_7 = require(v_u_2.Database.Components.Libraries.Skins)
local v_u_8 = require(v_u_2.Classes.Sound)
local v_u_9 = require(v_u_2.Shared.Janitor)
local v_u_10 = require(v_u_2.Database.Security.Router)
local v_u_11 = require(script.Classes.Animation)
local v_u_12 = require(script.Classes.Bobble)
local v_u_13 = workspace.CurrentCamera
local function v_u_20(p14, p15)
    local v16 = p14:GetDescendants()
    for _, v17 in ipairs(v16) do
        if v17:IsA("BasePart") then
            local v18 = v17:GetAttribute("HiddenTransparency")
            if p15 then
                local v19 = v17.Transparency
                v17.Transparency = 1
                if not v18 then
                    v17:SetAttribute("HiddenTransparency", v19)
                end
            elseif v18 then
                v17.Transparency = v18
            end
        end
    end
end
local function v_u_24(p21, p22)
    for _, v23 in pairs(p21:GetDescendants()) do
        if v23:IsA("MeshPart") then
            v23.Transparency = p22 == true and 0 or 1
        elseif v23:IsA("SurfaceGui") then
            v23.Enabled = p22
        end
    end
end
function v_u_1.aim(p25)
    if p25.Bobble then
        p25.Bobble:setIsAiming(true)
    end
    v_u_24(p25.Bobble.Scope, true)
    v_u_24(p25.Bobble.ScopeReticlePart, true)
    if p25.MuzzlePartWeld then
        local v26 = v_u_13.CFrame
        local v27 = p25.Model.WorldPivot
        local v28 = v26 + v26.UpVector * -0.5 + v27.LookVector * 1 + v27.RightVector * 0.1
        local v29 = p25.MuzzlePartWeld
        p25.MuzzlePartWeld.C0 = v29.Part0.CFrame:Inverse() * v28
    end
end
function v_u_1.unaim(p30)
    if p30.Bobble then
        p30.Bobble:setIsAiming(false)
    end
    v_u_24(p30.Bobble.Scope, false)
    v_u_24(p30.Bobble.ScopeReticlePart, false)
    if p30.OriginalC0 and p30.MuzzlePartWeld then
        p30.MuzzlePartWeld.C0 = p30.OriginalC0
    end
end
function v_u_1.unhide(p31)
    if p31.Hidden then
        v_u_20(p31.Model, false)
        p31.Hidden = false
    end
end
function v_u_1.hide(p32)
    if not p32.Hidden then
        v_u_20(p32.Model, true)
        p32.Hidden = true
    end
end
function v_u_1.equip(p33, p34)
    p33.IsEquipped = true
    if p33.Model then
        p33.Model.Parent = v_u_13
        if p33.LargeWeaponModel then
            p33.LargeWeaponModel.Parent = v_u_13
        end
        p33.Animation:stopAnimations()
        p33.Animation:play("Idle")
        if p33.Hidden then
            p33:unhide()
        end
        if not p34 then
            p33.Animation:play("Equip")
        end
    end
end
function v_u_1.unequip(p35)
    p35.IsEquipped = false
    p35.Animation:stopAnimations()
    if p35.Model then
        p35.Model.Parent = nil
    end
    if p35.LargeWeaponModel then
        p35.LargeWeaponModel.Parent = nil
    end
end
function v_u_1.applyCharmImpulse(p36, p37)
    if p36.LargeCharmModel and p36.LargeCharmModel.PrimaryPart then
        local v38 = 0
        for _, v39 in ipairs(p36.LargeCharmModel:GetDescendants()) do
            if v39:IsA("BasePart") then
                v38 = v38 + v39:GetMass()
            end
        end
        p36.LargeCharmModel.PrimaryPart:ApplyImpulse(p37 * 10 * v38)
    end
end
function v_u_1.render(p40, p41)
    if p40.Model and p40.Model:FindFirstChild("Stats") then
        local v42 = v_u_6.Get(p40.Player, "Settings.Game.Viewmodel") or {}
        if p40.Bobble and (p40.Bobble.Character and p40.Bobble.Character.PrimaryPart) then
            local v43, v44, v45 = p40.Bobble:getNextCFrame(p41)
            local v46 = (v42["X Offset"] or 0) / 100
            local v47 = (v42["Y Offset"] or 0) / 100
            local v48 = (v42["Z Offset"] or 0) / 100
            local v49 = v_u_13.CFrame * v43 * CFrame.Angles(p40.Model.Stats.Rotation.Value.X, p40.Model.Stats.Rotation.Value.Y, p40.Model.Stats.Rotation.Value.Z) * CFrame.new(p40.Model.Stats.Default.Value) * CFrame.new(v46, v47, v48)
            p40.Model:PivotTo(v49)
            if p40.LargeWeaponModel and p40.SmallWeaponModel then
                p40.LargeWeaponModel:PivotTo(p40.SmallWeaponModel:GetPivot())
                local v50 = p40.Model.WorldPivot.Position
                if p40.LastViewmodelPosition then
                    local v51 = v50 - p40.LastViewmodelPosition
                    if p40.LargeCharmModel and p40.LargeCharmModel.PrimaryPart then
                        p40:applyCharmImpulse(-v51 * 0.2)
                    end
                end
                p40.LastViewmodelPosition = v50
            end
            if p40.Bobble.Scope and p40.Bobble.IsAiming then
                local v52 = v_u_13.CFrame
                local v53 = v45.X * -v52.LookVector + v45.Y * -v52.UpVector
                p40.Bobble.Scope:PivotTo(v52 + v52.LookVector * 0.15 + v44 + v53)
                if p40.Bobble.ScopeReticlePart then
                    p40.Bobble.ScopeReticlePart.CFrame = v52 * CFrame.Angles(1.5707963267948966, 1.5707963267948966, -1.5707963267948966) + v52.LookVector * 0.15
                end
            end
        end
    end
end
function v_u_1.attachSleeves(p54, p55)
    local v56 = v_u_2.Assets.Sleeves:FindFirstChild(p55)
    if v56 then
        for _, v57 in ipairs(v56:GetChildren()) do
            local v58 = p54.Model:FindFirstChild(v57.Name)
            if v58 then
                local v59 = v57:Clone()
                v59.CastShadow = false
                v59.CanCollide = false
                v59.CanTouch = false
                v59.Anchored = false
                v59.CanQuery = false
                v59.Name = "Sleeve"
                local v60 = v58.Size.X * 1.3
                local v61 = v58.Size.Y * 1.4
                local v62 = v58.Size.Z * 0.79
                v59.Size = Vector3.new(v60, v61, v62)
                local v63 = v58.Size.Z / 2 - v59.Size.Z / 2
                local v64 = CFrame.new(0, -0.02, -v63)
                v59.Parent = v58
                local v65 = Instance.new("Motor6D", v59)
                v65.Part0 = v58
                v65.Part1 = v59
                v65.C0 = CFrame.identity
                v65.C1 = v64
            end
        end
    end
end
function v_u_1.addAttachments(p66, p67)
    local v68 = v_u_10.broadcastRouter("GetInventoryItemFromIdentifier", p66.Player, p67)
    if v68 then
        local v69 = v_u_7.GetGloves(v68.Name, v68.Skin, v68.Float)
        if v69 then
            for _, v70 in ipairs(v69:GetChildren()) do
                local v71 = p66.Model:FindFirstChild(v70.Name)
                if v71 then
                    local v72 = v70:Clone()
                    v72.CastShadow = false
                    v72.CanCollide = false
                    v72.CanTouch = false
                    v72.Anchored = true
                    v72.CanQuery = false
                    v72.Name = "Glove"
                    local v73 = v71.Size.X * 1.15
                    local v74 = v71.Size.Y * 1.18
                    local v75 = v71.Size.Z * 0.245
                    v72.Size = Vector3.new(v73, v74, v75)
                    local v76 = v71.Size.Z / 2 - v72.Size.Z / 2
                    local v77 = CFrame.new(0, 0, -v76 * 1.035) * v72.PivotOffset
                    v72.Parent = v71
                    local v78 = Instance.new("WeldConstraint", v72)
                    v78.Part0 = v71
                    v78.Part1 = v72
                    v72.CFrame = v71.CFrame * v77
                    v72.Anchored = false
                end
            end
            if p66.Team == "Counter-Terrorists" then
                p66:attachSleeves((workspace:GetAttribute("CTCharacter")))
            end
        end
    else
        return
    end
end
function v_u_1.construct(p79, p80, _)
    if p79.ModelJanitor then
        p79.ModelJanitor:Destroy()
    end
    p79.ModelJanitor = v_u_9.new()
    p79.CharmModel = nil
    p79.LargeWeaponModel = nil
    p79.SmallWeaponModel = nil
    p79.LargeCharmModel = nil
    p79.LastViewmodelPosition = nil
    if p79.Animation then
        p79.Animation:stopAnimations()
    end
    if p79.Model then
        p79.Model:Destroy()
        p79.Model = nil
    end
    local v81 = nil
    local v82
    if p79.Weapon == "Smoke Grenade" then
        v82 = p79.Team
        if v82 ~= "Counter-Terrorists" and v82 ~= "Terrorists" then
            v82 = v81
        end
    else
        v82 = v81
    end
    p79.Model = v_u_7.GetCameraModel(p79.Weapon, p79.Skin, p79.Float, p79.StatTrack, p79.NameTag, p79.Charm, p79.Stickers, v82)
    if not p79.Model then
        error((("Viewmodel.construct: Failed to get camera model for weapon \"%*\" with skin \"%*\""):format(p79.Weapon, p79.Skin)))
    end
    p79.Model.Parent = v_u_3
    p79.Model.Name = p79.Weapon
    local v83 = p80:GetAttribute("EquippedGloves")
    if v83 then
        v83 = v_u_4:JSONDecode(v83)
    end
    if v83 then
        p79:addAttachments(v83.SkinIdentifier)
    end
    for _, v84 in ipairs(p79.Model:GetDescendants()) do
        if v84:IsA("BasePart") then
            v84.CollisionGroup = "Viewmodel"
            v84.CanCollide = false
            v84.CastShadow = false
            v84.CanQuery = true
            v84.CanTouch = false
            if v84.Name == "HumanoidRootPart" or v84.Name == "ViewmodelLight" then
                v84.Transparency = 1
            end
        end
    end
    local v85 = p80:FindFirstChild("Body Colors")
    local v86 = nil
    if v85 then
        v86 = v85.TorsoColor3
    else
        local v87 = p80:FindFirstChild("Torso") or p80:FindFirstChild("UpperTorso")
        if v87 and v87:IsA("BasePart") then
            v86 = v87.Color
        end
    end
    if v86 then
        for _, v88 in ipairs({ "Right Arm", "Left Arm" }) do
            local v89 = p79.Model:FindFirstChild(v88)
            if v89 and v89:IsA("BasePart") then
                v89.Color = v86
            end
        end
    end
    local v90 = p79.Model:FindFirstChild("Interactables")
    local v91 = not v90 or v90:FindFirstChild("MuzzlePart", true) or (v90:FindFirstChild("MuzzlePartL", true) or v90:FindFirstChild("MuzzlePartR", true))
    p79.MuzzlePart = v91
    if v90 then
        p79.MuzzlePartL = v90:FindFirstChild("MuzzlePartL", true)
        p79.MuzzlePartR = v90:FindFirstChild("MuzzlePartR", true)
        if p79.MuzzlePartL and p79.MuzzlePartL:IsA("BasePart") then
            p79.MuzzlePartL.Transparency = 1
        end
        if p79.MuzzlePartR and p79.MuzzlePartR:IsA("BasePart") then
            p79.MuzzlePartR.Transparency = 1
        end
    end
    if p79.MuzzlePart and p79.MuzzlePart:IsA("BasePart") then
        p79.MuzzlePart.Transparency = 1
    end
    if p79.MuzzlePart and not p79.MuzzlePart:FindFirstChild("WeldConstraint", true) then
        local v92 = p79.Model:GetDescendants()
        for _, v93 in ipairs(v92) do
            if v93:IsA("Weld") and (v93.Part1 == v91 or v93.Part0 == v91) then
                p79.MuzzlePartWeld = v93
                p79.OriginalC0 = v93.C0
                break
            end
        end
    end
    p79.Model:ScaleTo(0.1)
    local v94 = p79.Model:FindFirstChild("CharmBase", true)
    if v94 and v94:IsA("Model") then
        local v95 = v94:FindFirstChildOfClass("Model")
        if v95 and v95.PrimaryPart then
            p79.CharmModel = v95
        end
    end
    if p79.CharmModel then
        p79:setupCharmPhysics()
    end
    if p79.Animation then
        p79.Animation:setModel(p79.Model)
    end
    if p79.Bobble then
        p79.Bobble:setModel(p79.Model)
    end
    if p79.IsEquipped then
        p79:equip(false)
    else
        p79.Model.Parent = nil
    end
end
function v_u_1.setupCharmPhysics(p_u_96)
    if p_u_96.CharmModel then
        p_u_96.CharmModel:PivotTo(p_u_96.CharmModel.Parent.PrimaryPart.CFrame * CFrame.new(0, 0, -1))
        local v_u_97 = p_u_96.CharmModel
        local v_u_98 = p_u_96.Model:FindFirstChild("Weapon") or (p_u_96.Model:FindFirstChild("WeaponL") or p_u_96.Model:FindFirstChild("WeaponR"))
        if v_u_98 then
            local v_u_99 = v_u_98.Parent:Clone()
            v_u_99.Parent = v_u_13
            local v_u_100 = v_u_99:FindFirstChild("Weapon") or (p_u_96.Model:FindFirstChild("WeaponL") or p_u_96.Model:FindFirstChild("WeaponR"))
            for _, v101 in v_u_99:GetChildren() do
                if v101.Name ~= "Weapon" and (v101.Name ~= "WeaponL" and (v101.Name ~= "WeaponR" and v101.Name ~= "CharmBase")) then
                    v101:Destroy()
                end
            end
            v_u_99:ScaleTo(1)
            v_u_99:PivotTo(v_u_98.Parent:GetPivot())
            v_u_100.PrimaryPart.Anchored = true
            local v102 = v_u_99:GetBoundingBox()
            if v_u_99.PrimaryPart then
                v_u_99.PrimaryPart.PivotOffset = v_u_99.PrimaryPart.CFrame:ToObjectSpace(v102)
            else
                v_u_99.WorldPivot = v102
            end
            v_u_99.PrimaryPart = v_u_100.PrimaryPart
            for _, v103 in ipairs(v_u_99:GetDescendants()) do
                if v103:IsA("BasePart") then
                    v103.Transparency = 1
                    v103.CanCollide = true
                elseif v103:IsA("Decal") or (v103:IsA("Texture") or v103:IsA("Beam")) then
                    v103.Transparency = 1
                elseif v103:IsA("SurfaceGui") then
                    v103.Enabled = false
                elseif v103:IsA("ParticleEmitter") then
                    v103.Enabled = false
                end
            end
            local v104 = v_u_99:FindFirstChild("CharmBase", true)
            local v105
            if v104 and v104:IsA("Model") then
                v105 = v104:FindFirstChildOfClass("Model")
                if v105 then
                    for _, v106 in ipairs(v105:GetDescendants()) do
                        if v106:IsA("BasePart") then
                            v106.CanCollide = true
                            v106.CollisionGroup = "Charm"
                        end
                    end
                end
            else
                v105 = nil
            end
            p_u_96.LargeWeaponModel = v_u_100.Parent
            p_u_96.SmallWeaponModel = v_u_98
            p_u_96.LargeCharmModel = v105
            if v105 and v_u_97 then
                p_u_96.ModelJanitor:Add(v_u_5.PostSimulation:Connect(function()
                    local v107 = p_u_96.LargeCharmModel
                    local v108 = v_u_97
                    if v107 and v108 then
                        if v107.PrimaryPart and v108.PrimaryPart then
                            local v109 = v_u_100:GetPivot():ToObjectSpace((v107:GetPivot()))
                            local v110 = CFrame.new(v109.Position / 10) * CFrame.fromOrientation(v109:ToOrientation())
                            v108:PivotTo(v_u_98:GetPivot() * v110)
                        end
                    else
                        return
                    end
                end))
            end
            p_u_96.CharmModel.PrimaryPart.Anchored = true
            p_u_96.ModelJanitor:Add(function()
                if v_u_99 then
                    v_u_99:Destroy()
                end
                p_u_96.LargeWeaponModel = nil
                p_u_96.SmallWeaponModel = nil
                p_u_96.LargeCharmModel = nil
            end)
        end
    else
        return
    end
end
function v_u_1.new(p_u_111, p112, p113)
    local v114 = v_u_1
    local v_u_115 = setmetatable({}, v114)
    v_u_115.Janitor = v_u_9.new()
    v_u_115.ModelJanitor = v_u_9.new()
    v_u_115.IsDestroyed = false
    v_u_115.Player = p_u_111.Player
    v_u_115.Team = v_u_115.Player:GetAttribute("Team")
    v_u_115.Weapon = p112
    v_u_115.Skin = p113
    v_u_115.StatTrack = p_u_111.StatTrack
    v_u_115.Stickers = p_u_111.Stickers
    v_u_115.NameTag = p_u_111.NameTag
    v_u_115.Float = p_u_111.Float
    v_u_115.Charm = p_u_111.Charm
    v_u_115.Hidden = false
    v_u_115.IsEquipped = false
    v_u_115.Sound = v_u_8.new(p112)
    v_u_115.Animation = v_u_11.new(v_u_115, v_u_115.Player, nil, v_u_115.Sound)
    v_u_115.Bobble = v_u_12.new(p_u_111, nil)
    local v116 = not p_u_111.Character and v_u_115.Player
    if v116 then
        v116 = v_u_115.Player.Character
    end
    if v116 then
        v_u_115:construct(v116, p_u_111)
    end
    v_u_115.Janitor:Add(v_u_115.Player.CharacterAdded:Connect(function(p117)
        v_u_115:construct(p117, p_u_111)
    end))
    v_u_115.Janitor:Add(function()
        if v_u_115.Animation then
            v_u_115.Animation:destroy()
            v_u_115.Animation = nil
        end
    end)
    v_u_115.Janitor:Add(function()
        if v_u_115.Bobble then
            v_u_115.Bobble:destroy()
            v_u_115.Bobble = nil
        end
    end)
    v_u_115.Janitor:Add(function()
        if v_u_115.Sound then
            v_u_115.Sound:destroy()
            v_u_115.Sound = nil
        end
    end)
    v_u_115.Janitor:Add(function()
        if v_u_115.ModelJanitor then
            v_u_115.ModelJanitor:Destroy()
            v_u_115.ModelJanitor = nil
        end
    end)
    return v_u_115
end
function v_u_1.destroy(p118)
    if not p118.IsDestroyed then
        p118.IsDestroyed = true
        if p118.Animation then
            p118.Animation:stopAnimations()
        end
        if p118.Animation then
            p118.Animation:destroy()
            p118.Animation = nil
        end
        if p118.Bobble then
            p118.Bobble:destroy()
            p118.Bobble = nil
        end
        if p118.Sound then
            p118.Sound:destroy()
            p118.Sound = nil
        end
        if p118.Model then
            p118.Model.Parent = nil
            p118.Model:Destroy()
            p118.Model = nil
        end
        if p118.Janitor then
            p118.Janitor:Destroy()
            p118.Janitor = nil
        end
        p118.StatTrack = nil
        p118.Stickers = nil
        p118.NameTag = nil
        p118.Player = nil
        p118.Weapon = nil
        p118.Float = nil
        p118.Charm = nil
        p118.Skin = nil
        p118.Team = nil
        p118.MuzzlePartWeld = nil
        p118.MuzzlePartL = nil
        p118.MuzzlePartR = nil
        p118.MuzzlePart = nil
        p118.OriginalC0 = nil
        p118.CharmModel = nil
        p118.ScaledCollisionModel = nil
        p118.LargeCharmModel = nil
        p118.LargeWeaponModel = nil
    end
end
return v_u_1