local v_u_1 = {}
local v_u_2 = game:GetService("ReplicatedStorage")
local v_u_3 = game:GetService("HttpService")
local v4 = game:GetService("Players")
require(v_u_2.Database.Custom.Types)
local v_u_5 = require(v_u_2.Controllers.CameraController)
local v_u_6 = require(v_u_2.Controllers.DataController)
local v_u_7 = require(v_u_2.Database.Security.Remotes)
local v_u_8 = require(v_u_2.Database.Security.Router)
local v9 = require(v_u_2.Packages.Signal)
local v_u_10 = require(v_u_2.Classes.Loadout)
local v_u_11 = require(v_u_2.Database.Custom.Constants)
local v_u_12 = require(v_u_2.Components.Common.VFXLibary.CreateMuzzleFlash.Character)
local v_u_13 = require(v_u_2.Components.Common.VFXLibary.CreateTracer)
local v_u_14 = require(v_u_2.Components.Common.VFXLibary.CreateMarker)
local v_u_15 = require(v_u_2.Components.Common.VFXLibary.CreateImpact)
local v_u_16 = require(v_u_2.Components.Common.VFXLibary.BreakGlass)
local v_u_17 = require(v_u_2.Components.Common.VFXLibary.CreateVoxelSmoke)
local v_u_18 = require(v_u_2.Components.Common.VFXLibary.CreateVoxelFire)
local v_u_19 = require(v_u_2.Components.Common.VFXLibary.FlashEffect)
local v_u_20 = require(v_u_2.Components.Common.CreateRagdoll)
local v_u_21 = require(v_u_2.Components.Common.RecycleFX)
local v_u_22 = v9.new()
v_u_1.OnInventoryItemEquipped = v_u_22
local v_u_23 = v9.new()
v_u_1.OnInventoryChanged = v_u_23
local v_u_24 = v4.LocalPlayer
local v_u_25 = nil
local v_u_26 = 0
local function v_u_29()
    local v27 = workspace:FindFirstChild("Debris")
    if v27 then
        for _, v28 in ipairs(v27:GetChildren()) do
            if v28:HasTag("Ragdoll") then
                v28:Destroy()
            end
        end
    end
end
function v_u_1.GetInventoryItemFromIdentifier(p30, p31)
    local v32 = v_u_6.Get(p30, "Inventory")
    if not v32 then
        return nil
    end
    for _, v33 in ipairs(v32) do
        if v33._id == p31 then
            return v33
        end
    end
    return nil
end
function v_u_1.GetEquippedInventoryItem(p34, p35)
    local v36 = p34:GetAttribute("Team")
    if not v36 or v36 ~= "Counter-Terrorists" and v36 ~= "Terrorists" then
        return nil
    end
    local v37, v38 = v_u_6.Get(p34, "Inventory", "Loadout")
    if not (v37 and v38) then
        return nil
    end
    local v39 = v38[v36]
    for _, v40 in ipairs(string.split(p35, ".")) do
        local v41 = tonumber(v40) or v40
        if v39 then
            v39 = v39[v41]
        end
        if not v39 then
            return nil
        end
    end
    for _, v42 in ipairs(v37) do
        if v42._id == v39 then
            return v42
        end
    end
    return nil
end
function v_u_1.getInventorySlot(p43)
    if v_u_25 then
        return v_u_25.Inventory[p43]
    else
        return nil
    end
end
function v_u_1.getPreviousEquipped()
    if v_u_25 then
        return v_u_25.PreviousEquipped
    else
        return nil
    end
end
function v_u_1.getCurrentEquipped()
    if v_u_25 then
        return v_u_25.CurrentEquipped
    else
        return nil
    end
end
function v_u_1.getCurrentInventory()
    if v_u_25 then
        return v_u_25.Inventory
    else
        return nil
    end
end
function v_u_1.getInventoryItemFromLoadout(p44)
    if v_u_25 then
        return v_u_25:getInventoryItemFromLoadout(p44)
    else
        return nil
    end
end
function v_u_1.UpdateStatTrack(_)
    local v45 = v_u_24.Character
    local v46
    if v45 and v45:IsDescendantOf(workspace) then
        local v47 = v45:FindFirstChild("Humanoid")
        v46 = v47 and v47.Health > 0 and true or false
    else
        v46 = false
    end
    if v46 then
        local v48 = v_u_1.getCurrentInventory()
        if not v48 then
            return
        end
        for _, v49 in pairs(v48) do
            for _, v50 in pairs(v49._items) do
                local v51 = v_u_1.GetInventoryItemFromIdentifier(v_u_24, v50._id)
                if v51 then
                    v50:updateStatTrackCounter(v51.StatTrack)
                end
            end
        end
    end
end
function v_u_1.CleanupCurrentLoadout()
    if v_u_25 then
        v_u_25:destroy()
        v_u_25 = nil
    end
end
local function v_u_60(p52, p53, p54)
    if v_u_25 then
        local v55 = v_u_25.Inventory[p52]
        if not v55 then
            return
        end
        local v56 = v55._items[p53]
        if not v56 then
            return
        end
        local v57 = v_u_25.CurrentEquipped
        local v58
        if v57 then
            v58 = v57.Identifier
        else
            v58 = v57
        end
        if v57 and v56.Identifier == v57.Identifier then
            return
        end
        if v57 then
            v57:unequip()
        end
        v_u_25:setCurrentEquipped(v56)
        local v59 = v_u_25.CurrentEquipped
        if v59 then
            if not require(v_u_2.Controllers.CaseSceneController).IsActive() then
                v_u_5.updateCameraFOV(v_u_11.DEFAULT_CAMERA_FOV)
            end
            v59:equip()
            if p54 then
                v_u_7.Inventory.WeaponEquipped.Send({
                    ["Identifier"] = v59.Identifier,
                    ["PreviousIdentifier"] = v58
                })
            end
        end
        v_u_26 = tick()
        if v_u_25.CurrentEquipped then
            v_u_22:Fire(p53, v_u_25.CurrentEquipped)
        end
    end
end
function v_u_1.equip(p61, p62)
    if tick() - v_u_26 > 0 then
        v_u_60(p61, p62, true)
    end
end
function v_u_1.equipLocal(p63, p64)
    v_u_60(p63, p64, false)
end
function v_u_1.removeInventoryItem(p65)
    if v_u_25 then
        v_u_25:removeInventoryItem(p65)
        local v66 = not v_u_25.CurrentEquipped and v_u_25:getNextInventorySlotFromPriority()
        if v66 then
            v_u_1.equip(v66, 1)
        end
        v_u_23:Fire(v_u_25.Inventory)
    end
end
function v_u_1.newInventoryItem(p67)
    if v_u_25 then
        v_u_25:grantPlayerInventoryItem(p67.slot, p67.identifier, p67._id, p67.weapon, p67.skin, p67.Float, p67.StatTrack, p67.NameTag, p67.OriginalOwner, p67.Charm, p67.Stickers, p67.customProperties)
        if p67.shouldEquip then
            local _, v68, v69 = v_u_25:getInventoryItemFromLoadout(p67.identifier)
            if v68 and v69 then
                v_u_1.equipLocal(v68, v69)
            else
                warn((("[InventoryController] Could not find item %* in loadout!"):format(p67.identifier)))
            end
        else
            local v70 = not v_u_25.CurrentEquipped and v_u_25:getNextInventorySlotFromPriority()
            if v70 then
                v_u_1.equip(v70, 1)
            end
        end
        v_u_23:Fire(v_u_25.Inventory)
    end
end
local function v_u_79(p71)
    if v_u_25 then
        local v_u_72 = p71 or 0
        if tick() - v_u_26 < 1.5 then
            return
        else
            local v_u_73 = v_u_24:GetAttribute("CurrentEquipped")
            if v_u_73 then
                local v74, v75 = pcall(function()
                    return v_u_3:JSONDecode(v_u_73)
                end)
                if v74 and (v75 and v75.Identifier) then
                    local v76 = v_u_25.CurrentEquipped
                    if v76 and v76.Identifier == v75.Identifier then
                        return
                    else
                        local v77, _, v78 = v_u_25:getInventoryItemFromLoadout(v75.Identifier)
                        if v77 then
                            if v76 then
                                v76:unequip()
                            end
                            v_u_25:setCurrentEquipped(v77)
                            v77:equip()
                            if v_u_25.CurrentEquipped then
                                v_u_22:Fire(v78, v_u_25.CurrentEquipped)
                            end
                        elseif v_u_72 < 5 then
                            task.delay(0.2, function()
                                v_u_79(v_u_72 + 1)
                            end)
                        end
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
end
function v_u_1.Initialize()
    v_u_7.Inventory.RemoveInventoryItem.Listen(v_u_1.removeInventoryItem)
    v_u_7.Inventory.NewInventoryItem.Listen(v_u_1.newInventoryItem)
    v_u_7.Inventory.UpdateStatTrack.Listen(function(p80)
        local v81 = p80.Player
        local v82 = p80.Identifier
        if not (v81 and v82) then
            return
        end
        local v83 = v_u_6.Get(v81, "Inventory")
        if v83 then
            for _, v84 in ipairs(v83) do
                if v84._id == v82 then
                    v84.StatTrack = p80.StatTrack
                    break
                end
            end
        end
        if v81 == v_u_24 then
            local v85 = v_u_1.getCurrentInventory()
            if not v85 then
                return
            end
            for _, v86 in pairs(v85) do
                for _, v87 in pairs(v86._items) do
                    if v87._id == v82 then
                        v87:updateStatTrackCounter(p80.StatTrack)
                        return
                    end
                end
            end
        end
    end)
    v_u_7.Inventory.CleanupGameLoadout.Listen(function()
        if v_u_25 then
            v_u_25:destroy()
            v_u_25 = nil
        end
    end)
    v_u_7.Inventory.CreateGameLoadout.Listen(function(...)
        v_u_25 = v_u_10.new(...)
        if v_u_25 then
            v_u_23:Fire(v_u_25.Inventory)
        end
    end)
    v_u_24:GetAttributeChangedSignal("CurrentEquipped"):Connect(function()
        task.defer(v_u_79)
    end)
end
function v_u_1.Start()
    v_u_6.CreateListener(v_u_24, "Settings.Video.Presets.Ragdolls", function(p88)
        if p88 == false then
            v_u_29()
        end
    end)
    v_u_7.VFX.CreateRagdoll.Listen(function(p89)
        if v_u_6.Get(v_u_24, "Settings.Video.Presets.Ragdolls") ~= false then
            v_u_20(p89)
        else
            local v90 = p89.Character
            if v90 and (typeof(v90) == "Instance" and v90:IsA("Model")) then
                v90:Destroy()
            end
        end
    end)
    v_u_7.VFX.CleanupDebris.Listen(v_u_21)
    v_u_7.VFX.CreateCharacterMuzzleFlash.Listen(function(p91)
        if v_u_6.Get(v_u_24, "Settings.Video.Presets.Muzzle Flash") ~= false then
            v_u_12(p91.PlayerName, p91.WeaponName, p91.ShootingHand, p91.Suppressor)
        end
    end)
    v_u_7.VFX.CreateImpact.Listen(function(p92)
        v_u_15(p92.Instance, p92.Material, p92.Position, p92.Normal, p92.Exit, p92.Ricochet, nil, p92.AttackerUserId)
    end)
    v_u_7.VFX.CreateMarker.Listen(function(p93)
        v_u_14(p93.Instance, p93.Type, p93.Position, p93.Normal)
    end)
    v_u_7.VFX.CreateTracer.Listen(function(p94)
        v_u_13(p94.Distance, p94.Origin, p94.Target)
    end)
    v_u_7.VFX.BreakGlass.Listen(function(p95)
        v_u_16(p95.Instance, p95.Position, p95.Direction)
    end)
    v_u_7.VFX.CreateVoxelSmoke.Listen(function(p96)
        v_u_17.Create(p96)
    end)
    v_u_7.VFX.DestroyVoxelSmoke.Listen(function(p97)
        v_u_17.Destroy(p97)
    end)
    v_u_7.VFX.DisruptVoxelSmoke.Listen(function(p98)
        v_u_17.Disrupt(p98.Position, p98.Radius, p98.Duration)
    end)
    v_u_7.VFX.CreateVoxelFire.Listen(function(p99)
        v_u_18.Create(p99)
    end)
    v_u_7.VFX.DestroyVoxelFire.Listen(function(p100)
        v_u_18.Destroy(p100)
    end)
    v_u_7.VFX.UpdateVoxelFire.Listen(function(p101)
        v_u_18.Update(p101)
    end)
    v_u_7.VFX.FlashPlayer.Listen(function(p102)
        v_u_19.Flash(p102)
    end)
    require(v_u_2.Database.Components.GameState).ListenToState(function(_, p103)
        if p103 == "Buy Period" then
            v_u_17.DestroyAll()
            v_u_18.DestroyAll()
        end
    end)
    v_u_6.CreateListener(v_u_24, "Inventory", function(p104)
        v_u_1.UpdateStatTrack(p104)
    end)
    v_u_8.observerRouter("GetInventoryItemFromIdentifier", function(p105, p106)
        return v_u_1.GetInventoryItemFromIdentifier(p105, p106)
    end)
    v_u_8.observerRouter("GetEquippedInventoryItem", function(p107, p108)
        return v_u_1.GetEquippedInventoryItem(p107, p108)
    end)
    v_u_8.observerRouter("GetCurrentEquipped", function()
        return v_u_1.getCurrentEquipped()
    end)
end
return v_u_1