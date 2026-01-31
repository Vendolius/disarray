local NewInstance = Instance.new
local Traceback = debug.traceback
local Unpack = table.unpack

local Signal = {}
Signal.__index = Signal
Signal.ClassName = "Signal"

function Signal.new()
    local self = setmetatable({}, Signal)

    self.BindableEvent = NewInstance("BindableEvent")
    self.ArgumentsMap = {}
    self.Source = Traceback()

    self.BindableEvent.Event:Connect(function(Key)
        self.ArgumentsMap[Key] = nil

        if (not self.BindableEvent) and (not next(self.ArgumentsMap)) then
            self.ArgumentsMap = nil
        end
    end)

    return self
end

function Signal:Fire(...)
    if not self.BindableEvent then
        return
    end

    local Arguments = {...}

    local Key = #self.ArgumentsMap + 1
    self.ArgumentsMap[Key] = Arguments

    self.BindableEvent:Fire(Key)
end

function Signal:Connect(Function)
    if not (type(Function) == "function") then
        error(("connect(%s)"):format(typeof(Function)), 2)
    end

    return self.BindableEvent.Event:Connect(function(Key)
        Function(Unpack(self.ArgumentsMap[Key]))
    end)
end

function Signal:Wait()
    local Key = self.BindableEvent.Event:Wait()
    local Arguments = self.ArgumentsMap[Key]

    if Arguments then
        return Unpack(Arguments)
    else
        error("Missing arg data, probably due to reentrance.")
        return nil
    end
end

function Signal:Destroy()
    if self.BindableEvent then
        self.BindableEvent:Destroy()
        self.BindableEvent = nil
    end

    setmetatable(self, nil)
end

return Signal