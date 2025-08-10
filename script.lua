local Spawner = loadstring(game:HttpGet("https://gitlab.com/darkiedarkie/dark/-/raw/main/Spawner.lua"))()

-- Create the main UI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "WoeqHub"
ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 300, 0, 400)
MainFrame.Position = UDim2.new(0.5, -150, 0.5, -200)
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
Title.Text = "WOEQ HUB"
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

-- Search bar
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
SearchBar.Parent = MainFrame

-- Tab buttons
local TabButtons = Instance.new("Frame")
TabButtons.Name = "TabButtons"
TabButtons.Size = UDim2.new(1, -10, 0, 30)
TabButtons.Position = UDim2.new(0, 5, 0, 65)
TabButtons.BackgroundTransparency = 1
TabButtons.Parent = MainFrame

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
        button.BackgroundColor3 = Color3.fromRGB(50, 50, 55)
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
ContentFrame.Size = UDim2.new(1, -10, 1, -110)
ContentFrame.Position = UDim2.new(0, 5, 0, 100)
ContentFrame.BackgroundTransparency = 1
ContentFrame.Parent = MainFrame

-- Pets content
local PetsContent = Instance.new("ScrollingFrame")
PetsContent.Name = "PetsContent"
PetsContent.Size = UDim2.new(1, 0, 1, 0)
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
SeedsContent.Size = UDim2.new(1, 0, 1, 0)
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
EggsContent.Size = UDim2.new(1, 0, 1, 0)
EggsContent.BackgroundTransparency = 1
EggsContent.ScrollBarThickness = 5
EggsContent.ScrollBarImageColor3 = Color3.fromRGB(100, 100, 100)
EggsContent.Visible = false
EggsContent.Parent = ContentFrame

local EggsList = Instance.new("UIListLayout")
EggsList.Name = "EggsList"
EggsList.Padding = UDim.new(0, 5)
EggsList.Parent = EggsContent

-- Pet options frame
local PetOptions = Instance.new("Frame")
PetOptions.Name = "PetOptions"
PetOptions.Size = UDim2.new(1, 0, 0, 80)
PetOptions.Position = UDim2.new(0, 0, 1, -80)
PetOptions.BackgroundTransparency = 1
PetOptions.Visible = false
PetOptions.Parent = PetsContent

local WeightLabel = Instance.new("TextLabel")
WeightLabel.Name = "WeightLabel"
WeightLabel.Size = UDim2.new(0.4, 0, 0, 20)
WeightLabel.Position = UDim2.new(0, 0, 0, 0)
WeightLabel.BackgroundTransparency = 1
WeightLabel.Text = "Pet Weight:"
WeightLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
WeightLabel.Font = Enum.Font.Gotham
WeightLabel.TextSize = 14
WeightLabel.TextXAlignment = Enum.TextXAlignment.Left
WeightLabel.Parent = PetOptions

local WeightInput = Instance.new("TextBox")
WeightInput.Name = "WeightInput"
WeightInput.Size = UDim2.new(0.6, 0, 0, 20)
WeightInput.Position = UDim2.new(0.4, 0, 0, 0)
WeightInput.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
WeightInput.BorderSizePixel = 0
WeightInput.Text = "1"
WeightInput.TextColor3 = Color3.fromRGB(255, 255, 255)
WeightInput.Font = Enum.Font.Gotham
WeightInput.TextSize = 14
WeightInput.Parent = PetOptions

local AgeLabel = Instance.new("TextLabel")
AgeLabel.Name = "AgeLabel"
AgeLabel.Size = UDim2.new(0.4, 0, 0, 20)
AgeLabel.Position = UDim2.new(0, 0, 0, 25)
AgeLabel.BackgroundTransparency = 1
AgeLabel.Text = "Pet Age:"
AgeLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
AgeLabel.Font = Enum.Font.Gotham
AgeLabel.TextSize = 14
AgeLabel.TextXAlignment = Enum.TextXAlignment.Left
AgeLabel.Parent = PetOptions

local AgeInput = Instance.new("TextBox")
AgeInput.Name = "AgeInput"
AgeInput.Size = UDim2.new(0.6, 0, 0, 20)
AgeInput.Position = UDim2.new(0.4, 0, 0, 25)
AgeInput.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
AgeInput.BorderSizePixel = 0
AgeInput.Text = "1"
AgeInput.TextColor3 = Color3.fromRGB(255, 255, 255)
AgeInput.Font = Enum.Font.Gotham
AgeInput.TextSize = 14
AgeInput.Parent = PetOptions

local SpawnButton = Instance.new("TextButton")
SpawnButton.Name = "SpawnButton"
SpawnButton.Size = UDim2.new(0.48, 0, 0, 25)
SpawnButton.Position = UDim2.new(0, 0, 0, 50)
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
SpinButton.Position = UDim2.new(0.52, 0, 0, 50)
SpinButton.BackgroundColor3 = Color3.fromRGB(60, 60, 65)
SpinButton.BorderSizePixel = 0
SpinButton.Text = "SPIN"
SpinButton.TextColor3 = Color3.fromRGB(255, 255, 255)
SpinButton.Font = Enum.Font.GothamBold
SpinButton.TextSize = 14
SpinButton.Parent = PetOptions

-- Tab switching function
local function switchTab(tab)
    PetsContent.Visible = false
    SeedsContent.Visible = false
    EggsContent.Visible = false
    PetOptions.Visible = false
    
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
        SeedsTab.BackgroundColor3 = Color3.fromRGB(60, 60, 65)
        local selected = Instance.new("BoolValue")
        selected.Name = "Selected"
        selected.Parent = SeedsTab
    elseif tab == "eggs" then
        EggsContent.Visible = true
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
local function createItemButton(parent, name, callback)
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
        button.BackgroundColor3 = Color3.fromRGB(50, 50, 55)
    end)
    
    button.MouseLeave:Connect(function()
        button.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
    end)
    
    button.MouseButton1Click:Connect(function()
        callback(name)
    end)
    
    return button
end

-- Populate pets
local pets = Spawner.GetPets()
for _, pet in pairs(pets) do
    createItemButton(PetsContent, pet, function(name)
        local kg = tonumber(WeightInput.Text) or 1
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

-- Set up spawn and spin buttons
SpawnButton.MouseButton1Click:Connect(function()
    if PetsContent.Visible then
        local selected = nil
        for _, child in pairs(PetsContent:GetChildren()) do
            if child:IsA("TextButton") and child.BackgroundColor3 == Color3.fromRGB(50, 50, 55) then
                selected = child.Text
                break
            end
        end
        if selected then
            local kg = tonumber(WeightInput.Text) or 1
            local age = tonumber(AgeInput.Text) or 1
            Spawner.SpawnPet(selected, kg, age)
        end
    elseif SeedsContent.Visible then
        local selected = nil
        for _, child in pairs(SeedsContent:GetChildren()) do
            if child:IsA("TextButton") and child.BackgroundColor3 == Color3.fromRGB(50, 50, 55) then
                selected = child.Text
                break
            end
        end
        if selected then
            Spawner.SpawnSeed(selected)
        end
    elseif EggsContent.Visible then
        local selected = nil
        for _, child in pairs(EggsContent:GetChildren()) do
            if child:IsA("TextButton") and child.BackgroundColor3 == Color3.fromRGB(50, 50, 55) then
                selected = child.Text
                break
            end
        end
        if selected then
            Spawner.SpawnEgg(selected)
        end
    end
end)

SpinButton.MouseButton1Click:Connect(function()
    if PetsContent.Visible then
        local selected = nil
        for _, child in pairs(PetsContent:GetChildren()) do
            if child:IsA("TextButton") and child.BackgroundColor3 == Color3.fromRGB(50, 50, 55) then
                selected = child.Text
                break
            end
        end
        if selected then
            Spawner.Spin(selected)
        end
    end
end)

-- Auto-resize scrolling frames
PetsContent.ChildAdded:Connect(function()
    PetsContent.CanvasSize = UDim2.new(0, 0, 0, PetsList.AbsoluteContentSize.Y + 85)
end)

SeedsContent.ChildAdded:Connect(function()
    SeedsContent.CanvasSize = UDim2.new(0, 0, 0, SeedsList.AbsoluteContentSize.Y + 5)
end)

EggsContent.ChildAdded:Connect(function()
    EggsContent.CanvasSize = UDim2.new(0, 0, 0, EggsList.AbsoluteContentSize.Y + 5)
end)

-- Set initial tab
switchTab("pets")

-- Watermark
local Watermark = Instance.new("TextLabel")
Watermark.Name = "Watermark"
Watermark.Size = UDim2.new(1, 0, 0, 15)
Watermark.Position = UDim2.new(0, 0, 1, -15)
Watermark.BackgroundTransparency = 1
Watermark.Text = "Woeq Hub v2.1"
Watermark.TextColor3 = Color3.fromRGB(150, 150, 150)
Watermark.Font = Enum.Font.Gotham
Watermark.TextSize = 11
Watermark.Parent = MainFrame
