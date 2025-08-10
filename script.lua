-- Create the basic ScreenGui and UI components
local player = game.Players.LocalPlayer
local screenGui = Instance.new("ScreenGui")
screenGui.Parent = player.PlayerGui
screenGui.Name = "PetSpawnerExecutor"

local frame = Instance.new("Frame")
frame.Parent = screenGui
frame.Size = UDim2.new(0, 400, 0, 400)
frame.Position = UDim2.new(0.5, -200, 0.5, -200)
frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
frame.BorderSizePixel = 0

-- Title label
local titleLabel = Instance.new("TextLabel")
titleLabel.Parent = frame
titleLabel.Size = UDim2.new(1, 0, 0, 40)
titleLabel.Position = UDim2.new(0, 0, 0, 0)
titleLabel.Text = "Pet Spawner"
titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
titleLabel.TextSize = 24
titleLabel.BackgroundTransparency = 1
titleLabel.TextAlign = Enum.TextXAlignment.Center
titleLabel.Font = Enum.Font.SourceSansBold

-- Pet Name Input
local petInput = Instance.new("TextBox")
petInput.Parent = frame
petInput.Size = UDim2.new(0.8, 0, 0, 40)
petInput.Position = UDim2.new(0.1, 0, 0.1, 0)
petInput.PlaceholderText = "Pet Name"
petInput.TextColor3 = Color3.fromRGB(255, 255, 255)
petInput.TextSize = 16
petInput.BackgroundColor3 = Color3.fromRGB(50, 50, 50)

-- Seed Name Input
local seedInput = Instance.new("TextBox")
seedInput.Parent = frame
seedInput.Size = UDim2.new(0.8, 0, 0, 40)
seedInput.Position = UDim2.new(0.1, 0, 0.2, 0)
seedInput.PlaceholderText = "Seed Name"
seedInput.TextColor3 = Color3.fromRGB(255, 255, 255)
seedInput.TextSize = 16
seedInput.BackgroundColor3 = Color3.fromRGB(50, 50, 50)

-- Egg Name Input
local eggInput = Instance.new("TextBox")
eggInput.Parent = frame
eggInput.Size = UDim2.new(0.8, 0, 0, 40)
eggInput.Position = UDim2.new(0.1, 0, 0.3, 0)
eggInput.PlaceholderText = "Egg Name"
eggInput.TextColor3 = Color3.fromRGB(255, 255, 255)
eggInput.TextSize = 16
eggInput.BackgroundColor3 = Color3.fromRGB(50, 50, 50)

-- Spawn Buttons (Pet, Seed, Egg)
local spawnPetButton = Instance.new("TextButton")
spawnPetButton.Parent = frame
spawnPetButton.Size = UDim2.new(0.8, 0, 0, 40)
spawnPetButton.Position = UDim2.new(0.1, 0, 0.4, 0)
spawnPetButton.Text = "Spawn Pet"
spawnPetButton.TextColor3 = Color3.fromRGB(255, 255, 255)
spawnPetButton.TextSize = 16
spawnPetButton.BackgroundColor3 = Color3.fromRGB(70, 70, 70)

local spawnSeedButton = Instance.new("TextButton")
spawnSeedButton.Parent = frame
spawnSeedButton.Size = UDim2.new(0.8, 0, 0, 40)
spawnSeedButton.Position = UDim2.new(0.1, 0, 0.5, 0)
spawnSeedButton.Text = "Spawn Seed"
spawnSeedButton.TextColor3 = Color3.fromRGB(255, 255, 255)
spawnSeedButton.TextSize = 16
spawnSeedButton.BackgroundColor3 = Color3.fromRGB(70, 70, 70)

local spawnEggButton = Instance.new("TextButton")
spawnEggButton.Parent = frame
spawnEggButton.Size = UDim2.new(0.8, 0, 0, 40)
spawnEggButton.Position = UDim2.new(0.1, 0, 0.6, 0)
spawnEggButton.Text = "Spawn Egg"
spawnEggButton.TextColor3 = Color3.fromRGB(255, 255, 255)
spawnEggButton.TextSize = 16
spawnEggButton.BackgroundColor3 = Color3.fromRGB(70, 70, 70)

-- Button to load the default UI
local loadDefaultUIButton = Instance.new("TextButton")
loadDefaultUIButton.Parent = frame
loadDefaultUIButton.Size = UDim2.new(0.8, 0, 0, 40)
loadDefaultUIButton.Position = UDim2.new(0.1, 0, 0.7, 0)
loadDefaultUIButton.Text = "Load Default UI"
loadDefaultUIButton.TextColor3 = Color3.fromRGB(255, 255, 255)
loadDefaultUIButton.TextSize = 16
loadDefaultUIButton.BackgroundColor3 = Color3.fromRGB(70, 70, 70)

-- Button to close the UI
local closeButton = Instance.new("TextButton")
closeButton.Parent = frame
closeButton.Size = UDim2.new(0.1, 0, 0, 30)
closeButton.Position = UDim2.new(1, -40, 0, 10)
closeButton.Text = "X"
closeButton.TextColor3 = Color3.fromRGB(255, 0, 0)
closeButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)

-- Handling the buttons
spawnPetButton.MouseButton1Click:Connect(function()
    local petName = petInput.Text
    if petName and petName ~= "" then
        Spawner.SpawnPet(petName, 1, 2)  -- Customize weights and age as needed
    else
        warn("Please enter a valid Pet name.")
    end
end)

spawnSeedButton.MouseButton1Click:Connect(function()
    local seedName = seedInput.Text
    if seedName and seedName ~= "" then
        Spawner.SpawnSeed(seedName)
    else
        warn("Please enter a valid Seed name.")
    end
end)

spawnEggButton.MouseButton1Click:Connect(function()
    local eggName = eggInput.Text
    if eggName and eggName ~= "" then
        Spawner.SpawnEgg(eggName)
    else
        warn("Please enter a valid Egg name.")
    end
end)

loadDefaultUIButton.MouseButton1Click:Connect(function()
    Spawner.Load()  -- Load default UI
end)

closeButton.MouseButton1Click:Connect(function()
    screenGui:Destroy()  -- Close the UI
end)
