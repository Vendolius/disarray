local v1 = require(script.Parent.Parent.process.bufferWriter)
require(script.Parent.Parent.types)
local v_u_2 = v1.writeu16
local v_u_3 = v1.writecopy
local v_u_4 = v1.dyn_alloc
local v_u_5 = buffer.create
local v_u_12 = {
    ["Read"] = function(p6, p7)
        local v8 = buffer.readu16(p6, p7)
        local v9 = v_u_5(v8)
        buffer.copy(v9, 0, p6, p7 + 2, v8)
        return v9, v8 + 2
    end,
    ["Write"] = function(p10)
        local v11 = buffer.len(p10)
        v_u_2(v11)
        v_u_4(v11)
        v_u_3(p10)
    end
}
return function()
    return v_u_12
end