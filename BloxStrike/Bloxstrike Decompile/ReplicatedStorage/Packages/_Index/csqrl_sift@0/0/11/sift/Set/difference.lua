require(script.Parent.Parent.Types)
return function(p1, ...)
    local v2 = table.clone(p1)
    for _, v3 in { ... } do
        if typeof(v3) == "table" then
            for v4 in v3 do
                v2[v4] = nil
            end
        end
    end
    return v2
end