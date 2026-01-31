return {
    ["truthy"] = function()
        return true
    end,
    ["noop"] = function() end,
    ["returned"] = function(...)
        return ...
    end
}