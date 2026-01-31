local v_u_1 = game:GetService("Players")
local v2 = game:GetService("ReplicatedStorage")
local v_u_3 = game:GetService("RunService")
local v_u_4 = game:GetService("HttpService")
require(script:WaitForChild("Types"))
local v_u_5 = require(v2.Shared.DebugFlags)
local v_u_6 = require(v2.Shared.Janitor)
local v_u_7 = {}
local v_u_8 = {}
local function v_u_14(p9, p10)
    local v11 = {}
    for _, v12 in pairs(v_u_1:GetPlayers()) do
        if v12.Character and v12.Character:FindFirstChild("HumanoidRootPart") then
            local v13 = v12.Character:FindFirstChild("HumanoidRootPart")
            if v13 and (v13.Position - p9).Magnitude <= p10 then
                table.insert(v11, v12)
            end
        end
    end
    return v11
end
local function v_u_24(p_u_15, p16, p17)
    local v18 = tick()
    local v19 = v_u_7[p_u_15]
    if not v19 then
        v19 = {}
        v_u_7[p_u_15] = v19
        local v20 = v_u_6.new()
        v_u_8[p_u_15] = v20
        v20:Add(v_u_1.PlayerRemoving:Connect(function(p21)
            if p21 == p_u_15 then
                local v22 = p_u_15
                v_u_7[v22] = nil
                if v_u_8[v22] then
                    v_u_8[v22]:Destroy()
                    v_u_8[v22] = nil
                end
            end
        end))
    end
    local v23 = v19[p16]
    if v23 then
        if v18 - v23.lastRequest >= 1 then
            v23.lastRequest = v18
            v23.requestCount = 1
            return false
        else
            if p17 <= v23.requestCount then
                return true
            end
            v23.requestCount = v23.requestCount + 1
            return false
        end
    else
        v19[p16] = {
            ["lastRequest"] = v18,
            ["requestCount"] = 1
        }
        return false
    end
end
local function v_u_35(p25, p26, p_u_27, p28)
    if v_u_5.IsEnabled("ByteNetPackets") then
        local v29, v30 = pcall(function()
            return v_u_4:JSONEncode(p_u_27)
        end)
        local v31 = not v29 and "unknown" or string.format("%.3f KB", #v30 / 1024)
        local v32 = v_u_3:IsServer() and "[SERVER]" or "[CLIENT]"
        local v33 = p25 == "OUTGOING" and "\226\172\134\239\184\143" or "\226\172\135\239\184\143"
        local v34 = not p28 and "" or " | Player: " .. p28.Name
        print(string.format("%s %s %s %s | Size: %s%s | Data: %s", v32, v33, p25, p26, v31, v34, not v29 and "{}" or v30))
    end
end
local function v_u_72(p_u_36, p_u_37, p_u_38)
    local v39 = {}
    for v_u_40, v41 in pairs(p_u_36) do
        if type(v41) == "function" then
            if v_u_40 == "Send" or (v_u_40 == "SendTo" or (v_u_40 == "SendToAll" or (v_u_40 == "SendToAllExcept" or v_u_40 == "SendToList"))) then
                v39[v_u_40] = function(p42, ...)
                    if v_u_40 == "SendToList" then
                        local v43 = select(1, ...)
                        if v43 and #v43 ~= 0 then
                            local v44 = {}
                            for _, v45 in ipairs(v43) do
                                local v46 = p_u_37
                                local v47 = p_u_38
                                local v48
                                if v46.middleware and not v46.middleware(p42, v45) then
                                    v48 = false
                                else
                                    local v49 = v46.maximum_requests_per_second or 10
                                    v48 = (v49 <= 0 or not v_u_24(v45, v47, v49)) and true or false
                                end
                                if v48 then
                                    table.insert(v44, v45)
                                end
                            end
                            if #v44 > 0 then
                                v_u_35("OUTGOING", p_u_38, p42)
                                return p_u_36[v_u_40](p42, v44)
                            end
                        end
                    else
                        local v50 = nil
                        if v_u_40 == "Send" then
                            v50 = v_u_1.LocalPlayer
                        elseif v_u_40 == "SendTo" then
                            v50 = select(1, ...)
                        end
                        if v50 then
                            local v51 = p_u_37
                            local v52 = p_u_38
                            local v53
                            if v51.middleware and not v51.middleware(p42, v50) then
                                v53 = false
                            else
                                local v54 = v51.maximum_requests_per_second or 10
                                v53 = (v54 <= 0 or not v_u_24(v50, v52, v54)) and true or false
                            end
                            if not v53 then
                                return
                            end
                        end
                        v_u_35("OUTGOING", p_u_38, p42, v50)
                        return p_u_36[v_u_40](p42, ...)
                    end
                end
            elseif v_u_40 == "Listen" or v_u_40 == "Connect" then
                v39[v_u_40] = function(p_u_55)
                    local function v58(p56, p57)
                        v_u_35("INCOMING", p_u_38, p56, p57)
                        return p_u_55(p56, p57)
                    end
                    return p_u_36[v_u_40](v58)
                end
            elseif v_u_40 == "Wait" then
                v39[v_u_40] = function()
                    local v59, v60 = p_u_36[v_u_40]()
                    v_u_35("INCOMING", p_u_38, v59, v60)
                    return v59, v60
                end
            else
                v39[v_u_40] = v41
            end
        else
            v39[v_u_40] = v41
        end
    end
    function v39.SendToProximity(p61, p62)
        local v63 = p62.position
        local v64 = p62.range or 60
        if not v63 then
            error("SendToProximity requires position in options")
        end
        local v65 = v_u_14(v63, v64)
        local v66 = false
        for _, v67 in pairs(v65) do
            local v68 = p_u_37
            local v69 = p_u_38
            local v70
            if v68.middleware and not v68.middleware(p61, v67) then
                v70 = false
            else
                local v71 = v68.maximum_requests_per_second or 10
                v70 = (v71 <= 0 or not v_u_24(v67, v69, v71)) and true or false
            end
            if v70 and p_u_36.SendTo then
                p_u_36.SendTo(p61, v67)
                v66 = true
            end
        end
        if v66 then
            v_u_35("OUTGOING", p_u_38, p61)
        end
    end
    return v39
end
return function(p_u_73, p74)
    local v_u_75 = p74 or {}
    local v_u_76 = v_u_75.name or tostring(p_u_73):gsub("table: ", "")
    return function(p77)
        return v_u_72(p_u_73(p77), v_u_75, v_u_76)
    end
end