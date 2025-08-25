-- Скрипт для эксплойта (Delta/Xeno/Synapse)

-- GUI
local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local ToggleButton = Instance.new("TextButton")
local CloseButton = Instance.new("TextButton")

ScreenGui.Parent = game.CoreGui

Frame.Size = UDim2.new(0, 200, 0, 100)
Frame.Position = UDim2.new(0.4, 0, 0.3, 0)
Frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
Frame.Active = true
Frame.Draggable = true
Frame.Parent = ScreenGui

ToggleButton.Size = UDim2.new(0.7, 0, 0.6, 0)
ToggleButton.Position = UDim2.new(0.05, 0, 0.2, 0)
ToggleButton.Text = "Гравитация: ВКЛ"
ToggleButton.TextColor3 = Color3.new(1, 1, 1)
ToggleButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
ToggleButton.Parent = Frame

CloseButton.Size = UDim2.new(0.2, 0, 0.3, 0)
CloseButton.Position = UDim2.new(0.75, 0, 0.05, 0)
CloseButton.Text = "X"
CloseButton.TextColor3 = Color3.new(1, 0, 0)
CloseButton.BackgroundColor3 = Color3.fromRGB(80, 0, 0)
CloseButton.Parent = Frame

-- Логика
local player = game.Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local hrp = char:WaitForChild("HumanoidRootPart")

local gravityOff = false
local bf = Instance.new("BodyForce")
bf.Force = Vector3.zero

local function toggle()
    gravityOff = not gravityOff
    if gravityOff then
        bf.Force = Vector3.new(0, workspace.Gravity * hrp.AssemblyMass, 0)
        bf.Parent = hrp
        ToggleButton.Text = "Гравитация: ВЫКЛ"
    else
        bf.Parent = nil
        ToggleButton.Text = "Гравитация: ВКЛ"
    end
end

ToggleButton.MouseButton1Click:Connect(toggle)
CloseButton.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

-- На случай респавна
player.CharacterAdded:Connect(function(nChar)
    char = nChar
    hrp = char:WaitForChild("HumanoidRootPart")
    if gravityOff then
        bf.Parent = hrp
    end
end)