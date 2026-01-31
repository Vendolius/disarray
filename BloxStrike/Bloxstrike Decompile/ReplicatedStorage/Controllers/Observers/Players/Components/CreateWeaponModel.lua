local v1 = game:GetService("ReplicatedStorage")
local v2 = game:GetService("Players")
require(v1.Database.Custom.Types)
require(script:WaitForChild("Types"))
local v_u_3 = require(v1.Components.Common.GetWeaponProperties)
local v_u_4 = require(v1.Shared.DebugFlags)
local v_u_5 = require(v1.Database.Components.Libraries.Skins)
local v_u_6 = require(v1.Database.Custom.GameStats.Character.Attachments)
local v_u_7 = { "PrimaryAttachment", "SecondaryAttachment", "MeleeAttachment" }
local v_u_8 = {
    ["MuzzlePartL"] = 1,
    ["MuzzlePartR"] = 1,
    ["MuzzlePart"] = 1,
    ["RootPart"] = 1,
    ["Hitbox"] = 1,
    ["Insert"] = 1,
    ["move"] = 1
}
local v_u_9 = {}
local v_u_10 = {}
local function v_u_14(p11, p12, ...)
    if v_u_4.IsEnabled("ThirdPersonWeaponModels") then
        local v13 = not p11 and "[ThirdPersonWeaponModels] " or "[ThirdPersonWeaponModels] " .. p11.Name .. " - "
        warn(v13 .. p12:format(...))
    end
end
local function v_u_17(p15)
    for _, v16 in ipairs(p15:GetDescendants()) do
        if v16:IsA("BasePart") then
            v16.CollisionGroup = "WeaponModel"
            v16.CastShadow = false
            v16.CanCollide = false
            v16.CanTouch = false
            v16.CanQuery = false
            v16.Anchored = false
            v16.Massless = true
        end
    end
end
local function v_u_22(p18)
    for v19, v20 in pairs(v_u_8) do
        local v21 = p18:FindFirstChild(v19, true)
        if v21 then
            v21.Transparency = v20
        end
    end
end
local function v_u_26(p23, p24)
    for _, v25 in ipairs(p23:GetDescendants()) do
        if v25:IsA("BasePart") then
            v25.Transparency = p24 and 0 or 1
        end
    end
    v_u_22(p23)
end
local function v_u_35(p27, p_u_28)
    local v29 = p_u_28.Parent
    if not (v29 and v29:IsA("BasePart")) then
        error((("Character attachment parent is not a BasePart: %*"):format(p_u_28.Name)))
    end
    local v_u_30 = p27:FindFirstChild("Insert", true) or p27.PrimaryPart
    if not v_u_30 then
        error("Weapon model has no PrimaryPart or Insert part")
    end
    local v_u_31 = v_u_30:FindFirstChild("WeaponAttachment")
    if not v_u_31 then
        v_u_31 = Instance.new("Attachment")
        v_u_31.Name = "WeaponAttachment"
        v_u_31.Parent = v_u_30
    end
    local v33, v34 = pcall(function()
        local v32 = Instance.new("AttachmentConstraint")
        v32.Parent = v_u_30
        v32.Attachment0 = p_u_28
        v32.Attachment1 = v_u_31
        return v32
    end)
    if not v33 then
        v_u_30.CFrame = v29.CFrame * p_u_28.CFrame * v_u_31.CFrame:Inverse()
        v34 = Instance.new("WeldConstraint")
        v34.Parent = v_u_30
        v34.Part0 = v29
        v34.Part1 = v_u_30
    end
    return v34
end
local function v_u_57(p36, p37, p38, p39, p40, p41, p42, p43, p44, p45)
    local v46 = nil
    local v47
    if p39 == "Smoke Grenade" then
        v47 = p36:GetAttribute("Team")
        if v47 ~= "Counter-Terrorists" and v47 ~= "Terrorists" then
            v47 = v46
        end
    else
        v47 = v46
    end
    local v48 = v_u_5.GetCharacterModel(p39, p40, p41, p42, p43, p44, p45, v47)
    v_u_17(v48)
    v_u_22(v48)
    local v49 = v_u_7[p38]
    local v50
    if v49 then
        v50 = p37:FindFirstChild(v49, true)
    else
        v50 = nil
    end
    if not v50 then
        local v51 = v_u_14
        local v52 = v_u_7[p38]
        v51(p36, "missing character attachment for slot=%d weapon=%s (expected %s)", p38, p39, (tostring(v52)))
        error((("Missing character attachment for slot: %*"):format(p38)))
    end
    v_u_35(v48, v50)
    local v53 = workspace:FindFirstChild("Debris")
    if v53 then
        local v54 = p36.Name .. "_WeaponAttachments"
        local v55 = v53:FindFirstChild(v54)
        if not v55 then
            v55 = Instance.new("Folder")
            v55.Name = v54
            v55.Parent = v53
        end
        v48.Parent = v55
        v48.Name = p39
    end
    local v56 = v_u_9[p36] or {
        ["Character"] = nil
    }
    v_u_9[p36] = v56
    v56[p38] = {
        ["StatTrack"] = p42,
        ["Stickers"] = p45,
        ["NameTag"] = p43,
        ["Model"] = v48,
        ["Float"] = p41,
        ["Charm"] = p44,
        ["Weapon"] = p39,
        ["Skin"] = p40
    }
    v_u_14(p36, "cached holster slot=%d weapon=%s skin=%s visible=%s", p38, p39, p40, "unknown")
    return v48
end
local function v_u_66(p58)
    local v59 = v_u_10[p58]
    if v59 then
        v59:Disconnect()
        v_u_10[p58] = nil
    end
    local v60 = v_u_9[p58]
    if v60 then
        for v61, v62 in pairs(v60) do
            if v62 and (typeof(v61) == "number" and typeof(v62) == "table") then
                if v62.Model then
                    v62.Model:Destroy()
                end
                v60[v61] = nil
            end
        end
        local v63 = workspace:FindFirstChild("Debris")
        if v63 then
            local v64 = v63:FindFirstChild(p58.Name .. "_Weapon")
            if v64 then
                v64:Destroy()
            end
            local v65 = v63:FindFirstChild(p58.Name .. "_WeaponAttachments")
            if v65 then
                v65:Destroy()
            end
        end
        v_u_14(p58, "cleared player cache (destroyed holsters)")
        v_u_9[p58] = nil
    end
end
local function v_u_78(p_u_67, p68)
    local v69 = v_u_9[p_u_67] or {
        ["Character"] = nil
    }
    v_u_9[p_u_67] = v69
    if v69.Character ~= p68 then
        if v69.Character then
            v_u_66(p_u_67)
            v69 = v_u_9[p_u_67] or {
                ["Character"] = nil
            }
            v_u_9[p_u_67] = v69
        end
        v69.Character = p68
        local v70 = v_u_10[p_u_67]
        if v70 then
            v70:Disconnect()
        end
        v_u_10[p_u_67] = p68.AncestryChanged:Connect(function(_, p71)
            if not p71 or p71.Name == "Debris" then
                local v72 = workspace:FindFirstChild("Debris")
                if v72 then
                    local v73 = v72:FindFirstChild(p_u_67.Name .. "_Weapon")
                    if v73 then
                        v73:Destroy()
                    end
                    local v74 = v72:FindFirstChild(p_u_67.Name .. "_WeaponAttachments")
                    if v74 then
                        v74:Destroy()
                    end
                end
                local v75 = v_u_9[p_u_67]
                if v75 then
                    for v76, v77 in pairs(v75) do
                        if v77 and (typeof(v76) == "number" and typeof(v77) == "table") then
                            v75[v76] = nil
                        end
                    end
                    v75.Character = nil
                end
            end
        end)
    end
end
local function v_u_93(p79, p80, p81, p82, p83)
    local v84 = v_u_3(p82.Weapon)
    if not v84 or v84.ShootingOptions ~= "Dual" then
        local v85 = v_u_9[p79] or {
            ["Character"] = nil
        }
        v_u_9[p79] = v85
        local v86 = v85[p81]
        if v86 then
            if v86.Skin == p82.Skin and (v86.Weapon == p82.Weapon and v86.Model) then
                local v87 = v86.Weapon
                local v88 = v86.Skin
                local v89
                if v87 == p83.Name then
                    v89 = v88 == p83.Skin
                else
                    v89 = false
                end
                v_u_26(v86.Model, not v89)
                return
            end
            if v86.Model then
                v86.Model:Destroy()
            end
        end
        v85[p81] = nil
        local v90 = p82.Weapon
        local v91 = p82.Skin
        local v92
        if v90 == p83.Name then
            v92 = v91 == p83.Skin
        else
            v92 = false
        end
        v_u_14(p79, "holster slot=%d weapon=%s skin=%s equippedInHand=%s", p81, p82.Weapon, p82.Skin, (tostring(v92)))
        v_u_26(v_u_57(p79, p80, p81, p82.Weapon, p82.Skin, p82.Float, p82.StatTrack, p82.NameTag, p82.Charm, p82.Stickers), not v92)
    end
end
local function v_u_109(p94, p95, p96, p97)
    v_u_78(p94, p95)
    if not p97[1] then
        local v98 = v_u_9[p94]
        local v99 = v98 and v98[1]
        if v99 then
            local v100 = v99.Model
            if v100 then
                v100:Destroy()
            end
            v98[1] = nil
        end
    end
    if not p97[2] then
        local v101 = v_u_9[p94]
        local v102 = v101 and v101[2]
        if v102 then
            local v103 = v102.Model
            if v103 then
                v103:Destroy()
            end
            v101[2] = nil
        end
    end
    if not p97[3] then
        local v104 = v_u_9[p94]
        local v105 = v104 and v104[3]
        if v105 then
            local v106 = v105.Model
            if v106 then
                v106:Destroy()
            end
            v104[3] = nil
        end
    end
    for v107, v108 in pairs(p97) do
        if v108 then
            v_u_93(p94, p95, v107, v108, p96)
        end
    end
end
local function v_u_118(p110, p111, p112)
    local v113 = Instance.new("Motor6D")
    v113.Name = "WeaponAttachment" .. (p112 or "")
    v113.Parent = p110
    v113.Part0 = p110
    v113.Part1 = p112 and p111:FindFirstChild(p112, true) or p111.PrimaryPart
    local v114 = p111:FindFirstChild("Properties")
    if v114 then
        for _, v115 in ipairs(p112 and { "LEFT", "RIGHT" } or { "" }) do
            local v116 = v114:FindFirstChild("C0" .. v115)
            if v116 then
                v113.C0 = v116.Value
            end
            local v117 = v114:FindFirstChild("C1" .. v115)
            if v117 then
                v113.C1 = v117.Value
            end
        end
    end
    return v113
end
local function v_u_123(p119, p120)
    local v121 = p119:FindFirstChild("RightHand")
    local v122 = p119:FindFirstChild("LeftHand")
    if v121 and v122 then
        v_u_118(v121, p120, "HandleR")
        v_u_118(v122, p120, "HandleL")
    else
        warn("CreateDualMotor6DAttachments: Could not find RightHand or LeftHand for dual weapon")
    end
end
local function v_u_131(p124, p125, p126)
    local v127 = p126:FindFirstChild("WeaponAttachment")
    p125:ClearAllChildren()
    local v128 = workspace:FindFirstChild("Debris")
    local v129 = v128 and v128:FindFirstChild(p124.Name .. "_Weapon")
    if v129 then
        v129:Destroy()
    end
    if v127 then
        v127:Destroy()
    end
    local v130 = p126:FindFirstChild("WeaponAttachmentHandleR")
    if v130 then
        v130:Destroy()
    end
end
local function v_u_150(p132, p133, p134)
    local v135 = p133.Parent
    if not v135 or v135.Name == "Debris" then
        return nil, nil
    end
    local v136 = p134.Name
    local v137 = v_u_6.WEAPON_JOINT_PARTS[v136] or v_u_6.DEFAULT_JOINT_PART
    local v138 = p133:WaitForChild(v137, 10)
    local v139 = ("Failed to get joint part: %* for weapon: %*"):format(v137, v136)
    assert(v138, v139)
    local v140 = v_u_3(p134.Name)
    local v141 = p133:FindFirstChild("WeaponModel")
    if not v141 then
        return nil, nil
    end
    v_u_131(p132, v141, v138)
    local v142 = p133:FindFirstChild("LeftHand")
    local v143 = v142 and v142:FindFirstChild("WeaponAttachmentHandleL")
    if v143 then
        v143:Destroy()
    end
    local v144 = nil
    local v145
    if p134.Name == "Smoke Grenade" then
        v145 = p132:GetAttribute("Team")
        if v145 ~= "Counter-Terrorists" and v145 ~= "Terrorists" then
            v145 = v144
        end
    else
        v145 = v144
    end
    local v146 = v_u_5.GetCharacterModel(p134.Name, p134.Skin, p134.Float, p134.StatTrack, p134.NameTag, p134.Charm, p134.Stickers, v145)
    v_u_17(v146)
    v_u_22(v146)
    local v147 = p134.IsSuppressed
    local v148 = v146:FindFirstChild("Silencer", true)
    if v148 and v140.HasSuppressor then
        v148.Transparency = v147 and 0 or 1
    end
    if v140.ShootingOptions == "Dual" then
        v_u_123(p133, v146)
    else
        v_u_118(v138, v146, nil)
    end
    local v149 = workspace:FindFirstChild("Debris")
    if v149 then
        v146.Parent = v149
        v146.Name = p132.Name .. "_Weapon"
        v146:SetAttribute("PersistentDebris", true)
    end
    return v146, v138
end
local function v_u_156(p151, p152, p153)
    local v154 = p151.Character
    if v154 then
        local _, v155 = v_u_150(p151, v154, p152)
        if v155 then
            v_u_109(p151, v154, p152, p153)
            return v155, v_u_66
        end
    end
    return nil, nil
end
local v157 = setmetatable({}, {
    ["__call"] = function(_, ...)
        return v_u_156(...)
    end
})
v157.ClearPlayerCache = v_u_66
v2.PlayerRemoving:Connect(function(p158)
    v_u_66(p158)
end)
return v157