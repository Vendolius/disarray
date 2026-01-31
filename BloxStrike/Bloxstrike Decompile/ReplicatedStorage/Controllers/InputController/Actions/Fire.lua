local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = game:GetService("RunService")
local v3 = game:GetService("Players")
require(script.Parent.Parent.Types)
local v_u_4 = v3.LocalPlayer
local v_u_5 = require(v1.Controllers.InventoryController)
local v_u_6 = require(v1.Controllers.SpectateController)
local v_u_7 = require(v1.Controllers.HintController)
local v_u_8 = require(v1.Database.Security.Router)
local v_u_9 = require(v1.Database.Components.GameState)
local v_u_10 = nil
local v_u_11 = nil
local v21 = {
    ["Name"] = "Fire",
    ["Group"] = "Default",
    ["Category"] = "Weapon Keys",
    ["Callback"] = function(p12, _)
        if v_u_4:GetAttribute("IsPlayerChatting") then
            return
        elseif v_u_4:GetAttribute("IsSpectating") and p12 == Enum.UserInputState.Begin then
            v_u_6.Previous()
            return
        elseif v_u_6.IsLocalPlayerDead() then
            return
        else
            local v_u_13 = v_u_5.getCurrentEquipped()
            if v_u_13 and v_u_4.Character then
                if v_u_9.GetState() ~= "Buy Period" then
                    v_u_8.broadcastRouter("Cancel Defuse Bomb")
                    if p12 == Enum.UserInputState.Begin then
                        local v14 = v_u_13.Properties.Class
                        local v15 = v_u_13.Properties.Slot
                        if v14 == "C4" then
                            v_u_13:shoot()
                            return
                        end
                        if v15 == "Grenade" then
                            v_u_13:StartThrow()
                            return
                        end
                        if v14 == "Weapon" then
                            v_u_13.IsFireHeld = true
                        end
                        local v16 = not v_u_13.IsBurstShooting and (not v_u_13.IsShooting and v_u_13.Properties.FireRate)
                        if v16 then
                            v16 = tick() - v_u_13.AlternativeSwitchTick > v_u_13.Properties.FireRate
                        end
                        if v16 then
                            if v_u_10 then
                                task.cancel(v_u_10)
                                v_u_10 = nil
                                v_u_11 = nil
                            end
                            local v17 = v_u_13.AlternativeShootingOption == "Burst" and 3 or 1
                            v_u_13.IsBurstShooting = v17 == 3
                            for _ = 1, v17 do
                                v_u_13:shoot()
                                if v_u_13.Rounds and v_u_13.Rounds <= 0 then
                                    v_u_7:createHint("Reload")
                                end
                                task.wait(0.075)
                            end
                            task.wait(0.15)
                            if v_u_13 and v_u_13.IsBurstShooting then
                                v_u_13.IsBurstShooting = false
                                return
                            end
                        elseif not v_u_13.Properties.Automatic and (v_u_13.AlternativeShootingOption == "Default" and (v_u_13.IsShooting and v_u_11 ~= v_u_13.Identifier)) then
                            if v_u_10 then
                                task.cancel(v_u_10)
                            end
                            local v18 = (v_u_13.Properties.FireRate or 0.15) - (tick() - v_u_13.ShootRequestTick)
                            local v19 = math.max(0, v18)
                            if v19 <= 0.15 then
                                v_u_11 = v_u_13.Identifier
                                v_u_10 = task.delay(v19, function()
                                    v_u_2.Heartbeat:Wait()
                                    v_u_2.Heartbeat:Wait()
                                    v_u_10 = nil
                                    v_u_11 = nil
                                    local v20 = v_u_5.getCurrentEquipped()
                                    if v20 then
                                        if v20.Identifier == v_u_13.Identifier then
                                            if v20.Properties.Automatic then
                                                return
                                            elseif v20.AlternativeShootingOption == "Burst" then
                                                return
                                            elseif v20.Rounds <= 0 then
                                                v_u_7:createHint("Reload")
                                            else
                                                v20:shoot()
                                            end
                                        else
                                            return
                                        end
                                    else
                                        return
                                    end
                                end)
                                return
                            end
                        end
                    else
                        if p12 == Enum.UserInputState.End and v_u_13.Properties.Class == "Weapon" then
                            v_u_13.IsFireHeld = false
                            return
                        end
                        if p12 == Enum.UserInputState.End and v_u_13.Properties.Class == "C4" then
                            v_u_13:cancel()
                            return
                        end
                        if v_u_13.Properties.Slot == "Grenade" and p12 == Enum.UserInputState.End then
                            if v_u_13.ThrowStarted and not v_u_13.ThrowFinished then
                                v_u_13:Throw("Far")
                            end
                            return
                        end
                    end
                end
            else
                return
            end
        end
    end
}
return table.freeze(v21)