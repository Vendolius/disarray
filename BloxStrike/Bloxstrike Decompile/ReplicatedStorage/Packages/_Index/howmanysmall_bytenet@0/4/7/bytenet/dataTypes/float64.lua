local v1 = require(script.Parent.Parent.process.bufferWriter)
require(script.Parent.Parent.types)
local v_u_4 = {
    ["Write"] = v1.writef64,
    ["Read"] = function(p2, p3)
        return buffer.readf64(p2, p3), 8
    end
}
return function()
    return v_u_4
end