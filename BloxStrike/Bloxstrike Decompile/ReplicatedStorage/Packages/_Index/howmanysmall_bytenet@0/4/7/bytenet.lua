local v1 = game:GetService("RunService")
local v2 = require(script.dataTypes.array)
local v3 = require(script.dataTypes.bool)
local v4 = require(script.dataTypes.buff)
local v5 = require(script.dataTypes.cframe)
local v6 = require(script.process.client)
local v7 = require(script.packets.definePacket)
local v8 = require(script.dataTypes.float32)
local v9 = require(script.dataTypes.float64)
local v10 = require(script.dataTypes.inst)
local v11 = require(script.dataTypes.int16)
local v12 = require(script.dataTypes.int32)
local v13 = require(script.dataTypes.int8)
local v14 = require(script.dataTypes.map)
local v15 = require(script.namespaces.namespace)
local v16 = require(script.dataTypes.nothing)
local v17 = require(script.dataTypes.optional)
local v18 = require(script.process.server)
local v19 = require(script.dataTypes.string)
local v20 = require(script.dataTypes.struct)
require(script.types)
local v21 = require(script.dataTypes.uint16)
local v22 = require(script.dataTypes.uint32)
local v23 = require(script.dataTypes.uint8)
local v24 = require(script.dataTypes.unknown)
local v25 = require(script.replicated.values)
local v26 = require(script.dataTypes.vec2)
local v27 = require(script.dataTypes.vec3)
v25.start()
if v1:IsServer() then
    v18.start()
else
    v6.start()
end
local v28 = v3()
local v29 = v4()
local v30 = v10()
local v31 = v16()
local v32 = v26()
local v33 = v27()
return table.freeze({
    ["DefinePacket"] = v7,
    ["DefineNamespace"] = v15,
    ["Array"] = v2,
    ["Bool"] = v28,
    ["Buff"] = v29,
    ["CFrame"] = v5(),
    ["Float32"] = v8(),
    ["Float64"] = v9(),
    ["Inst"] = v30,
    ["Int16"] = v11(),
    ["Int32"] = v12(),
    ["Int8"] = v13(),
    ["Map"] = v14,
    ["Nothing"] = v31,
    ["Optional"] = v17,
    ["String"] = v19(),
    ["Struct"] = v20,
    ["Uint16"] = v21(),
    ["Uint32"] = v22(),
    ["Uint8"] = v23(),
    ["Unknown"] = v24(),
    ["Vec2"] = v32,
    ["Vec3"] = v33,
    ["Boolean"] = v28,
    ["Buffer"] = v29,
    ["Instance"] = v30,
    ["Nil"] = v31,
    ["Vector2"] = v32,
    ["Vector3"] = v33
})