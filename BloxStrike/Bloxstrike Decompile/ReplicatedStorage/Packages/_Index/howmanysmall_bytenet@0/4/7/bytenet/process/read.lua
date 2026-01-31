local v1 = require(script.Parent.Parent.namespaces.packetIDs)
local v_u_2 = require(script.Parent.readRefs)
local v_u_3 = v1.ref()
local v_u_4 = nil
local function v_u_7(p5, ...)
    local v6 = v_u_4
    v_u_4 = nil
    p5(...)
    v_u_4 = v6
end
local function v_u_8()
    while true do
        v_u_7(coroutine.yield())
    end
end
local function v_u_10(p9, ...)
    if v_u_4 == nil then
        v_u_4 = coroutine.create(v_u_8)
        coroutine.resume(v_u_4)
    end
    task.spawn(v_u_4, p9, ...)
end
return function(p11, p12, p13)
    local v14 = buffer.len(p11)
    v_u_2.set(p12)
    local v15 = 0
    while v15 < v14 do
        local v16 = v_u_3[buffer.readu8(p11, v15)]
        local v17 = v15 + 1
        local v18, v19 = v16.Reader(p11, v17)
        v15 = v17 + v19
        for _, v20 in v16.GetListeners() do
            v_u_10(v20, v18, p13)
        end
    end
end