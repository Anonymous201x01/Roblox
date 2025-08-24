-- Tornado (educational, use at your own risk)
-- Controls: G toggle, = increase radius, - decrease radius
-- Chat commands: /tornado on|off, /radius <number>

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local lp = Players.LocalPlayer

local enabled = false
local radius = 12          -- стартовый радиус
local minR, maxR = 4, 60   -- пределы
local scanRange = 120      -- искать детали в этом радиусе от тебя
local angularSpeed = 2.2   -- рад/сек
local targets = {}

local function clamp(n, a, b) if n < a then return a elseif n > b then return b else return n end end

-- Фаза для каждой детали (число из GetDebugId)
local function phase(part)
    local id = part:GetDebugId()
    local n = tonumber(id:match("%d+")) or 0
    return (n % 628) / 100 -- 0..6.28
end

-- Фильтр: берем только реальные физические детали, не Anchored, не твой персонаж, не игроки
local function eligible(part, myChar)
    if not part:IsA("BasePart") then return false end
    if part.Anchored then return false end
    if part.Parent == myChar then return false end
    -- не трогаем живых игроков (NPC можно, но игрокам бессмысленно — не реплицируется)
    local hum = part.Parent and part.Parent:FindFirstChildOfClass("Humanoid")
    if hum and Players:GetPlayerFromCharacter(part.Parent) then return false end
    return true
end

-- Переиндексация целей раз в 0.5 сек (чтоб не грузить)
task.spawn(function()
    while true do
        task.wait(0.5)
        local char = lp.Character
        local hrp = char and char:FindFirstChild("HumanoidRootPart")
        if not hrp then targets = {} continue end
        local origin = hrp.Position

        local newTargets = {}
        for _, d in ipairs(workspace:GetDescendants()) do
            if eligible(d, char) then
                local dist = (d.Position - origin).Magnitude
                if dist <= scanRange then
                    newTargets[#newTargets+1] = d
                end
            end
        end
        targets = newTargets
    end
end)

-- Управление с клавы
UIS.InputBegan:Connect(function(input, gp)
    if gp then return end
    if input.KeyCode == Enum.KeyCode.G then
        enabled = not enabled
        print("Tornado:", enabled and "ON" or "OFF")
    elseif input.KeyCode == Enum.KeyCode.Equals then
        radius = clamp(radius + 2, minR, maxR)
        print("Radius:", radius)
    elseif input.KeyCode == Enum.KeyCode.Minus then
        radius = clamp(radius - 2, minR, maxR)
        print("Radius:", radius)
    end
end)

-- Команды через чат (удобно на телефоне)
lp.Chatted:Connect(function(msg)
    msg = msg:lower()
    if msg == "/tornado on" then enabled = true; print("Tornado: ON") return end
    if msg == "/tornado off" then enabled = false; print("Tornado: OFF") return end
    local r = msg:match("^/radius%s+(%d+)$")
    if r then
        radius = clamp(tonumber(r), minR, maxR)
        print("Radius:", radius)
    end
end)

-- Основной цикл
RunService.Heartbeat:Connect(function(dt)
    if not enabled then return end
    local char = lp.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end

    local base = tick() * angularSpeed
    local origin = hrp.Position

    for _, p in ipairs(targets) do
        if p and p.Parent and not p.Anchored then
            local ang = base + phase(p)
            local targetPos = Vector3.new(
                origin.X + math.cos(ang) * radius,
                origin.Y,
                origin.Z + math.sin(ang) * radius
            )
            -- небольшой подброс, чтобы не залипали
            p.AssemblyLinearVelocity = Vector3.new(0, 6, 0)
            -- безопасно пробуем задать позицию
            pcall(function()
                p.CFrame = CFrame.new(targetPos, origin)
            end)
        end
    end
end)

print("[Tornado] loaded. Press G or type /tornado on")
