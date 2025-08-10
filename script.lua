local Spawner = loadstring(game:HttpGet("https://gitlab.com/darkiedarkie/dark/-/raw/main/Spawner.lua"))()

-- Create the main UI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "SpawnerUI"
ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 350, 0, 400)
MainFrame.Position = UDim2.new(0.5, -175, 0.5, -200)
MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
MainFrame.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
MainFrame.BorderSizePixel = 0
MainFrame.Parent = ScreenGui

local Title = Instance.new("TextLabel")
Title.Name = "Title"
Title.Size = UDim2.new(1, 0, 0, 40)
Title.Position = UDim2.new(0, 0, 0, 0)
Title.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
Title.BorderSizePixel = 0
Title.Text = "Item Spawner"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 18
Title.Parent = MainFrame

local CloseButton = Instance.new("TextButton")
CloseButton.Name = "CloseButton"
CloseButton.Size = UDim2.new(0, 30, 0, 30)
CloseButton.Position = UDim2.new(1, -30, 0, 5)
CloseButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
CloseButton.BorderSizePixel = 0
CloseButton.Text = "X"
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.Font = Enum.Font.GothamBold
CloseButton.TextSize = 16
CloseButton.Parent = Title

CloseButton.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

-- Create tab buttons
local TabButtons = Instance.new("Frame")
TabButtons.Name = "TabButtons"
TabButtons.Size = UDim2.new(1, 0, 0, 40)
TabButtons.Position = UDim2.new(0, 0, 0, 40)
TabButtons.BackgroundTransparency = 1
TabButtons.Parent = MainFrame

local PetsTab = Instance.new("TextButton")
PetsTab.Name = "PetsTab"
PetsTab.Size = UDim2.new(0.25, 0, 1, 0)
PetsTab.Position = UDim2.new(0, 0, 0, 0)
PetsTab.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
PetsTab.BorderSizePixel = 0
PetsTab.Text = "Pets"
PetsTab.TextColor3 = Color3.fromRGB(255, 255, 255)
PetsTab.Font = Enum.Font.Gotham
PetsTab.TextSize = 14
PetsTab.Parent = TabButtons

local SeedsTab = Instance.new("TextButton")
SeedsTab.Name = "SeedsTab"
SeedsTab.Size = UDim2.new(0.25, 0, 1, 0)
SeedsTab.Position = UDim2.new(0.25, 0, 0, 0)
SeedsTab.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
SeedsTab.BorderSizePixel = 0
SeedsTab.Text = "Seeds"
SeedsTab.TextColor3 = Color3.fromRGB(255, 255, 255)
SeedsTab.Font = Enum.Font.Gotham
SeedsTab.TextSize = 14
SeedsTab.Parent = TabButtons

local EggsTab = Instance.new("TextButton")
EggsTab.Name = "EggsTab"
EggsTab.Size = UDim2.new(0.25, 0, 1, 0)
EggsTab.Position = UDim2.new(0.5, 0, 0, 0)
EggsTab.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
EggsTab.BorderSizePixel = 0
EggsTab.Text = "Eggs"
EggsTab.TextColor3 = Color3.fromRGB(255, 255, 255)
EggsTab.Font = Enum.Font.Gotham
EggsTab.TextSize = 14
EggsTab.Parent = TabButtons

local SpinTab = Instance.new("TextButton")
SpinTab.Name = "SpinTab"
SpinTab.Size = UDim2.new(0.25, 0, 1, 0)
SpinTab.Position = UDim2.new(0.75, 0, 0, 0)
SpinTab.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
SpinTab.BorderSizePixel = 0
SpinTab.Text = "Spin"
SpinTab.TextColor3 = Color3.fromRGB(255, 255, 255)
SpinTab.Font = Enum.Font.Gotham
SpinTab.TextSize = 14
SpinTab.Parent = TabButtons

-- Create content frames
local ContentFrame = Instance.new("Frame")
ContentFrame.Name = "ContentFrame"
ContentFrame.Size = UDim2.new(1, -10, 1, -90)
ContentFrame.Position = UDim2.new(0, 5, 0, 85)
ContentFrame.BackgroundTransparency = 1
ContentFrame.Parent = MainFrame

-- Pets content
local PetsContent = Instance.new("ScrollingFrame")
PetsContent.Name = "PetsContent"
PetsContent.Size = UDim2.new(1, 0, 1, 0)
PetsContent.BackgroundTransparency = 1
PetsContent.ScrollBarThickness = 5
PetsContent.Visible = false
PetsContent.Parent = ContentFrame

local PetsList = Instance.new("UIListLayout")
PetsList.Name = "PetsList"
PetsList.Padding = UDim.new(0, 5)
PetsList.Parent = PetsContent

-- Seeds content
local SeedsContent = Instance.new("ScrollingFrame")
SeedsContent.Name = "SeedsContent"
SeedsContent.Size = UDim2.new(1, 0, 1, 0)
SeedsContent.BackgroundTransparency = 1
SeedsContent.ScrollBarThickness = 5
SeedsContent.Visible = false
SeedsContent.Parent = ContentFrame

local SeedsList = Instance.new("UIListLayout")
SeedsList.Name = "SeedsList"
SeedsList.Padding = UDim.new(0, 5)
SeedsList.Parent = SeedsContent

-- Eggs content
local EggsContent = Instance.new("ScrollingFrame")
EggsContent.Name = "EggsContent"
EggsContent.Size = UDim2.new(1, 0, 1, 0)
EggsContent.BackgroundTransparency = 1
EggsContent.ScrollBarThickness = 5
EggsContent.Visible = false
EggsContent.Parent = ContentFrame

local EggsList = Instance.new("UIListLayout")
EggsList.Name = "EggsList"
EggsList.Padding = UDim.new(0, 5)
EggsList.Parent = EggsContent

-- Spin content
local SpinContent = Instance.new("Frame")
SpinContent.Name = "SpinContent"
SpinContent.Size = UDim2.new(1, 0, 1, 0)
SpinContent.BackgroundTransparency = 1
SpinContent.Visible = false
SpinContent.Parent = ContentFrame

-- Input fields for pet spawning
local KGLabel = Instance.new("TextLabel")
KGLabel.Name = "KGLabel"
KGLabel.Size = UDim2.new(0, 100, 0, 20)
KGLabel.Position = UDim2.new(0, 10, 0, 10)
KGLabel.BackgroundTransparency = 1
KGLabel.Text = "KG:"
KGLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
KGLabel.Font = Enum.Font.Gotham
KGLabel.TextSize = 14
KGLabel.Parent = PetsContent

local KGInput = Instance.new("TextBox")
KGInput.Name = "KGInput"
KGInput.Size = UDim2.new(0, 100, 0, 20)
KGInput.Position = UDim2.new(0, 120, 0, 10)
KGInput.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
KGInput.BorderSizePixel = 0
KGInput.Text = "1"
KGInput.TextColor3 = Color3.fromRGB(255, 255, 255)
KGInput.Font = Enum.Font.Gotham
KGInput.TextSize = 14
KGInput.Parent = PetsContent

local AgeLabel = Instance.new("TextLabel")
AgeLabel.Name = "AgeLabel"
AgeLabel.Size = UDim2.new(0, 100, 0, 20)
AgeLabel.Position = UDim2.new(0, 10, 0, 40)
AgeLabel.BackgroundTransparency = 1
AgeLabel.Text = "Age:"
AgeLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
AgeLabel.Font = Enum.Font.Gotham
AgeLabel.TextSize = 14
AgeLabel.Parent = PetsContent

local AgeInput = Instance.new("TextBox")
AgeInput.Name = "AgeInput"
AgeInput.Size = UDim2.new(0, 100, 0, 20)
AgeInput.Position = UDim2.new(0, 120, 0, 40)
AgeInput.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
AgeInput.BorderSizePixel = 0
AgeInput.Text = "1"
AgeInput.TextColor3 = Color3.fromRGB(255, 255, 255)
AgeInput.Font = Enum.Font.Gotham
AgeInput.TextSize = 14
AgeInput.Parent = PetsContent

-- Spin input
local SpinInput = Instance.new("TextBox")
SpinInput.Name = "SpinInput"
SpinInput.Size = UDim2.new(0, 200, 0, 30)
SpinInput.Position = UDim2.new(0.5, -100, 0.5, -15)
SpinInput.AnchorPoint = Vector2.new(0.5, 0.5)
SpinInput.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
SpinInput.BorderSizePixel = 0
SpinInput.Text = "Sunflower"
SpinInput.TextColor3 = Color3.fromRGB(255, 255, 255)
SpinInput.Font = Enum.Font.Gotham
SpinInput.TextSize = 14
SpinInput.Parent = SpinContent

local SpinButton = Instance.new("TextButton")
SpinButton.Name = "SpinButton"
SpinButton.Size = UDim2.new(0, 100, 0, 30)
SpinButton.Position = UDim2.new(0.5, -50, 0.5, 30)
SpinButton.AnchorPoint = Vector2.new(0.5, 0.5)
SpinButton.BackgroundColor3 = Color3.fromRGB(80, 120, 80)
SpinButton.BorderSizePixel = 0
SpinButton.Text = "SPIN"
SpinButton.TextColor3 = Color3.fromRGB(255, 255, 255)
SpinButton.Font = Enum.Font.GothamBold
SpinButton.TextSize = 14
SpinButton.Parent = SpinContent

SpinButton.MouseButton1Click:Connect(function()
    Spawner.Spin(SpinInput.Text)
end)

-- Tab switching function
local function switchTab(tab)
    PetsContent.Visible = false
    SeedsContent.Visible = false
    EggsContent.Visible = false
    SpinContent.Visible = false
    
    PetsTab.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    SeedsTab.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    EggsTab.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    SpinTab.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    
    if tab == "pets" then
        PetsContent.Visible = true
        PetsTab.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
    elseif tab == "seeds" then
        SeedsContent.Visible = true
        SeedsTab.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
    elseif tab == "eggs" then
        EggsContent.Visible = true
        EggsTab.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
    elseif tab == "spin" then
        SpinContent.Visible = true
        SpinTab.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
    end
end

PetsTab.MouseButton1Click:Connect(function()
    switchTab("pets")
end)

SeedsTab.MouseButton1Click:Connect(function()
    switchTab("seeds")
end)

EggsTab.MouseButton1Click:Connect(function()
    switchTab("eggs")
end)

SpinTab.MouseButton1Click:Connect(function()
    switchTab("spin")
end)

-- Populate the lists
local function createItemButton(parent, name, callback)
    local button = Instance.new("TextButton")
    button.Name = name
    button.Size = UDim2.new(1, -10, 0, 30)
    button.Position = UDim2.new(0, 5, 0, 0)
    button.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
    button.BorderSizePixel = 0
    button.Text = name
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.Font = Enum.Font.Gotham
    button.TextSize = 14
    button.Parent = parent
    
    button.MouseButton1Click:Connect(function()
        callback(name)
    end)
    
    return button
end

-- Populate pets
local pets = Spawner.GetPets()
for _, pet in pairs(pets) do
    createItemButton(PetsContent, pet, function(name)
        local kg = tonumber(KGInput.Text) or 1
        local age = tonumber(AgeInput.Text) or 1
        Spawner.SpawnPet(name, kg, age)
    end)
end

-- Populate seeds
local seeds = Spawner.GetSeeds()
for _, seed in pairs(seeds) do
    createItemButton(SeedsContent, seed, function(name)
        Spawner.SpawnSeed(name)
    end)
end

-- Populate eggs
local eggs = Spawner.GetEggs()
for _, egg in pairs(eggs) do
    createItemButton(EggsContent, egg, function(name)
        Spawner.SpawnEgg(name)
    end)
end

-- Set initial tab
switchTab("pets")

-- Auto-resize scrolling frames
PetsContent.ChildAdded:Connect(function()
    PetsContent.CanvasSize = UDim2.new(0, 0, 0, PetsList.AbsoluteContentSize.Y + 70)
end)

SeedsContent.ChildAdded:Connect(function()
    SeedsContent.CanvasSize = UDim2.new(0, 0, 0, SeedsList.AbsoluteContentSize.Y)
end)

EggsContent.ChildAdded:Connect(function()
    EggsContent.CanvasSize = UDim2.new(0, 0, 0, EggsList.AbsoluteContentSize.Y)
end)
