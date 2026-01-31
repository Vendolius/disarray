local v1 = require(script.Parent.Parent.process.bufferWriter)
require(script.Parent.Parent.types)
local v_u_4 = {
    ["Write"] = v1.writef32,
    ["Read"] = function(p2, p3)
        return buffer.readf32(p2, p3), 4
    end
}
return function()
    return v_u_4
end