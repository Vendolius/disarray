local v1 = script.Parent.Parent
require(v1.Types)
return function(p2)
    local v3 = {}
    for _, v4 in ipairs(p2) do
        v3[v4] = true
    end
    return v3
end