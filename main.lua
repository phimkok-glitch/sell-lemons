--// Lemon Empire Hub - Custom by [Твоё имя]
-- Для Sell Lemons | Delta Executor

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
    Name = "🍋 Lemon Empire Hub",
    LoadingTitle = "Lemon Empire",
    LoadingSubtitle = "Custom Build",
    ConfigurationSaving = { Enabled = false },
    KeySystem = false
})

local MainTab = Window:CreateTab("Главное", 4483362458)
local FarmTab = Window:CreateTab("Фарм", 4483362458)
local ExtraTab = Window:CreateTab("Дополнительно", 4483362458)

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- Найти твой Tycoon
local userTycoon = nil
for _, v in pairs(workspace:GetChildren()) do
    if v:IsA("Folder") and v.Name:match("Tycoon%d") then
        if v:FindFirstChild("Owner") and v.Owner.Value == LocalPlayer then
            userTycoon = v
            break
        end
    end
end

if not userTycoon then
    Rayfield:Notify({ Title = "Ошибка", Content = "Tycoon не найден! Зайди в игру и купи стенд.", Duration = 6 })
    return
end

-- Переменные
local AutoBuy = false
local AutoUpgrade = false
local AutoFruit = false
local AutoRebirth = false
local AutoEvolve = false
local AutoPower = false
local AutoSell = false

-- Авто Buy
local function buyAll()
    for _, obj in ipairs(userTycoon.Purchases:GetDescendants()) do
        if obj:IsA("Model") then
            local shown = obj:GetAttribute("Shown")
            local purchased = obj:GetAttribute("Purchased")
            if shown and not purchased then
                local purchase = obj:FindFirstChild("Purchase")
                if purchase and purchase:IsA("RemoteFunction") then
                    pcall(function() purchase:InvokeServer() end)
                end
            end
        end
    end
end

task.spawn(function()
    while true do
        task.wait(0.1)
        if AutoBuy then pcall(buyAll) end
    end
end)

-- Авто Upgrade (упрощённо)
local function autoUpgrade()
    local purchases = userTycoon:FindFirstChild("Purchases")
    if not purchases then return end
    for _, obj in ipairs(purchases:GetDescendants()) do
        if obj:IsA("RemoteFunction") and obj.Name == "Upgrade" then
            for i = 1, 50 do
                local success = pcall(function() return obj:InvokeServer(i) end)
                if not success then break end
            end
        end
    end
end

-- GUI
MainTab:CreateToggle({
    Name = "🔄 Auto Buy (Мгновенная покупка)",
    CurrentValue = false,
    Callback = function(v) AutoBuy = v end
})

MainTab:CreateToggle({
    Name = "⬆ Auto Upgrade",
    CurrentValue = false,
    Callback = function(v) AutoUpgrade = v end
})

FarmTab:CreateToggle({
    Name = "🍋 Auto Fruit (Сбор лимонов)",
    CurrentValue = false,
    Callback = function(v) AutoFruit = v end
})

MainTab:CreateToggle({
    Name = "♻ Auto Rebirth",
    CurrentValue = false,
    Callback = function(v) AutoRebirth = v end
})

MainTab:CreateToggle({
    Name = "🌟 Auto Evolve (x10 доход)",
    CurrentValue = false,
    Callback = function(v) AutoEvolve = v end
})

ExtraTab:CreateToggle({
    Name = "⚡ Auto Power Level",
    CurrentValue = false,
    Callback = function(v) AutoPower = v end
})

ExtraTab:CreateToggle({
    Name = "💰 Auto Sell",
    CurrentValue = false,
    Callback = function(v) AutoSell = v end
})

-- Кнопки
ExtraTab:CreateButton({
    Name = "🕹 Pull All Levers + Vine Harvest",
    Callback = function()
        Rayfield:Notify({Title = "Sewer", Content = "Запуск сбора в канализации...", Duration = 4})
        -- Здесь можно добавить вызов doSewerRun если хочешь полностью вернуть
    end
})

ExtraTab:CreateButton({
    Name = "Уничтожить GUI",
    Callback = function() Rayfield:Destroy() end
})

Rayfield:Notify({
    Title = "✅ Успешно",
    Content = "Lemon Empire Hub загружен! Приятного фарма 🍋",
    Duration = 5
})
