require(script.Parent.Parent.types)
local v_u_1 = nil
local v_u_2 = nil
local v_u_3 = nil
local v_u_4 = nil
local v_u_5 = buffer.create
return {
    ["alloc"] = function(p6)
        if v_u_2 + p6 >= v_u_1 then
            v_u_1 = v_u_1 * 2
            local v7 = v_u_5(v_u_1)
            buffer.copy(v7, 0, v_u_3)
            v_u_3 = v7
        end
    end,
    ["dyn_alloc"] = function(p8)
        while v_u_1 <= v_u_2 + p8 do
            v_u_1 = v_u_1 * 2
        end
        local v9 = v_u_5(v_u_1)
        buffer.copy(v9, 0, v_u_3)
        v_u_3 = v9
    end,
    ["writeu8NoAlloc"] = function(p10)
        local v11 = v_u_3
        local v12 = v_u_2
        buffer.writeu8(v11, v12, p10)
        v_u_2 = v_u_2 + 1
    end,
    ["writeu8"] = function(p13)
        if v_u_2 + 1 >= v_u_1 then
            v_u_1 = v_u_1 * 2
            local v14 = v_u_5(v_u_1)
            buffer.copy(v14, 0, v_u_3)
            v_u_3 = v14
        end
        local v15 = v_u_3
        local v16 = v_u_2
        buffer.writeu8(v15, v16, p13)
        v_u_2 = v_u_2 + 1
    end,
    ["writei8"] = function(p17)
        if v_u_2 + 1 >= v_u_1 then
            v_u_1 = v_u_1 * 2
            local v18 = v_u_5(v_u_1)
            buffer.copy(v18, 0, v_u_3)
            v_u_3 = v18
        end
        local v19 = v_u_3
        local v20 = v_u_2
        buffer.writei8(v19, v20, p17)
        v_u_2 = v_u_2 + 1
    end,
    ["writeReference"] = function(p21)
        local v22 = v_u_4
        table.insert(v22, p21)
        local v23 = #v_u_4
        local v24 = v_u_3
        local v25 = v_u_2
        buffer.writeu8(v24, v25, v23)
        v_u_2 = v_u_2 + 1
    end,
    ["writeu16"] = function(p26)
        if v_u_2 + 2 >= v_u_1 then
            v_u_1 = v_u_1 * 2
            local v27 = v_u_5(v_u_1)
            buffer.copy(v27, 0, v_u_3)
            v_u_3 = v27
        end
        local v28 = v_u_3
        local v29 = v_u_2
        buffer.writeu16(v28, v29, p26)
        v_u_2 = v_u_2 + 2
    end,
    ["writei16"] = function(p30)
        if v_u_2 + 2 >= v_u_1 then
            v_u_1 = v_u_1 * 2
            local v31 = v_u_5(v_u_1)
            buffer.copy(v31, 0, v_u_3)
            v_u_3 = v31
        end
        local v32 = v_u_3
        local v33 = v_u_2
        buffer.writeu16(v32, v33, p30)
        v_u_2 = v_u_2 + 2
    end,
    ["writeu32"] = function(p34)
        if v_u_2 + 4 >= v_u_1 then
            v_u_1 = v_u_1 * 2
            local v35 = v_u_5(v_u_1)
            buffer.copy(v35, 0, v_u_3)
            v_u_3 = v35
        end
        local v36 = v_u_3
        local v37 = v_u_2
        buffer.writeu32(v36, v37, p34)
        v_u_2 = v_u_2 + 4
    end,
    ["writestring"] = function(p38)
        buffer.writestring(v_u_3, v_u_2, p38)
        v_u_2 = v_u_2 + #p38
    end,
    ["writei32"] = function(p39)
        if v_u_2 + 4 >= v_u_1 then
            v_u_1 = v_u_1 * 2
            local v40 = v_u_5(v_u_1)
            buffer.copy(v40, 0, v_u_3)
            v_u_3 = v40
        end
        local v41 = v_u_3
        local v42 = v_u_2
        buffer.writei32(v41, v42, p39)
        v_u_2 = v_u_2 + 4
    end,
    ["writef32NoAlloc"] = function(p43)
        local v44 = v_u_3
        local v45 = v_u_2
        buffer.writef32(v44, v45, p43)
        v_u_2 = v_u_2 + 4
    end,
    ["writef64NoAlloc"] = function(p46)
        local v47 = v_u_3
        local v48 = v_u_2
        buffer.writef64(v47, v48, p46)
        v_u_2 = v_u_2 + 4
    end,
    ["writef32"] = function(p49)
        if v_u_2 + 4 >= v_u_1 then
            v_u_1 = v_u_1 * 2
            local v50 = v_u_5(v_u_1)
            buffer.copy(v50, 0, v_u_3)
            v_u_3 = v50
        end
        local v51 = v_u_3
        local v52 = v_u_2
        buffer.writef32(v51, v52, p49)
        v_u_2 = v_u_2 + 4
    end,
    ["writef64"] = function(p53)
        if v_u_2 + 8 >= v_u_1 then
            v_u_1 = v_u_1 * 2
            local v54 = v_u_5(v_u_1)
            buffer.copy(v54, 0, v_u_3)
            v_u_3 = v54
        end
        local v55 = v_u_3
        local v56 = v_u_2
        buffer.writef64(v55, v56, p53)
        v_u_2 = v_u_2 + 8
    end,
    ["writecopy"] = function(p57)
        buffer.copy(v_u_3, v_u_2, p57)
        v_u_2 = v_u_2 + buffer.len(p57)
    end,
    ["writebool"] = function(p58)
        if v_u_2 + 1 >= v_u_1 then
            v_u_1 = v_u_1 * 2
            local v59 = v_u_5(v_u_1)
            buffer.copy(v59, 0, v_u_3)
            v_u_3 = v59
        end
        local v60 = v_u_3
        local v61 = v_u_2
        buffer.writeu8(v60, v61, p58 and 1 or 0)
        v_u_2 = v_u_2 + 1
    end,
    ["writePacket"] = function(p62, p63, p64, p65)
        v_u_1 = p62.size
        v_u_2 = p62.cursor
        v_u_4 = p62.references
        v_u_3 = p62.buff
        if v_u_2 + 1 >= v_u_1 then
            v_u_1 = v_u_1 * 2
            local v66 = v_u_5(v_u_1)
            buffer.copy(v66, 0, v_u_3)
            v_u_3 = v66
        end
        local v67 = v_u_3
        local v68 = v_u_2
        buffer.writeu8(v67, v68, p63)
        v_u_2 = v_u_2 + 1
        p64(p65)
        p62.size = v_u_1
        p62.cursor = v_u_2
        p62.references = v_u_4
        p62.buff = v_u_3
        return p62
    end
}