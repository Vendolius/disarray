local v_u_1 = {}
local v_u_2 = game:GetService("ReplicatedStorage")
local v_u_3 = game:GetService("HttpService")
local v4 = game:GetService("RunService")
require(script:WaitForChild("Types"))
local v_u_5 = require(v_u_2.Database.Components.Common.RemoveFromArray)
local v_u_6 = require(v_u_2.Packages.Signal).new()
v_u_1.OnCasesUpdated = v_u_6
local v_u_7 = v4:IsStudio()
local v_u_8 = {}
local function v_u_11(p9)
    local v10 = DateTime.now().UnixTimestamp
    if v_u_7 then
        return true
    elseif p9.status == "inactive" or not p9.isEnabled then
        return false
    elseif p9.releaseDate or p9.discontinueDate then
        if p9.releaseDate and v10 < DateTime.fromIsoDate(p9.releaseDate).UnixTimestamp then
            return false
        else
            return (not p9.discontinueDate or DateTime.fromIsoDate(p9.discontinueDate).UnixTimestamp > v10) and true or false
        end
    else
        return true
    end
end
function v_u_1.IsCaseEnabled(p12)
    local v13 = v_u_1.GetCase(p12)
    if v13 then
        return v_u_11(v13)
    else
        return false
    end
end
function v_u_1.GetCaseByName(p14)
    if not v_u_8 then
        return nil
    end
    for _, v15 in ipairs(v_u_8) do
        if v15.name == p14 then
            return v15
        end
    end
    return nil
end
function v_u_1.GetCase(p16)
    if not v_u_8 then
        return nil
    end
    for _, v17 in ipairs(v_u_8) do
        if v17.caseId == p16 then
            return v17
        end
    end
    return nil
end
function v_u_1.GetFeaturedCases(p_u_18)
    local v19 = {}
    for _, v20 in ipairs(v_u_8) do
        if v20.isFeatured and v_u_11(v20) then
            table.insert(v19, v20)
        end
    end
    table.sort(v19, function(p21, p22)
        return p21.displayOrder < p22.displayOrder
    end)
    v_u_5(v19, function(p23, _)
        return p_u_18 < p23
    end)
    return v19
end
function v_u_1.GetCases()
    local v24 = {}
    for _, v25 in ipairs(v_u_8) do
        if v_u_11(v25) then
            table.insert(v24, v25)
        end
    end
    table.sort(v24, function(p26, p27)
        return p26.displayOrder < p27.displayOrder
    end)
    return v24
end
function v_u_1.ObserveAvailableCases(p28)
    local v_u_29 = v_u_6:Connect(p28)
    if v_u_8 then
        p28(v_u_8)
    end
    return function()
        v_u_29:Disconnect()
    end
end
if v_u_2:GetAttribute("AvaiableCases") then
    v_u_8 = v_u_3:JSONDecode((v_u_2:GetAttribute("AvaiableCases")))
    if #v_u_6:GetConnections() > 0 then
        v_u_6:Fire(v_u_8)
    end
end
v_u_2:GetAttributeChangedSignal("AvaiableCases"):Connect(function()
    local v30 = v_u_2:GetAttribute("AvaiableCases")
    if v30 then
        v_u_8 = v_u_3:JSONDecode(v30)
        if #v_u_6:GetConnections() > 0 then
            v_u_6:Fire(v_u_8)
        end
    else
        return
    end
end)
return v_u_1