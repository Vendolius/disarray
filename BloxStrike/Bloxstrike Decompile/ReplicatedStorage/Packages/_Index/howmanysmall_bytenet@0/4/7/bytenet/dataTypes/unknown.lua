local v1 = require(script.Parent.Parent.process.bufferWriter)
local v_u_2 = require(script.Parent.Parent.process.readRefs)
require(script.Parent.Parent.types)
local v_u_3 = v1.writeReference
local v_u_4 = v1.alloc
return function()
    return {
        ["Write"] = function(p5)
            v_u_4(1)
            v_u_3(p5)
        end,
        ["Read"] = function(p6, p7)
            local v8 = v_u_2.get()
            if v8 then
                return v8[buffer.readu8(p6, p7)], 1
            else
                return nil, 1
            end
        end
    }
end