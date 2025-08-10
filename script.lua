local Spawner = loadstring(game:HttpGet("https://gitlab.com/darkiedarkie/dark/-/raw/main/Spawner.lua"))()

-- Remove default UI
-- Spawner.Load() -- not calling this

-- Create ScreenGui
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = game:GetService("CoreGui")

-- Draggable Frame
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 300, 0, 200)
MainFrame.Position = UDim2.new(0.3, 0, 0.3, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

-- Title
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 40)
Title.BackgroundColor3 = Color3.fromRGB(0, 85, 170)
Title.Text = "Custom Spawner UI"
Title.TextColor3 = Color3.new(1, 1, 1)
Title.Font = Enum.Font.SourceSansBold
Title.TextSize = 20
Title.Parent = MainFrame

-- Utility function for buttons
local function createButton(name, yPos, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, -20, 0, 30)
    btn.Position = UDim2.new(0, 10, 0, yPos)
    btn.BackgroundColor3 = Color3.fromRGB(40, 40, 55)
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.Font = Enum.Font.SourceSans
    btn.TextSize = 18
    btn.Text = name
    btn.MouseButton1Click:Connect(callback)
    btn.Parent = MainFrame
end

-- Buttons using Spawner functions
createButton("Spawn Raccoon", 50, function()
    Spawner.SpawnPet("Raccoon", 1, 2)
end)

createButton("Spawn Candy Blossom", 90, function()
    Spawner.SpawnSeed("Candy Blossom")
end)

createButton("Spawn Night Egg", 130, function()
    Spawner.SpawnEgg("Night Egg")
end)

createButton("Spin Sunflower", 170, function()
    Spawner.Spin("Sunflower")
end)
