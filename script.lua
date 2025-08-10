local Spawner = loadstring(game:HttpGet("https://gitlab.com/darkiedarkie/dark/-/raw/main/Spawner.lua"))()

-- Create the main UI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "WoeqHub"
ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 300, 0, 350)
MainFrame.Position = UDim2.new(0.5, -150, 0.5, -175)
MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
MainFrame.BorderSizePixel = 0
MainFrame.ClipsDescendants = true
MainFrame.Parent = ScreenGui

-- Make frame draggable
local dragToggle = nil
local dragStart = nil
local startPos = nil

local function updateInput(input)
    local delta = input.Position - dragStart
    MainFrame.Position = UDim2.new(
        startPos.X.Scale, 
        startPos.X.Offset + delta.X, 
        startPos.Y.Scale, 
        startPos.Y.Offset + delta.Y
    )
end

MainFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragToggle = true
        dragStart = input.Position
        startPos = MainFrame.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragToggle = false
            end
        end)
    end
end)

MainFrame.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement and dragToggle then
        updateInput(input)
    end
end)

-- Title bar
local TitleBar = Instance.new("Frame")
TitleBar.Name = "TitleBar"
TitleBar.Size = UDim2.new(1, 0, 0, 30)
TitleBar.Position = UDim2.new(0, 0, 0, 0)
TitleBar.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
TitleBar.BorderSizePixel = 0
TitleBar.Parent = MainFrame

local Title = Instance.new("TextLabel")
Title.Name = "Title"
Title.Size = UDim2.new(0, 200, 1, 0)
Title.Position = UDim2.new(0.5, -100, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "DARK SPAWNER"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 16
Title.Parent = TitleBar

local CloseButton = Instance.new("TextButton")
CloseButton.Name = "CloseButton"
CloseButton.Size = UDim2.new(0, 30, 0, 30)
CloseButton.Position = UDim2.new(1, -30, 0, 0)
CloseButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
CloseButton.BorderSizePixel = 0
CloseButton.Text = "X"
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.Font = Enum.Font.GothamBold
CloseButton.TextSize = 14
CloseButton.Parent = TitleBar

CloseButton.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

-- Search bar (hidden by default)
local SearchBar = Instance.new("TextBox")
SearchBar.Name = "SearchBar"
SearchBar.Size = UDim2.new(1, -10, 0, 25)
SearchBar.Position = UDim2.new(0, 5, 0, 35)
SearchBar.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
SearchBar.BorderSizePixel = 0
SearchBar.PlaceholderText = "Search items..."
SearchBar.Text = ""
SearchBar.TextColor3 = Color3.fromRGB(255, 255, 255)
SearchBar.Font = Enum.Font.Gotham
SearchBar.TextSize = 14
SearchBar.Visible = false
SearchBar.Parent = MainFrame

-- Toggle search button
local SearchToggle = Instance.new("TextButton")
SearchToggle.Name = "SearchToggle"
SearchToggle.Size = UDim2.new(0, 25, 0, 25)
SearchToggle.Position = UDim2.new(1, -60, 0, 2)
SearchToggle.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
SearchToggle.BorderSizePixel = 0
SearchToggle.Text = "🔍"
SearchToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
SearchToggle.Font = Enum.Font.Gotham
SearchToggle.TextSize = 14
SearchToggle.Parent = TitleBar

SearchToggle.MouseButton1Click:Connect(function()
    SearchBar.Visible = not SearchBar.Visible
    if SearchBar.Visible then
        SearchBar:TweenPosition(UDim2.new(0, 5, 0, 35), "Out", "Quad", 0.2, true)
    else
        SearchBar:TweenPosition(UDim2.new(0, 5, 0, 0), "Out", "Quad", 0.2, true)
    end
end)

-- Tab buttons
local TabButtons = Instance.new("Frame")
TabButtons.Name = "TabButtons"
TabButtons.Size = UDim2.new(1, -10, 0, 30)
TabButtons.Position = UDim2.new(0, 5, 0, SearchBar.Visible and 65 or 40)
TabButtons.BackgroundTransparency = 1
TabButtons.Parent = MainFrame

SearchBar:GetPropertyChangedSignal("Visible"):Connect(function()
    TabButtons.Position = UDim2.new(0, 5, 0, SearchBar.Visible and 65 or 40)
end)

local function createTabButton(name, position)
    local button = Instance.new("TextButton")
    button.Name = name.."Tab"
    button.Size = UDim2.new(0.32, 0, 1, 0)
    button.Position = position
    button.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
    button.BorderSizePixel = 0
    button.Text = name
    button.TextColor3 = Color3.fromRGB(200, 200, 200)
    button.Font = Enum.Font.Gotham
    button.TextSize = 14
    button.Parent = TabButtons
    
    button.MouseEnter:Connect(function()
        if not button:FindFirstChild("Selected") then
            button.BackgroundColor3 = Color3.fromRGB(50, 50, 55)
        end
    end)
    
    button.MouseLeave:Connect(function()
        if not button:FindFirstChild("Selected") then
            button.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
        end
    end)
    
    return button
end

local PetsTab = createTabButton("Pets", UDim2.new(0, 0, 0, 0))
local SeedsTab = createTabButton("Seeds", UDim2.new(0.34, 0, 0, 0))
local EggsTab = createTabButton("Eggs", UDim2.new(0.68, 0, 0, 0))

-- Content frame
local ContentFrame = Instance.new("Frame")
ContentFrame.Name = "ContentFrame"
ContentFrame.Size = UDim2.new(1, -10, 1, SearchBar.Visible and -110 or -85)
ContentFrame.Position = UDim2.new(0, 5, 0, SearchBar.Visible and 100 or 75)
ContentFrame.BackgroundTransparency = 1
ContentFrame.Parent = MainFrame

SearchBar:GetPropertyChangedSignal("Visible"):Connect(function()
    ContentFrame.Size = UDim2.new(1, -10, 1, SearchBar.Visible and -110 or -85)
    ContentFrame.Position = UDim2.new(0, 5, 0, SearchBar.Visible and 100 or 75)
end)

-- Pets content
local PetsContent = Instance.new("ScrollingFrame")
PetsContent.Name = "PetsContent"
PetsContent.Size = UDim2.new(1, 0, 1, -80)
PetsContent.BackgroundTransparency = 1
PetsContent.ScrollBarThickness = 5
PetsContent.ScrollBarImageColor3 = Color3.fromRGB(100, 100, 100)
PetsContent.Visible = false
PetsContent.Parent = ContentFrame

local PetsList = Instance.new("UIListLayout")
PetsList.Name = "PetsList"
PetsList.Padding = UDim.new(0, 5)
PetsList.Parent = PetsContent

-- Seeds content
local SeedsContent = Instance.new("ScrollingFrame")
SeedsContent.Name = "SeedsContent"
SeedsContent.Size = UDim2.new(1, 0, 1, -40)
SeedsContent.BackgroundTransparency = 1
SeedsContent.ScrollBarThickness = 5
SeedsContent.ScrollBarImageColor3 = Color3.fromRGB(100, 100, 100)
SeedsContent.Visible = false
SeedsContent.Parent = ContentFrame

local SeedsList = Instance.new("UIListLayout")
SeedsList.Name = "SeedsList"
SeedsList.Padding = UDim.new(0, 5)
SeedsList.Parent = SeedsContent

-- Eggs content
local EggsContent = Instance.new("ScrollingFrame")
EggsContent.Name = "EggsContent"
EggsContent.Size = UDim2.new(1, 0, 1, -40)
EggsContent.BackgroundTransparency = 1
EggsContent.ScrollBarThickness = 5
EggsContent.ScrollBarImageColor3 = Color3.fromRGB(100, 100, 100)
EggsContent.Visible = false
EggsContent.Parent = ContentFrame

local EggsList = Instance.new("UIListLayout")
EggsList.Name = "EggsList"
EggsList.Padding = UDim.new(0, 5)
EggsList.Parent = EggsContent

-- Pet options frame (matches Dark Spawner layout)
local PetOptions = Instance.new("Frame")
PetOptions.Name = "PetOptions"
PetOptions.Size = UDim2.new(1, 0, 0, 80)
PetOptions.Position = UDim2.new(0, 0, 1, -80)
PetOptions.BackgroundTransparency = 1
PetOptions.Visible = false
PetOptions.Parent = PetsContent

local PetLabel = Instance.new("TextLabel")
PetLabel.Name = "PetLabel"
PetLabel.Size = UDim2.new(1, 0, 0, 20)
PetLabel.Position = UDim2.new(0, 0, 0, 0)
PetLabel.BackgroundTransparency = 1
PetLabel.Text = "Pet"
PetLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
PetLabel.Font = Enum.Font.Gotham
PetLabel.TextSize = 14
PetLabel.TextXAlignment = Enum.TextXAlignment.Left
PetLabel.Parent = PetOptions

local PetValue = Instance.new("TextLabel")
PetValue.Name = "PetValue"
PetValue.Size = UDim2.new(1, 0, 0, 20)
PetValue.Position = UDim2.new(0, 0, 0, 20)
PetValue.BackgroundTransparency = 1
PetValue.Text = "None"
PetValue.TextColor3 = Color3.fromRGB(150, 150, 150)
PetValue.Font = Enum.Font.Gotham
PetValue.TextSize = 14
PetValue.TextXAlignment = Enum.TextXAlignment.Left
PetValue.Parent = PetOptions

local WeightLabel = Instance.new("TextLabel")
WeightLabel.Name = "WeightLabel"
WeightLabel.Size = UDim2.new(0.5, 0, 0, 20)
WeightLabel.Position = UDim2.new(0, 0, 0, 40)
WeightLabel.BackgroundTransparency = 1
WeightLabel.Text = "Pet Weight: 1"
WeightLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
WeightLabel.Font = Enum.Font.Gotham
WeightLabel.TextSize = 14
WeightLabel.TextXAlignment = Enum.TextXAlignment.Left
WeightLabel.Parent = PetOptions

local AgeLabel = Instance.new("TextLabel")
AgeLabel.Name = "AgeLabel"
AgeLabel.Size = UDim2.new(0.5, 0, 0, 20)
AgeLabel.Position = UDim2.new(0.5, 0, 0, 40)
AgeLabel.BackgroundTransparency = 1
AgeLabel.Text = "Pet Age: 1"
AgeLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
AgeLabel.Font = Enum.Font.Gotham
AgeLabel.TextSize = 14
AgeLabel.TextXAlignment = Enum.TextXAlignment.Left
AgeLabel.Parent = PetOptions

local SpawnButton = Instance.new("TextButton")
SpawnButton.Name = "SpawnButton"
SpawnButton.Size = UDim2.new(0.48, 0, 0, 25)
SpawnButton.Position = UDim2.new(0, 0, 0, 60)
SpawnButton.BackgroundColor3 = Color3.fromRGB(60, 60, 65)
SpawnButton.BorderSizePixel = 0
SpawnButton.Text = "SPAWN"
SpawnButton.TextColor3 = Color3.fromRGB(255, 255, 255)
SpawnButton.Font = Enum.Font.GothamBold
SpawnButton.TextSize = 14
SpawnButton.Parent = PetOptions

local SpinButton = Instance.new("TextButton")
SpinButton.Name = "SpinButton"
SpinButton.Size = UDim2.new(0.48, 0, 0, 25)
SpinButton.Position = UDim2.new(0.52, 0, 0, 60)
SpinButton.BackgroundColor3 = Color3.fromRGB(60, 60, 65)
SpinButton.BorderSizePixel = 0
SpinButton.Text = "SPIN"
SpinButton.TextColor3 = Color3.fromRGB(255, 255, 255)
SpinButton.Font = Enum.Font.GothamBold
SpinButton.TextSize = 14
SpinButton.Parent = PetOptions

-- Seed options frame
local SeedOptions = Instance.new("Frame")
SeedOptions.Name = "SeedOptions"
SeedOptions.Size = UDim2.new(1, 0, 0, 40)
SeedOptions.Position = UDim2.new(0, 0, 1, -40)
SeedOptions.BackgroundTransparency = 1
SeedOptions.Visible = false
SeedOptions.Parent = SeedsContent

local SeedLabel = Instance.new("TextLabel")
SeedLabel.Name = "SeedLabel"
SeedLabel.Size = UDim2.new(1, 0, 0, 20)
SeedLabel.Position = UDim2.new(0, 0, 0, 0)
SeedLabel.BackgroundTransparency = 1
SeedLabel.Text = "Seed"
SeedLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
SeedLabel.Font = Enum.Font.Gotham
SeedLabel.TextSize = 14
SeedLabel.TextXAlignment = Enum.TextXAlignment.Left
SeedLabel.Parent = SeedOptions

local SeedValue = Instance.new("TextLabel")
SeedValue.Name = "SeedValue"
SeedValue.Size = UDim2.new(1, 0, 0, 20)
SeedValue.Position = UDim2.new(0, 0, 0, 20)
SeedValue.BackgroundTransparency = 1
SeedValue.Text = "None"
SeedValue.TextColor3 = Color3.fromRGB(150, 150, 150)
SeedValue.Font = Enum.Font.Gotham
SeedValue.TextSize = 14
SeedValue.TextXAlignment = Enum.TextXAlignment.Left
SeedValue.Parent = SeedOptions

local SeedSpawnButton = Instance.new("TextButton")
SeedSpawnButton.Name = "SeedSpawnButton"
SeedSpawnButton.Size = UDim2.new(0.48, 0, 0, 25)
SeedSpawnButton.Position = UDim2.new(0, 0, 0, 40)
SeedSpawnButton.BackgroundColor3 = Color3.fromRGB(60, 60, 65)
SeedSpawnButton.BorderSizePixel = 0
SeedSpawnButton.Text = "SPAWN"
SeedSpawnButton.TextColor3 = Color3.fromRGB(255, 255, 255)
SeedSpawnButton.Font = Enum.Font.GothamBold
SeedSpawnButton.TextSize = 14
SeedSpawnButton.Parent = SeedsContent

local SeedSpinButton = Instance.new("TextButton")
SeedSpinButton.Name = "SeedSpinButton"
SeedSpinButton.Size = UDim2.new(0.48, 0, 0, 25)
SeedSpinButton.Position = UDim2.new(0.52, 0, 0, 40)
SeedSpinButton.BackgroundColor3 = Color3.fromRGB(60, 60, 65)
SeedSpinButton.BorderSizePixel = 0
SeedSpinButton.Text = "SPIN"
SeedSpinButton.TextColor3 = Color3.fromRGB(255, 255, 255)
SeedSpinButton.Font = Enum.Font.GothamBold
SeedSpinButton.TextSize = 14
SeedSpinButton.Parent = SeedsContent

-- Egg options frame
local EggOptions = Instance.new("Frame")
EggOptions.Name = "EggOptions"
EggOptions.Size = UDim2.new(1, 0, 0, 40)
EggOptions.Position = UDim2.new(0, 0, 1, -40)
EggOptions.BackgroundTransparency = 1
EggOptions.Visible = false
EggOptions.Parent = EggsContent

local EggLabel = Instance.new("TextLabel")
EggLabel.Name = "EggLabel"
EggLabel.Size = UDim2.new(1, 0, 0, 20)
EggLabel.Position = UDim2.new(0, 0, 0, 0)
EggLabel.BackgroundTransparency = 1
EggLabel.Text = "Egg"
EggLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
EggLabel.Font = Enum.Font.Gotham
EggLabel.TextSize = 14
EggLabel.TextXAlignment = Enum.TextXAlignment.Left
EggLabel.Parent = EggOptions

local EggValue = Instance.new("TextLabel")
EggValue.Name = "EggValue"
EggValue.Size = UDim2.new(1, 0, 0, 20)
EggValue.Position = UDim2.new(0, 0, 0, 20)
EggValue.BackgroundTransparency = 1
EggValue.Text = "None"
EggValue.TextColor3 = Color3.fromRGB(150, 150, 150)
EggValue.Font = Enum.Font.Gotham
EggValue.TextSize = 14
EggValue.TextXAlignment = Enum.TextXAlignment.Left
EggValue.Parent = EggOptions

local EggSpawnButton = Instance.new("TextButton")
EggSpawnButton.Name = "EggSpawnButton"
EggSpawnButton.Size = UDim2.new(0.48, 0, 0, 25)
EggSpawnButton.Position = UDim2.new(0, 0, 0, 40)
EggSpawnButton.BackgroundColor3 = Color3.fromRGB(60, 60, 65)
EggSpawnButton.BorderSizePixel = 0
EggSpawnButton.Text = "SPAWN"
EggSpawnButton.TextColor3 = Color3.fromRGB(255, 255, 255)
EggSpawnButton.Font = Enum.Font.GothamBold
EggSpawnButton.TextSize = 14
EggSpawnButton.Parent = EggsContent

-- Tab switching function
local function switchTab(tab)
    PetsContent.Visible = false
    SeedsContent.Visible = false
    EggsContent.Visible = false
    PetOptions.Visible = false
    SeedOptions.Visible = false
    EggOptions.Visible = false
    
    for _, btn in pairs({PetsTab, SeedsTab, EggsTab}) do
        btn.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
        if btn:FindFirstChild("Selected") then
            btn.Selected:Destroy()
        end
    end
    
    if tab == "pets" then
        PetsContent.Visible = true
        PetOptions.Visible = true
        PetsTab.BackgroundColor3 = Color3.fromRGB(60, 60, 65)
        local selected = Instance.new("BoolValue")
        selected.Name = "Selected"
        selected.Parent = PetsTab
    elseif tab == "seeds" then
        SeedsContent.Visible = true
        SeedOptions.Visible = true
        SeedsTab.BackgroundColor3 = Color3.fromRGB(60, 60, 65)
        local selected = Instance.new("BoolValue")
        selected.Name = "Selected"
        selected.Parent = SeedsTab
    elseif tab == "eggs" then
        EggsContent.Visible = true
        EggOptions.Visible = true
        EggsTab.BackgroundColor3 = Color3.fromRGB(60, 60, 65)
        local selected = Instance.new("BoolValue")
        selected.Name = "Selected"
        selected.Parent = EggsTab
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

-- Search function
local function updateSearch()
    local searchText = string.lower(SearchBar.Text)
    
    for _, content in pairs({PetsContent, SeedsContent, EggsContent}) do
        for _, child in pairs(content:GetChildren()) do
            if child:IsA("TextButton") then
                if searchText == "" then
                    child.Visible = true
                else
                    child.Visible = string.find(string.lower(child.Text), searchText) ~= nil
                end
            end
        end
    end
end

SearchBar:GetPropertyChangedSignal("Text"):Connect(updateSearch)

-- Create item buttons
local function createItemButton(parent, name, callback, valueLabel)
    local button = Instance.new("TextButton")
    button.Name = name
    button.Size = UDim2.new(1, 0, 0, 25)
    button.Position = UDim2.new(0, 0, 0, 0)
    button.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
    button.BorderSizePixel = 0
    button.Text = name
    button.TextColor3 = Color3.fromRGB(200, 200, 200)
    button.Font = Enum.Font.Gotham
    button.TextSize = 14
    button.TextXAlignment = Enum.TextXAlignment.Left
    button.Parent = parent
    
    button.MouseEnter:Connect(function()
        if not button:FindFirstChild("Selected") then
            button.BackgroundColor3 = Color3.fromRGB(50, 50, 55)
        end
    end)
    
    button.MouseLeave:Connect(function()
        if not button:FindFirstChild("Selected") then
            button.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
        end
    end)
    
    button.MouseButton1Click:Connect(function()
        -- Deselect all other buttons
        for _, child in pairs(parent:GetChildren()) do
            if child:IsA("TextButton") and child:FindFirstChild("Selected") then
                child.Selected:Destroy()
                child.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
            end
        end
        
        -- Select this button
        local selected = Instance.new("BoolValue")
        selected.Name = "Selected"
        selected.Parent = button
        button.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
        
        -- Update the value label
        if valueLabel then
            valueLabel.Text = name
        end
        
        callback(name)
    end)
    
    return button
end

-- Populate pets
local pets = Spawner.GetPets()
for _, pet in pairs(pets) do
    createItemButton(PetsContent, pet, function(name)
        PetValue.Text = name
    end, PetValue)
end

-- Populate seeds
local seeds = Spawner.GetSeeds()
for _, seed in pairs(seeds) do
    createItemButton(SeedsContent, seed, function(name)
        SeedValue.Text = name
    end, SeedValue)
end

-- Populate eggs
local eggs = Spawner.GetEggs()
for _, egg in pairs(eggs) do
    createItemButton(EggsContent, egg, function(name)
        EggValue.Text = name
    end, EggValue)
end

-- Set up spawn and spin buttons
SpawnButton.MouseButton1Click:Connect(function()
    if PetsContent.Visible and PetValue.Text ~= "None" then
        Spawner.SpawnPet(PetValue.Text, 1, 1)
    elseif SeedsContent.Visible and SeedValue.Text ~= "None" then
        Spawner.SpawnSeed(SeedValue.Text)
    elseif EggsContent.Visible and EggValue.Text ~= "None" then
        Spawner.SpawnEgg(EggValue.Text)
    end
end)

SpinButton.MouseButton1Click:Connect(function()
    if PetsContent.Visible and PetValue.Text ~= "None" then
        Spawner.Spin(PetValue.Text)
    end
end)

SeedSpawnButton.MouseButton1Click:Connect(function()
    if SeedValue.Text ~= "None" then
        Spawner.SpawnSeed(SeedValue.Text)
    end
end)

SeedSpinButton.MouseButton1Click:Connect(function()
    if SeedValue.Text ~= "None" then
        Spawner.Spin(SeedValue.Text)
    end
end)

EggSpawnButton.MouseButton1Click:Connect(function()
    if EggValue.Text ~= "None" then
        Spawner.SpawnEgg(EggValue.Text)
    end
end)

-- Auto-resize scrolling frames
PetsContent.ChildAdded:Connect(function()
    PetsContent.CanvasSize = UDim2.new(0, 0, 0, PetsList.AbsoluteContentSize.Y)
end)

SeedsContent.ChildAdded:Connect(function()
    SeedsContent.CanvasSize = UDim2.new(0, 0, 0, SeedsList.AbsoluteContentSize.Y)
end)

EggsContent.ChildAdded:Connect(function()
    EggsContent.CanvasSize = UDim2.new(0, 0, 0, EggsList.AbsoluteContentSize.Y)
end)

-- Set initial tab
switchTab("pets")

-- Watermark
local Watermark = Instance.new("TextLabel")
Watermark.Name = "Watermark"
Watermark.Size = UDim2.new(1, 0, 0, 15)
Watermark.Position = UDim2.new(0, 0, 1, -15)
Watermark.BackgroundTransparency = 1
Watermark.Text = "Woeq Hub v2.2"
Watermark.TextColor3 = Color3.fromRGB(150, 150, 150)
Watermark.Font = Enum.Font.Gotham
Watermark.TextSize = 11
Watermark.Parent = MainFrame
