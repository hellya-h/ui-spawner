local Spawner = loadstring(game:HttpGet("https://gitlab.com/darkiedarkie/dark/-/raw/main/Spawner.lua"))()

-- Create the main UI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "WoeqHub"
ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 350, 0, 400) -- Smaller size
MainFrame.Position = UDim2.new(0.5, -175, 0.5, -200) -- Centered
MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 25)
MainFrame.BorderColor3 = Color3.fromRGB(0, 100, 255)
MainFrame.BorderSizePixel = 2
MainFrame.ClipsDescendants = true
MainFrame.Parent = ScreenGui

-- Make frame draggable
local dragToggle = nil
local dragSpeed = 0.25
local dragStart = nil
local startPos = nil

local function updateInput(input)
    local delta = input.Position - dragStart
    local position = UDim2.new(
        startPos.X.Scale, 
        startPos.X.Offset + delta.X, 
        startPos.Y.Scale, 
        startPos.Y.Offset + delta.Y
    )
    game:GetService("TweenService"):Create(
        MainFrame, 
        TweenInfo.new(dragSpeed), 
        {Position = position}
    ):Play()
end

MainFrame.InputBegan:Connect(function(input)
    if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) then
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
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        if dragToggle then
            updateInput(input)
        end
    end
end)

-- Title bar with gradient
local TitleBar = Instance.new("Frame")
TitleBar.Name = "TitleBar"
TitleBar.Size = UDim2.new(1, 0, 0, 30) -- Smaller title bar
TitleBar.Position = UDim2.new(0, 0, 0, 0)
TitleBar.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
TitleBar.BorderSizePixel = 0
TitleBar.ZIndex = 2
TitleBar.Parent = MainFrame

local Gradient = Instance.new("UIGradient")
Gradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 80, 255)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 180, 255))
}
Gradient.Rotation = 90
Gradient.Parent = TitleBar

local Title = Instance.new("TextLabel")
Title.Name = "Title"
Title.Size = UDim2.new(0, 200, 0, 30)
Title.Position = UDim2.new(0.5, -100, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "WOEQ HUB"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 16
Title.ZIndex = 3
Title.Parent = TitleBar

local CloseButton = Instance.new("TextButton")
CloseButton.Name = "CloseButton"
CloseButton.Size = UDim2.new(0, 25, 0, 25)
CloseButton.Position = UDim2.new(1, -30, 0, 2)
CloseButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
CloseButton.BorderSizePixel = 0
CloseButton.Text = "X"
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.Font = Enum.Font.GothamBold
CloseButton.TextSize = 14
CloseButton.ZIndex = 3
CloseButton.Parent = TitleBar

CloseButton.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

-- Search bar
local SearchBar = Instance.new("TextBox")
SearchBar.Name = "SearchBar"
SearchBar.Size = UDim2.new(1, -10, 0, 25)
SearchBar.Position = UDim2.new(0, 5, 0, 35)
SearchBar.BackgroundColor3 = Color3.fromRGB(30, 30, 50)
SearchBar.BorderColor3 = Color3.fromRGB(0, 100, 255)
SearchBar.BorderSizePixel = 1
SearchBar.PlaceholderText = "Search Pets, Seeds, Eggs..."
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
    button.Size = UDim2.new(0.24, 0, 1, 0)
    button.Position = position
    button.BackgroundColor3 = Color3.fromRGB(25, 25, 40)
    button.BorderColor3 = Color3.fromRGB(0, 100, 255)
    button.BorderSizePixel = 1
    button.Text = name
    button.TextColor3 = Color3.fromRGB(200, 200, 255)
    button.Font = Enum.Font.GothamSemibold
    button.TextSize = 12
    button.Parent = TabButtons
    
    button.MouseEnter:Connect(function()
        game:GetService("TweenService"):Create(
            button,
            TweenInfo.new(0.1),
            {BackgroundColor3 = Color3.fromRGB(40, 40, 60)}
        ):Play()
    end)
    
    button.MouseLeave:Connect(function()
        game:GetService("TweenService"):Create(
            button,
            TweenInfo.new(0.1),
            {BackgroundColor3 = Color3.fromRGB(25, 25, 40)}
        ):Play()
    end)
    
    return button
end

local PetsTab = createTabButton("Pets", UDim2.new(0, 0, 0, 0))
local SeedsTab = createTabButton("Seeds", UDim2.new(0.25, 0, 0, 0))
local EggsTab = createTabButton("Eggs", UDim2.new(0.5, 0, 0, 0))
local SpinTab = createTabButton("Spin", UDim2.new(0.75, 0, 0, 0))

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
PetsContent.ScrollBarImageColor3 = Color3.fromRGB(0, 150, 255)
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
SeedsContent.ScrollBarImageColor3 = Color3.fromRGB(0, 150, 255)
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
EggsContent.ScrollBarImageColor3 = Color3.fromRGB(0, 150, 255)
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

-- Input fields for pets
local KGInput = Instance.new("TextBox")
KGInput.Name = "KGInput"
KGInput.Size = UDim2.new(0.45, 0, 0, 25)
KGInput.Position = UDim2.new(0, 5, 0, 5)
KGInput.BackgroundColor3 = Color3.fromRGB(30, 30, 50)
KGInput.BorderColor3 = Color3.fromRGB(0, 100, 255)
KGInput.BorderSizePixel = 1
KGInput.Text = "1"
KGInput.TextColor3 = Color3.fromRGB(255, 255, 255)
KGInput.Font = Enum.Font.Gotham
KGInput.TextSize = 14
KGInput.Parent = PetsContent

local AgeInput = Instance.new("TextBox")
AgeInput.Name = "AgeInput"
AgeInput.Size = UDim2.new(0.45, 0, 0, 25)
AgeInput.Position = UDim2.new(0.5, 5, 0, 5)
AgeInput.BackgroundColor3 = Color3.fromRGB(30, 30, 50)
AgeInput.BorderColor3 = Color3.fromRGB(0, 100, 255)
AgeInput.BorderSizePixel = 1
AgeInput.Text = "1"
AgeInput.TextColor3 = Color3.fromRGB(255, 255, 255)
AgeInput.Font = Enum.Font.Gotham
AgeInput.TextSize = 14
AgeInput.Parent = PetsContent

-- Spin section
local SpinInput = Instance.new("TextBox")
SpinInput.Name = "SpinInput"
SpinInput.Size = UDim2.new(1, -10, 0, 30)
SpinInput.Position = UDim2.new(0, 5, 0.5, -40)
SpinInput.BackgroundColor3 = Color3.fromRGB(30, 30, 50)
SpinInput.BorderColor3 = Color3.fromRGB(0, 100, 255)
SpinInput.BorderSizePixel = 1
SpinInput.Text = "Sunflower"
SpinInput.TextColor3 = Color3.fromRGB(255, 255, 255)
SpinInput.Font = Enum.Font.Gotham
SpinInput.TextSize = 14
SpinInput.Parent = SpinContent

local SpinButton = Instance.new("TextButton")
SpinButton.Name = "SpinButton"
SpinButton.Size = UDim2.new(1, -10, 0, 30)
SpinButton.Position = UDim2.new(0, 5, 0.5, 0)
SpinButton.BackgroundColor3 = Color3.fromRGB(0, 100, 255)
SpinButton.BorderSizePixel = 0
SpinButton.Text = "SPIN"
SpinButton.TextColor3 = Color3.fromRGB(255, 255, 255)
SpinButton.Font = Enum.Font.GothamBold
SpinButton.TextSize = 16
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
    
    local tabs = {PetsTab, SeedsTab, EggsTab, SpinTab}
    for _, t in ipairs(tabs) do
        t.BackgroundColor3 = Color3.fromRGB(25, 25, 40)
    end
    
    if tab == "pets" then
        PetsContent.Visible = true
        PetsTab.BackgroundColor3 = Color3.fromRGB(0, 100, 255)
    elseif tab == "seeds" then
        SeedsContent.Visible = true
        SeedsTab.BackgroundColor3 = Color3.fromRGB(0, 100, 255)
    elseif tab == "eggs" then
        EggsContent.Visible = true
        EggsTab.BackgroundColor3 = Color3.fromRGB(0, 100, 255)
    elseif tab == "spin" then
        SpinContent.Visible = true
        SpinTab.BackgroundColor3 = Color3.fromRGB(0, 100, 255)
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

-- Search function
local function filterItems(searchText, items)
    local filtered = {}
    searchText = string.lower(searchText)
    for _, item in pairs(items) do
        if string.find(string.lower(item), searchText) then
            table.insert(filtered, item)
        end
    end
    return filtered
end

local function updateSearch()
    local searchText = SearchBar.Text
    if searchText == "" then
        -- Show all items if search is empty
        for _, child in pairs(PetsContent:GetChildren()) do
            if child:IsA("TextButton") then
                child.Visible = true
            end
        end
        for _, child in pairs(SeedsContent:GetChildren()) do
            if child:IsA("TextButton") then
                child.Visible = true
            end
        end
        for _, child in pairs(EggsContent:GetChildren()) do
            if child:IsA("TextButton") then
                child.Visible = true
            end
        end
    else
        -- Filter items
        for _, child in pairs(PetsContent:GetChildren()) do
            if child:IsA("TextButton") then
                child.Visible = string.find(string.lower(child.Text), string.lower(searchText)) ~= nil
            end
        end
        for _, child in pairs(SeedsContent:GetChildren()) do
            if child:IsA("TextButton") then
                child.Visible = string.find(string.lower(child.Text), string.lower(searchText)) ~= nil
            end
        end
        for _, child in pairs(EggsContent:GetChildren()) do
            if child:IsA("TextButton") then
                child.Visible = string.find(string.lower(child.Text), string.lower(searchText)) ~= nil
            end
        end
    end
end

SearchBar:GetPropertyChangedSignal("Text"):Connect(updateSearch)

-- Create item buttons
local function createItemButton(parent, name, callback)
    local button = Instance.new("TextButton")
    button.Name = name
    button.Size = UDim2.new(1, -10, 0, 30)
    button.Position = UDim2.new(0, 5, 0, 0)
    button.BackgroundColor3 = Color3.fromRGB(30, 30, 50)
    button.BorderColor3 = Color3.fromRGB(0, 100, 255)
    button.BorderSizePixel = 1
    button.Text = name
    button.TextColor3 = Color3.fromRGB(200, 200, 255)
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

-- Auto-resize scrolling frames
PetsContent.ChildAdded:Connect(function()
    PetsContent.CanvasSize = UDim2.new(0, 0, 0, PetsList.AbsoluteContentSize.Y + 40)
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
Watermark.Text = "Woeq Hub v2.0"
Watermark.TextColor3 = Color3.fromRGB(150, 150, 255)
Watermark.Font = Enum.Font.Gotham
Watermark.TextSize = 11
Watermark.Parent = MainFrame
