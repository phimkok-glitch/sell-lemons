--// Lemon Empire Hub v2.2 - Светло-синий + Auto Sell
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
    Name = "🍋 Lemon Empire Hub v2.2",
    LoadingTitle = "Lemon Empire",
    LoadingSubtitle = "phimkok",
    ConfigurationSaving = { Enabled = false },
    KeySystem = false
})

local MainTab = Window:CreateTab("Основное", 4483362458)
local FarmTab = Window:CreateTab("Фарм", 4483362458)

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local userTycoon = workspace:FindFirstChild("Tycoon2")

local AutoBuy = false
local AutoUpgrade = false
local AutoFruit = false
local AutoRebirth = false
local AutoEvolve = false
local AutoSell = false

-- Auto Buy без Decoration
local function buyAllNoDecoration()
    local purchases = userTycoon and userTycoon:FindFirstChild("Purchases")
    if not purchases then return end
    for _, obj in ipairs(purchases:GetDescendants()) do
        if obj:IsA("Model") then
            local name = obj.Name:lower()
            if name:find("decoration") or name:find("decor") or name:find("skin") or name:find("effect") then
                continue
            end
            local shown = obj:GetAttribute("Shown")
            local purchased = obj:GetAttribute("Purchased")
            if shown == true and purchased ~= true then
                local purchase = obj:FindFirstChild("Purchase")
                if purchase then pcall(function() purchase:InvokeServer() end) end
            end
        end
    end
end

-- Auto Sell
local function autoSell()
    local sellButton = userTycoon and userTycoon:FindFirstChild("Sell", true) or workspace:FindFirstChild("Sell", true)
    if sellButton then
        pcall(function()
            fireclickdetector(sellButton:FindFirstChildOfClass("ClickDetector"))
        end)
    end
end

task.spawn(function()
    while true do
        task.wait(0.15)
        if AutoBuy then pcall(buyAllNoDecoration) end
        if AutoSell then pcall(autoSell) end
    end
end)

-- GUI (Светло-синий стиль)
MainTab:CreateToggle({
    Name = "🔄 Auto Buy (без Decoration)",
    CurrentValue = false,
    Callback = function(v) AutoBuy = v end
})

MainTab:CreateToggle({
    Name = "💰 Auto Sell (Продажа лимонов)",
    CurrentValue = false,
    Callback = function(v) AutoSell = v end
})

MainTab:CreateToggle({
    Name = "⬆ Auto Upgrade",
    CurrentValue = false,
    Callback = function(v) AutoUpgrade = v end
})

FarmTab:CreateToggle({
    Name = "🍋 Auto Fruit",
    CurrentValue = false,
    Callback = function(v) AutoFruit = v end
})

MainTab:CreateToggle({
    Name = "♻ Auto Rebirth",
    CurrentValue = false,
    Callback = function(v) AutoRebirth = v end
})

Rayfield:Notify({
    Title = "✅ Загружено v2.2",
    Content = "Светло-синий + Auto Sell добавлен!",
    Duration = 6
})
