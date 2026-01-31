-- ragebot is very perfect lol
local Success, Error = pcall(function()
    local Tick = tick
    local Game = game
    local GetService = Game.GetService
    local WaitForChild = Game.WaitForChild
    local FindFirstChildOfClass = Game.FindFirstChildOfClass
    local GetPropertyChangedSignal = Game.GetPropertyChangedSignal
    
    local HookMetamethod = hookmetamethod
    local GetNamecallMethod = getnamecallmethod

    local NewInstance = Instance.new
    local NewVector3 = Vector3.new
    local NewVector2 = Vector2.new
    local NewCFrame = CFrame.new
    local NewUDim2 = UDim2.new
    local NewRGB = Color3.fromRGB
    local NewRay = Ray.new

    local White = NewRGB(255, 255, 255)
    local Black = NewRGB(0, 0, 0)

    local PointToObjectSpace = NewCFrame().PointToObjectSpace
    local PointToWorldSpace = NewCFrame().PointToWorldSpace
    local Dot = NewVector3().Dot

    local Random = math.random
    local Atan2 = math.atan2
    local Floor = math.floor
    local Acos = math.acos
    local Abs = math.abs
    local Deg = math.deg
    local Rad = math.rad
    local Tan = math.tan
    local Cos = math.cos
    local Sin = math.sin
    local Max = math.max
    local Min = math.min
    local Clamp = math.clamp
    local Pi = math.pi

    local Infinite = 1 / 0
    local ToDeg = 180 / Pi
    local ToRad = Pi / 180
    local TwoPi = Pi * 2

    local Spawn = task.spawn
    local Delay = task.delay

    local Insert = table.insert
    local Remove = table.remove
    local Rep = string.rep

    local Destroy = Game.Destroy
    local NewNumberSequence = NumberSequence.new
    local NewColorSequence = ColorSequence.new

    local ReplicatedStorage = GetService(Game, "ReplicatedStorage")
    local RunService = GetService(Game, "RunService")
    local Workspace = GetService(Game, "Workspace")
    local Players = GetService(Game, "Players")

    local RenderStepped = RunService.RenderStepped
    local Stepped = RunService.Stepped
    local Heartbeat = RunService.Heartbeat

    local Raycast = Workspace.Raycast
    local CurrentCamera = Workspace.CurrentCamera
    local ScreenSize = CurrentCamera.ViewportSize
    local ScreenSizeX = ScreenSize.X
    local ScreenSizeY = ScreenSize.Y

    local LocalPlayer = Players.LocalPlayer
    local PlayerAdded = Players.PlayerAdded
    local PlayerRemoved = Players.PlayerRemoving


    -- Modules
    local disarray = {}

    local Draw     = loadstring(readfile("disarray/Libraries/Draw.lua"))()
    local Menu, Flags = loadstring(readfile("disarray/Libraries/Menu.lua"))():Load({
        CheatName = "Disarray",
        CheatGame = "BloxStrike",
        CheatUser = LocalPlayer.Name,
        Parent = Draw.Folder,
        ZIndex = 1,
        Window = {
            Size = NewUDim2(0, 600, 0, 400)
        }
    })

    -- Tables
    local Camera   = {}
    local Info     = {}
    local Esp      = {}
    local Movement = {}
    local Visuals  = {}
    local Ragebot  = {}
    local AntiAim  = {}




    local function RecursivePrint(Table, Indent)
        Indent = Indent or 0
        local Spacing = Rep("  ", Indent)

        for Index, Value in next, Table do
            if typeof(Value) == "table" then
                print(Spacing .. tostring(Index) .. " = {")
                RecursivePrint(Value, Indent + 1)
                print(Spacing .. "}")
            else
                print(Spacing .. tostring(Index) .. " = " .. tostring(Value))
            end
        end
    end


    local Overlay = Draw.ScreenGui({
        {"Parent", Draw.Folder},
        {"ZIndexBehavior", Enum.ZIndexBehavior.Global},
        {"IgnoreGuiInset", true},
        {"Enabled", true},
        {"DisplayOrder", 3}
    })

    -- Menu
    do
        local VisualsPage = Menu.Window.Pages[4]

        local EspSection = VisualsPage:CreateSection({Name = "Player ESP", Side = 1, Length = 1}) do
            EspSection:CreateToggle({Name = "Enabled", Flag = "esp players enabled"})
            
            local BoundingBoxToggle = EspSection:CreateToggle({Name = "Bounding box", Flag = "esp players bounding box"})
            BoundingBoxToggle:CreateColorpicker({Color = NewRGB(3, 162, 158), Transparency = 0, Flag = "esp players bounding box color"})
            
            local FilledBoxToggle = EspSection:CreateToggle({Name = "Filled bounding box", Flag = "esp players filled bounding box"})
            FilledBoxToggle:CreateColorpicker({Color = NewRGB(0, 0, 0), Transparency = 0.8, Flag = "esp players filled bounding box color"})
            
            local HealthBarToggle = EspSection:CreateToggle({Name = "Health bar", Flag = "esp players health bar"})
            HealthBarToggle:CreateColorpicker({Color = NewRGB(0, 255, 0), Transparency = 0, Flag = "esp players health bar color high"})
            HealthBarToggle:CreateColorpicker({Color = NewRGB(255, 0, 0), Transparency = 0, Flag = "esp players health bar color low"})
            
            local NameToggle = EspSection:CreateToggle({Name = "Name", Flag = "esp players name"})
            NameToggle:CreateColorpicker({Color = NewRGB(255, 255, 255), Transparency = 0, Flag = "esp players name color"})
            
            EspSection:CreateToggle({Name = "Held weapon", Flag = "esp players held weapon"})
            EspSection:CreateToggle({Name = "Distance", Flag = "esp players distance"})
            
            local SkeletonToggle = EspSection:CreateToggle({Name = "Skeleton", Flag = "esp players skeleton"})
            SkeletonToggle:CreateColorpicker({Color = NewRGB(255, 255, 255), Transparency = 0, Flag = "esp players skeleton color"})
            
            local ArrowToggle = EspSection:CreateToggle({Name = "Out of view", Flag = "esp players out of view"})
            ArrowToggle:CreateColorpicker({Color = NewRGB(255, 255, 255), Transparency = 0, Flag = "esp players arrow color"})
            
            EspSection:CreateToggle({Name = "Dynamic arrow size", Flag = "esp players dynamic arrow size"})
            EspSection:CreateSlider({Name = "Arrow size", Value = 10, Minimum = 5, Maximum = 30, Flag = "esp players arrow size"})
        end

        local EspSettingsSection = VisualsPage:CreateSection({Name = "ESP Settings", Side = 2, Length = 0.5}) do
            EspSettingsSection:CreateSlider({Name = "Refresh rate", Value = 100, Minimum = 1, Maximum = 200, Suffix = " FPS", Flag = "esp esp settings refresh rate"})
            EspSettingsSection:CreateSlider({Name = "Maximum draw distance", Value = 1000, Minimum = 0, Maximum = 5000, Suffix = " studs", Flag = "esp esp settings maximum draw distance"})
        end
    end


    -- Garbage Collector
    do
        local NamecallFunction
        local IndexFunction

        local Garbage = getgc(true)
        
        for i = 1, #Garbage do
            local Value = Garbage[i]

            if typeof(Value) ~= "table" then
                continue 
            end

            if rawget(Value, "namecallInstance") then
                for _, SubTable in next, Value do
                    if typeof(SubTable) ~= "table" then
                        continue
                    end

                    for Index, Entry in next, SubTable do
                        if Entry ~= "kick" then
                            continue
                        end

                        if type(Index) ~= "number" then
                            continue
                        end

                        local Element = SubTable[Index + 1]
                        if typeof(Element) ~= "function" then
                            continue
                        end

                        local Constants = getconstants(Element)
                        for i = 1, #Constants do
                            if Constants[i] == "namecallInstance" then
                                NamecallFunction = Element
                                break
                            end
                        end
                    end
                end
            end

            if rawget(Value, "indexInstance") then
                for _, SubTable in next, Value do
                    if typeof(SubTable) ~= "table" then
                        continue
                    end

                    for Index, Entry in next, SubTable do
                        if Entry ~= "kick" then
                            continue
                        end

                        if type(Index) ~= "number" then
                            continue
                        end

                        local Element = SubTable[Index + 1]
                        if typeof(Element) ~= "function" then
                            continue
                        end

                        local Constants = getconstants(Element)
                        for i = 1, #Constants do
                            if Constants[i] == "indexInstance" then
                                IndexFunction = Element
                                break
                            end
                        end
                    end
                end
            end
        end

        Garbage = nil
        
        if NamecallFunction then
            hookfunction(NamecallFunction, function() return false end)
            print("NamecallFunction")
        end

        if IndexFunction then
            hookfunction(IndexFunction, function() return false end)
            print("IndexFunction")
        end
    end

    -- Camera
    do
        local FrustumXDiv, FrustumYDiv
        local HalfScreenX, HalfScreenY
        local FrustumX, FrustumY

        Camera.UpdateSize = function()
            ScreenSize = CurrentCamera.ViewportSize
            ScreenSizeX, ScreenSizeY = ScreenSize.X, ScreenSize.Y
            HalfScreenX, HalfScreenY = ScreenSizeX / 2, ScreenSizeY / 2

            FrustumXDiv = ScreenSizeX / (FrustumX * 2)
            FrustumYDiv = ScreenSizeY / (FrustumY * 2)
        end

        Camera.UpdateFOV = function()
            FrustumY = Tan(CurrentCamera.FieldOfView * ToRad / 2)
            FrustumX = ScreenSizeX / ScreenSizeY * FrustumY

            FrustumXDiv = ScreenSizeX / (FrustumX * 2)
            FrustumYDiv = ScreenSizeY / (FrustumY * 2)
        end

        Camera.WorldToViewportPoint = function(Position, CheckScreen)
            local Projected = PointToObjectSpace(CurrentCamera.CFrame, Position)

            local Z = -Projected.Z

            local PositionX = HalfScreenX + Projected.X / Z * FrustumXDiv
            local PositionY = HalfScreenY - Projected.Y / Z * FrustumYDiv

            local OnScreen = CheckScreen and Z > 0 and PositionX >= 0 and PositionX <= ScreenSizeX and PositionY >= 0 and PositionY <= ScreenSizeY
            
            return NewVector3(PositionX, PositionY, Z), OnScreen
        end

        GetPropertyChangedSignal(CurrentCamera, "FieldOfView"):Connect(Camera.UpdateFOV)
        GetPropertyChangedSignal(CurrentCamera, "ViewportSize"):Connect(Camera.UpdateSize)

        Camera.UpdateFOV()
        Camera.UpdateSize()
    end

    -- Info
    do
        -- Allocations
        Info.Players = {}
        Info.PlayersIndex = 0

        local BodyPartList = {
            ["Head"] = true,
            ["UpperTorso"] = true,
            ["LowerTorso"] = true,
            ["LeftUpperArm"] = true,
            ["RightUpperArm"] = true,
            ["LeftLowerArm"] = true,
            ["RightLowerArm"] = true,
            ["LeftHand"] = true,
            ["RightHand"] = true,
            ["LeftUpperLeg"] = true,
            ["RightUpperLeg"] = true,
            ["LeftLowerLeg"] = true,
            ["RightLowerLeg"] = true,
            ["LeftFoot"] = true,
            ["RightFoot"] = true
        }

        local SkeletonJoints = {
            {"Head", "UpperTorso"},
            {"UpperTorso", "LowerTorso"},
            {"UpperTorso", "LeftUpperArm"},
            {"UpperTorso", "RightUpperArm"},
            {"LeftUpperArm", "LeftLowerArm"},
            {"RightUpperArm", "RightLowerArm"},
            {"LeftLowerArm", "LeftHand"},
            {"RightLowerArm", "RightHand"},
            {"LowerTorso", "LeftUpperLeg"},
            {"LowerTorso", "RightUpperLeg"},
            {"LeftUpperLeg", "LeftLowerLeg"},
            {"RightUpperLeg", "RightLowerLeg"},
            {"LeftLowerLeg", "LeftFoot"},
            {"RightLowerLeg", "RightFoot"}
        }

        -- Functions
        do
            Info.AddPlayer = function(Player)
                local Data = {
                    Player = Player,
                    Name = Player.Name,
                    Team = Player:GetAttribute("Team"),

                    Health = 100,
                    MaxHealth = 100,

                    BodyParts = {},
                    Joints = {},

                    Renders = Esp.CreateRenders(Player)
                }

                Data.UpdateJoints = function()
                    Data.Joints = {}
                    if Data.Character then
                        for i = 1, #SkeletonJoints do
                            local JointNames = SkeletonJoints[i]
                            local PartA = Data.BodyParts[JointNames[1]]
                            local PartB = Data.BodyParts[JointNames[2]]
                            
                            if PartA and PartB then
                                table.insert(Data.Joints, {PartA, PartB})
                            end
                        end
                    end
                end

                Data.UpdateTeam = function()
                    Data.Team = Data.Player:GetAttribute("Team")
                end

                Data.OnSpawn = function(Character)
                    Data.Character = Character
                    Data.Humanoid = WaitForChild(Character, "Humanoid", Infinite)
                    Data.RootPart = WaitForChild(Character, "HumanoidRootPart", Infinite)
                    Data.Health = Data.Humanoid.Health
                    Data.MaxHealth = Data.Humanoid.MaxHealth
                    
                    for _, Child in ipairs(Character:GetChildren()) do
                        if Child:IsA("BasePart") and BodyPartList[Child.Name] then
                            Data.BodyParts[Child.Name] = Child
                        end
                    end
                    Data.UpdateJoints()

                    Character.ChildAdded:Connect(function(Child)
                        local ClassName = Child.ClassName
                        if ClassName == "Tool" then
                            Data.Weapon = Child.Name
                        elseif Child:IsA("BasePart") and BodyPartList[Child.Name] and not Data.BodyParts[Child.Name] then
                            Data.BodyParts[Child.Name] = Child
                            Data.UpdateJoints()
                        end
                    end)

                    Character.ChildRemoved:Connect(function(Child)
                        local ClassName = Child.ClassName
                        if ClassName == "Tool" then
                            Data.Weapon = nil
                        elseif Child:IsA("BasePart") and Data.BodyParts[Child.Name] then
                            Data.BodyParts[Child.Name] = nil
                            Data.UpdateJoints()
                        end
                    end)

                    Data.Humanoid.HealthChanged:Connect(function(New)
                        if not Data.Humanoid then return end

                        Data.Health = New
                        Data.MaxHealth = Data.Humanoid.MaxHealth
                    end)

                    Data.Humanoid.Died:Connect(function()
                        Data.OnDeath()
                    end)
                end

                Data.OnDeath = function()
                    Data.Character = nil
                    Data.Humanoid = nil
                    Data.RootPart = nil
                    Data.Health = 0

                    Data.RootCFrame = nil
                    Data.RootPosition = nil

                    Data.Weapon = nil
                    Data.Distance = 0

                    Data.Joints = {}
                    Data.BodyParts = {}
                end

                Data.UpdateTeam()
                GetPropertyChangedSignal(Data.Player, "Team"):Connect(Data.UpdateTeam)

                Player.CharacterAdded:Connect(Data.OnSpawn)
                Player.CharacterRemoving:Connect(function()
                    Data.OnDeath()
                end)
                local Character = Player.Character
                if Character then
                    Spawn(Data.OnSpawn, Character)
                end

                Info.PlayersIndex += 1
                Info.Players[Info.PlayersIndex] = Data
                Info.Players[Player] = Data

                return Data
            end

            Info.RemovePlayer = function(Player)
                local Data = Info.Players[Player]
                Info.Players[Player] = nil

                for i = 1, Info.PlayersIndex do
                    if Info.Players[i] == Data then
                        Remove(Info.Players, i)
                        Info.PlayersIndex -= 1
                        break
                    end
                end
            end

            Info.Step = function()
                local LocalRootPart = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                local LocalPosition = LocalRootPart and LocalRootPart.Position

                for i = 1, Info.PlayersIndex do
                    local Data = Info.Players[i]

                    if Data.Humanoid and Data.RootPart and Data.Character and Data.Character.Parent and Data.Health > 0 then
                        Data.RootCFrame = Data.RootPart.CFrame
                        Data.RootPosition = Data.RootPart.Position

                        if LocalPosition then
                            Data.Distance = (Data.RootPosition - LocalPosition).Magnitude
                        else
                            Data.Distance = 0
                        end
                    else
                        Data.RootCFrame = nil
                        Data.RootPosition = nil
                        Data.Distance = 0
                    end
                end
            end

            Info.Initialize = function()
                local PlayerList = Players:GetPlayers()
                for i = 2, #PlayerList do
                    Info.AddPlayer(PlayerList[i])
                end

                PlayerAdded:Connect(Info.AddPlayer)
                PlayerRemoved:Connect(Info.RemovePlayer)
                Stepped:Connect(Info.Step)

            end
        end
    end

    -- ESP
    do
        -- Allocations
        local MinecraftFont = Draw.ImportFont("Minecraft", "Minecraft", "", 400)
        Esp.RefreshRate = 1 / 100

        Esp.CreateRenders = function(Player)
            local Renders = {}

            Renders[1] = Draw.Frame({
                {"Parent", Overlay},
                {"BackgroundTransparency", 1},
                {"Visible", true}
            })

            Draw.UIStroke({
                {"Parent", Renders[1]},
                {"LineJoinMode", Enum.LineJoinMode.Miter},
                {"Thickness", 3},
                {"Transparency", 0.25},
                {"Color", NewRGB(0, 0, 0)}
            })

            Renders[2] = Draw.Frame({
                {"ZIndex", 1},
                {"Parent", Renders[1]},
                {"Visible", false},
                {"Position", NewUDim2(0, -1, 0, -1)},
                {"Size", NewUDim2(1, 2, 1, 2)},
                {"BackgroundTransparency", 1}
            })

            Draw.UIStroke({
                {"Parent", Renders[2]},
                {"LineJoinMode", Enum.LineJoinMode.Miter},
                {"Thickness", 1},
                {"Transparency", 0},
                {"Color", NewRGB(3, 162, 158)}
            })

            Renders[3] = Draw.Frame({
                {"ZIndex", 2},
                {"Parent", Renders[2]},
                {"Visible", false},
                {"Position", NewUDim2(0, 1, 0, 1)},
                {"Size", NewUDim2(1, -2, 1, -2)},
                {"BackgroundTransparency", 0.8},
                {"BackgroundColor3", NewRGB(0, 0, 0)},
                {"BorderSizePixel", 0}
            })

            Renders[4] = Draw.TextLabel({
                {"ZIndex", 3},
                {"Parent", Renders[1]},
                {"Visible", false},
                {"Position", NewUDim2(0.5, 0, 1, 6)},
                {"Text", ""},
                {"BackgroundTransparency", 1}
            }, {MinecraftFont, 10, White})

            Draw.UIStroke({
                {"Parent", Renders[4]},
                {"Transparency", 0.4}
            })

            Renders[5] = Draw.TextLabel({
                {"ZIndex", 3},
                {"Parent", Renders[1]},
                {"Visible", false},
                {"Position", NewUDim2(0.5, 0, 1, 15)},
                {"Text", "50.0M"},
                {"BackgroundTransparency", 1}
            }, {MinecraftFont, 10, White})

            Draw.UIStroke({
                {"Parent", Renders[5]},
                {"Transparency", 0.4}
            })

            Renders[6] = Draw.Frame({
                {"ZIndex", 3},
                {"Parent", Renders[1]},
                {"Visible", false},
                {"Position", NewUDim2(0, -7, 0, -2)},
                {"Size", NewUDim2(0, 2, 1, 4)},
                {"BorderSizePixel", 0},
                {"BackgroundColor3", NewRGB(0, 0, 0)},
                {"BackgroundTransparency", 0.4}
            })

            Renders[7] = Draw.Frame({
                {"ZIndex", 4},
                {"Parent", Renders[6]},
                {"Visible", false},
                {"AnchorPoint", NewVector2(0, 1)},
                {"Position", NewUDim2(0, 0, 1, 0)},
                {"Size", NewUDim2(1, 0, 1, 0)},
                {"BorderSizePixel", 0},
                {"BackgroundColor3", NewRGB(0, 255, 0)},
                {"BackgroundTransparency", 0}
            })

            Draw.UIStroke({
                {"Parent", Renders[6]},
                {"Transparency", 0.4}
            })

            Renders[8] = Draw.TextLabel({
                {"ZIndex", 3},
                {"Parent", Renders[1]},
                {"Visible", false},
                {"Position", NewUDim2(0.5, 0, 0, -9)},
                {"Text", Player.Name},
                {"BackgroundTransparency", 1}
            }, {MinecraftFont, 10, White})

            Renders[9] = Draw.TextLabel({
                {"ZIndex", 2},
                {"Parent", Renders[1]},
                {"Visible", false},
                {"Position", NewUDim2(0.5, 1, 0, -8)},
                {"Text", Player.Name},
                {"BackgroundTransparency", 1}
            }, {MinecraftFont, 10, Black})

            Renders[10] = Draw.ImageLabel({
                {"ZIndex", 4},
                {"Parent", Overlay},
                {"Visible", false},
                {"Size", NewUDim2(0, 10, 0, 10)},
                {"BackgroundTransparency", 1},
                {"BorderSizePixel", 0},
                {"Image", "http://www.roblox.com/asset/?id=15000587389"}
            })

            for i = 1, 15 do
                local Line = NewInstance("Frame")
                Line.Parent = Overlay
                Line.AnchorPoint = NewVector2(0.5, 0.5)
                Line.BorderSizePixel = 0
                Line.BackgroundColor3 = NewRGB(255, 255, 255)
                Renders[10 + i] = Line
            end

            return Renders
        end

        local LastStep = 0
        Esp.Step = function()
            local RefreshRateFlag = Flags["esp esp settings refresh rate"]
            local RefreshRate = RefreshRateFlag and (1 / RefreshRateFlag.Value) or Esp.RefreshRate
            if RefreshRate ~= 0 then
                local Time = Tick()

                if (Time - LastStep) < RefreshRate then
                    return
                end

                LastStep = Time
            end

            local EnabledFlag = Flags["esp players enabled"]
            if not EnabledFlag or not EnabledFlag.Value then
                for i = 1, Info.PlayersIndex do
                    local Renders = Info.Players[i].Renders
                    Renders[1].Visible = false
                    Renders[10].Visible = false
                    for j = 11, 25 do
                        Renders[j].Visible = false
                    end
                end
                return
            end

            local WorldToViewportPoint = Camera.WorldToViewportPoint
            local DrawDistanceFlag = Flags["esp esp settings maximum draw distance"]
            local DrawDistance = DrawDistanceFlag and DrawDistanceFlag.Value or 1000

            local BoundingBoxFlag = Flags["esp players bounding box"]
            local ShowBox = BoundingBoxFlag and BoundingBoxFlag.Value or false
            local FilledBoxFlag = Flags["esp players filled bounding box"]
            local ShowFill = ShowBox and FilledBoxFlag and FilledBoxFlag.Value or false
            local HealthBarFlag = Flags["esp players health bar"]
            local ShowHealth = HealthBarFlag and HealthBarFlag.Value or false
            local NameFlag = Flags["esp players name"]
            local ShowName = NameFlag and NameFlag.Value or false
            local WeaponFlag = Flags["esp players held weapon"]
            local ShowWeapon = WeaponFlag and WeaponFlag.Value or false
            local DistanceFlag = Flags["esp players distance"]
            local ShowDistance = DistanceFlag and DistanceFlag.Value or false
            local SkeletonFlag = Flags["esp players skeleton"]
            local ShowSkeleton = SkeletonFlag and SkeletonFlag.Value or false
            local ArrowFlag = Flags["esp players out of view"]
            local ShowArrow = ArrowFlag and ArrowFlag.Value or false

            local PlayersList = Info.Players
            for i = 1, Info.PlayersIndex do
                local Data = PlayersList[i]

                if not Data.Player or not Data.Player.Parent or not Players:FindFirstChild(Data.Player.Name) then
                    local Renders = Data.Renders
                    Renders[1].Visible = false
                    Renders[10].Visible = false
                    for j = 11, 25 do
                        Renders[j].Visible = false
                    end
                    continue
                end

                if not Data.RootPosition or Data.Distance > DrawDistance then
                    local Renders = Data.Renders
                    Renders[1].Visible = false
                    Renders[10].Visible = false
                    for j = 11, 25 do
                        Renders[j].Visible = false
                    end
                    continue
                end

                if not Data.Character or not Data.Character.Parent or Data.Health <= 0 or not Data.Humanoid or not Data.RootPart or not Data.RootPart.Parent then
                    local Renders = Data.Renders
                    Renders[1].Visible = false
                    Renders[10].Visible = false
                    for j = 11, 25 do
                        Renders[j].Visible = false
                    end
                    continue
                end

                local LocalTeam = LocalPlayer:GetAttribute("Team")
                local PlayerTeam = Data.Player:GetAttribute("Team")
                if LocalTeam and PlayerTeam and LocalTeam == PlayerTeam then
                    local Renders = Data.Renders
                    Renders[1].Visible = false
                    Renders[10].Visible = false
                    for j = 11, 25 do
                        Renders[j].Visible = false
                    end
                    continue
                end

                local Renders = Data.Renders
                local RootPosition = Data.RootPosition
                local Position, OnScreen = WorldToViewportPoint(RootPosition, true)

                if not OnScreen then
                    if ShowArrow then
                        local Relative = PointToObjectSpace(CurrentCamera.CFrame, RootPosition)
                        local Angle = Atan2(-Relative.Y, Relative.X)
                        local Rotation = Deg(Angle)
                        local Radius = 350

                        local Arrow = Renders[10]
                        local ArrowColorpicker = Flags["esp players arrow color"]
                        Arrow.ImageColor3 = ArrowColorpicker and ArrowColorpicker.Color or NewRGB(255, 255, 255)
                        Arrow.ImageTransparency = ArrowColorpicker and ArrowColorpicker.Transparency or 0
                        Arrow.Position = NewUDim2(0, ScreenSizeX / 2 + Radius * Cos(Rad(Rotation)), 0, ScreenSizeY / 2 + Radius * Sin(Rad(Rotation)))
                        Arrow.Rotation = Rotation + 90
                        Arrow.Visible = true

                        local ArrowDynamicFlag = Flags["esp players dynamic arrow size"]
                        local ArrowDynamic = ArrowDynamicFlag and ArrowDynamicFlag.Value or false
                        local ArrowSizeFlag = Flags["esp players arrow size"]
                        local ArrowSize = ArrowDynamic and Clamp(((Data.Distance - 1) / (100 - 1)) * (7 - 20) + 20, 7, 20) or (ArrowSizeFlag and ArrowSizeFlag.Value or 10)
                        Arrow.Size = NewUDim2(0, ArrowSize, 0, ArrowSize)
                    else
                        Renders[10].Visible = false
                    end

                    Renders[1].Visible = false
                    for j = 11, 25 do
                        Renders[j].Visible = false
                    end
                    continue
                end

                local RootUpVector = Data.RootCFrame.UpVector
                local RootRightVector = Data.RootCFrame.RightVector

                local HeadPosition = RootPosition
                local HeadPart = Data.BodyParts.Head
                if HeadPart then
                    HeadPosition = HeadPart.Position
                else
                    local TorsoPart = Data.BodyParts.Torso or Data.BodyParts.UpperTorso
                    if TorsoPart then
                        HeadPosition = TorsoPart.Position + RootUpVector * 2.5
                    else
                        HeadPosition = RootPosition + RootUpVector * 2.5
                    end
                end

                local Top = WorldToViewportPoint(HeadPosition + RootUpVector * 0.5, false)
                local Bottom = WorldToViewportPoint(RootPosition - RootUpVector * 2.5, false)
                local Left = WorldToViewportPoint(RootPosition - RootRightVector * 1.5, false)
                local Right = WorldToViewportPoint(RootPosition + RootRightVector * 1.5, false)

                local Width = Abs(Left.X - Right.X)
                local Height = Abs(Top.Y - Bottom.Y)
                local SizeX = Floor(Max(Width, Height * 0.5))

                local Framework = Renders[1]
                Framework.Position = NewUDim2(0, Floor((Left.X + Right.X - SizeX) / 2), 0, Floor(Min(Top.Y, Bottom.Y)))
                Framework.Size = NewUDim2(0, SizeX, 0, Floor(Height))
                Framework.Visible = true

                if ShowBox then
                    local Box = Renders[2]
                    local BoxFill = Renders[3]
                    Box.Visible = true

                    local BoxColorpicker = Flags["esp players bounding box color"]
                    if BoxColorpicker then
                        local BoxStroke = Box:FindFirstChildOfClass("UIStroke")
                        if BoxStroke then
                            BoxStroke.Color = BoxColorpicker.Color
                            BoxStroke.Transparency = BoxColorpicker.Transparency
                        end
                    end

                    if ShowFill then
                        BoxFill.Visible = true
                        local BoxFillColorpicker = Flags["esp players filled bounding box color"]
                        if BoxFillColorpicker then
                            BoxFill.BackgroundColor3 = BoxFillColorpicker.Color
                            BoxFill.BackgroundTransparency = BoxFillColorpicker.Transparency
                        end
                    else
                        BoxFill.Visible = false
                    end
                else
                    Renders[2].Visible = false
                    Renders[3].Visible = false
                end

                if ShowHealth then
                    local Percent = Data.Health / Data.MaxHealth
                    Renders[7].Visible = true
                    Renders[7].Size = NewUDim2(1, 0, Percent, 0)
                    local HealthColorLow = Flags["esp players health bar color low"]
                    local HealthColorHigh = Flags["esp players health bar color high"]
                    if HealthColorLow and HealthColorHigh then
                        Renders[7].BackgroundColor3 = HealthColorHigh.Color:Lerp(HealthColorLow.Color, 1 - Percent)
                    end
                    Renders[6].Visible = true
                else
                    Renders[6].Visible = false
                    Renders[7].Visible = false
                end

                if ShowName then
                    local Name = Renders[8]
                    local NameShadow = Renders[9]
                    Name.Visible = true
                    local NameColorpicker = Flags["esp players name color"]
                    if NameColorpicker then
                        Name.TextColor3 = NameColorpicker.Color
                        Name.TextTransparency = NameColorpicker.Transparency
                        NameShadow.TextTransparency = NameColorpicker.Transparency
                    end
                    NameShadow.Visible = true
                else
                    Renders[8].Visible = false
                    Renders[9].Visible = false
                end

                if ShowWeapon and Data.Weapon then
                    Renders[4].Visible = true
                    Renders[4].Text = Data.Weapon
                else
                    Renders[4].Visible = false
                end

                if ShowDistance then
                    local Distance = Renders[5]
                    Distance.Visible = true
                    Distance.Text = (Floor(Data.Distance * 10 + 0.5) / 10) .. "M"
                    Distance.Position = Renders[4].Visible and NewUDim2(0.5, 0, 1, 14) or NewUDim2(0.5, 0, 1, 6)
                else
                    Renders[5].Visible = false
                end

                if ShowSkeleton then
                    local Joints = Data.Joints
                    for j = 1, #Joints do
                        local PartA = Joints[j][1]
                        local PartB = Joints[j][2]

                        if not PartA or not PartB then
                            if j <= 15 then
                                Renders[10 + j].Visible = false
                            end
                            continue
                        end

                        local PositionA = WorldToViewportPoint(PartA.Position)
                        local PositionB = WorldToViewportPoint(PartB.Position)

                        if PositionA.Z > 0 and PositionB.Z > 0 then
                            local Center = (NewVector2(PositionA.X, PositionA.Y) + NewVector2(PositionB.X, PositionB.Y)) / 2
                            local Offset = NewVector2(PositionB.X, PositionB.Y) - NewVector2(PositionA.X, PositionA.Y)

                            if j <= 15 then
                                local Line = Renders[10 + j]
                                Line.Position = NewUDim2(0, Center.X, 0, Center.Y)
                                Line.Size = NewUDim2(0, Offset.Magnitude, 0, 1)
                                Line.Rotation = Deg(Atan2(Offset.Y, Offset.X))
                                local SkeletonColorpicker = Flags["esp players skeleton color"]
                                if SkeletonColorpicker then
                                    Line.BackgroundColor3 = SkeletonColorpicker.Color
                                    Line.BackgroundTransparency = SkeletonColorpicker.Transparency
                                end
                                Line.Visible = true
                            end
                        else
                            if j <= 15 then
                                Renders[10 + j].Visible = false
                            end
                        end
                    end
                    for j = #Joints + 1, 15 do
                        Renders[10 + j].Visible = false
                    end
                else
                    for j = 11, 25 do
                        Renders[j].Visible = false
                    end
                end

                Renders[10].Visible = false
            end
        end

        Esp.Initialize = function()
            RenderStepped:Connect(Esp.Step)
        end
    end

    -- Movement
    do
        local CharacterController = require(ReplicatedStorage.Controllers.CharacterController)
        local CharacterClass = require(ReplicatedStorage.Classes.Character)
        local UserInputService = GetService(Game, "UserInputService")

        local GetCharacter = CharacterController.getCurrentCharacter
        local RealTick = tick
        local OriginalGetMaxSpeed = CharacterClass.GetMaxSpeed

        Movement.SpeedMultiplier = 1.25
        Movement.StrafeDirection = 1
        Movement.LastStrafeTime = 0
        Movement.BaseMaxSpeed = 20
        Movement.WasStrafeActive = false
        Movement.PlayerModule = nil
        Movement.Controls = nil
        Movement.LastTick = RealTick()
        Movement.TickOffset = 0

        local function HookedTick()
            local CallStack = debug.traceback()
            if string.find(CallStack, "BlankRequest", 1, true) or string.find(CallStack, "ReportPlayerConnect", 1, true) then
                return RealTick()
            end

            if Flags["movement speed hack enabled"] and Flags["movement speed hack enabled"].Value then
                local MultiplierFlag = Flags["movement speed hack multiplier"]
                if MultiplierFlag then
                    local Multiplier = MultiplierFlag.Value
                    local CurrentTime = RealTick()
                    local DeltaTime = CurrentTime - Movement.LastTick
                    Movement.TickOffset += DeltaTime * (1 - (1 / Multiplier))
                    Movement.LastTick = CurrentTime
                    return CurrentTime - Movement.TickOffset
                end
            end

            return RealTick()
        end

        tick = HookedTick

        CharacterClass.GetMaxSpeed = function(CharacterInstance)
            local BaseSpeed = OriginalGetMaxSpeed(CharacterInstance)
            
            if not Flags["movement speed hack enabled"] or not Flags["movement speed hack enabled"].Value then
                return BaseSpeed
            end

            local MultiplierFlag = Flags["movement speed hack multiplier"]
            if not MultiplierFlag then
                return BaseSpeed
            end
            
            local Multiplier = MultiplierFlag.Value
            
            if BaseSpeed < 25 then
                return BaseSpeed * Multiplier
            end
            
            return BaseSpeed
        end

        Movement.Step = function()
            local Character = GetCharacter()
            if not Character then
                return
            end

            if Flags["movement speed hack enabled"] and Flags["movement speed hack enabled"].Value then
                local MultiplierFlag = Flags["movement speed hack multiplier"]
                if MultiplierFlag then
                    local Multiplier = MultiplierFlag.Value
                    if Character.MaxSpeed then
                        local BaseSpeed = Movement.BaseMaxSpeed
                        Character.MaxSpeed = BaseSpeed * Multiplier
                    end
                end
            end

            if Flags["movement auto bhop enabled"] and Flags["movement auto bhop enabled"].Value then
                local Humanoid = Character.Humanoid
                if Humanoid then
                    local State = Humanoid:GetState()
                    local IsSpacePressed = UserInputService:IsKeyDown(Enum.KeyCode.Space)
                    
                    if IsSpacePressed and State == Enum.HumanoidStateType.Running then
                        if not Character.IsJumping and not Character.IsJumpRequested then
                            CharacterController.jump()
                        end
                    end
                end
            end

            if Flags["movement auto strafe enabled"] and Flags["movement auto strafe enabled"].Value then
                local Humanoid = Character.Humanoid
                local RootPart = Character.HumanoidRootPart
                
                if Humanoid and RootPart then
                    local State = Humanoid:GetState()
                    
                    if not Movement.PlayerModule then
                        Movement.PlayerModule = LocalPlayer:WaitForChild("PlayerScripts"):WaitForChild("PlayerModule")
                        Movement.Controls = require(Movement.PlayerModule):GetControls()
                    end
                    
                    local ActiveController = Movement.Controls.activeController
                    
                    if ActiveController and ActiveController.UpdateMovement then
                        if State == Enum.HumanoidStateType.Freefall or State == Enum.HumanoidStateType.Jumping then
                            local IsAPressed = UserInputService:IsKeyDown(Enum.KeyCode.A)
                            local IsDPressed = UserInputService:IsKeyDown(Enum.KeyCode.D)
                            local IsWPressed = UserInputService:IsKeyDown(Enum.KeyCode.W)
                            local IsSPressed = UserInputService:IsKeyDown(Enum.KeyCode.S)
                            
                            if IsAPressed or IsDPressed or IsWPressed or IsSPressed then
                                if IsAPressed then
                                    ActiveController.leftValue = -1
                                    ActiveController.rightValue = 0
                                elseif IsDPressed then
                                    ActiveController.rightValue = 1
                                    ActiveController.leftValue = 0
                                elseif IsWPressed then
                                    ActiveController.forwardValue = -1
                                    ActiveController.backwardValue = 0
                                elseif IsSPressed then
                                    ActiveController.backwardValue = 1
                                    ActiveController.forwardValue = 0
                                end
                            else
                                local Velocity = RootPart.AssemblyLinearVelocity
                                local CameraCFrame = CurrentCamera.CFrame
                                local CameraRight = CameraCFrame.RightVector
                                
                                local HorizontalVelocity = Vector3.new(Velocity.X, 0, Velocity.Z)
                                local VelocityMagnitude = HorizontalVelocity.Magnitude
                                
                                local CurrentTime = Tick()
                                if CurrentTime - Movement.LastStrafeTime > 0.03 then
                                    if VelocityMagnitude > 0.1 then
                                        local VelocityDirection = HorizontalVelocity.Unit
                                        local Cross = CameraRight:Cross(VelocityDirection)
                                        Movement.StrafeDirection = Cross.Y > 0 and 1 or -1
                                    else
                                        Movement.StrafeDirection = -Movement.StrafeDirection
                                    end
                                    Movement.LastStrafeTime = CurrentTime
                                end
                                
                                if Movement.StrafeDirection > 0 then
                                    ActiveController.rightValue = 1
                                    ActiveController.leftValue = 0
                                else
                                    ActiveController.leftValue = -1
                                    ActiveController.rightValue = 0
                                end
                            end
                            
                            ActiveController:UpdateMovement(Enum.UserInputState.Begin)
                            Movement.WasStrafeActive = true
                        else
                            if Movement.WasStrafeActive then
                                ActiveController.leftValue = 0
                                ActiveController.rightValue = 0
                                ActiveController.forwardValue = 0
                                ActiveController.backwardValue = 0
                                ActiveController:UpdateMovement(Enum.UserInputState.End)
                                Movement.WasStrafeActive = false
                            end
                        end
                    end
                end
            end
        end

        Movement.Initialize = function()
            Heartbeat:Connect(Movement.Step)
            Movement.Loaded = true
        end
    end

    -- Visuals
    do
        local ByteNet = require(ReplicatedStorage.Database.Security.Remotes)
        local OriginalSend = ByteNet.Inventory.ShootWeapon.Send
        
        Visuals.CreateTracer = function(Origin, Position, Color, Transparency, LifeTime)
            local Part0 = NewInstance("Part")
            Part0.Parent = Workspace
            Part0.Anchored = true
            Part0.CanCollide = false
            Part0.Transparency = 1
            Part0.Size = NewVector3(0.1, 0.1, 0.1)
            Part0.CFrame = NewCFrame(Origin)
            
            local Attachment0 = NewInstance("Attachment")
            Attachment0.Parent = Part0
            
            local Part1 = NewInstance("Part")
            Part1.Parent = Workspace
            Part1.Anchored = true
            Part1.CanCollide = false
            Part1.Transparency = 1
            Part1.Size = NewVector3(0.1, 0.1, 0.1)
            Part1.CFrame = NewCFrame(Position)
            
            local Attachment1 = NewInstance("Attachment")
            Attachment1.Parent = Part1
            
            local Beam = NewInstance("Beam")
            Beam.Parent = Part0
            Beam.Attachment0 = Attachment0
            Beam.Attachment1 = Attachment1
            Beam.Enabled = true
            Beam.FaceCamera = true
            Beam.Transparency = NewNumberSequence(Transparency)
            Beam.Color = NewColorSequence(Color)
            Beam.Texture = "rbxassetid://446111271"
            Beam.TextureLength = 12
            Beam.TextureSpeed = 8
            Beam.TextureMode = Enum.TextureMode.Wrap
            Beam.ZOffset = 0
            Beam.Width0 = 0.2
            Beam.Width1 = 0.2
            Beam.LightEmission = 1
            Beam.LightInfluence = 1
            
            Delay(LifeTime or 0.5, function()
                Destroy(Part0)
                Destroy(Part1)
                Destroy(Beam)
            end)
        end
        
        Visuals.HookLocalTracers = function()
            ByteNet.Inventory.ShootWeapon.Send = function(Data)
                if Flags["visuals local tracers"] and Flags["visuals local tracers"].Value and Data and Data.Bullets then
                    local TracerColor = Flags["visuals local tracer color"]
                    local TracerColorValue = TracerColor and TracerColor.Color or White
                    local TracerTransparency = TracerColor and TracerColor.Transparency or 0
                    
                    for _, Bullet in ipairs(Data.Bullets) do
                        if Bullet and Bullet.Origin and Bullet.Hits then
                            local LastPosition = Bullet.Origin
                            for _, Hit in ipairs(Bullet.Hits) do
                                if Hit and Hit.Position then
                                    Visuals.CreateTracer(LastPosition, Hit.Position, TracerColorValue, TracerTransparency, 0.5)
                                    LastPosition = Hit.Position
                                end
                            end
                            
                            if Bullet.Direction then
                                local FinalPosition = Bullet.Origin + (Bullet.Direction * 500)
                                Visuals.CreateTracer(LastPosition, FinalPosition, TracerColorValue, TracerTransparency, 0.5)
                            end
                        end
                    end
                end
                
                return OriginalSend(Data)
            end
        end
        
        Visuals.HookEnemyTracers = function()
            ByteNet.VFX.CreateTracer.Listen(function(Data)
                if Flags["visuals enemy tracers"] and Flags["visuals enemy tracers"].Value and Data then
                    local TracerColor = Flags["visuals enemy tracer color"]
                    local TracerColorValue = TracerColor and TracerColor.Color or NewRGB(255, 0, 0)
                    local TracerTransparency = TracerColor and TracerColor.Transparency or 0
                    
                    if Data.Origin and Data.Target then
                        Visuals.CreateTracer(Data.Origin, Data.Target, TracerColorValue, TracerTransparency, 0.5)
                    end
                end
            end)
        end
        
        Visuals.HookLocalTracers()
        Visuals.HookEnemyTracers()
    end

    -- Ragebot
    do
        local RaycastLib = require(ReplicatedStorage.Shared.Raycast)
        local ByteNet = require(ReplicatedStorage.Database.Security.Remotes)
        local GetRayIgnore = require(ReplicatedStorage.Components.Common.GetRayIgnore)
        local InventoryController = require(ReplicatedStorage.Controllers.InventoryController)
        
        Ragebot.LastShot = 0
        
        Ragebot.CanPenetrate = function(Origin, Direction, Distance, Penetration, TargetCharacter)
            if Penetration <= 0 then return false end
            
            local Hits = RaycastLib.castThrough(Origin, Direction * Distance, Penetration, GetRayIgnore())
            
            if not Hits or #Hits == 0 then return false end
            
            for _, Hit in ipairs(Hits) do
                if Hit.instance and Hit.instance:IsDescendantOf(TargetCharacter) then
                    return true
                end
            end
            
            return false
        end
        
        Ragebot.GetBestTarget = function()
            local BestTarget = nil
            local BestDistance = Infinite
            local LocalTeam = LocalPlayer:GetAttribute("Team")
            
            local IgnoreTeam = Flags["ragebot ignore team"] and Flags["ragebot ignore team"].Value
            local AutoWall = Flags["ragebot auto wall"] and Flags["ragebot auto wall"].Value
            local TargetPart = Flags["ragebot target part"] and Flags["ragebot target part"].Value or "Head"
            local FovLimit = Flags["ragebot fov limit"] and Flags["ragebot fov limit"].Value or 180
            
            for i = 1, Info.PlayersIndex do
                local Data = Info.Players[i]
                local PlayerTeam = Data.Player:GetAttribute("Team")
                
                if Data.Character and Data.Health > 0 and Data.RootPart then
                    if IgnoreTeam or LocalTeam ~= PlayerTeam then
                        local TargetBodyPart = Data.BodyParts[TargetPart] or Data.BodyParts.Head
                        if TargetBodyPart then
                            local TargetPosition = TargetBodyPart.Position
                            local CameraPosition = CurrentCamera.CFrame.Position
                            local Direction = (TargetPosition - CameraPosition).Unit
                            local Distance = (TargetPosition - CameraPosition).Magnitude
                            
                            local ScreenPosition = CurrentCamera:WorldToScreenPoint(TargetPosition)
                            local ScreenCenter = NewVector2(ScreenSizeX / 2, ScreenSizeY / 2)
                            local FovDistance = (NewVector2(ScreenPosition.X, ScreenPosition.Y) - ScreenCenter).Magnitude
                            local FovAngle = Atan2(FovDistance, ScreenSizeY) * ToDeg
                            
                            if FovAngle <= FovLimit and Distance < BestDistance then
                                local CanHit = false
                                
                                if AutoWall then
                                    local CurrentWeapon = InventoryController.getCurrentEquipped()
                                    local WeaponPenetration = CurrentWeapon and CurrentWeapon.Properties and CurrentWeapon.Properties.Penetration or 0
                                    CanHit = Ragebot.CanPenetrate(CameraPosition, Direction, Distance, WeaponPenetration, Data.Character)
                                else
                                    local RayParams = RaycastParams.new()
                                    RayParams.FilterType = Enum.RaycastFilterType.Exclude
                                    RayParams.FilterDescendantsInstances = {LocalPlayer.Character, CurrentCamera}
                                    local Result = Workspace:Raycast(CameraPosition, Direction * Distance, RayParams)
                                    CanHit = Result and Result.Instance and Result.Instance:IsDescendantOf(Data.Character)
                                end
                                
                                if CanHit then
                                    BestTarget = Data
                                    BestDistance = Distance
                                end
                            end
                        end
                    end
                end
            end
            
            return BestTarget
        end
        
        Ragebot.Shoot = function()
            if not (Flags["ragebot auto shoot"] and Flags["ragebot auto shoot"].Value) then
                return
            end
            
            local CurrentWeapon = InventoryController.getCurrentEquipped()
            if not CurrentWeapon or not CurrentWeapon.Properties then return end
            
            local FireRate = CurrentWeapon.Properties.FireRate or 0.1
            local CurrentTime = Tick()
            
            if CurrentTime - Ragebot.LastShot < FireRate then
                return
            end
            
            local Target = Ragebot.GetBestTarget()
            if not Target then return end
            
            local TargetPart = Flags["ragebot target part"] and Flags["ragebot target part"].Value or "Head"
            local TargetBodyPart = Target.BodyParts[TargetPart] or Target.BodyParts.Head
            if not TargetBodyPart then return end
            
            local TargetPosition = TargetBodyPart.Position
            local CameraPosition = CurrentCamera.CFrame.Position
            local Direction = (TargetPosition - CameraPosition).Unit
            
            local Penetration = CurrentWeapon.Properties.Penetration or 0
            local Range = CurrentWeapon.Properties.Range or 500
            local RayIgnore = GetRayIgnore()
            
            local FirstHit = RaycastLib.cast(CameraPosition, Direction * Range, nil, RayIgnore)
            if not FirstHit or not FirstHit.instance then
                return
            end
            
            local FirstHitPosition = FirstHit.position
            local BulletDistance = (FirstHitPosition - CameraPosition).Magnitude
            
            local PenetrationHits = RaycastLib.castThrough(FirstHitPosition - Direction * 0.001, Direction * (Penetration + 0.001), Penetration, RayIgnore)
            
            local Hits = {}
            local LastPosition = CameraPosition
            
            for Index, Hit in ipairs(PenetrationHits) do
                if Hit.instance and Hit.material then
                    local HitData = {
                        Distance = (Hit.position - LastPosition).Magnitude,
                        Instance = Hit.instance,
                        Position = Hit.position,
                        Normal = Hit.normal or NewVector3(0, 0, 0),
                        Material = Hit.material.Name,
                        Exit = Index % 2 == 0
                    }
                    Insert(Hits, HitData)
                    LastPosition = Hit.position
                end
            end
            
            local BulletData = {
                Origin = CameraPosition,
                Direction = Direction,
                Distance = BulletDistance,
                Hits = Hits
            }
            
            ByteNet.Inventory.ShootWeapon.Send({
                IsSniperScoped = CurrentWeapon.IsSniperScoped or false,
                ShootingHand = CurrentWeapon.ShootingHand or "Right",
                Identifier = CurrentWeapon.Identifier or "",
                Capacity = CurrentWeapon.Capacity or 30,
                Bullets = {BulletData},
                Rounds = CurrentWeapon.Rounds or 30
            })
            
            local FinalHitPosition = #Hits > 0 and Hits[#Hits].Position or FirstHitPosition
            local TracerDistance = (FinalHitPosition - CameraPosition).Magnitude
            
            ByteNet.VFX.CreateTracer.Send({
                Distance = TracerDistance,
                Origin = CameraPosition,
                Target = FinalHitPosition
            })
            
            Ragebot.LastShot = CurrentTime
        end
        
        Ragebot.Step = function()
            if Flags["ragebot enabled"] and Flags["ragebot enabled"].Value then
                Ragebot.Shoot()
            end
        end
        
        Ragebot.Initialize = function()
            Heartbeat:Connect(Ragebot.Step)
        end
    end

    -- Anti Aim
    do
        local CharacterController = require(ReplicatedStorage.Controllers.CharacterController)
        local OriginalCameraOffset = nil
        
        AntiAim.Step = function()
            local Character = CharacterController.getCurrentCharacter()
            if not Character or not Character.Humanoid then return end
            
            local ThirdPersonEnabled = Flags["antiaim third person enabled"]
            if ThirdPersonEnabled and ThirdPersonEnabled.Value then
                local DistanceFlag = Flags["antiaim third person distance"]
                local Distance = DistanceFlag and DistanceFlag.Value or 10
                
                if not OriginalCameraOffset then
                    OriginalCameraOffset = Character.Humanoid.CameraOffset
                end
                
                Character.Humanoid.CameraOffset = NewVector3(0, 0, Distance)
            else
                if OriginalCameraOffset then
                    if Character.Humanoid then
                        Character.Humanoid.CameraOffset = OriginalCameraOffset
                    end
                    OriginalCameraOffset = nil
                end
            end
            
            local AntiAimEnabled = Flags["antiaim enabled"]
            if AntiAimEnabled and AntiAimEnabled.Value and Character.HumanoidRootPart then
                local AntiAimMode = Flags["antiaim mode"]
                local Mode = AntiAimMode and AntiAimMode.Value or "Spin"
                
                local YawValue = 0
                local PitchValue = 0
                
                if Mode == "Spin" then
                    local SpinSpeed = Flags["antiaim spin speed"] and Flags["antiaim spin speed"].Value or 10
                    YawValue = (Tick() * SpinSpeed * 10) % 360
                elseif Mode == "Jitter" then
                    local Jitter = Tick() % 0.2 < 0.1 and 90 or -90
                    YawValue = Jitter
                elseif Mode == "Backwards" then
                    YawValue = 180
                elseif Mode == "Custom" then
                    YawValue = Flags["antiaim custom yaw"] and Flags["antiaim custom yaw"].Value or 0
                    PitchValue = Flags["antiaim custom pitch"] and Flags["antiaim custom pitch"].Value or 0
                end
                
                Character.HumanoidRootPart.CFrame = Character.HumanoidRootPart.CFrame * CFrame.Angles(Rad(PitchValue), Rad(YawValue), 0)
            end
        end
        
        AntiAim.Initialize = function()
            Heartbeat:Connect(AntiAim.Step)
        end
    end

    -- Menu Movement Section
    do
        local MovementPage = Menu.Window.Pages[5]

        local MovementSection = MovementPage:CreateSection({Name = "Movement", Side = 1, Length = 1}) do
            MovementSection:CreateToggle({Name = "Speed hack", Flag = "movement speed hack enabled"})
            MovementSection:CreateSlider({Name = "Speed multiplier", Value = 1.25, Minimum = 1, Maximum = 5, Decimals = 0.01, Flag = "movement speed hack multiplier"})
            MovementSection:CreateToggle({Name = "Auto bhop", Flag = "movement auto bhop enabled"})
            MovementSection:CreateToggle({Name = "Auto strafe", Flag = "movement auto strafe enabled"})
        end
    end

    -- Menu Ragebot Section
    do
        local CombatPage = Menu.Window.Pages[2]

        local RagebotSection = CombatPage:CreateSection({Name = "Ragebot", Side = 1, Length = 1}) do
            RagebotSection:CreateToggle({Name = "Enabled", Flag = "ragebot enabled"})
            RagebotSection:CreateToggle({Name = "Auto shoot", Flag = "ragebot auto shoot"})
            RagebotSection:CreateDropdown({Name = "Target part", Options = {"Head", "Torso", "HumanoidRootPart"}, Value = "Head", Flag = "ragebot target part"})
            RagebotSection:CreateSlider({Name = "FOV limit", Value = 180, Minimum = 0, Maximum = 180, Suffix = "°", Flag = "ragebot fov limit"})
            RagebotSection:CreateToggle({Name = "Ignore team", Flag = "ragebot ignore team"})
            RagebotSection:CreateToggle({Name = "Auto wall", Flag = "ragebot auto wall"})
        end
    end

    -- Menu Visuals Section
    do
        local VisualsPage = Menu.Window.Pages[4]

        local TracersSection = VisualsPage:CreateSection({Name = "Bullet Tracers", Side = 2, Length = 0.5}) do
            local LocalTracerToggle = TracersSection:CreateToggle({Name = "Local tracers", Flag = "visuals local tracers"})
            LocalTracerToggle:CreateColorpicker({Color = NewRGB(255, 255, 255), Transparency = 0, Flag = "visuals local tracer color"})
            
            local EnemyTracerToggle = TracersSection:CreateToggle({Name = "Enemy tracers", Flag = "visuals enemy tracers"})
            EnemyTracerToggle:CreateColorpicker({Color = NewRGB(255, 0, 0), Transparency = 0, Flag = "visuals enemy tracer color"})
        end
    end

    -- Menu Anti Aim Section
    do
        local AntiAimPage = Menu.Window.Pages[3]

        local ThirdPersonSection = AntiAimPage:CreateSection({Name = "Third Person", Side = 1, Length = 0.5}) do
            ThirdPersonSection:CreateToggle({Name = "Enabled", Flag = "antiaim third person enabled"})
            ThirdPersonSection:CreateSlider({Name = "Distance", Value = 10, Minimum = 5, Maximum = 30, Flag = "antiaim third person distance"})
        end

        local AntiAimSection = AntiAimPage:CreateSection({Name = "Anti Aim", Side = 1, Length = 1}) do
            AntiAimSection:CreateToggle({Name = "Enabled", Flag = "antiaim enabled"})
            AntiAimSection:CreateDropdown({Name = "Mode", Options = {"Spin", "Jitter", "Backwards", "Custom"}, Value = "Spin", Flag = "antiaim mode"})
            AntiAimSection:CreateSlider({Name = "Spin speed", Value = 1, Minimum = 0.1, Maximum = 10, Decimals = 0.1, Flag = "antiaim spin speed"})
            AntiAimSection:CreateSlider({Name = "Custom yaw", Value = 0, Minimum = -180, Maximum = 180, Suffix = "°", Flag = "antiaim custom yaw"})
            AntiAimSection:CreateSlider({Name = "Custom pitch", Value = 0, Minimum = -90, Maximum = 90, Suffix = "°", Flag = "antiaim custom pitch"})
        end
    end

    Info.Initialize()
    Esp.Initialize()
    Movement.Initialize()
    Ragebot.Initialize()
    AntiAim.Initialize()

    if Menu.Window then
        Menu.Window:Open()
    end
end)

if not Success then
    print("[disarray] Runtime error caught:", Error)
end
