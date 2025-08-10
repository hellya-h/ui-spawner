-- Create the ScreenGui and set up the basic UI components
local player = game.Players.LocalPlayer
local screenGui = Instance.new("ScreenGui")
screenGui.Parent = player.PlayerGui
screenGui.Name = "CustomSpawnerUI"

local frame = Instance.new("Frame")
frame.Parent = screenGui
frame.Size = UDim2.new(0, 400, 0, 500)
frame.Position = UDim2.new(0.5, -200, 0.5, -250)
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
frame.BorderSizePixel = 5
frame.BorderColor3 = Color3.fromRGB(255, 255, 255)

-- Add title label
local titleLabel = Instance.new("TextLabel")
titleLabel.Parent = frame
titleLabel.Size = UDim2.new(1, 0, 0, 50)
titleLabel.Position = UDim2.new(0, 0, 0, 0)
titleLabel.Text = "Custom Pet Spawner"
titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
titleLabel.TextSize = 24
titleLabel.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
titleLabel.TextAlign = Enum.TextXAlignment.Center
titleLabel.Font = Enum.Font.SourceSansBold

-- Add buttons for spawning pets, seeds, and eggs
local spawnPetButton = Instance.new("TextButton")
spawnPetButton.Parent = frame
spawnPetButton.Size = UDim2.new(0.8, 0, 0, 50)
spawnPetButton.Position = UDim2.new(0.1, 0, 0.2, 0)
spawnPetButton.Text = "Spawn Pet"
spawnPetButton.TextColor3 = Color3.fromRGB(255, 255, 255)
spawnPetButton.TextSize = 18
spawnPetButton.BackgroundColor3 = Color3.fromRGB(75, 75, 75)

local spawnSeedButton = Instance.new("TextButton")
spawnSeedButton.Parent = frame
spawnSeedButton.Size = UDim2.new(0.8, 0, 0, 50)
spawnSeedButton.Position = UDim2.new(0.1, 0, 0.3, 0)
spawnSeedButton.Text = "Spawn Seed"
spawnSeedButton.TextColor3 = Color3.fromRGB(255, 255, 255)
spawnSeedButton.TextSize = 18
spawnSeedButton.BackgroundColor3 = Color3.fromRGB(75, 75, 75)

local spawnEggButton = Instance.new("TextButton")
spawnEggButton.Parent = frame
spawnEggButton.Size = UDim2.new(0.8, 0, 0, 50)
spawnEggButton.Position = UDim2.new(0.1, 0, 0.4, 0)
spawnEggButton.Text = "Spawn Egg"
spawnEggButton.TextColor3 = Color3.fromRGB(255, 255, 255)
spawnEggButton.TextSize = 18
spawnEggButton.BackgroundColor3 = Color3.fromRGB(75, 75, 75)

-- Add input fields for specifying pet, seed, and egg parameters
local petInput = Instance.new("TextBox")
petInput.Parent = frame
petInput.Size = UDim2.new(0.8, 0, 0, 50)
petInput.Position = UDim2.new(0.1, 0, 0.5, 0)
petInput.PlaceholderText = "Enter Pet Name"
petInput.TextColor3 = Color3.fromRGB(255, 255, 255)
petInput.TextSize = 18
petInput.BackgroundColor3 = Color3.fromRGB(100, 100, 100)

local seedInput = Instance.new("TextBox")
seedInput.Parent = frame
seedInput.Size = UDim2.new(0.8, 0, 0, 50)
seedInput.Position = UDim2.new(0.1, 0, 0.6, 0)
seedInput.PlaceholderText = "Enter Seed Name"
seedInput.TextColor3 = Color3.fromRGB(255, 255, 255)
seedInput.TextSize = 18
seedInput.BackgroundColor3 = Color3.fromRGB(100, 100, 100)

local eggInput = Instance.new("TextBox")
eggInput.Parent = frame
eggInput.Size = UDim2.new(0.8, 0, 0, 50)
eggInput.Position = UDim2.new(0.1, 0, 0.7, 0)
eggInput.PlaceholderText = "Enter Egg Name"
eggInput.TextColor3 = Color3.fromRGB(255, 255, 255)
eggInput.TextSize = 18
eggInput.BackgroundColor3 = Color3.fromRGB(100, 100, 100)

-- Create a function to handle the spawning logic
spawnPetButton.MouseButton1Click:Connect(function()
    local petName = petInput.Text
    if petName ~= "" then
        -- Here you can specify default weight (1) and age (2) or take input from the user
        Spawner.SpawnPet(petName, 1, 2)
    else
        print("Please enter a pet name.")
    end
end)

spawnSeedButton.MouseButton1Click:Connect(function()
    local seedName = seedInput.Text
    if seedName ~= "" then
        Spawner.SpawnSeed(seedName)
    else
        print("Please enter a seed name.")
    end
end)

spawnEggButton.MouseButton1Click:Connect(function()
    local eggName = eggInput.Text
    if eggName ~= "" then
        Spawner.SpawnEgg(eggName)
    else
        print("Please enter an egg name.")
    end
end)

-- Add a button to load the default UI
local loadUIButton = Instance.new("TextButton")
loadUIButton.Parent = frame
loadUIButton.Size = UDim2.new(0.8, 0, 0, 50)
loadUIButton.Position = UDim2.new(0.1, 0, 0.8, 0)
loadUIButton.Text = "Load Default UI"
loadUIButton.TextColor3 = Color3.fromRGB(255, 255, 255)
loadUIButton.TextSize = 18
loadUIButton.BackgroundColor3 = Color3.fromRGB(75, 75, 75)

loadUIButton.MouseButton1Click:Connect(function()
    Spawner.Load()
end)

-- Optional: Add a close button
local closeButton = Instance.new("TextButton")
closeButton.Parent = frame
closeButton.Size = UDim2.new(0.1, 0, 0, 30)
closeButton.Position = UDim2.new(1, -40, 0, 10)
closeButton.Text = "X"
closeButton.TextColor3 = Color3.fromRGB(255, 0, 0)
closeButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)

closeButton.MouseButton1Click:Connect(function()
    screenGui:Destroy()
end)

