local v1 = require(script.Parent.Parent.process.bufferWriter)
require(script.Parent.Parent.types)
local v_u_2 = v1.writeu16
local v_u_3 = v1.writestring
local v_u_4 = v1.dyn_alloc
local v_u_10 = {
    ["Read"] = function(p5, p6)
        local v7 = buffer.readu16(p5, p6)
        return buffer.readstring(p5, p6 + 2, v7), v7 + 2
    end,
    ["Write"] = function(p8)
        local v9 = #p8
        v_u_2(v9)
        v_u_4(v9)
        v_u_3(p8)
    end
}
return function()
    return v_u_10
end