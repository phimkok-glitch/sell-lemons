task.wait(2)

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Workspace = game:GetService("Workspace")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local VirtualInputManager = game:GetService("VirtualInputManager")
local UserInputService = game:GetService("UserInputService")

local CommF = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("CommF_")

-- ==================== GUI ====================
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "BFGui"
ScreenGui.ResetOnSpawn = false
ScreenGui.IgnoreGuiInset = true
ScreenGui.Parent = LocalPlayer.PlayerGui

-- Кнопка открыть (всегда видна)
local OpenBtn = Instance.new("TextButton")
OpenBtn.Size = UDim2.new(0, 50, 0, 50)
OpenBtn.Position = UDim2.new(0, 10, 0.5, -25)
OpenBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 45)
OpenBtn.Text = "☰"
OpenBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
OpenBtn.TextSize = 22
OpenBtn.Font = Enum.Font.GothamBold
OpenBtn.ZIndex = 10
OpenBtn.Parent = ScreenGui
Instance.new("UICorner", OpenBtn).CornerRadius = UDim.new(0, 10)
Instance.new("UIStroke", OpenBtn).Color = Color3.fromRGB(80, 80, 120)

-- Главное окно
local Main = Instance.new("Frame")
Main.Size = UDim2.new(0, 200, 0, 300)
Main.Position = UDim2.new(0, 70, 0.5, -150)
Main.BackgroundColor3 = Color3.fromRGB(18, 18, 28)
Main.BorderSizePixel = 0
Main.Parent = ScreenGui
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 10)
local mainStroke = Instance.new("UIStroke", Main)
mainStroke.Color = Color3.fromRGB(70, 70, 110)
mainStroke.Thickness = 1.5

-- Заголовок
local TitleBar = Instance.new("Frame")
TitleBar.Size = UDim2.new(1, 0, 0, 38)
TitleBar.BackgroundColor3 = Color3.fromRGB(35, 35, 55)
TitleBar.BorderSizePixel = 0
TitleBar.Parent = Main
Instance.new("UICorner", TitleBar).CornerRadius = UDim.new(0, 10)

local TitleText = Instance.new("TextLabel")
TitleText.Size = UDim2.new(1, -40, 1, 0)
TitleText.Position = UDim2.new(0, 10, 0, 0)
TitleText.BackgroundTransparency = 1
TitleText.Text = "🍎 BF Cheat v1.1"
TitleText.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleText.TextSize = 13
TitleText.Font = Enum.Font.GothamBold
TitleText.TextXAlignment = Enum.TextXAlignment.Left
TitleText.Parent = TitleBar

-- Кнопка закрыть
local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 28, 0, 28)
CloseBtn.Position = UDim2.new(1, -34, 0, 5)
CloseBtn.BackgroundColor3 = Color3.fromRGB(180, 50, 50)
CloseBtn.Text = "✕"
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.TextSize = 13
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.Parent = TitleBar
Instance.new("UICorner", CloseBtn).CornerRadius = UDim.new(0, 6)

CloseBtn.MouseButton1Click:Connect(function()
    Main.Visible = false
end)
OpenBtn.MouseButton1Click:Connect(function()
    Main.Visible = true
end)

-- Перетаскивание
local dragging, dragStart, startPos
TitleBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = Main.Position
    end
end)
UserInputService.InputChanged:Connect(function(input)
    if dragging and (input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseMovement) then
        local delta = input.Position - dragStart
        Main.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)
UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)

-- Список кнопок
local ListFrame = Instance.new("Frame")
ListFrame.Size = UDim2.new(1, -10, 1, -48)
ListFrame.Position = UDim2.new(0, 5, 0, 43)
ListFrame.BackgroundTransparency = 1
ListFrame.Parent = Main

local ListLayout = Instance.new("UIListLayout", ListFrame)
ListLayout.Padding = UDim.new(0, 5)
ListLayout.SortOrder = Enum.SortOrder.LayoutOrder

-- ==================== НАСТРОЙКИ ====================
local Settings = {
    AutoFarm   = false,
    AutoQuest  = false,
    AutoParry  = false,
    ESPPlayers = false,
    ESPFruits  = false,
}

local Toggles = {}

local function CreateToggle(icon, label, key)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, 0, 0, 42)
    btn.BackgroundColor3 = Color3.fromRGB(28, 28, 42)
    btn.BorderSizePixel = 0
    btn.AutoButtonColor = false
    btn.Parent = ListFrame
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 8)

    -- Иконка
    local iconLbl = Instance.new("TextLabel", btn)
    iconLbl.Size = UDim2.new(0, 36, 1, 0)
    iconLbl.Position = UDim2.new(0, 4, 0, 0)
    iconLbl.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
    iconLbl.Text = icon
    iconLbl.TextSize = 16
    iconLbl.Font = Enum.Font.GothamBold
    iconLbl.TextColor3 = Color3.fromRGB(255, 255, 255)
    Instance.new("UICorner", iconLbl).CornerRadius = UDim.new(0, 6)

    -- Текст
    local textLbl = Instance.new("TextLabel", btn)
    textLbl.Size = UDim2.new(1, -90, 1, 0)
    textLbl.Position = UDim2.new(0, 46, 0, 0)
    textLbl.BackgroundTransparency = 1
    textLbl.Text = label
    textLbl.TextSize = 12
    textLbl.Font = Enum.Font.GothamBold
    textLbl.TextColor3 = Color3.fromRGB(200, 200, 220)
    textLbl.TextXAlignment = Enum.TextXAlignment.Left

    -- Статус
    local statusLbl = Instance.new("TextLabel", btn)
    statusLbl.Size = UDim2.new(0, 38, 0, 22)
    statusLbl.Position = UDim2.new(1, -42, 0.5, -11)
    statusLbl.BackgroundColor3 = Color3.fromRGB(180, 50, 50)
    statusLbl.Text = "OFF"
    statusLbl.TextSize = 11
    statusLbl.Font = Enum.Font.GothamBold
    statusLbl.TextColor3 = Color3.fromRGB(255, 255, 255)
    Instance.new("UICorner", statusLbl).CornerRadius = UDim.new(0, 5)

    btn.MouseButton1Click:Connect(function()
        Settings[key] = not Settings[key]
        if Settings[key] then
            statusLbl.Text = "ON"
            statusLbl.BackgroundColor3 = Color3.fromRGB(40, 160, 80)
            btn.BackgroundColor3 = Color3.fromRGB(25, 45, 35)
        else
            statusLbl.Text = "OFF"
            statusLbl.BackgroundColor3 = Color3.fromRGB(180, 50, 50)
            btn.BackgroundColor3 = Color3.fromRGB(28, 28, 42)
        end
    end)

    Toggles[key] = {status = statusLbl, btn = btn}
end

CreateToggle("⚔️", "Автофарм",   "AutoFarm")
CreateToggle("📜", "Auto Quest",  "AutoQuest")
CreateToggle("🛡️", "Auto Parry",  "AutoParry")
CreateToggle("👁️", "ESP Игроки",  "ESPPlayers")
CreateToggle("🍎", "ESP Фрукты",  "ESPFruits")

print("✅ BF v1.1 загружен!")

-- ==================== КВЕСТЫ ====================
local QuestList = {
    {Level = 0,    QuestName = "BanditQuest1",           QuestID = 1},
    {Level = 10,   QuestName = "JungleQuest",            QuestID = 1},
    {Level = 15,   QuestName = "BuggyQuest1",            QuestID = 1},
    {Level = 30,   QuestName = "PirateVillageQuest",     QuestID = 1},
    {Level = 40,   QuestName = "DesertQuest",            QuestID = 1},
    {Level = 60,   QuestName = "SnowQuest",              QuestID = 1},
    {Level = 75,   QuestName = "MarineQuest2",           QuestID = 1},
    {Level = 90,   QuestName = "SkylandsQuest",          QuestID = 1},
    {Level = 100,  QuestName = "FishmanQuest",           QuestID = 1},
    {Level = 120,  QuestName = "GodQuest",               QuestID = 1},
    {Level = 700,  QuestName = "Area1Quest",             QuestID = 1},
    {Level = 725,  QuestName = "Area2Quest",             QuestID = 1},
    {Level = 775,  QuestName = "ZombieQuest",            QuestID = 1},
    {Level = 875,  QuestName = "SnowMountainQuest",      QuestID = 1},
    {Level = 925,  QuestName = "IceSideQuest",           QuestID = 1},
    {Level = 1000, QuestName = "ColdIslandQuest",        QuestID = 1},
    {Level = 1100, QuestName = "MagmaQuest",             QuestID = 1},
    {Level = 1175, QuestName = "FountainQuest",          QuestID = 1},
    {Level = 1250, QuestName = "ShipQuest1",             QuestID = 1},
    {Level = 1350, QuestName = "ShipQuest2",             QuestID = 1},
    {Level = 1425, QuestName = "ForgottenQuest",         QuestID = 1},
    {Level = 1500, QuestName = "PirateMillionaireQuest", QuestID = 1},
    {Level = 1575, QuestName = "DragonCrewWarriorQuest", QuestID = 1},
    {Level = 1700, QuestName = "MarineCommodoreQuest",   QuestID = 1},
    {Level = 1775, QuestName = "FishmanRaiderQuest",     QuestID = 1},
    {Level = 1975, QuestName = "HauntedQuest",           QuestID = 1},
    {Level = 2075, QuestName = "SeaOfTreatsQuest",       QuestID = 1},
    {Level = 2450, QuestName = "TikiOutpostQuest",       QuestID = 1},
    {Level = 2600, QuestName = "SubmergedIslandQuest",   QuestID = 1},
}

-- ==================== AUTO QUEST ====================
task.spawn(function()
    while task.wait(2) do
        if not Settings.AutoQuest then continue end
        pcall(function()
            local level = 0
            pcall(function() level = LocalPlayer.Data.Level.Value end)
            local mainGui = LocalPlayer.PlayerGui:FindFirstChild("Main")
            if mainGui and mainGui:FindFirstChild("Quest") and not mainGui.Quest.Visible then
                local bestQuest = nil
                for _, q in ipairs(QuestList) do
                    if level >= q.Level then bestQuest = q end
                end
                if bestQuest then
                    CommF:InvokeServer("StartQuest", bestQuest.QuestName, bestQuest.QuestID)
                end
            end
        end)
    end
end)

-- ==================== AUTO FARM ====================
task.spawn(function()
    while true do
        if not Settings.AutoFarm then task.wait(1) continue end
        pcall(function()
            local char = LocalPlayer.Character
            if not char or not char:FindFirstChild("HumanoidRootPart") then task.wait(1) return end
            local root = char.HumanoidRootPart
            local target, minDist = nil, math.huge

            local enemyFolders = {}
            if Workspace:FindFirstChild("Enemies") then
                table.insert(enemyFolders, Workspace.Enemies)
            end
            for _, folder in pairs(Workspace:GetChildren()) do
                if folder.Name:find("Enemy") or folder.Name:find("Mob") then
                    table.insert(enemyFolders, folder)
                end
            end

            for _, folder in ipairs(enemyFolders) do
                for _, mob in ipairs(folder:GetChildren()) do
                    local hum = mob:FindFirstChild("Humanoid")
                    local hrp = mob:FindFirstChild("HumanoidRootPart")
                    if hum and hum.Health > 0 and hrp then
                        local dist = (hrp.Position - root.Position).Magnitude
                        if dist < minDist and dist < 250 then
                            minDist = dist
                            target = mob
                        end
                    end
                end
            end

            if target and target:FindFirstChild("HumanoidRootPart") then
                root.CFrame = target.HumanoidRootPart.CFrame * CFrame.new(0, 6, 7)
                task.wait(0.1)
                -- атака через инпут
                VirtualInputManager:SendMouseButtonEvent(500, 300, 0, true, game, 1)
                task.wait(0.05)
                VirtualInputManager:SendMouseButtonEvent(500, 300, 0, false, game, 1)
            end
        end)
        task.wait(0.3 + math.random() * 0.2)
    end
end)

-- ==================== AUTO PARRY ====================
task.spawn(function()
    while task.wait(0.07) do
        if not Settings.AutoParry then continue end
        pcall(function()
            local char = LocalPlayer.Character
            if not char or not char:FindFirstChild("HumanoidRootPart") then return end
            local enemiesFolder = Workspace:FindFirstChild("Enemies")
            if not enemiesFolder then return end
            for _, enemy in ipairs(enemiesFolder:GetChildren()) do
                local hrp = enemy:FindFirstChild("HumanoidRootPart")
                if hrp and (hrp.Position - char.HumanoidRootPart.Position).Magnitude < 15 then
                    if keypress then
                        keypress(0x46)
                        task.wait(0.028)
                        keyrelease(0x46)
                    end
                    break
                end
            end
        end)
    end
end)

-- ==================== ESP ИГРОКИ ====================
local ESPTable = {}
task.spawn(function()
    while task.wait(0.5) do
        if Settings.ESPPlayers then
            local myChar = LocalPlayer.Character
            if not myChar or not myChar:FindFirstChild("HumanoidRootPart") then continue end
            for _, plr in ipairs(Players:GetPlayers()) do
                if plr == LocalPlayer then continue end
                local char = plr.Character
                if char and char:FindFirstChild("Head") and char:FindFirstChild("HumanoidRootPart") and char:FindFirstChild("Humanoid") then
                    if ESPTable[plr] and not ESPTable[plr].Parent then ESPTable[plr] = nil end
                    if not ESPTable[plr] then
                        local bg = Instance.new("BillboardGui")
                        bg.Adornee = char.Head
                        bg.Size = UDim2.new(0, 200, 0, 70)
                        bg.StudsOffset = Vector3.new(0, 4, 0)
                        bg.AlwaysOnTop = true
                        bg.Parent = char.Head
                        local label = Instance.new("TextLabel", bg)
                        label.Size = UDim2.new(1,0,1,0)
                        label.BackgroundTransparency = 1
                        label.TextScaled = true
                        label.Font = Enum.Font.GothamBold
                        label.TextColor3 = Color3.fromRGB(255, 70, 70)
                        ESPTable[plr] = bg
                    end
                    local dist = math.floor((char.HumanoidRootPart.Position - myChar.HumanoidRootPart.Position).Magnitude)
                    ESPTable[plr].TextLabel.Text = string.format("%s\nHP: %d/%d\nDist: %dm",
                        plr.Name, math.floor(char.Humanoid.Health), math.floor(char.Humanoid.MaxHealth), dist)
                end
            end
        else
            for _, gui in pairs(ESPTable) do if gui and gui.Parent then gui:Destroy() end end
            ESPTable = {}
        end
    end
end)

Players.PlayerRemoving:Connect(function(plr)
    if ESPTable[plr] then ESPTable[plr]:Destroy() ESPTable[plr] = nil end
end)

-- ==================== ESP ФРУКТЫ ====================
local FruitESP = {}
task.spawn(function()
    while task.wait(1) do
        if Settings.ESPFruits then
            local myChar = LocalPlayer.Character
            if not myChar or not myChar:FindFirstChild("HumanoidRootPart") then continue end

            -- Очистка старых
            for obj, gui in pairs(FruitESP) do
                if not obj or not obj.Parent then
                    if gui and gui.Parent then gui:Destroy() end
                    FruitESP[obj] = nil
                end
            end

            -- Поиск фруктов в Workspace
            for _, obj in pairs(Workspace:GetDescendants()) do
                if obj:IsA("BasePart") and obj.Name:find("Fruit") or
                   obj:IsA("Model") and obj.Name:find("Fruit") then
                    if not FruitESP[obj] then
                        local part = obj:IsA("BasePart") and obj or obj:FindFirstChildWhichIsA("BasePart")
                        if part then
                            local bg = Instance.new("BillboardGui")
                            bg.Adornee = part
                            bg.Size = UDim2.new(0, 160, 0, 50)
                            bg.StudsOffset = Vector3.new(0, 3, 0)
                            bg.AlwaysOnTop = true
                            bg.Parent = part
                            local label = Instance.new("TextLabel", bg)
                            label.Size = UDim2.new(1,0,1,0)
                            label.BackgroundTransparency = 1
                            label.TextScaled = true
                            label.Font = Enum.Font.GothamBold
                            label.TextColor3 = Color3.fromRGB(255, 200, 0)
                            label.Text = "🍎 " .. obj.Name
                            FruitESP[obj] = bg
                        end
                    end
                end
            end
        else
            for _, gui in pairs(FruitESP) do if gui and gui.Parent then gui:Destroy() end end
            FruitESP = {}
        end
    end
end)
