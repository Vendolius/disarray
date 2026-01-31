local v_u_1 = game:GetService("ReplicatedStorage")
require(v_u_1.Database.Custom.Types)
return function(p2)
    local v3 = v_u_1.Database.Custom.Weapons:FindFirstChild(p2)
    local v4 = ("\"%*\" is not a valid member of database.custom.weapons"):format(p2)
    assert(v3, v4)
    return require(v3)
end