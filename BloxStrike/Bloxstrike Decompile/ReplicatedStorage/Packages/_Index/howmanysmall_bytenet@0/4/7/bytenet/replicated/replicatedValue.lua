local v_u_1 = game:GetService("HttpService")
local v_u_2 = game:GetService("RunService"):IsServer() and "server" or "client"
local v3 = {}
local v_u_4 = {
    ["__index"] = v3
}
function v3.write(p5, p6)
    local v7 = v_u_2 == "server"
    assert(v7, "cannot write to replicatedvalue on client")
    p5._luauData = p6
    p5._value.Value = v_u_1:JSONEncode(p6)
end
function v3.read(p8)
    return p8._luauData
end
return function(p9)
    local v10 = v_u_4
    local v_u_11 = setmetatable({}, v10)
    v_u_11._luauData = {}
    v_u_11._value = p9
    if v_u_2 == "client" then
        v_u_11._luauData = table.freeze(v_u_1:JSONDecode(p9.Value))
        p9.Changed:Connect(function(p12)
            if p12 then
                v_u_11._luauData = table.freeze(v_u_1:JSONDecode(p12))
            end
        end)
    end
    return v_u_11
end