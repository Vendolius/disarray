local v1 = require(script.Parent.Parent.process.bufferWriter)
require(script.Parent.Parent.types)
local v_u_2 = v1.writef32NoAlloc
local v_u_3 = v1.alloc
local v_u_12 = {
    ["Read"] = function(p4, p5)
        local v6 = buffer.readf32(p4, p5)
        local v7 = p5 + 4
        local v8 = buffer.readf32(p4, v7)
        local v9 = p5 + 8
        local v10 = buffer.readf32(p4, v9)
        return Vector3.new(v6, v8, v10), 12
    end,
    ["Write"] = function(p11)
        v_u_3(12)
        v_u_2(p11.X)
        v_u_2(p11.Y)
        v_u_2(p11.Z)
    end
}
return function()
    return v_u_12
end