local v_u_1 = {}
v_u_1.__index = v_u_1
local v2 = game:GetService("ReplicatedStorage")
local v_u_3 = game:GetService("RunService")
local v4 = game:GetService("Players")
require(v2.Database.Custom.Types)
require(script:WaitForChild("Types"))
local v_u_5 = v4.LocalPlayer
local v_u_6 = require(v2.Components.Common.GetWeaponProperties)
local v_u_7 = require(v2.Database.Custom.GameStats.NumberSlots)
local v8 = require(v2.Components.Grenade)
local v9 = require(v2.Components.Weapon)
local v10 = require(v2.Components.Melee)
local v11 = require(v2.Components.C4)
local v_u_12 = require(v2.Shared.Janitor)
local v_u_13 = {
    ["Grenade"] = v8,
    ["Weapon"] = v9,
    ["Melee"] = v10,
    ["C4"] = v11
}
function v_u_1.setCurrentEquipped(p14, p15)
    p14.PreviousEquipped = p14.CurrentEquipped
    p14.CurrentEquipped = p15
end
function v_u_1.getNextInventorySlotFromPriority(p16)
    local v17 = -1
    local v18 = nil
    for v19, v20 in ipairs(p16.Inventory) do
        if #v20._items >= 1 then
            local v21 = v_u_7.Priorities[v19] or 0
            if v17 < v21 then
                v18 = v19
                v17 = v21
            end
        end
    end
    return v18
end
function v_u_1.getInventoryItemFromLoadout(p22, p23)
    local v24 = nil
    local v25 = nil
    local v26 = nil
    for v27, v28 in ipairs(p22.Inventory) do
        local v29 = v28._items
        for v30, v31 in ipairs(v29) do
            if v31.Identifier == p23 then
                v26 = v30
                v25 = v27
                v24 = v31
                break
            end
        end
    end
    return v24, v25, v26
end
function v_u_1.removeInventoryItem(p32, p33)
    local v34, v35, v36 = p32:getInventoryItemFromLoadout(p33)
    local v37 = v34 and p32.Inventory[v35]
    if v37 then
        table.remove(v37._items, v36)
        if p32.CurrentEquipped == v34 then
            p32:setCurrentEquipped(nil)
        end
        v34:destroy()
    end
end
function v_u_1.grantPlayerInventoryItem(p_u_38, p39, p40, p41, p42, p43, p44, p45, p46, p47, p48, p49, p50)
    local v51 = p_u_38.Inventory[p39]
    local v52 = ("%* does not exist in player inventory"):format(p39)
    assert(v51, v52)
    local v53 = v_u_13[v_u_6(p42).Class]
    local v54 = ("Client couldn\'t find weapon component for \"%*\""):format(p42)
    assert(v53, v54)
    local v_u_55 = v53.new(v_u_5, p40, p41, p39, p42, p43, p44, p45, p46, p47, p48, p49, p50)
    local v56 = v51._items
    table.insert(v56, v_u_55)
    p_u_38.Janitor:Add(function()
        if not p_u_38.IsDestroyed and v_u_55 then
            local v57 = v_u_55
            if getmetatable(v57) and not v_u_55.IsDestroyed then
                v_u_55:destroy()
            end
        end
    end)
end
function v_u_1.new(p58)
    local v59 = v_u_1
    local v_u_60 = setmetatable({}, v59)
    v_u_60.Janitor = v_u_12.new()
    v_u_60.IsDestroyed = false
    v_u_60.Inventory = p58
    v_u_60.PreviousEquipped = nil
    v_u_60.CurrentEquipped = nil
    v_u_60.Janitor:Add(v_u_3.RenderStepped:Connect(function(p61)
        if v_u_60.IsDestroyed then
            return
        else
            local v62 = v_u_5.Character
            if not (v62 and v62:GetAttribute("Dead")) then
                if v_u_60.CurrentEquipped then
                    v_u_60.CurrentEquipped.Viewmodel:render(p61)
                end
            end
        end
    end))
    return v_u_60
end
function v_u_1.destroy(p63)
    if not p63.IsDestroyed then
        p63.IsDestroyed = true
        if p63.CurrentEquipped then
            if p63.CurrentEquipped.unequip then
                p63.CurrentEquipped:unequip()
            end
            if p63.CurrentEquipped.destroy and not p63.CurrentEquipped.IsDestroyed then
                p63.CurrentEquipped:destroy()
            end
            p63.CurrentEquipped = nil
        end
        if p63.PreviousEquipped then
            if p63.PreviousEquipped.destroy and not p63.PreviousEquipped.IsDestroyed then
                p63.PreviousEquipped:destroy()
            end
            p63.PreviousEquipped = nil
        end
        if p63.Inventory then
            for _, v64 in ipairs(p63.Inventory) do
                if v64 and v64._items then
                    table.clear(v64._items)
                end
            end
        end
        p63.Janitor:Destroy()
        p63.Janitor = nil
        p63.Inventory = nil
    end
end
return v_u_1