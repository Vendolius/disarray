local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = game:GetService("Workspace")
game:GetService("Debris")
local v_u_3 = require(v1:WaitForChild("Packages"):WaitForChild("Sift"))
local v_u_4 = table.freeze({
    ["Sandy Brick"] = 0.25,
    ["IndoorWall"] = 0.25
})
local v_u_5 = table.freeze({
    [Enum.Material.Asphalt] = 0.25,
    [Enum.Material.Basalt] = 0.25,
    [Enum.Material.Brick] = 0.25,
    [Enum.Material.Cobblestone] = 0.25,
    [Enum.Material.Concrete] = 0.25,
    [Enum.Material.CrackedLava] = 0.25,
    [Enum.Material.DiamondPlate] = 0.25,
    [Enum.Material.Foil] = 0.25,
    [Enum.Material.Glacier] = 0.25,
    [Enum.Material.Granite] = 0.25,
    [Enum.Material.Grass] = 0.25,
    [Enum.Material.Ground] = 0.25,
    [Enum.Material.Ice] = 0.25,
    [Enum.Material.LeafyGrass] = 0.25,
    [Enum.Material.Limestone] = 0.25,
    [Enum.Material.Marble] = 0.25,
    [Enum.Material.Metal] = 0.25,
    [Enum.Material.Mud] = 0.25,
    [Enum.Material.Pavement] = 0.25,
    [Enum.Material.Rock] = 0.25,
    [Enum.Material.Salt] = 0.25,
    [Enum.Material.Sand] = 0.25,
    [Enum.Material.Sandstone] = 0.25,
    [Enum.Material.Slate] = 0.25,
    [Enum.Material.Snow] = 0.25,
    [Enum.Material.ForceField] = 0.25,
    [Enum.Material.Neon] = 0.25,
    [Enum.Material.CorrodedMetal] = 0.25,
    [Enum.Material.Pebble] = 0.25,
    [Enum.Material.CeramicTiles] = 0.25,
    [Enum.Material.Plaster] = 0.25,
    [Enum.Material.Plastic] = 7,
    [Enum.Material.SmoothPlastic] = 7,
    [Enum.Material.Wood] = 7,
    [Enum.Material.WoodPlanks] = 7,
    [Enum.Material.Cardboard] = 7,
    [Enum.Material.Glass] = 100,
    [Enum.Material.Fabric] = 100
})
local v_u_6 = Instance.new("Folder")
v_u_6.Parent = workspace:FindFirstChild("Debris") or workspace
v_u_6.Name = "RaycastVisualizers"
local function v_u_10(p7)
    local v8 = p7:FindFirstAncestorWhichIsA("Model")
    if v8 then
        local v9 = not v8:FindFirstChildOfClass("Humanoid") and v8.Parent
        if v9 then
            v9 = v8.Parent:FindFirstChildOfClass("Humanoid")
        end
        if v9 then
            return true, v9
        end
    end
    return false, nil
end
local function v_u_14(p11, p12)
    for _, v13 in pairs(p12) do
        if p11 == v13 or p11:IsDescendantOf(v13) then
            return true
        end
    end
    return false
end
local function v_u_37(p15, p16, p17, p18, p19, p20, p21, p22)
    local v23 = RaycastParams.new()
    v23.FilterType = Enum.RaycastFilterType.Include
    v23.CollisionGroup = "Bullet"
    v23.FilterDescendantsInstances = { p17 }
    local v24 = p15 + p16 * 1000
    local v25 = v_u_2:Raycast(v24, p15 - v24, v23)
    if not v25 then
        return 0, Vector3.new(0, 0, 0), p21, false
    end
    local v26 = (p15 - v25.Position).Magnitude
    local v27 = v25.Position
    local v28 = p21 + v26
    local v29 = false
    local v30 = v25.Instance.MaterialVariant
    local v31
    if v30 == "" then
        v31 = false
    else
        v31 = v_u_4[v30] ~= nil
    end
    if v31 then
        p20[v30] = (p20[v30] or 0) + v26
        local v32 = v_u_4[v30] or 20
        if p20[v30] > v32 + p22 then
            return v26, v27, v28, true
        end
        local v33 = {
            ["instance"] = v25.Instance,
            ["position"] = v25.Position,
            ["normal"] = v25.Normal,
            ["material"] = v25.Material
        }
        table.insert(p18, v33)
        return v26, v27, v28, v29
    end
    local v34 = v25.Material
    p19[v34] = (p19[v34] or 0) + v26
    local v35 = v_u_5[v34] or 20
    if p19[v34] > v35 + p22 then
        return v26, v27, v28, true
    end
    local v36 = {
        ["instance"] = v25.Instance,
        ["position"] = v25.Position,
        ["normal"] = v25.Normal,
        ["material"] = v25.Material
    }
    table.insert(p18, v36)
    return v26, v27, v28, v29
end
local function v_u_51(p38, p39, p40, p41)
    local v42 = p39.Unit
    local v43 = {}
    local v44 = {}
    local v45 = 0
    local v46 = {}
    for _ = 1, 100 do
        local v47 = v_u_2:Raycast(p38, v42 * 1000, p41)
        if not v47 then
            break
        end
        p41:AddToFilter(v47.Instance)
        local v48 = {
            ["instance"] = v47.Instance,
            ["position"] = v47.Position,
            ["normal"] = v47.Normal,
            ["material"] = v47.Material
        }
        table.insert(v46, v48)
        local v49, v50
        v49, p38, v45, v50 = v_u_37(v47.Position, v42, v47.Instance, v46, v43, v44, v45, p40)
        if v50 then
            break
        end
    end
    return v46
end
return {
    ["isPartOfHumanoid"] = function(p52)
        return v_u_10(p52)
    end,
    ["cast"] = function(p53, p54, p55, p56, p57)
        local v58 = not p56 and {} or v_u_3.Array.copy(p56)
        if not p55 then
            p55 = RaycastParams.new()
            p55.FilterType = Enum.RaycastFilterType.Exclude
            p55.IgnoreWater = false
            p55.CollisionGroup = "Bullet"
        end
        p55.FilterDescendantsInstances = v58
        while true do
            local v59 = v_u_2:Raycast(p53, p54, p55)
            if not v59 then
                break
            end
            local v60
            if p57 == nil then
                if p55.FilterType == Enum.RaycastFilterType.Include then
                    v60 = not v_u_14(v59.Instance, v58)
                else
                    local v61 = v59.Instance
                    local v62 = v61:IsDescendantOf(v_u_6)
                    local v63 = v61:FindFirstAncestorWhichIsA("Model")
                    if v63 then
                        local v64 = not v63:FindFirstChildOfClass("Humanoid") and v63.Parent
                        if v64 then
                            v64 = v63.Parent:FindFirstChildOfClass("Humanoid")
                        end
                    end
                    v60 = v62 or (v61:FindFirstAncestorWhichIsA("Accessory") ~= nil or v61.Name == "CollisionCapsule")
                end
            else
                v60 = p57(v59.Instance)
            end
            if not v60 then
                return {
                    ["instance"] = v59.Instance,
                    ["position"] = v59.Position,
                    ["normal"] = v59.Normal,
                    ["material"] = v59.Material
                }
            end
            local v65 = v59.Instance
            table.insert(v58, v65)
            p55.FilterDescendantsInstances = v58
        end
        return {
            ["position"] = p53 + p54
        }
    end,
    ["castThrough"] = function(p66, p67, p68, p69)
        local v70 = RaycastParams.new()
        v70.CollisionGroup = "Bullet"
        if p69 then
            v70.FilterDescendantsInstances = p69
        end
        return v_u_51(p66, p67, p68, v70)
    end
}