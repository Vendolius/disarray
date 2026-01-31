local v1 = require(script.Parent.Parent.process.bufferWriter)
require(script.Parent.Parent.types)
local v_u_2 = v1.writef32NoAlloc
local v_u_3 = v1.alloc
local v_u_24 = {
    ["Read"] = function(p4, p5)
        local v6 = buffer.readf32(p4, p5)
        local v7 = p5 + 4
        local v8 = buffer.readf32(p4, v7)
        local v9 = p5 + 8
        local v10 = buffer.readf32(p4, v9)
        local v11 = p5 + 12
        local v12 = buffer.readf32(p4, v11)
        local v13 = p5 + 16
        local v14 = buffer.readf32(p4, v13)
        local v15 = p5 + 20
        local v16 = buffer.readf32(p4, v15)
        return CFrame.new(v6, v8, v10) * CFrame.Angles(v12, v14, v16), 24
    end,
    ["Write"] = function(p17)
        local v18 = p17.X
        local v19 = p17.Y
        local v20 = p17.Z
        local v21, v22, v23 = p17:ToEulerAnglesXYZ()
        v_u_3(24)
        v_u_2(v18)
        v_u_2(v19)
        v_u_2(v20)
        v_u_2(v21)
        v_u_2(v22)
        v_u_2(v23)
    end
}
return function()
    return v_u_24
end