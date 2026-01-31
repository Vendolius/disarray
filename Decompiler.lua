local Directory = "game_decompile"
makefolder(Directory)

local PCall = pcall
local GMatch = string.gmatch

function DecompileScript(Script)
    local Success, Bytecode = PCall(function()
        return decompile(Script)
    end)

    if Success and Bytecode then
        local ScriptDirectory = Directory
        local FullName = Script:GetFullName()

        for Folder in GMatch(FullName, "([^%.]+)%.") do
            if Folder ~= Script.Name then
                ScriptDirectory ..= "/" .. Folder
                makefolder(ScriptDirectory)
            end
        end

        ScriptDirectory ..= "/" .. Script.Name .. ".lua"

        writefile(ScriptDirectory, Bytecode)
    end
end

local Scripts = {}
local Garbage = getgc(true)

for _, Value in Garbage do 
    if typeof(Value) == "Instance" and (Value.ClassName:match("Script")) then
        if not Value.Parent then continue end
        DecompileScript(Value)
        Scripts[Value.Name] = true 
    end
end 

Garbage = nil

for _, Value in getscripts() do 
    if Scripts[Value.Name] then continue end 

    DecompileScript(Value)
end   