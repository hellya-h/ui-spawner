local Spawner = loadstring(game:HttpGet("https://gitlab.com/darkiedarkie/dark/-/raw/main/Spawner.lua"))()

-- Create the main UI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "WoeqHub"
ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 400, 0, 450)
MainFrame.Position = UDim2.new(0.5, -200, 0.5, -225)
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
TitleBar.Size = UDim2.new(1, 0, 0, 40)
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
Title.Size = UDim2.new(0, 200, 0, 40)
Title.Position = UDim2.new(0.5, -100, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "WOEQ HUB"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 18
Title.ZIndex = 3
Title.Parent = TitleBar

local CloseButton = Instance.new("TextButton")
CloseButton.Name = "CloseButton"
CloseButton.Size = UDim2.new(0, 30, 0, 30)
CloseButton.Position = UDim2.new(1, -35, 0, 5)
CloseButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
CloseButton.BorderSizePixel = 0
CloseButton.Text = "X"
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.Font = Enum.Font.GothamBold
CloseButton.TextSize = 16
CloseButton.ZIndex = 3
CloseButton.Parent = TitleBar

CloseButton.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

-- Create tab buttons with gradient effect
local TabButtons = Instance.new("Frame")
TabButtons.Name = "TabButtons"
TabButtons.Size = UDim2.new(1, -10, 0, 40)
TabButtons.Position = UDim2.new(0, 5, 0, 45)
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
    button.TextSize = 14
    button.Parent = TabButtons
    
    local buttonGradient = Instance.new("UIGradient")
    buttonGradient.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.fromRGB(30, 30, 50)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(20, 20, 40))
    }
    buttonGradient.Rotation = 90
    buttonGradient.Parent = button
    
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

-- Create content frames
local ContentFrame = Instance.new("Frame")
ContentFrame.Name = "ContentFrame"
ContentFrame.Size = UDim2.new(1, -10, 1, -100)
ContentFrame.Position = UDim2.new(0, 5, 0, 90)
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
PetsList.Padding = UDim.new(0, 8)
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
SeedsList.Padding = UDim.new(0, 8)
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
EggsList.Padding = UDim.new(0, 8)
EggsList.Parent = EggsContent

-- Spin content
local SpinContent = Instance.new("Frame")
SpinContent.Name = "SpinContent"
SpinContent.Size = UDim2.new(1, 0, 1, 0)
SpinContent.BackgroundTransparency = 1
SpinContent.Visible = false
SpinContent.Parent = ContentFrame

-- Input fields for pet spawning with better styling
local function createInputField(parent, name, position, defaultValue)
    local frame = Instance.new("Frame")
    frame.Name = name.."Frame"
    frame.Size = UDim2.new(1, 0, 0, 30)
    frame.Position = position
    frame.BackgroundTransparency = 1
    frame.Parent = parent
    
    local label = Instance.new("TextLabel")
    label.Name = name.."Label"
    label.Size = UDim2.new(0.4, 0, 1, 0)
    label.Position = UDim2.new(0, 0, 0, 0)
    label.BackgroundTransparency = 1
    label.Text = name..":"
    label.TextColor3 = Color3.fromRGB(200, 200, 255)
    label.Font = Enum.Font.GothamSemibold
    label.TextSize = 14
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = frame
    
    local input = Instance.new("TextBox")
    input.Name = name.."Input"
    input.Size = UDim2.new(0.6, -10, 1, 0)
    input.Position = UDim2.new(0.4, 0, 0, 0)
    input.BackgroundColor3 = Color3.fromRGB(30, 30, 50)
    input.BorderColor3 = Color3.fromRGB(0, 100, 255)
    input.BorderSizePixel = 1
    input.Text = tostring(defaultValue)
    input.TextColor3 = Color3.fromRGB(255, 255, 255)
    input.Font = Enum.Font.Gotham
    input.TextSize = 14
    input.Parent = frame
    
    return input
end

local KGInput = createInputField(PetsContent, "KG", UDim2.new(0, 0, 0, 0), 1)
local AgeInput = createInputField(PetsContent, "Age", UDim2.new(0, 0, 0, 40), 1)

-- Enhanced spin section
local SpinFrame = Instance.new("Frame")
SpinFrame.Name = "SpinFrame"
SpinFrame.Size = UDim2.new(1, 0, 0, 100)
SpinFrame.Position = UDim2.new(0, 0, 0.5, -50)
SpinFrame.AnchorPoint = Vector2.new(0, 0.5)
SpinFrame.BackgroundTransparency = 1
SpinFrame.Parent = SpinContent

local SpinInput = Instance.new("TextBox")
SpinInput.Name = "SpinInput"
SpinInput.Size = UDim2.new(1, -20, 0, 40)
SpinInput.Position = UDim2.new(0, 10, 0, 0)
SpinInput.BackgroundColor3 = Color3.fromRGB(30, 30, 50)
SpinInput.BorderColor3 = Color3.fromRGB(0, 100, 255)
SpinInput.BorderSizePixel = 1
SpinInput.Text = "Sunflower"
SpinInput.TextColor3 = Color3.fromRGB(255, 255, 255)
SpinInput.Font = Enum.Font.Gotham
SpinInput.TextSize = 14
SpinInput.Parent = SpinFrame

local SpinButton = Instance.new("TextButton")
SpinButton.Name = "SpinButton"
SpinButton.Size = UDim2.new(1, -20, 0, 40)
SpinButton.Position = UDim2.new(0, 10, 0, 50)
SpinButton.BackgroundColor3 = Color3.fromRGB(0, 100, 255)
SpinButton.BorderSizePixel = 0
SpinButton.Text = "SPIN"
SpinButton.TextColor3 = Color3.fromRGB(255, 255, 255)
SpinButton.Font = Enum.Font.GothamBold
SpinButton.TextSize = 16
SpinButton.Parent = SpinFrame

local SpinButtonGradient = Instance.new("UIGradient")
SpinButtonGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 80, 255)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 180, 255))
}
SpinButtonGradient.Rotation = 90
SpinButtonGradient.Parent = SpinButton

SpinButton.MouseButton1Click:Connect(function()
    Spawner.Spin(SpinInput.Text)
end)

-- Tab switching function with animations
local function switchTab(tab)
    PetsContent.Visible = false
    SeedsContent.Visible = false
    EggsContent.Visible = false
    SpinContent.Visible = false
    
    local tabs = {PetsTab, SeedsTab, EggsTab, SpinTab}
    for _, t in ipairs(tabs) do
        game:GetService("TweenService"):Create(
            t,
            TweenInfo.new(0.2),
            {BackgroundColor3 = Color3.fromRGB(25, 25, 40)}
        ):Play()
    end
    
    if tab == "pets" then
        PetsContent.Visible = true
        game:GetService("TweenService"):Create(
            PetsTab,
            TweenInfo.new(0.2),
            {BackgroundColor3 = Color3.fromRGB(0, 100, 255)}
        ):Play()
    elseif tab == "seeds" then
        SeedsContent.Visible = true
        game:GetService("TweenService"):Create(
            SeedsTab,
            TweenInfo.new(0.2),
            {BackgroundColor3 = Color3.fromRGB(0, 100, 255)}
        ):Play()
    elseif tab == "eggs" then
        EggsContent.Visible = true
        game:GetService("TweenService"):Create(
            EggsTab,
            TweenInfo.new(0.2),
            {BackgroundColor3 = Color3.fromRGB(0, 100, 255)}
        ):Play()
    elseif tab == "spin" then
        SpinContent.Visible = true
        game:GetService("TweenService"):Create(
            SpinTab,
            TweenInfo.new(0.2),
            {BackgroundColor3 = Color3.fromRGB(0, 100, 255)}
        ):Play()
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

-- Enhanced item button creation
local function createItemButton(parent, name, callback)
    local button = Instance.new("TextButton")
    button.Name = name
    button.Size = UDim2.new(1, -10, 0, 35)
    button.Position = UDim2.new(0, 5, 0, 0)
    button.BackgroundColor3 = Color3.fromRGB(30, 30, 50)
    button.BorderColor3 = Color3.fromRGB(0, 100, 255)
    button.BorderSizePixel = 1
    button.Text = name
    button.TextColor3 = Color3.fromRGB(200, 200, 255)
    button.Font = Enum.Font.Gotham
    button.TextSize = 14
    button.Parent = parent
    
    local buttonGradient = Instance.new("UIGradient")
    buttonGradient.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.fromRGB(40, 40, 60)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(30, 30, 50))
    }
    buttonGradient.Rotation = 90
    buttonGradient.Parent = button
    
    button.MouseEnter:Connect(function()
        game:GetService("TweenService"):Create(
            button,
            TweenInfo.new(0.1),
            {BackgroundColor3 = Color3.fromRGB(50, 50, 70)}
        ):Play()
    end)
    
    button.MouseLeave:Connect(function()
        game:GetService("TweenService"):Create(
            button,
            TweenInfo.new(0.1),
            {BackgroundColor3 = Color3.fromRGB(30, 30, 50)}
        ):Play()
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
    PetsContent.CanvasSize = UDim2.new(0, 0, 0, PetsList.AbsoluteContentSize.Y + 80)
end)

SeedsContent.ChildAdded:Connect(function()
    SeedsContent.CanvasSize = UDim2.new(0, 0, 0, SeedsList.AbsoluteContentSize.Y + 5)
end)

EggsContent.ChildAdded:Connect(function()
    EggsContent.CanvasSize = UDim2.new(0, 0, 0, EggsList.AbsoluteContentSize.Y + 5)
end)

-- Set initial tab
switchTab("pets")

-- Add watermark
local Watermark = Instance.new("TextLabel")
Watermark.Name = "Watermark"
Watermark.Size = UDim2.new(1, 0, 0, 20)
Watermark.Position = UDim2.new(0, 0, 1, -20)
Watermark.BackgroundTransparency = 1
Watermark.Text = "Woeq Hub v1.0"
Watermark.TextColor3 = Color3.fromRGB(150, 150, 255)
Watermark.Font = Enum.Font.Gotham
Watermark.TextSize = 12
Watermark.Parent = MainFrame
