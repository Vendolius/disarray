local v1 = game:GetService("ReplicatedStorage")
local v2 = game:GetService("Players")
require(script.Parent.Parent.Types)
local v_u_3 = v2.LocalPlayer
local v_u_4 = require(v1.Controllers.InventoryController)
local v_u_5 = require(v1.Controllers.SpectateController)
local v_u_6 = require(v1.Database.Components.GameState)
local v_u_7 = {
    ["ToggleScope"] = true
}
return table.freeze({
    ["Name"] = "Secondary Fire",
    ["Group"] = "Default",
    ["Category"] = "Weapon Keys",
    ["Callback"] = function(p8, _)
        if v_u_3:GetAttribute("IsSpectating") and p8 == Enum.UserInputState.Begin then
            v_u_5.Next()
            return
        elseif v_u_5.IsLocalPlayerDead() then
            return
        else
            local v9 = v_u_4.getCurrentEquipped()
            if v_u_3.Character and v9 then
                if not v9 or (v9.Properties.Slot ~= "Grenade" or v_u_6.GetState() ~= "Buy Period") then
                    if p8 == Enum.UserInputState.Begin then
                        if v9.Properties.Class == "Grenade" then
                            if v_u_6.GetState() ~= "Buy Period" then
                                v9:StartThrow()
                                return
                            end
                        else
                            if v9.Properties.HasScope then
                                v9:scope(v_u_7.ToggleScope)
                                return
                            end
                            if v9.Properties.HasSuppressor then
                                if v9.IsSuppressed then
                                    v9:removeSuppressor()
                                else
                                    v9:addSuppressor()
                                end
                            end
                            if v9.Properties.ShootingOptions == "Burst" then
                                v9:updateFireMode()
                                return
                            end
                            if v9.Properties.Type == "Equipment" and v_u_6.GetState() ~= "Buy Period" then
                                v9:shoot(true)
                                return
                            end
                        end
                    else
                        if v9.Properties.HasScope and (not v_u_7.ToggleScope and p8 == Enum.UserInputState.End) then
                            v9:unscope()
                            return
                        end
                        if v9.Properties.Slot == "Grenade" and p8 == Enum.UserInputState.End then
                            if v_u_6.GetState() == "Buy Period" then
                                return
                            end
                            if v9.ThrowStarted and not v9.ThrowFinished then
                                v9:Throw("Near")
                            end
                        end
                    end
                end
            else
                return
            end
        end
    end
})