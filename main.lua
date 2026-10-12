-- Versucht gethui() zu nutzen (Standard für moderne Exploits), andernfalls Fallback auf CoreGui
local targetParent = (gethui and gethui()) or game:GetService("CoreGui")

-- Falls das GUI bereits existiert, altes löschen um Überlagerungen zu vermeiden
if targetParent:FindFirstChild("ItsEverydayBroSS") then
    targetParent.ItsEverydayBroSS:Destroy()
end

-- Haupt-UI-Container erstellen
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "ItsEverydayBroSS"
ScreenGui.ResetOnSpawn = false
ScreenGui.IgnoreGuiInset = true
ScreenGui.Parent = targetParent

-- Hauptfenster (Hintergrund)
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 480, 0, 320)
MainFrame.Position = UDim2.new(0.5, -240, 0.5, -160)
MainFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Parent = ScreenGui

-- UICorner für abgerundete Ecken
local FrameCorner = Instance.new("UICorner")
FrameCorner.CornerRadius = UDim.new(0, 8)
FrameCorner.Parent = MainFrame

-- Titelzeile
local Title = Instance.new("TextLabel")
Title.Name = "Title"
Title.Text = "its everyday bro ss"
Title.Size = UDim2.new(0, 300, 0, 30)
Title.Position = UDim2.new(0, 15, 0, 10)
Title.BackgroundTransparency = 1
Title.Font = Enum.Font.SourceSans
Title.TextSize = 22
Title.TextColor3 = Color3.fromRGB(30, 30, 30)
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = MainFrame

-- Tab-Anzeige
local Tab1 = Instance.new("TextLabel")
Tab1.Name = "Tab1"
Tab1.Text = "tab 1"
Tab1.Size = UDim2.new(0, 65, 0, 20)
Tab1.Position = UDim2.new(0, 15, 0, 40)
Tab1.BackgroundColor3 = Color3.fromRGB(160, 160, 160)
Tab1.BorderSizePixel = 0
Tab1.Font = Enum.Font.SourceSans
Tab1.TextSize = 14
Tab1.TextColor3 = Color3.fromRGB(0, 0, 0)
Tab1.Parent = MainFrame

-- Code-Eingabefeld (TextBox)
local TextBox = Instance.new("TextBox")
TextBox.Name = "CodeBox"
TextBox.Text = 'print("Haha. not right now..")'
TextBox.ClearTextOnFocus = false
TextBox.MultiLine = true
TextBox.Size = UDim2.new(0, 320, 0, 200)
TextBox.Position = UDim2.new(0, 15, 0, 60)
TextBox.BackgroundColor3 = Color3.fromRGB(170, 170, 170)
TextBox.BorderSizePixel = 0
TextBox.Font = Enum.Font.Code
TextBox.TextSize = 12
TextBox.TextColor3 = Color3.fromRGB(0, 0, 0)
TextBox.TextXAlignment = Enum.TextXAlignment.Left
TextBox.TextYAlignment = Enum.TextYAlignment.Top
TextBox.Parent = MainFrame

----------------------------------------------------------------
-- UTILITY BUTTONS (UNTEN)
----------------------------------------------------------------

local function createBottomButton(name, text, xPos, width)
    local btn = Instance.new("TextButton")
    btn.Name = name
    btn.Text = text
    btn.Size = UDim2.new(0, width, 0, 25)
    btn.Position = UDim2.new(0, xPos, 0, 270)
    btn.BackgroundColor3 = Color3.fromRGB(180, 180, 180)
    btn.BorderSizePixel = 0
    btn.Font = Enum.Font.SourceSans
    btn.TextSize = 16
    btn.TextColor3 = Color3.fromRGB(0, 0, 0)
    btn.Parent = MainFrame
    return btn
end

local ExecuteBtn = createBottomButton("ExecuteBtn", "Execute", 15, 80)
local ClearBtn = createBottomButton("ClearBtn", "Clear", 105, 80)
local R6Btn = createBottomButton("R6Btn", "r6", 290, 25)
local ReBtn = createBottomButton("ReBtn", "re", 320, 25)

----------------------------------------------------------------
-- SCHNELLWAHL-BUTTONS (RECHTS)
----------------------------------------------------------------

local QuickActions = {
    {Text = "its everyday bro\ntrolling gui", Code = 'require(82952434559322)("username")'},
    {Text = "skid hub v3", Code = 'print("DELETEWD")'},
    {Text = "ai serverside\nmaker", Code = 'print("DELETED")'},
    {Text = "ban all", Code = 'print("DELETED")'},
    {Text = "tax evasion", Code = 'print("DELETD")'},
    {Text = "money laundering", Code = 'print("DELETED")'}
}

for i, action in ipairs(QuickActions) do
    local ActionBtn = Instance.new("TextButton")
    ActionBtn.Name = "Action_" .. i
    ActionBtn.Text = action.Text
    ActionBtn.Size = UDim2.new(0, 110, 0, 30)
    ActionBtn.Position = UDim2.new(0, 350, 0, 60 + ((i - 1) * 35))
    ActionBtn.BackgroundColor3 = Color3.fromRGB(180, 180, 180)
    ActionBtn.BorderSizePixel = 0
    ActionBtn.Font = Enum.Font.SourceSans
    ActionBtn.TextSize = 13
    ActionBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
    ActionBtn.Parent = MainFrame
    
    ActionBtn.MouseButton1Click:Connect(function()
        TextBox.Text = action.Code
    end)
end

----------------------------------------------------------------
-- KERNFUNKTIONEN (INTERAKTION)
----------------------------------------------------------------

-- Code ausführen via Executor loadstring
ExecuteBtn.MouseButton1Click:Connect(function()
    local codeToRun = TextBox.Text
    local success, parseError = pcall(function()
        -- Nutzt das integrierte loadstring des Xeno Executors
        local func = loadstring(codeToRun)
        if func then
            task.spawn(func)
        else
            error("Syntaxfehler im Code!")
        end
    end)
    if not success then
        warn("Ausführung fehlgeschlagen: " .. tostring(parseError))
    end
end)

-- Textbox leeren
ClearBtn.MouseButton1Click:Connect(function()
    TextBox.Text = ""
end)

-- R6 Anpassung
R6Btn.MouseButton1Click:Connect(function()
    pcall(function()
        workspace.AvatarIdempotentMode = Enum.AvatarJointPositioningMode.Default
        print("Rig-sWITCHED")
    end)
end)

-- Lokalen Charakter respawnen (Re-Load)
ReBtn.MouseButton1Click:Connect(function()
    local p = game:GetService("Players").LocalPlayer
    if p then
        pcall(function()
            p:LoadCharacter()
        end)
    end
end)

----------------------------------------------------------------
-- SMOOTH DRAGGING LOGIK (ZIEHEN DES GUIS)
----------------------------------------------------------------

local UserInputService = game:GetService("UserInputService")
local dragging, dragInput, dragStart, startPos

local function update(input)
    local delta = input.Position - dragStart
    MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end

MainFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = MainFrame.Position
        
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

MainFrame.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        update(input)
    end
end)
