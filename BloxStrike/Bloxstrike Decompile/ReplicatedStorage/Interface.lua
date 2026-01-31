local v_u_1 = {}
v_u_1.__index = v_u_1
local v_u_2 = game:GetService("ReplicatedStorage")
local v_u_3 = game:GetService("StarterGui")
local v_u_4 = game:GetService("Players").LocalPlayer
local v_u_5 = v_u_4:WaitForChild("PlayerGui")
local v_u_6 = require(v_u_2.Classes.Sound)
local v_u_7 = require(v_u_2.Database.Security.Router)
local v_u_8 = require(v_u_2.Shared.Promise)
local v_u_9 = require(v_u_2.Controllers.DataController)
local v_u_10 = require(script.MenuState)
local v_u_11 = script:WaitForChild("Screens")
local v_u_12 = v_u_2.Assets.UI.MainGui
v_u_12.Parent = v_u_5
local function v_u_14(p_u_13)
    debug.setmemorycategory((("%*"):format(p_u_13.Name)))
    return v_u_8.try(function()
        return require(p_u_13)
    end):catch(warn)
end
local function v_u_20(p15, p16)
    if p16 then
        for _, v17 in ipairs(p15:GetChildren()) do
            local v_u_18 = p16:FindFirstChild(v17.Name)
            if v17:IsA("Folder") then
                if v_u_18 then
                    v_u_20(v17, v_u_18)
                else
                    warn((("Missing corresponding interface folder : \"%*\""):format((string.lower(v17:GetFullName())))))
                end
            elseif v17:IsA("ModuleScript") then
                if v_u_18 then
                    v_u_14(v17):andThen(function(p19)
                        v_u_8.try(p19.Initialize, v_u_12, v_u_18):andThen(p19.Start):catch(warn)
                    end)
                else
                    warn((("Missing corresponding interface module for : \"%*\""):format((string.lower(v17:GetFullName())))))
                end
            end
        end
    else
        warn((("Pointer: \"%*\" is not apart of interface."):format(p15.Name)))
    end
end
function v_u_1.guarantee(p21)
    for _ = 1, 15 do
        if pcall(p21) then
            break
        end
    end
end
function v_u_1.Initialize()
    v_u_10.Initialize(v_u_12)
    v_u_1.guarantee(function()
        v_u_3:SetCoreGuiEnabled(Enum.CoreGuiType.All, false)
        v_u_3:SetCore("ResetButtonCallback", false)
    end)
    local v_u_22 = v_u_12:WaitForChild("Gameplay"):WaitForChild("Bottom")
    local v_u_23 = nil
    local v_u_24 = nil
    local v_u_25 = nil
    local v_u_26 = nil
    local v_u_27 = nil
    local function v_u_31(p28)
        local v29 = require(v_u_2.Components.Common.GetUserPlatform)
        local v30 = table.find(v29(), "Mobile") and 1 or p28
        if v_u_23 then
            v_u_23.Scale = v30
        end
        if v_u_24 then
            v_u_24.Scale = v30
        end
        if v_u_25 then
            v_u_25.Scale = v30
        end
        if v_u_26 then
            v_u_26.Scale = v30
        end
        if v_u_27 then
            v_u_27.Scale = v30
        end
    end
    task.spawn(function()
        task.wait(0.1)
        local v32 = v_u_22:FindFirstChild("Ammo")
        if v32 then
            local v33 = v32:FindFirstChild("UIScale")
            if v33 then
                v_u_23 = v33
            else
                local v34 = Instance.new("UIScale")
                v34.Name = "HUDScale"
                v34.Parent = v32
                v_u_23 = v34
            end
        end
        local v35 = v_u_22:FindFirstChild("Armor")
        if v35 then
            local v36 = v35:FindFirstChild("UIScale")
            if v36 then
                v_u_24 = v36
            else
                local v37 = Instance.new("UIScale")
                v37.Name = "HUDScale"
                v37.Parent = v35
                v_u_24 = v37
            end
        end
        local v38 = v_u_22:FindFirstChild("Health")
        if v38 then
            local v39 = v38:FindFirstChild("UIScale")
            if v39 then
                v_u_25 = v39
            else
                local v40 = Instance.new("UIScale")
                v40.Name = "HUDScale"
                v40.Parent = v38
                v_u_25 = v40
            end
        end
        local v41 = v_u_22:FindFirstChild("Inventory")
        if v41 then
            local v42 = v41:FindFirstChild("UIScale")
            if v42 then
                v_u_26 = v42
            else
                local v43 = Instance.new("UIScale")
                v43.Name = "HUDScale"
                v43.Parent = v41
                v_u_26 = v43
            end
        end
        local v44 = v_u_22:FindFirstChild("Money")
        if v44 then
            local v45 = v44:FindFirstChild("UIScale")
            if v45 then
                v_u_27 = v45
            else
                local v46 = Instance.new("UIScale")
                v46.Name = "HUDScale"
                v46.Parent = v44
                v_u_27 = v46
            end
        end
        v_u_31(v_u_9.Get(v_u_4, "Settings.Game.HUD.Scale") or 1)
    end)
    v_u_9.CreateListener(v_u_4, "Settings.Game.HUD.Scale", function(p47)
        if v_u_23 and (v_u_24 and (v_u_25 and (v_u_26 and v_u_27))) then
            v_u_31(p47 or 1)
        end
    end)
    v_u_7.observerRouter("RunInterfaceSound", function(p48)
        local v49 = (v_u_9.Get(v_u_4, "Settings.Audio.Music.Main Menu Volume") or 100) / 100
        local v50 = {
            ["Parent"] = v_u_5,
            ["Name"] = p48
        }
        v_u_6.new("Interface"):playOneTime(v50, v49)
    end)
    v_u_7.observerRouter("RunStoreSound", function(p51)
        local v52 = (v_u_9.Get(v_u_4, "Settings.Audio.Music.Main Menu Volume") or 100) / 100
        local v53 = {
            ["Parent"] = v_u_5,
            ["Name"] = p51
        }
        v_u_6.new("Store"):playOneTime(v53, v52)
    end)
end
function v_u_1.Start()
    v_u_20(v_u_11, v_u_12)
end
return v_u_1