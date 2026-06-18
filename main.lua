--// phimkok Hub v3.4 - Sell Lemons
-- Created by phimkok

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

Rayfield.Theme = {
    Default = Color3.fromRGB(20, 25, 45),
    TextColor = Color3.fromRGB(230, 245, 255),
    MainColor = Color3.fromRGB(35, 75, 155),
    AccentColor = Color3.fromRGB(70, 150, 255),
}

local Window = Rayfield:CreateWindow({
    Name = "phimkok Hub - Sell Lemons",
    LoadingTitle = "phimkok Hub",
    LoadingSubtitle = "v3.4 | Full Features",
    ConfigurationSaving = { Enabled = false },
    KeySystem = false
})

local MainTab = Window:CreateTab("Main", 4483362458)
local FarmTab = Window:CreateTab("Farm", 4483362458)
local ExtraTab = Window:CreateTab("Extra", 4483362458)

local userTycoon = workspace:FindFirstChild("Tycoon2")

local AutoBuy = false
local AutoClick = false
local AutoUpgrade = false
local AutoFruit = false
local AutoRebirth = false
local AutoEvolve = false

-- Auto Buy without Decoration
local function buyAllNoDecoration()
    local purchases = userTycoon and userTycoon:FindFirstChild("Purchases")
    if not purchases then return end
    for _, obj in ipairs(purchases:GetDescendants()) do
        if obj:IsA("Model") then
            local name = obj.Name:lower()
            if name:find("decoration") or name:find("decor") then continue end
            if obj:GetAttribute("Shown") and not obj:GetAttribute("Purchased") then
                local purchase = obj:FindFirstChild("Purchase")
                if purchase then pcall(function() purchase:InvokeServer() end) end
            end
        end
    end
end

-- Auto Click
task.spawn(function()
    while true do
        task.wait(0.05)
        if AutoClick then
            for _, v in ipairs(workspace:GetDescendants()) do
                if v.Name == "CLICK" or v.Name:find("Click") then
                    local cd = v:FindFirstChildOfClass("ClickDetector")
                    if cd then pcall(function() fireclickdetector(cd) end) end
                end
            end
        end
    end
end)

-- Auto Upgrade
task.spawn(function()
    while true do
        task.wait(0.4)
        if AutoUpgrade then
            for _, v in ipairs(workspace:GetDescendants()) do
                if v.Name == "Upgrade" or v.Name:find("Upgrade") then
                    local cd = v:FindFirstChildOfClass("ClickDetector")
                    if cd then pcall(function() fireclickdetector(cd) end) end
                end
            end
        end
    end
end)

-- Auto Fruit
task.spawn(function()
    while true do
        task.wait(0.25)
        if AutoFruit then
            for _, tree in ipairs(workspace:GetDescendants()) do
                if tree.Name == "LemonTree" then
                    for _, fruit in ipairs(tree:GetDescendants()) do
                        if fruit.Name == "Fruit" and fruit:FindFirstChild("ClickPart") then
                            local cd = fruit.ClickPart:FindFirstChildOfClass("ClickDetector")
                            if cd then pcall(function() fireclickdetector(cd) end) end
                        end
                    end
                end
            end
        end
    end
end)

-- GUI
MainTab:CreateToggle({Name = "Auto Buy (No Decoration)", CurrentValue = false, Callback = function(v) AutoBuy = v end})
MainTab:CreateToggle({Name = "Auto Click", CurrentValue = false, Callback = function(v) AutoClick = v end})
MainTab:CreateToggle({Name = "Auto Upgrade", CurrentValue = false, Callback = function(v) AutoUpgrade = v end})

FarmTab:CreateToggle({Name = "Auto Fruit", CurrentValue = false, Callback = function(v) AutoFruit = v end})
MainTab:CreateToggle({Name = "Auto Rebirth", CurrentValue = false, Callback = function(v) AutoRebirth = v end})
MainTab:CreateToggle({Name = "Auto Evolve", CurrentValue = false, Callback = function(v) AutoEvolve = v end})

Rayfield:Notify({Title = "phimkok Hub v3.4", Content = "Full version loaded!", Duration = 5})
