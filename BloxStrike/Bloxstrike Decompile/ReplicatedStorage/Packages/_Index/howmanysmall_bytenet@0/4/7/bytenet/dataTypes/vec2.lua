local v1 = require(script.Parent.Parent.process.bufferWriter)
require(script.Parent.Parent.types)
local v_u_2 = v1.writef32NoAlloc
local v_u_3 = v1.alloc
local v_u_10 = {
    ["Read"] = function(p4, p5)
        local v6 = Vector2.new
        local v7 = buffer.readf32(p4, p5)
        local v8 = p5 + 4
        return v6(v7, (buffer.readf32(p4, v8))), 8
    end,
    ["Write"] = function(p9)
        v_u_3(8)
        v_u_2(p9.X)
        v_u_2(p9.Y)
    end
}
return function()
    return v_u_10
end