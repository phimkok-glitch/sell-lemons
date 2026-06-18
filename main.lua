--// Lemon Empire Hub v2.4 - Чистая версия
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

-- Светло-синий цвет
Rayfield.Theme = {
    Default = Color3.fromRGB(25, 25, 45),
    TextColor = Color3.fromRGB(220, 240, 255),
    MainColor = Color3.fromRGB(40, 80, 160),
    AccentColor = Color3.fromRGB(80, 160, 255),
}

local Window = Rayfield:CreateWindow({
    Name = "🍋 Lemon Empire Hub v2.4",
    LoadingTitle = "Lemon Empire",
    LoadingSubtitle = "Чистая версия",
    ConfigurationSaving = { Enabled = false },
    KeySystem = false
})

local MainTab = Window:CreateTab("Основное", 4483362458)
local FarmTab = Window:CreateTab("Фарм", 4483362458)

local userTycoon = workspace:FindFirstChild("Tycoon2")

local AutoBuy = false
local AutoUpgrade = false
local AutoFruit = false
local AutoRebirth = false
local AutoEvolve = false

-- Auto Buy без Decoration
local function buyAllNoDecoration()
    local purchases = userTycoon and userTycoon:FindFirstChild("Purchases")
    if not purchases then return end
    for _, obj in ipairs(purchases:GetDescendants()) do
        if obj:IsA("Model") then
            local name = obj.Name:lower()
            if name:find("decoration") or name:find("decor") or name:find("skin") then continue end
            if obj:GetAttribute("Shown") and not obj:GetAttribute("Purchased") then
                local purchase = obj:FindFirstChild("Purchase")
                if purchase then pcall(function() purchase:InvokeServer() end) end
            end
        end
    end
end

task.spawn(function()
    while true do
        task.wait(0.1)
        if AutoBuy then pcall(buyAllNoDecoration) end
    end
end)

-- Улучшенный Auto Fruit
task.spawn(function()
    while true do
        task.wait(0.25)
        if AutoFruit then
            for _, tree in ipairs(workspace:GetDescendants()) do
                if tree.Name == "LemonTree" then
                    for _, part in ipairs(tree:GetDescendants()) do
                        if part.Name == "Fruit" and part:FindFirstChild("ClickPart") then
                            local cd = part.ClickPart:FindFirstChildOfClass("ClickDetector")
                            if cd then
                                pcall(function() fireclickdetector(cd) end)
                            end
                        end
                    end
                end
            end
        end
    end
end)

-- GUI
MainTab:CreateToggle({
    Name = "🔄 Auto Buy (без Decoration)",
    CurrentValue = false,
    Callback = function(v) AutoBuy = v end
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

MainTab:CreateToggle({
    Name = "🌟 Auto Evolve",
    CurrentValue = false,
    Callback = function(v) AutoEvolve = v end
})

Rayfield:Notify({
    Title = "✅ v2.4 Загружено",
    Content = "Вернул как было + улучшил Auto Fruit",
    Duration = 5
})
