local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = require(game.ReplicatedStorage.Shared.Promise)
local function v4(p_u_3)
    debug.setmemorycategory((("%*"):format(p_u_3.Name)))
    return v_u_2.try(function()
        return require(p_u_3)
    end):catch(warn)
end
for _, v5 in ipairs(v1.Controllers:GetChildren()) do
    if v5:IsA("ModuleScript") then
        v4(v5):andThen(function(p6)
            local v7 = typeof(p6) == "table" and p6.Initialize
            if v7 then
                v_u_2.try(v7):catch(warn):await()
            end
            local v8 = typeof(p6) == "table" and p6.Start
            if v8 then
                v_u_2.try(v8):catch(warn)
            end
        end)
    end
end
for _, v9 in ipairs(v1.Controllers.Observers:GetChildren()) do
    if v9:IsA("ModuleScript") then
        v4(v9)
    elseif v9:IsA("Folder") then
        for _, v10 in ipairs(v9:GetChildren()) do
            if v10:IsA("ModuleScript") then
                v4(v10)
            end
        end
    end
end
v4(v1:WaitForChild("Interface")):andThen(function(p_u_11)
    return v_u_2.try(p_u_11.Initialize):andThen(function()
        return p_u_11.Start()
    end):catch(warn)
end)