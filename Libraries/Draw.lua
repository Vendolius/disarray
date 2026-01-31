-- Draw Library
local Env = getgenv()

if Env.Draw then
    return Env.Draw
end

local PCall = pcall

local Enum = Enum
local Game = game
local HttpGet = Game.HttpGet
local GetService = Game.GetService

local NewInstance = Instance.new
local NewVector2 = Vector2.new
local NewUDim2 = UDim2.new
local NewUDim = UDim.new
local NewFont = Font.new
local NewRGB = Color3.fromRGB

local Wait = task.wait

local White = NewRGB(255, 255, 255)
local Black = NewRGB(0, 0, 0)

local TextService = GetService(Game, "TextService")
local HttpService = GetService(Game, "HttpService")

local JSONEncode = HttpService.JSONEncode


local Draw = {}



function Assert(Condition, Message)
    if not Condition then
        warn("[ASSERT] " .. (Message or "Assertion failed!"))
        --Debug.Log("Error", Message or "Assertion failed!")
        repeat Wait() until false -- Avoid using error()
    end
end


-- Draw Lib
do
    -- Allocations
    Draw.Fonts = {
        ["Default"] = NewFont("rbxasset://fonts/families/Ubuntu.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
    }

    Draw.Folder = NewInstance("Folder")
    Draw.Folder.Parent = gethui()
    Draw.Folder.Name = "disarray"

    -- Functions
    do
        Draw.ImportFont = function(Index, Name, Link, Weight, FontWeight, FontStyle)
            local DotTTF  = "disarray/Fonts/" .. Name .. ".ttf"
            local DotFONT = "disarray/Fonts/" .. Name .. ".font"

            if not isfile(DotTTF) then
                local Success, Data = PCall(HttpGet, Game, Link)
                Assert(Success and Data, "[Draw.ImportFont] Failed to fetch .ttf for font " .. Name)
                writefile(DotTTF, Data)
            end

            writefile(DotFONT, JSONEncode(HttpService, {
                name = Name,
                faces = {{
                    name = "Regular",
                    weight = Weight or 400,
                    style = "normal",
                    assetId = getcustomasset(DotTTF)
                }}
            }))

            Draw.Fonts[Index] = NewFont(getcustomasset(DotFONT), FontWeight or Enum.FontWeight.Regular, FontStyle or Enum.FontStyle.Normal)

            return Draw.Fonts[Index]
        end

        Draw.ScreenGui = function(Properties)
			local Render = NewInstance("ScreenGui")
			Render.ZIndexBehavior = Enum.ZIndexBehavior.Global
			Render.IgnoreGuiInset = true
			Render.DisplayOrder = 1

            for i = 1, #Properties do
                local Property = Properties[i]
                Render[Property[1]] = Property[2]
            end

			return Render
		end

        Draw.Frame = function(Properties)
			local Render = NewInstance("Frame")
			Render.BorderSizePixel = 1
			Render.BackgroundTransparency = 0
			Render.BackgroundColor3 = Black
			Render.BorderColor3 = Black
			Render.ZIndex = 1
			Render.Visible = true

            for i = 1, #Properties do
                local Property = Properties[i]
                Render[Property[1]] = Property[2]
            end

			return Render
		end

        Draw.ScrollingFrame = function(Properties)
			local Render = NewInstance("ScrollingFrame")
			Render.BorderSizePixel = 1
			Render.BackgroundTransparency = 0
			Render.BorderColor3 = Black
			Render.BackgroundColor3 = Black
			Render.ZIndex = 1
			Render.Visible = true
			
            for i = 1, #Properties do
                local Property = Properties[i]
                Render[Property[1]] = Property[2]
            end

			return Render
		end

        Draw.TextLabel = function(Properties, Font)
            local Render = NewInstance("TextLabel")
            Render.BackgroundTransparency = 1
            Render.TextStrokeTransparency = 1
            Render.TextTransparency = 0
            Render.BorderSizePixel = 0
            Render.Text = "TextLabel"
            Render.FontFace = Font[1]
            Render.TextSize = Font[2]
            Render.TextColor3 = Font[3]
            Render.ZIndex = 1
            Render.Visible = true

            for i = 1, #Properties do
                local Property = Properties[i]
                Render[Property[1]] = Property[2]
            end

            return Render
        end

        Draw.UIStroke = function(Properties)
            local Render = NewInstance("UIStroke")
            Render.ApplyStrokeMode = Enum.ApplyStrokeMode.Contextual
            Render.LineJoinMode = Enum.LineJoinMode.Miter
            Render.Color = Black
            Render.Transparency = 0
            Render.Thickness = 1
            Render.Enabled = true

            for i = 1, #Properties do
                local Property = Properties[i]
                Render[Property[1]] = Property[2]
            end

            return Render
        end
        
		Draw.ImageLabel = function(Properties)
			local Render = NewInstance("ImageLabel")
			Render.BorderSizePixel = 1
			Render.BackgroundTransparency = 0
			Render.BackgroundColor3 = White
			Render.ImageColor3 = White
			Render.BorderColor3 = Black
			Render.ResampleMode = Enum.ResamplerMode.Default
			Render.ZIndex = 1
			Render.Visible = true
			
            for i = 1, #Properties do
                local Property = Properties[i]
                Render[Property[1]] = Property[2]
            end

			return Render
		end

        Draw.ImageButton = function(Properties)
			local Render = NewInstance("ImageButton")
			Render.BorderSizePixel = 1
			Render.BackgroundTransparency = 0
			Render.BackgroundColor3 = White
			Render.ImageColor3 = White
			Render.BorderColor3 = Black
			Render.ResampleMode = Enum.ResamplerMode.Default
			Render.AutoButtonColor = false
			Render.ZIndex = 1
			Render.Visible = true
			
            for i = 1, #Properties do
                local Property = Properties[i]
                Render[Property[1]] = Property[2]
            end

			return Render
		end

        Draw.TextButton = function(Properties, Font)
            local Render = NewInstance("TextButton")
            Render.BorderSizePixel = 1
            Render.BackgroundTransparency = 0
            Render.TextStrokeTransparency = 1
            Render.BorderColor3 = Black
            Render.BackgroundColor3 = Black
            Render.FontFace = Font[1]
            Render.TextSize = Font[2]
            Render.TextColor3 = Font[3]
            Render.AutoButtonColor = false
            Render.RichText = true
            Render.ZIndex = 1
            Render.Visible = true

            for i = 1, #Properties do
                local Property = Properties[i]
                Render[Property[1]] = Property[2]
            end

			return Render
        end

        Draw.Textbox = function(Properties, Font)
            local Render = NewInstance("TextBox")
            Render.BorderSizePixel = 1
            Render.BackgroundTransparency = 0
            Render.TextStrokeTransparency = 1
            Render.PlaceholderText = ""
            Render.BorderColor3 = Black
            Render.BackgroundColor3 = Black
            Render.FontFace = Font[1]
            Render.TextSize = Font[2]
            Render.TextColor3 = Font[3]
            Render.ClearTextOnFocus = false
            Render.ZIndex = 1
            Render.Visible = true

            for i = 1, #Properties do
                local Property = Properties[i]
                Render[Property[1]] = Property[2]
            end

			return Render
        end

        Draw.UIListLayout = function(Properties)
			local Render = NewInstance("UIListLayout")
			Render.ItemLineAlignment = "Start"
            Render.FillDirection = "Vertical"
			Render.VerticalFlex = "None"
			Render.Padding = NewUDim(0, 0)
			Render.Wraps = false

            for i = 1, #Properties do
                local Property = Properties[i]
                Render[Property[1]] = Property[2]
            end

			return Render
		end

        Draw.UIGradient = function(Properties)
            local Render = NewInstance("UIGradient")
            Render.Offset = NewVector2(0, 0)
            --Render.Transparency = 0
            Render.Rotation = 90
            Render.Enabled = true

            for i = 1, #Properties do
                local Property = Properties[i]
                Render[Property[1]] = Property[2]
            end

            return Render
        end

        Draw.GetTextBounds = function(Text, Font, FontSize)
            local Params = NewInstance("GetTextBoundsParams")

            Params.Text = Text
            Params.Font = Font
            Params.Size = FontSize
            Params.Width = ScreenSize.X

            local Bounds = GetTextBoundsAsync(TextService, Params)

            Destroy(Params)

            return Bounds
		end
    end
end


Env.Draw = Draw

return Draw