local v1 = require(script.Parent.Parent.process.bufferWriter)
require(script.Parent.Parent.types)
local v_u_4 = {
    ["Write"] = v1.writeu8,
    ["Read"] = function(p2, p3)
        return buffer.readu8(p2, p3), 1
    end
}
return function()
    return v_u_4
end