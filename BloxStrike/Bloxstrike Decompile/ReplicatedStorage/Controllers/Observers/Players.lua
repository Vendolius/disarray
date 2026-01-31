local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = game:GetService("HttpService")
local v3 = game:GetService("Players")
require(v1.Database.Custom.Types)
local v_u_4 = require(v1.Packages.Observers)
local v_u_5 = require(v1.Shared.DebugFlags)
local v_u_6 = v3.LocalPlayer
local v_u_7 = require(script.Components.CreateWeaponModel)
local v_u_8 = {}
local function v_u_16(p9)
    v_u_8[p9] = nil
    local v10 = p9.Character
    if v10 and v10:IsDescendantOf(workspace) then
        local v11 = v10:FindFirstChild("WeaponAttachments")
        if v11 then
            v11:ClearAllChildren()
        end
        local v12 = v10:FindFirstChild("WeaponModel")
        if v12 then
            v12:ClearAllChildren()
        end
        local v13 = workspace:FindFirstChild("Debris")
        if v13 then
            local v14 = v13:FindFirstChild(p9.Name .. "_Weapon")
            if v14 then
                v14:Destroy()
            end
            local v15 = v13:FindFirstChild(p9.Name .. "_WeaponAttachments")
            if v15 then
                v15:Destroy()
            end
        end
    else
        return
    end
end
local function v_u_21(p17)
    local v18 = {}
    for v19 = 1, 3 do
        local v20 = p17:GetAttribute("Slot" .. v19)
        if v20 then
            v18[v19] = v_u_2:JSONDecode(v20)
        end
    end
    return v18
end
local function v_u_32(p22)
    if typeof(p22) ~= "table" then
        return ""
    end
    local v23 = {}
    for v24, v25 in ipairs(p22) do
        if typeof(v25) == "table" then
            local v26 = v25.Position
            local v27 = typeof(v26) == "table" and (v26.Rotation or "") or ""
            local v28 = typeof(v26) == "table" and (v26.X or "") or ""
            local v29 = typeof(v26) == "table" and (v26.Y or "") or ""
            local v30 = string.format
            local v31 = v25.Sticker or ""
            v23[v24] = v30("%s@%s,%s,%s", tostring(v31), tostring(v27), tostring(v28), (tostring(v29)))
        else
            v23[v24] = tostring(v25)
        end
    end
    return table.concat(v23, ";")
end
local function v_u_54(p33)
    if typeof(p33) ~= "table" then
        return ""
    end
    local v34 = table.concat
    local v35 = {}
    local v36 = p33.Identifier or ""
    local v37 = tostring(v36)
    local v38 = p33.Name or ""
    local v39 = tostring(v38)
    local v40 = p33.Skin or ""
    local v41 = tostring(v40)
    local v42 = p33.Float or ""
    local v43 = tostring(v42)
    local v44 = p33.StatTrack or ""
    local v45 = tostring(v44)
    local v46 = p33.NameTag or ""
    local v47 = tostring(v46)
    local v48 = p33.Charm
    local v49
    if v48 == nil or v48 == false then
        v49 = ""
    elseif typeof(v48) == "table" then
        local v50 = v48._id or ""
        local v51 = tostring(v50)
        local v52 = v48.Position or ""
        v49 = v51 .. "@" .. tostring(v52)
    else
        v49 = tostring(v48)
    end
    local v53 = p33.IsSuppressed or ""
    __set_list(v35, 1, {v37, v39, v41, v43, v45, v47, v49, tostring(v53), v_u_32(p33.Stickers)})
    return v34(v35, "|")
end
return v_u_4.observePlayer(function(p_u_55)
    if p_u_55 == v_u_6 then
        return function() end
    end
    local v_u_64 = v_u_4.observeAttribute(p_u_55, "CurrentEquipped", function(p56)
        if v_u_5.IsEnabled("ThirdPersonWeaponModels") then
            local v57 = warn
            local v58 = p_u_55.Name
            local v59 = typeof(p56) == "string" and (#p56 or -1) or -1
            v57(("[ThirdPersonWeaponModels] %s CurrentEquipped changed (%s bytes JSON)"):format(v58, (tostring(v59))))
        end
        if not p56 then
            v_u_16(p_u_55)
            return function() end
        end
        local v_u_60 = v_u_2:JSONDecode(p56)
        local v61 = v_u_54(v_u_60)
        if v61 ~= "" and v_u_8[p_u_55] == v61 then
            return function() end
        end
        v_u_8[p_u_55] = v61
        local v62, v63, _ = pcall(function()
            return v_u_7(p_u_55, v_u_60, (v_u_21(p_u_55)))
        end)
        if v_u_5.IsEnabled("ThirdPersonWeaponModels") then
            if v62 then
                warn(("[ThirdPersonWeaponModels] %s CreateWeaponModel ok"):format(p_u_55.Name))
            else
                warn(("[ThirdPersonWeaponModels] %s CreateWeaponModel failed: %s"):format(p_u_55.Name, (tostring(v63))))
            end
        end
        return function()
            if p_u_55:GetAttribute("CurrentEquipped") == nil then
                v_u_16(p_u_55)
            end
        end
    end)
    return function()
        v_u_64()
        v_u_7.ClearPlayerCache(p_u_55)
        v_u_8[p_u_55] = nil
    end
end)