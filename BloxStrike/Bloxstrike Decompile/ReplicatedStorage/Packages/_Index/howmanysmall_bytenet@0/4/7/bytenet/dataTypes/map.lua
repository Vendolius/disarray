local v1 = require(script.Parent.Parent.process.bufferWriter)
require(script.Parent.Parent.types)
local v_u_2 = v1.writeu16
return function(p_u_3, p_u_4)
    local v_u_5 = p_u_3.Write
    local v_u_6 = p_u_4.Write
    return {
        ["Read"] = function(p7, p8)
            local v9 = buffer.readu16(p7, p8)
            local v10 = p8 + 2
            local v11 = {}
            for _ = 1, v9 do
                local v12, v13 = p_u_3.Read(p7, v10)
                local v14 = v10 + v13
                local v15, v16 = p_u_4.Read(p7, v14)
                v10 = v14 + v16
                v11[v12] = v15
            end
            return v11, v10 - p8
        end,
        ["Write"] = function(p17)
            local v18 = 0
            for _ in p17 do
                v18 = v18 + 1
            end
            v_u_2(v18)
            for v19, v20 in p17 do
                v_u_5(v19)
                v_u_6(v20)
            end
        end
    }
end