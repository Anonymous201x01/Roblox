--// Торнадо-скрипт для Roblox
--// Работает только через Executor (Delta и т.п.)

-- Настройки
local enabled = false -- начальное состояние
local radius = 10 -- радиус вращения

-- UI для управления (кнопка + ползунок)
local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local Toggle = Instance.new("TextButton")
local Slider = Instance.new("TextButton")

ScreenGui.Parent = game.CoreGui
Frame.Parent = ScreenGui
Frame.Size = UDim2.new(0,200,0,100)
Frame.Position = UDim2.new(0.05,0,0.05,0)
Frame.BackgroundColor3 = Color3.fromRGB(30,30,30)
Frame.Active = true
Frame.Draggable = true

Toggle.Parent = Frame
Toggle.Size = UDim2.new(0,180,0,40)
Toggle.Position = UDim2.new(0,10,0,10)
Toggle.Text = "Торнадо: OFF"
Toggle.BackgroundColor3 = Color3.fromRGB(60,60,60)

Slider.Parent = Frame
Slider.Size = UDim2.new(0,180,0,40)
Slider.Position = UDim2.new(0,10,0,55)
Slider.Text = "Радиус: "..radius
Slider.BackgroundColor3 = Color3.fromRGB(60,60,60)

-- Логика переключения
Toggle.MouseButton1Click:Connect(function()
    enabled = not enabled
    Toggle.Text = enabled and "Торнадо: ON" or "Торнадо: OFF"
end)

-- Логика изменения радиуса (по кликам)
Slider.MouseButton1Click:Connect(function()
    radius = radius + 5
    if radius > 50 then radius = 5 end
    Slider.Text = "Радиус: "..radius
end)

-- Основной цикл торнадо
task.spawn(function()
    local angle = 0
    while true do
        task.wait(0.05)
        if enabled then
            angle += 0.2
            local root = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
            if root then
                for _,obj in pairs(workspace:GetDescendants()) do
                    if obj:IsA("BasePart") and not obj.Anchored and obj.Parent ~= game.Players.LocalPlayer.Character then
                        local x = root.Position.X + math.cos(angle + obj:GetDebugId()) * radius
                        local z = root.Position.Z + math.sin(angle + obj:GetDebugId()) * radius
                        local y = root.Position.Y
                        obj.Velocity = Vector3.new(0,20,0) -- чуть вверх
                        obj.CFrame = CFrame.new(Vector3.new(x,y,z))
                    end
                end
            end
        end
    end
end)