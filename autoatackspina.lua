local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local humanoidRootPart = character:WaitForChild("HumanoidRootPart")

-- Настройки
local TELEPORT_DISTANCE = 3 -- дистанция за спиной врага
local AUTO_ATTACK_RANGE = 5 -- дистанция автоатаки
local SCAN_RADIUS = 50 -- радиус поиска врагов

-- Состояние
local isActive = false
local currentTarget = nil
local connection = nil

-- === GUI для телефона ===
local screenGui = Instance.new("ScreenGui")
screenGui.Parent = player:WaitForChild("PlayerGui")

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 200, 0, 100)
frame.Position = UDim2.new(0.5, -100, 0.8, 0) -- снизу по центру
frame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
frame.BackgroundTransparency = 0.2
frame.Active = true
frame.Draggable = true
frame.Parent = screenGui

local button = Instance.new("TextButton")
button.Size = UDim2.new(1, -20, 0.5, -10)
button.Position = UDim2.new(0, 10, 0.25, 0)
button.Text = "ВКЛЮЧИТЬ"
button.TextScaled = true
button.BackgroundColor3 = Color3.fromRGB(0, 170, 0)
button.TextColor3 = Color3.fromRGB(255, 255, 255)
button.Font = Enum.Font.SourceSansBold
button.Parent = frame

-- === Функции ===

-- Поиск ближайшего врага
local function findNearestEnemy()
    local closestEnemy, closestDistance
    for _, npc in ipairs(workspace:GetChildren()) do
        if npc:FindFirstChild("Humanoid") and npc.Humanoid.Health > 0 then
            if not npc:FindFirstChild("Player") and npc.Name ~= character.Name then
                local npcRoot = npc:FindFirstChild("HumanoidRootPart") or npc:FindFirstChild("Torso")
                if npcRoot then
                    local dist = (humanoidRootPart.Position - npcRoot.Position).Magnitude
                    if (not closestDistance or dist < closestDistance) and dist <= SCAN_RADIUS then
                        closestEnemy, closestDistance = npc, dist
                    end
                end
            end
        end
    end
    return closestEnemy
end

-- Телепорт за спину врага
local function teleportBehindEnemy(enemy)
    local enemyRoot = enemy:FindFirstChild("HumanoidRootPart") or enemy:FindFirstChild("Torso")
    if not enemyRoot then return end
    humanoidRootPart.CFrame = enemyRoot.CFrame * CFrame.new(0, 0, -TELEPORT_DISTANCE)
end

-- Автоатака
local function autoAttack(enemy)
    local enemyHumanoid = enemy:FindFirstChild("Humanoid")
    if not enemyHumanoid or enemyHumanoid.Health <= 0 then return end
    local enemyRoot = enemy:FindFirstChild("HumanoidRootPart") or enemy:FindFirstChild("Torso")
    if not enemyRoot then return end

    local dist = (humanoidRootPart.Position - enemyRoot.Position).Magnitude
    if dist <= AUTO_ATTACK_RANGE then
        local tool = character:FindFirstChildOfClass("Tool")
        if tool then
            tool:Activate()
        end
    end
end

-- Основной цикл
local function mainLoop()
    if not isActive or not character or humanoid.Health <= 0 then
        currentTarget = nil
        return
    end

    if not currentTarget or not currentTarget:FindFirstChild("Humanoid") or currentTarget.Humanoid.Health <= 0 then
        currentTarget = findNearestEnemy()
        if not currentTarget then return end
    end

    teleportBehindEnemy(currentTarget)
    autoAttack(currentTarget)
end

-- Переключение кнопкой
local function toggleScript()
    isActive = not isActive
    if isActive then
        button.Text = "ВЫКЛЮЧИТЬ"
        button.BackgroundColor3 = Color3.fromRGB(170, 0, 0)
        connection = RunService.Heartbeat:Connect(mainLoop)
    else
        button.Text = "ВКЛЮЧИТЬ"
        button.BackgroundColor3 = Color3.fromRGB(0, 170, 0)
        if connection then connection:Disconnect() connection = nil end
        currentTarget = nil
    end
end

button.MouseButton1Click:Connect(toggleScript)

-- Сброс при смерти
humanoid.Died:Connect(function()
    if connection then connection:Disconnect() connection = nil end
    isActive = false
    currentTarget = nil
    button.Text = "ВКЛЮЧИТЬ"
    button.BackgroundColor3 = Color3.fromRGB(0, 170, 0)
end)

-- Подключение при респавне
player.CharacterAdded:Connect(function(newChar)
    character = newChar
    humanoid = character:WaitForChild("Humanoid")
    humanoidRootPart = character:WaitForChild("HumanoidRootPart")

    humanoid.Died:Connect(function()
        if connection then connection:Disconnect() connection = nil end
        isActive = false
        currentTarget = nil
        button.Text = "ВКЛЮЧИТЬ"
        button.BackgroundColor3 = Color3.fromRGB(0, 170, 0)
    end)
end)

print("Скрипт загружен! Управление через всплывающее окно на экране.")