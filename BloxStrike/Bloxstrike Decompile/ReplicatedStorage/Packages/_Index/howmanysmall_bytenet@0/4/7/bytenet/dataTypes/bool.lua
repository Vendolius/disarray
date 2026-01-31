local v1 = require(script.Parent.Parent.process.bufferWriter)
require(script.Parent.Parent.types)
local v_u_4 = {
    ["Read"] = function(p2, p3)
        return buffer.readu8(p2, p3) == 1, 1
    end,
    ["Length"] = 1,
    ["Write"] = v1.writebool
}
return function()
    return v_u_4
end