local Success, Error = pcall(function()
    local Tick = tick
    local Game = game
    local GetService = Game.GetService
    local WaitForChild = Game.WaitForChild
    local FindFirstChildOfClass = Game.FindFirstChildOfClass
    local GetPropertyChangedSignal = Game.GetPropertyChangedSignal

    local NewInstance = Instance.new
    local NewVector3 = Vector3.new
    local NewVector2 = Vector2.new
    local NewCFrame = CFrame.new
    local NewUDim2 = UDim2.new
    local NewRGB = Color3.fromRGB

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
    local Max = math.max
    local Min = math.min
    local Pi = math.pi

    local Infinite = 1 / 0
    local ToDeg = 180 / Pi
    local ToRad = Pi / 180
    local TwoPi = Pi * 2

    local Spawn = task.spawn

    local Remove = table.remove
    local Rep = string.rep

    local RunService = GetService(Game, "RunService")
    local Workspace = GetService(Game, "Workspace")
    local Players = GetService(Game, "Players")

    local RenderStepped = RunService.RenderStepped
    local Stepped = RunService.Stepped

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

    local Camera   = {}
    local Info     = {}
    local Esp      = {}


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


        -- Functions
        do
            Info.AddPlayer = function(Player)
                local Data = {
                    Player = Player,
                    Name = Player.Name,
                    Team = Player.Team,

                    Health = 100,
                    MaxHealth = 100,

                    ForceField = false,

                    BodyParts = {},
                    Joints = {},

                    Renders = Esp.CreateRenders(Player)
                }

                Data.OnSpawn = function(Character)
                    Data.Character = Character
                    Data.Humanoid = WaitForChild(Character, "Humanoid", Infinite)
                    Data.RootPart = WaitForChild(Character, "HumanoidRootPart", Infinite)
                    Data.Health = Data.Humanoid.Health
                    Data.MaxHealth = Data.Humanoid.MaxHealth

                    Character.ChildAdded:Connect(function(Child)
                        if Child.ClassName == "Tool" then
                            Data.Weapon = Child.Name
                        end
                    end)

                    Character.ChildRemoved:Connect(function(Child)
                        if Child.ClassName == "Tool" then
                            Data.Weapon = nil
                        end
                    end)

                    Data.Humanoid.HealthChanged:Connect(function()
                        if not Data.Humanoid then return end

                        local Health = Data.Humanoid.Health
                        if Health <= 0 then
                            Data.OnDeath()
                            return
                        end

                        Data.Health = Health
                        Data.MaxHealth = Data.Humanoid.MaxHealth
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

                Player.CharacterAdded:Connect(Data.OnSpawn)
                local Character = Player.Character
                if Character then
                    Spawn(Data.OnSpawn, Player.Character)
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
                for i = 1, Info.PlayersIndex do
                    local Data = Info.Players[i]

                    if Data.Humanoid and Data.RootPart then
                        Data.RootCFrame = Data.RootPart.CFrame
                        Data.RootPosition = Data.RootPart.Position

                        --RecursivePrint(Data)
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

            Renders[6] = Draw.Frame({ -- Health Outline
                {"Parent", Renders[1]},
                {"Position", NewUDim2(0, 0, 0, -4)},
                {"Size", NewUDim2(1, 0, 0, 2)},
                {"BorderSizePixel", 0},
                {"BackgroundColor3", NewRGB(0, 0, 0)},
                {"BackgroundTransparency", 0.4},
                {"ZIndex", 3},
                {"Visible", false}
            })

            Renders[7] = Draw.Frame({ -- Health Inline
                {"Parent", Renders[6]},
                {"AnchorPoint", NewVector2(0, 0)},
                {"Position", NewUDim2(0, 0, 0, 0)},
                {"Size", NewUDim2(1, 0, 1, 0)},
                {"BorderSizePixel", 0},
                {"BackgroundColor3", NewRGB(0, 255, 0)},
                {"BackgroundTransparency", 0},
                {"ZIndex", 4},
                {"Visible", false}
            })

            Draw.UIStroke({
                {"Parent", Renders[6]},
                {"Transparency", 0.4}
            })

            Renders[8] = Draw.TextLabel({
                {"ZIndex", 3},
                {"Parent", Renders[1]},
                {"Visible", false},
                {"Position", NewUDim2(0.5, 0, 0, -11)},
                {"Text", Player.Name},
                {"BackgroundTransparency", 1}
            }, {MinecraftFont, 10, White})

            Renders[9] = Draw.TextLabel({
                {"ZIndex", 2},
                {"Parent", Renders[1]},
                {"Visible", false},
                {"Position", NewUDim2(0.5, 1, 0, -10)},
                {"Text", Player.Name},
                {"BackgroundTransparency", 1}
            }, {MinecraftFont, 10, Black})

            return Renders
        end

        local LastStep = 0
        Esp.Step = function()
            local RefreshRate = Esp.RefreshRate
            if RefreshRate ~= 0 then
                local Time = Tick()

                if (Time - LastStep) < RefreshRate then
                    return
                end

                LastStep = Time
            end

            local WorldToViewportPoint = Camera.WorldToViewportPoint

            local PlayersList = Info.Players
            for i = 1, Info.PlayersIndex do
                local Data = PlayersList[i]
                local RootPosition = Data.RootPosition

                if not RootPosition then
                    local Renders = Data.Renders

                    Renders[1].Visible = false
                    continue
                end

                local Renders = Data.Renders
                local Position, OnScreen = WorldToViewportPoint(RootPosition, true)

                if not OnScreen then
                    Renders[1].Visible = false
                    continue
                end

                local RootUpVector = Data.RootCFrame.UpVector
                local Top = WorldToViewportPoint(RootPosition + RootUpVector * 1.5, false)
                local Bottom = WorldToViewportPoint(RootPosition - RootUpVector * 2.5, false)

                local Width = Abs(Top.X - Bottom.X)
                local Height = Max(Abs(Top.Y - Bottom.Y), Width)
                local SizeX = Floor(Max(Height / 2, Width * 2.5))

                local Framework = Renders[1]
                Framework.Position = NewUDim2(0, Floor((Top.X + Bottom.X - SizeX) / 2), 0, Floor(Min(Top.Y, Bottom.Y)))
                Framework.Size = NewUDim2(0, SizeX, 0, Floor(Height))
                Framework.Visible = true

                if true then
                    local Name = Renders[8]
                    local NameShadow = Renders[9]

                    Name.Visible = true
                    Name.TextColor3 = NewRGB(255, 255, 255)
                    Name.TextTransparency = 0.2

                    NameShadow.Visible = true
                    NameShadow.TextTransparency = 0.3
                else
                    Renders[8].Visible = false
                    Renders[9].Visible = false
                end
            end
        end

        Esp.Initialize = function()
            RenderStepped:Connect(Esp.Step)
        end
    end

    Info.Initialize()
    Esp.Initialize()
end)

if not Success then
    print("[disarray] Runtime error caught:", Error)
end