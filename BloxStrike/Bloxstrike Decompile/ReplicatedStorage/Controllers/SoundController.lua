local v_u_1 = {}
local v_u_2 = game:GetService("ReplicatedStorage")
local v_u_3 = game:GetService("ContentProvider")
local v_u_4 = game:GetService("RunService")
local v_u_5 = game:GetService("Players")
local v6 = game:GetService("Workspace")
local v_u_7 = v_u_5.LocalPlayer
local v_u_8 = require(v_u_2.Database.Security.Remotes)
local v_u_9 = require(v_u_2.Packages.Observers)
local v_u_10 = require(v_u_2.Database.Security.Router)
local v_u_11 = require(v_u_2.Controllers.DataController)
local v_u_12 = require(v_u_2.Classes.Sound)
local v_u_13 = require(v_u_2.Interface.MenuState)
local v_u_14 = require(v_u_2.Shared.DebugFlags)
local v_u_15 = require(v_u_2.Database.Components.GameState)
local v_u_16 = require(v_u_2.Components.Common.VFXLibary.FlashEffect)
local v_u_17 = require(script.MovementSounds)
local v_u_18 = require(v_u_2.Database.Audio.Character)
local v_u_19 = require(v_u_2.Database.Audio.FloorSounds)
local v_u_20 = v6.CurrentCamera
local v_u_21 = {
    ["WeaponSuppressed"] = 50,
    ["Footstep"] = 48,
    ["Landing"] = 60,
    ["Weapon"] = 120,
    ["Melee"] = 50,
    ["Jump"] = 40
}
local v_u_22 = {}
local v_u_23 = {}
local v_u_24 = nil
function v_u_1.GetPlayerNoiseCone()
    if v_u_24 and tick() - v_u_24.Time >= 2 then
        v_u_24 = nil
    end
    return v_u_24
end
function v_u_1.UpdatePlayerNoiseCone(p25, p26, p27)
    local v28 = p26 * 0.5
    local v29 = tick()
    if p27 then
        v28 = v28 * 0.5
    end
    if v_u_24 and (v29 - v_u_24.Time < 2 and v28 < v_u_24.Range) then
        v_u_24.Time = v29
    else
        v_u_24 = {
            ["Position"] = p25,
            ["Range"] = v28,
            ["Time"] = v29
        }
    end
end
function v_u_1.GetFootstepRange(p30, p31)
    local v32 = v_u_19[p30] or v_u_19.Concrete
    local v33 = v_u_21.Footstep
    if v32 and v32.Properties then
        v33 = v32.Properties.RollOffMaxDistance or v33
    end
    if p31 then
        v33 = v33 * 0.5 or v33
    end
    return v33
end
function v_u_1.GetWeaponShootRange(p34, p35)
    local v36
    if v_u_23[p34] then
        v36 = v_u_23[p34]
    else
        local v37 = v_u_2.Database.Audio.Weapons:FindFirstChild(p34)
        if v37 then
            local v38
            v38, v36 = pcall(require, v37)
            if v38 and v36 then
                v_u_23[p34] = v36
            else
                v36 = nil
            end
        else
            v36 = nil
        end
    end
    if v36 then
        if p35 and v36.Silencer then
            local v39 = v36.Silencer
            local v40 = v_u_21.WeaponSuppressed
            if v39 and v39.Properties then
                v40 = v39.Properties.RollOffMaxDistance or v40
            end
            return v40
        else
            local v41 = v36.Shoot
            local v42 = v_u_21.Weapon
            if v41 and v41.Properties then
                v42 = v41.Properties.RollOffMaxDistance or v42
            end
            return v42
        end
    else
        return p35 and v_u_21.WeaponSuppressed or v_u_21.Weapon
    end
end
function v_u_1.GetMeleeRange(p43)
    local v44
    if v_u_23[p43] then
        v44 = v_u_23[p43]
    else
        local v45 = v_u_2.Database.Audio.Weapons:FindFirstChild(p43)
        if v45 then
            local v46
            v46, v44 = pcall(require, v45)
            if v46 and v44 then
                v_u_23[p43] = v44
            else
                v44 = nil
            end
        else
            v44 = nil
        end
    end
    if not v44 then
        return v_u_21.Melee
    end
    local v47 = v44.HitOne
    local v48 = v_u_21.Melee
    if v47 and v47.Properties then
        v48 = v47.Properties.RollOffMaxDistance or v48
    end
    return v48
end
function v_u_1.GetMovementRange(p49, p50)
    local v51 = v_u_21[p49] or v_u_21.Footstep
    if p49 == "Landing" then
        local v52 = v_u_18["Fall Damage"]
        if v52 and v52.Properties then
            v51 = v52.Properties.RollOffMaxDistance or v51
        end
    end
    if p50 then
        v51 = v51 * 0.5 or v51
    end
    return v51
end
function v_u_1.ClearPlayerNoiseCone()
    v_u_24 = nil
end
function v_u_1.Initialize()
    for _, v53 in ipairs(v_u_2.Database.Audio:GetDescendants()) do
        if v53:IsA("ModuleScript") then
            v_u_12.createSoundGroup(v53)
        end
    end
    task.spawn(function()
        v_u_3:PreloadAsync({ v_u_2.Sounds })
    end)
    v_u_10.observerRouter("RunRoundSound", function(p54)
        if v_u_13.GetCurrentScreen() == nil then
            local v55 = {
                ["Parent"] = v_u_20,
                ["Name"] = p54
            }
            return v_u_12.new("Round"):playOneTime(v55)
        end
    end)
    local v_u_56 = nil
    local v_u_57 = nil
    local v_u_58 = nil
    local function v_u_69(p59)
        if v_u_56 and v_u_56.Parent then
            local v60 = (v_u_11.Get(v_u_7, "Settings.Audio.Music.Round Start Volume") or 50) / 50
            local v61 = (v_u_11.Get(v_u_7, "Settings.Audio.Audio.Master Volume") or 100) / 100
            local v62 = v_u_56:GetAttribute("BaseVolume") or v_u_56.Volume
            local v63
            if p59 and v_u_58 then
                local v64 = tick() - v_u_58
                if v64 < 6 then
                    v63 = 1
                else
                    local v65 = 1 - (v64 - 6) * 0.2
                    v63 = math.max(0, v65)
                end
            else
                v63 = 1
            end
            v_u_56.Volume = v62 * v60 * v61 * v63
            if p59 and v_u_58 then
                local v66 = tick() - v_u_58
                local v67
                if v66 < 6 then
                    v67 = 1
                else
                    local v68 = 1 - (v66 - 6) * 0.2
                    v67 = math.max(0, v68)
                end
                if v67 <= 0 then
                    if v_u_57 then
                        v_u_57:Disconnect()
                        v_u_57 = nil
                    end
                    v_u_56:Stop()
                    v_u_56:Destroy()
                    v_u_56 = nil
                    v_u_58 = nil
                end
            end
        end
    end
    v_u_15.ListenToState(function(_, p70)
        if p70 == "Buy Period" then
            local v71 = v_u_7:GetAttribute("Team")
            if v71 ~= "Counter-Terrorists" and v71 ~= "Terrorists" then
                return
            end
            if v_u_56 then
                if v_u_57 then
                    v_u_57:Disconnect()
                    v_u_57 = nil
                end
                if v_u_56.Parent then
                    v_u_56:Stop()
                    v_u_56:Destroy()
                end
                v_u_56 = nil
                v_u_58 = nil
            end
            local v72 = (v_u_11.Get(v_u_7, "Settings.Audio.Music.Round Start Volume") or 50) / 50
            local v73 = {
                ["Parent"] = v_u_20,
                ["Name"] = "Buy Phase"
            }
            v_u_56 = v_u_12.new("Round"):play(v73, v72)
            if v_u_56 then
                local v_u_74 = v_u_56
                v_u_74.Destroying:Once(function()
                    if v_u_56 == v_u_74 then
                        v_u_56 = nil
                        v_u_58 = nil
                    end
                end)
                local v75 = (v_u_11.Get(v_u_7, "Settings.Audio.Audio.Master Volume") or 100) / 100
                local v76 = v_u_56.Volume
                if v72 > 0 and v75 > 0 then
                    v76 = v76 / (v72 * v75) or v76
                end
                v_u_56:SetAttribute("BaseVolume", v76)
                v_u_58 = tick()
                task.spawn(function()
                    v_u_57 = v_u_4.Heartbeat:Connect(function()
                        if not (v_u_56 and v_u_56.Parent) then
                            if v_u_57 then
                                v_u_57:Disconnect()
                                v_u_57 = nil
                            end
                            goto l10
                        end
                        if not v_u_58 then
                            return
                        end
                        local v77 = tick() - v_u_58
                        local v78 = v77 >= 6
                        v_u_69(v78)
                        if v78 then
                            if not (v_u_56 and v_u_56.Parent) then
                                ::l12::
                                if v_u_57 then
                                    v_u_57:Disconnect()
                                    v_u_57 = nil
                                    return
                                end
                                goto l10
                            end
                            local v79
                            if v77 < 6 then
                                v79 = 1
                            else
                                local v80 = 1 - (v77 - 6) * 0.2
                                v79 = math.max(0, v80)
                            end
                            if v79 <= 0 then
                                goto l12
                            end
                        end
                        ::l10::
                    end)
                end)
                return
            end
        elseif v_u_56 then
            if v_u_57 then
                v_u_57:Disconnect()
                v_u_57 = nil
            end
            if v_u_56.Parent then
                v_u_56:Stop()
                v_u_56:Destroy()
            end
            v_u_56 = nil
            v_u_58 = nil
        end
    end)
    v_u_11.CreateListener(v_u_7, "Settings.Audio.Music.Round Start Volume", function()
        v_u_69(v_u_57 ~= nil)
    end)
    v_u_11.CreateListener(v_u_7, "Settings.Audio.Audio.Master Volume", function()
        v_u_69(v_u_57 ~= nil)
    end)
    local v_u_81 = nil
    v_u_8.Sound.ReplicateSound.Listen(function(p82)
        local v83 = v_u_16.GetAudioFadeMultiplier()
        if v_u_14.IsEnabled("WeaponFX") then
            local v84
            if p82 and p82.Name then
                local v85 = p82.Name
                v84 = tostring(v85) or ""
            else
                v84 = ""
            end
            local v86
            if p82 and p82.Class then
                local v87 = p82.Class
                v86 = tostring(v87) or ""
            else
                v86 = ""
            end
            local v88 = string.lower(v84)
            if string.find(v88, "shoot", 1, true) or string.find(v88, "fire", 1, true) then
                local v89 = v_u_16.IsFlashed()
                local v90 = warn
                local v91 = "[WeaponFX][Client][Sound] recv class=%s name=%s flashed=%s parent=%s position=%s path=%s"
                local v92 = tostring(v89)
                local v93
                if p82 then
                    v93 = p82.Parent
                else
                    v93 = p82
                end
                local v94 = tostring(v93)
                local v95
                if p82 then
                    v95 = p82.Position
                else
                    v95 = p82
                end
                local v96 = tostring(v95)
                local v97
                if p82 then
                    v97 = p82.Path
                else
                    v97 = p82
                end
                v90(v91:format(v86, v84, v92, v94, v96, (tostring(v97))))
            end
        end
        if p82.Name == "Bomb Planted Music" and (p82.Class == "Counter-Terrorists" and v_u_81) then
            if v_u_81.Parent then
                v_u_81:Stop()
                v_u_81:Destroy()
            end
            v_u_81 = nil
        end
        if p82.Position then
            local v98 = v_u_12.new(p82.Class)
            local v99 = {
                ["Position"] = p82.Position,
                ["Class"] = p82.Class,
                ["Name"] = p82.Name
            }
            local v100 = p82.Duration
            v98:PlaySoundAtPosition(v99, tonumber(v100), v83)
        elseif p82.Parent or p82.Path then
            if p82.Parent and p82.Parent:IsA("BasePart") then
                local v101 = p82.Parent
                if v101 and v101.Name == "Head" then
                    local v102 = v101.Parent
                    if v102 and (v102:IsA("Model") and (v102:IsDescendantOf(workspace) and v_u_5:GetPlayerFromCharacter(v102) == v_u_7)) then
                        if v_u_14.IsEnabled("WeaponFX") then
                            local v103 = warn
                            local v104 = p82.Name
                            local v105 = tostring(v104)
                            local v106 = p82.Class
                            v103(("[WeaponFX][Client][Sound] skipped local duplicate head sound name=%s class=%s"):format(v105, (tostring(v106))))
                        end
                        return
                    end
                end
            end
            if (p82.Name == "Bomb Defused" or p82.Name == "Hostage Rescued") and v_u_13.GetCurrentScreen() ~= nil then
                return
            end
            if p82.Name == "Bomb Planted Music" and p82.Class == "Counter-Terrorists" then
                if v_u_15.GetState() ~= "Round In Progress" then
                    return
                end
                if v_u_13.GetCurrentScreen() ~= nil then
                    return
                end
                v83 = v83 * ((v_u_11.Get(v_u_7, "Settings.Audio.Music.Bomb/Hostage Volume") or 50) / 50)
            elseif (p82.Name == "Counter-Terrorists Win" or p82.Name == "Terrorists Win") and p82.Class == "Round" then
                if v_u_13.GetCurrentScreen() ~= nil then
                    return
                end
                v83 = v83 * ((v_u_11.Get(v_u_7, "Settings.Audio.Music.Round End Volume") or 50) / 50)
            end
            local v_u_107 = v_u_12.new(p82.Class):playOneTime({
                ["Parent"] = p82.Parent,
                ["Name"] = p82.Name,
                ["Path"] = p82.Path
            }, v83)
            if (p82.Name == "Counter-Terrorists Win" or p82.Name == "Terrorists Win") and (p82.Class == "Round" and v_u_107) then
                if v_u_107 then
                    local v108 = (v_u_11.Get(v_u_7, "Settings.Audio.Music.Round End Volume") or 50) / 50
                    local v109 = (v_u_11.Get(v_u_7, "Settings.Audio.Audio.Master Volume") or 100) / 100
                    local v_u_110 = v_u_107.Volume
                    if v108 > 0 and v109 > 0 then
                        v_u_110 = v_u_110 / (v108 * v109) or v_u_110
                    end
                    v_u_107:SetAttribute("BaseVolume", v_u_110)
                    local function v113()
                        if v_u_107 and v_u_107.Parent then
                            local v111 = (v_u_11.Get(v_u_7, "Settings.Audio.Music.Round End Volume") or 50) / 50
                            local v112 = (v_u_11.Get(v_u_7, "Settings.Audio.Audio.Master Volume") or 100) / 100
                            v_u_107.Volume = (v_u_107:GetAttribute("BaseVolume") or v_u_110) * v111 * v112
                        end
                    end
                    local v_u_114 = v_u_11.CreateListener(v_u_7, "Settings.Audio.Music.Round End Volume", v113)
                    local v_u_115 = v_u_11.CreateListener(v_u_7, "Settings.Audio.Audio.Master Volume", v113)
                    v_u_107.Destroying:Once(function()
                        v_u_11.RemoveListener(v_u_7, "Settings.Audio.Music.Round End Volume", v_u_114)
                        v_u_11.RemoveListener(v_u_7, "Settings.Audio.Audio.Master Volume", v_u_115)
                    end)
                    return
                end
            else
                v_u_81 = p82.Name == "Bomb Planted Music" and (p82.Class == "Counter-Terrorists" and v_u_107)
                if v_u_81 then
                    local v116 = (v_u_11.Get(v_u_7, "Settings.Audio.Music.Bomb/Hostage Volume") or 50) / 50
                    local v117 = (v_u_11.Get(v_u_7, "Settings.Audio.Audio.Master Volume") or 100) / 100
                    local v_u_118 = v_u_81.Volume
                    if v116 > 0 and v117 > 0 then
                        v_u_118 = v_u_118 / (v116 * v117) or v_u_118
                    end
                    v_u_81:SetAttribute("BaseVolume", v_u_118)
                    local function v121()
                        if v_u_81 and v_u_81.Parent then
                            local v119 = (v_u_11.Get(v_u_7, "Settings.Audio.Music.Bomb/Hostage Volume") or 50) / 50
                            local v120 = (v_u_11.Get(v_u_7, "Settings.Audio.Audio.Master Volume") or 100) / 100
                            v_u_81.Volume = (v_u_81:GetAttribute("BaseVolume") or v_u_118) * v119 * v120
                        end
                    end
                    local v_u_122 = v_u_11.CreateListener(v_u_7, "Settings.Audio.Music.Bomb/Hostage Volume", v121)
                    local v_u_123 = v_u_11.CreateListener(v_u_7, "Settings.Audio.Audio.Master Volume", v121)
                    v_u_81.Destroying:Once(function()
                        v_u_11.RemoveListener(v_u_7, "Settings.Audio.Music.Bomb/Hostage Volume", v_u_122)
                        v_u_11.RemoveListener(v_u_7, "Settings.Audio.Audio.Master Volume", v_u_123)
                    end)
                end
            end
        end
    end)
    local v_u_124 = game:GetService("CollectionService")
    local function v_u_127()
        local v_u_125 = v_u_124:GetTagged("Bomb")[1]
        if v_u_125 and v_u_125:IsDescendantOf(workspace) then
            local v_u_126 = nil
            v_u_126 = v_u_125:GetAttributeChangedSignal("Defused"):Connect(function()
                if v_u_125:GetAttribute("Defused") then
                    if v_u_81 then
                        if v_u_81.Parent then
                            v_u_81:Stop()
                            v_u_81:Destroy()
                        end
                        v_u_81 = nil
                    end
                    if v_u_126 then
                        v_u_126:Disconnect()
                    end
                end
            end)
        end
    end
    v_u_124:GetInstanceAddedSignal("Bomb"):Connect(function(_)
        v_u_127()
    end)
    task.defer(function()
        v_u_127()
    end)
    v_u_15.ListenToState(function(_, p128)
        if p128 ~= "Round In Progress" and v_u_81 then
            if v_u_81.Parent then
                v_u_81:Stop()
                v_u_81:Destroy()
            end
            v_u_81 = nil
        end
    end)
    v_u_8.Sound.StopSoundAtPosition.Listen(function(p129)
        local v130 = workspace:FindFirstChild("Debris")
        if v130 then
            for _, v131 in ipairs(v130:GetChildren()) do
                if v131.Name == "Sound" and (v131:IsA("BasePart") and (v131.Position - p129.Position).Magnitude <= p129.Radius) then
                    v131:Destroy()
                end
            end
        end
    end)
    v_u_10.observerRouter("UpdatePlayerNoiseCone", function(p132, p133, p134, p135)
        if typeof(p134) ~= "number" then
            p134 = ({
                ["Footstep"] = v_u_1.GetFootstepRange(p134 or "Concrete", p135),
                ["Landing"] = v_u_1.GetMovementRange("Landing", p135),
                ["Jump"] = v_u_1.GetMovementRange("Jump", p135)
            })[p132]
        end
        if not p134 then
            return nil
        end
        v_u_1.UpdatePlayerNoiseCone(p133, p134, p135)
        return nil
    end)
end
function v_u_1.Start()
    v_u_9.observeCharacter(function(p136, p137)
        local v138 = p136 == v_u_7
        local v_u_139 = v_u_22[p136]
        if not v_u_139 then
            v_u_139 = v_u_17.new(p136)
            v_u_22[p136] = v_u_139
        end
        if v138 then
            v_u_1.ClearPlayerNoiseCone()
        end
        v_u_139:SetCharacter(p137)
        return function()
            v_u_139:SetCharacter(nil)
        end
    end)
    v_u_5.PlayerRemoving:Connect(function(p140)
        local v141 = v_u_22[p140]
        if v141 then
            v_u_22[p140] = nil
            v141:Destroy()
        end
    end)
    v_u_4.Heartbeat:Connect(function(p142)
        local v143 = v_u_7.Character
        local v144
        if v143 and v143:IsDescendantOf(workspace) then
            local v145 = v143:FindFirstChild("Humanoid")
            local v146 = v145 and (v145.Health > 0 and v143:FindFirstChild("HumanoidRootPart"))
            if v146 then
                v144 = v146.Position
            else
                v144 = nil
            end
        else
            v144 = nil
        end
        for _, v147 in pairs(v_u_22) do
            v147:Update(p142, v144)
        end
    end)
end
return v_u_1