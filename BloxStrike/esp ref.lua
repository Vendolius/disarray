-- Esp
do
    Esp.AddPlayer = function(Player)
        local This = {}

        This.Framework = Draw:Frame({
            Name = Player.Name,
            Parent = Menu.Overlay,
            Visible = true,
            BackgroundTransparency = 1
        })

        This.BoxOutline = Draw:UIStroke({
            Parent = This.Framework,
            LineJoinMode = Enum.LineJoinMode.Miter,
            Thickness = 3,
            Transparency = 0.25,
            Color = NewRGB(0, 0, 0)
        })
        
        This.Box = Draw:Frame({
            ZIndex = 1,
            Parent = This.Framework,
            Visible = false,
            Position = NewUDim2(0, -1, 0, -1),
            Size = NewUDim2(1, 2, 1, 2),
            BackgroundTransparency = 1
        })

        This.BoxInline = Draw:UIStroke({
            Parent = This.Box,
            LineJoinMode = Enum.LineJoinMode.Miter,
            Thickness = 1,
            Transparency = 0,
            Color = NewRGB(3, 162, 158)
        })
        
        This.BoxFill = Draw:Frame({
            ZIndex = 2,
            Parent = This.Box,
            Visible = false,
            Position = NewUDim2(0, 1, 0, 1),
            Size = NewUDim2(1, -2, 1, -2),
            BackgroundTransparency = 0.8,
            BackgroundColor3 = NewRGB(0, 0, 0),
            BorderSizePixel = 0
        })

        This.HealthOutline = Draw:Frame({
            ZIndex = 3,
            Parent = This.Framework,
            Visible = false,
            Position = NewUDim2(0, -7, 0, -2),
            Size = NewUDim2(0, 2, 1, 4),
            BorderSizePixel = 0,
            BackgroundColor3 = NewRGB(0, 0, 0),
            BackgroundTransparency = 0.4
        })

        This.HealthInline = Draw:Frame({
            ZIndex = 4,
            Parent = This.HealthOutline,
            Visible = false,
            AnchorPoint = NewVector2(0, 1),
            Position = NewUDim2(0, 0, 1 ,0),
            Size = NewUDim2(1, 0, 1, 0),
            BorderSizePixel = 0,
            BackgroundColor3 = NewRGB(0, 255, 0),
            BackgroundTransparency = 0
        })

        Draw:UIStroke({
            Parent = This.HealthOutline,
            Transparency = 0.4
        })

        This.Name = Draw:TextLabel({
            ZIndex = 3,
            Parent = This.Framework,
            Visible = false,
            Position = NewUDim2(0.5, 0, 0, -9),
            Text = Player.Name,
            FontFace = Fonts[1][1],
            TextSize = Fonts[1][2],
            TextColor3 = NewRGB(255, 255, 255),
            TextTransparency = 0,
            TextStrokeTransparency = 1,
            BackgroundTransparency = 1
        })

        This.NameShadow = Draw:TextLabel({
            ZIndex = 2,
            Parent = This.Framework,
            Visible = false,
            Position = NewUDim2(0.5, 1, 0, -8),
            Text = Player.Name,
            FontFace = Fonts[1][1],
            TextSize = Fonts[1][2],
            TextColor3 = NewRGB(0, 0, 0),
            TextTransparency = 0,
            TextStrokeTransparency = 1,
            BackgroundTransparency = 1
        })

        This.Weapon = Draw:TextLabel({
            ZIndex = 3,
            Parent = This.Framework,
            Visible = false,
            Position = NewUDim2(0.5, 0, 1, 6),
            Text = "",
            FontFace = Fonts[2][1],
            TextSize = Fonts[2][2],
            TextColor3 = NewRGB(255, 255, 255),
            TextTransparency = 0,
            TextStrokeTransparency = 1,
            BackgroundTransparency = 1
        })

        This.Distance = Draw:TextLabel({
            ZIndex = 3,
            Parent = This.Framework,
            Visible = false,
            Position = NewUDim2(0.5, 0, 1, 15),
            Text = "50.0M",
            FontFace = Fonts[2][1],
            TextSize = Fonts[2][2],
            TextColor3 = NewRGB(255, 255, 255),
            TextTransparency = 0,
            TextStrokeTransparency = 1,
            BackgroundTransparency = 1
        })

        Draw:UIStroke({
            Parent = This.Weapon,
            Transparency = 0.4
        })

        Draw:UIStroke({
            Parent = This.Distance,
            Transparency = 0.4
        })

        This.Arrow = Draw:ImageLabel({
            ZIndex = 4,
            Parent = Menu.Overlay,
            Visible = false,
            Size = NewUDim2(0, 10, 0, 10),
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            Image = "http://www.roblox.com/asset/?id=15000587389"
        })

        for i = 1, 9 do
            local Line = NewInstance("Frame")
            Line.Parent = Menu.Overlay
            Line.AnchorPoint = NewVector2(0.5, 0.5)
            Line.BorderSizePixel = 0
            Line.BackgroundColor3 = NewRGB(255, 255, 255)
            This[i] = Line
        end

        return This
    end

    local LastStep = 0
    Esp.Step = function()
        local Time = Tick()
        local Delta = Time - LastStep

        if Delta < (1 / Flags["esp esp settings refresh rate"].Value) then
            return
        end

        LastStep = Time

        if not Flags["esp players enabled"].Value then
            for i = 1, Info.PlayersIndex do
                local Renders = Info.Players[i].Renders
                Renders.Framework.Visible = false
                Renders.Arrow.Visible = false

                for i = 1, 9 do
                    Renders[i].Visible = false
                end
            end

            return
        end

        local WTVP = Camera.WorldToViewportPoint

        local ShowBox = Flags["esp players bounding box"].Value
        local ShowFill = ShowBox and Flags["esp players filled bounding box"].Value
        local ShowHealth = Flags["esp players health bar"].Value
        local ShowName = Flags["esp players name"].Value
        local ShowWeapon = Flags["esp players held weapon"].Value
        local ShowDistance = Flags["esp players distance"].Value
        local ShowSkeleton = Flags["esp players skeleton"].Value
        local ShowArrow = Flags["esp players out of view"].Value

        local BoxColorpicker = ShowBox and Flags["esp players bounding box color"]
        local BoxFillColorpicker = ShowFill and Flags["esp players filled bounding box color"]
        local HealthColorLow = ShowHealth and Flags["esp players health bar color low"]
        local HealthColorHigh = ShowHealth and Flags["esp players health bar color high"]
        local NameColorpicker = ShowName and Flags["esp players name color"]
        local SkeletonColorpicker = ShowSkeleton and Flags["esp players skeleton color"]
        local ArrowColorpicker = ShowArrow and Flags["esp players arrow color"]
        local ArrowDynamic = ShowArrow and Flags["esp players dynamic arrow size"].Value
        local ArrowSize = not ArrowDynamic and Flags["esp players arrow size"].Value

        local DrawDistance = Flags["esp esp settings maximum draw distance"].Value

        for i = 1, Info.PlayersIndex do
            local Data = Info.Players[i]

            if not Data.RootPosition or Data.Distance > DrawDistance then
                local Renders = Data.Renders
                Renders.Framework.Visible = false
                Renders.Arrow.Visible = false

                for i = 1, 9 do
                    Renders[i].Visible = false
                end

                continue
            end

            if not Data.Character or not Data.Character.Parent or Data.Health <= 0 or not Data.Humanoid or not Data.RootPart or not Data.RootPart.Parent then
                local Renders = Data.Renders
                Renders.Framework.Visible = false
                Renders.Arrow.Visible = false

                for i = 1, 9 do
                    Renders[i].Visible = false
                end

                continue
            end

            local LocalTeam = LocalPlayer.Team
            local LocalTeamAttr = LocalPlayer:GetAttribute("Team")
            local PlayerTeam = Data.Player.Team
            local PlayerTeamAttr = Data.Player:GetAttribute("Team")
            Data.IsTeammate = (LocalTeam and PlayerTeam and LocalTeam == PlayerTeam) or (LocalTeamAttr and PlayerTeamAttr and LocalTeamAttr == PlayerTeamAttr)

            if Data.IsTeammate then
                local Renders = Data.Renders
                Renders.Framework.Visible = false
                Renders.Arrow.Visible = false

                for i = 1, 9 do
                    Renders[i].Visible = false
                end

                continue
            end

            local Renders = Data.Renders
            local RootPosition = Data.RootPosition
            local Position, OnScreen = WTVP(RootPosition, true)

            if not OnScreen then
                if not ShowArrow then
                    Renders.Framework.Visible = false
                    Renders.Arrow.Visible = false
                    for i = 1, 9 do
                        Renders[i].Visible = false
                    end

                    continue
                end

                local Relative = PointToObjectSpace(CurrentCamera.CFrame, RootPosition)
                local Angle = Atan2(-Relative.Y, Relative.X)
                local Rotation = Deg(Angle)
                local Radius = 350

                local Arrow = Renders.Arrow

                Arrow.ImageColor3 = ArrowColorpicker.Color
                Arrow.ImageTransparency = ArrowColorpicker.Transparency
                Arrow.Position = NewUDim2(0, ScreenSizeX / 2 + Radius * Cos(Rad(Rotation)), 0, ScreenSizeY / 2 + Radius * Sin(Rad(Rotation)))
                Arrow.Rotation = Rotation + 90
                Arrow.Visible = true

                local Size = ArrowDynamic and Clamp(((Data.Distance - 1) / (100 - 1)) * (7 - 20) + 20, 7, 20) or ArrowSize
                Arrow.Size = NewUDim2(0, Size, 0, Size)
                
                Renders.Framework.Visible = false
                for i = 1, 9 do
                    Renders[i].Visible = false
                end
                continue
            end

            local RootUpVector = Data.RootCFrame.UpVector
            local RootRightVector = Data.RootCFrame.RightVector
            
            local HeadPosition = RootPosition
            if Data.BodyParts.head then
                HeadPosition = Data.BodyParts.head.Position
            else
                HeadPosition = RootPosition + RootUpVector * 2.5
            end
            
            local Top = WTVP(HeadPosition + RootUpVector * 0.5, false)
            local Bottom = WTVP(RootPosition - RootUpVector * 2.5, false)
            local Left = WTVP(RootPosition - RootRightVector * 1.5, false)
            local Right = WTVP(RootPosition + RootRightVector * 1.5, false)

            local Width = Abs(Left.X - Right.X)
            local Height = Abs(Top.Y - Bottom.Y)
            local SizeX = Floor(Max(Width, Height * 0.5))

            local Framework = Renders.Framework
            Framework.Position = NewUDim2(0, Floor((Left.X + Right.X - SizeX) / 2), 0, Floor(Min(Top.Y, Bottom.Y)))
            Framework.Size = NewUDim2(0, SizeX, 0, Floor(Height))
            Framework.Visible = true

            if ShowBox then
                local Box, BoxInline, BoxOutline, BoxFill = Renders.Box, Renders.BoxInline, Renders.BoxOutline, Renders.BoxFill

                Box.Visible = true
                BoxInline.Enabled = true
                BoxInline.Color = BoxColorpicker.Color
                BoxInline.Transparency = BoxColorpicker.Transparency

                BoxOutline.Enabled = true
                BoxOutline.Transparency = BoxColorpicker.Transparency

                if ShowFill then
                    BoxFill.Visible = true
                    BoxFill.BackgroundColor3 = BoxFillColorpicker.Color
                    BoxFill.BackgroundTransparency = BoxFillColorpicker.Transparency
                else
                    BoxFill.Visible = false
                end
            else
                Renders.Box.Visible = false
                Renders.BoxInline.Enabled = false
                Renders.BoxOutline.Enabled = false
            end

            if ShowHealth then
                local Percent = Data.Health / Data.MaxHealth

                Renders.HealthInline.Visible = true
                Renders.HealthInline.Size = NewUDim2(1, 0, Percent, 0)
                Renders.HealthInline.BackgroundColor3 = HealthColorLow.Color:Lerp(HealthColorHigh.Color, Percent)
                Renders.HealthOutline.Visible = true
            else
                Renders.HealthOutline.Visible = false
                Renders.HealthInline.Visible = false
            end

            if ShowName then
                local Name = Renders.Name
                local NameShadow = Renders.NameShadow

                Name.Visible = true
                Name.TextColor3 = NameColorpicker.Color
                Name.TextTransparency = NameColorpicker.Transparency

                NameShadow.Visible = true
                NameShadow.TextTransparency = NameColorpicker.Transparency
            else
                Renders.Name.Visible = false
                Renders.NameShadow.Visible = false
            end

            if ShowWeapon and Data.Weapon then
                local Weapon = Renders.Weapon

                Weapon.Visible = true
                Weapon.Text = Data.Weapon
            else
                Renders.Weapon.Visible = false
            end

            if ShowDistance then
                local Distance = Renders.Distance

                Distance.Visible = true
                Distance.Text = (Floor(Data.Distance * 10 + 0.5) / 10) .. "M"
                Distance.Position = Renders.Weapon.Visible and NewUDim2(0.5, 0, 1, 14) or NewUDim2(0.5, 0, 1, 6)
            else
                Renders.Distance.Visible = false
            end

            if ShowSkeleton then
                local Joints = Data.Joints
                local DebugSkeleton = false
                if Flags["esp debug skeleton"] then
                    DebugSkeleton = Flags["esp debug skeleton"].Value
                end
                if DebugSkeleton then
                    Debugging.Log("Debug", {"ESP", "Skeleton"}, {
                        Player = Data.Name,
                        JointsCount = #Joints
                    })
                end
                for i = 1, #Joints do
                    local PartA = Joints[i][1]
                    local PartB = Joints[i][2]
                    
                    if not PartA or not PartB then
                        if DebugSkeleton then
                            Debugging.Log("Warn", {"ESP", "Skeleton"}, {
                                Joint = i,
                                PartA = PartA == nil,
                                PartB = PartB == nil
                            })
                        end
                        continue
                    end
                    
                    local PositionA = WTVP(PartA.Position)
                    local PositionB = WTVP(PartB.Position)

                    if DebugSkeleton and i == 1 then
                        Debugging.Log("Debug", {"ESP", "Skeleton"}, {
                            Joint = i,
                            PartA = PartA.Name,
                            PartB = PartB.Name,
                            PositionA = PositionA,
                            PositionB = PositionB
                        })
                    end

                    if PositionA.Z > 0 and PositionB.Z > 0 then
                        local Center = (NewVector2(PositionA.X, PositionA.Y) + NewVector2(PositionB.X, PositionB.Y)) / 2
                        local Offset = NewVector2(PositionB.X, PositionB.Y) - NewVector2(PositionA.X, PositionA.Y)

                        local Line = Renders[i]
                        Line.Position = NewUDim2(0, Center.X, 0, Center.Y)
                        Line.Size = NewUDim2(0, Offset.Magnitude, 0, 1)
                        Line.Rotation = Deg(Atan2(Offset.Y, Offset.X))
                        Line.BackgroundColor3 = SkeletonColorpicker.Color
                        Line.Transparency = SkeletonColorpicker.Transparency
                        Line.Visible = true
                    else
                        if DebugSkeleton and i == 1 then
                            Debugging.Log("Debug", {"ESP", "Skeleton"}, {
                                Joint = i,
                                PositionAZ = PositionA.Z,
                                PositionBZ = PositionB.Z,
                                Message = "Off screen"
                            })
                        end
                        Renders[i].Visible = false
                    end
                end
            else
                for i = 1, 9 do
                    Renders[i].Visible = false
                end
            end

            Renders.Arrow.Visible = false
        end
    end

    Esp.Connections = {}
    
    Esp.Load = function()
        Esp.StepConnection = RenderStepped:Connect(Esp.Step)
        Esp.Connections[#Esp.Connections + 1] = Esp.StepConnection

        Esp.Loaded = true
    end
end