local v_u_1 = game:GetService("Players")
local v2 = game:GetService("RunService")
local v_u_3 = require(script.Parent.Parent.process.client)
local v_u_4 = require(script.Parent.Parent.process.server)
require(script.Parent.Parent.types)
local v_u_5 = v2:IsServer() and "server" or "client"
return function(p6, p_u_7)
    local v8 = p6.ReliabilityType or "Reliable"
    local v_u_9 = {}
    local v_u_10
    if v8 == "Reliable" then
        v_u_10 = v_u_4.sendPlayerReliable
    else
        v_u_10 = v_u_4.sendPlayerUnreliable
    end
    local v_u_11
    if v8 == "Reliable" then
        v_u_11 = v_u_4.sendAllReliable
    else
        v_u_11 = v_u_4.sendAllUnreliable
    end
    local v_u_12
    if v8 == "Reliable" then
        v_u_12 = v_u_3.sendReliable
    else
        v_u_12 = v_u_3.sendUnreliable
    end
    local v_u_13 = p6.Value.Write
    local v14 = {}
    local v16 = {
        ["__index"] = function(p15)
            if (p15 == "SendTo" or (p15 == "SendToAllExcept" or p15 == "SendToAll")) and v_u_5 == "client" then
                error("You cannot use SendTo, SendToAllExcept, or SendToAll on the client")
            elseif p15 == "Send" and v_u_5 == "server" then
                error("You cannot use Send on the server")
            end
        end
    }
    setmetatable(v14, v16)
    v14.Reader = p6.Value.Read
    v14.reader = p6.Value.Read
    if v_u_5 == "server" then
        function v14.SendToList(p17, p18)
            for _, v19 in p18 do
                v_u_10(v19, p_u_7, v_u_13, p17)
            end
        end
        function v14.SendTo(p20, p21)
            v_u_10(p21, p_u_7, v_u_13, p20)
        end
        function v14.SendToAllExcept(p22, p23)
            for _, v24 in v_u_1:GetPlayers() do
                if v24 ~= p23 then
                    v_u_10(v24, p_u_7, v_u_13, p22)
                end
            end
        end
        function v14.SendToAll(p25)
            v_u_11(p_u_7, v_u_13, p25)
        end
    elseif v_u_5 == "client" then
        function v14.Send(p26)
            v_u_12(p_u_7, v_u_13, p26)
        end
    end
    function v14.Wait()
        local v_u_27 = nil
        local v_u_28 = coroutine.running()
        local v29 = v_u_9
        local function v32(p30, p31)
            task.spawn(v_u_28, p30, p31)
            table.remove(v_u_9, v_u_27)
        end
        table.insert(v29, v32)
        v_u_27 = #v_u_9
        return coroutine.yield()
    end
    function v14.Listen(p_u_33)
        local v34 = v_u_9
        table.insert(v34, p_u_33)
        return function()
            local v35 = table.find(v_u_9, p_u_33)
            if v35 then
                table.remove(v_u_9, v35)
            end
        end
    end
    v14.Connect = v14.Listen
    function v14.GetListeners()
        return v_u_9
    end
    return v14
end