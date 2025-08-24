-- Instant Teleport Forward Script (Mobile)
local Player = game:GetService("Players").LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()
local RootPart = Character:WaitForChild("HumanoidRootPart")

-- Create simple mobile GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "MobileTeleportGUI"
ScreenGui.Parent = game:GetService("CoreGui")
ScreenGui.ResetOnSpawn = false

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 180, 0, 100)
MainFrame.Position = UDim2.new(0, 20, 0.7, -50)
MainFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

local TeleportButton = Instance.new("TextButton")
TeleportButton.Size = UDim2.new(0.8, 0, 0, 50)
TeleportButton.Position = UDim2.new(0.1, 0, 0.2, 0)
TeleportButton.BackgroundColor3 = Color3.fromRGB(60, 160, 60)
TeleportButton.TextColor3 = Color3.fromRGB(255, 255, 255)
TeleportButton.Text = "📲 TELEPORT"
TeleportButton.Font = Enum.Font.GothamBold
TeleportButton.TextSize = 16
TeleportButton.Parent = MainFrame

local CloseButton = Instance.new("TextButton")
CloseButton.Size = UDim2.new(0, 30, 0, 30)
CloseButton.Position = UDim2.new(1, -30, 0, 0)
CloseButton.BackgroundColor3 = Color3.fromRGB(255, 60, 60)
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.Text = "X"
CloseButton.Font = Enum.Font.GothamBold
CloseButton.Parent = MainFrame

-- Instant teleport function
local function InstantTeleport()
    if not Character or not RootPart then return end
    
    -- Calculate 5 steps forward (approximately 10-12 studs)
    local teleportDistance = 12
    local forwardDirection = RootPart.CFrame.LookVector
    local currentPosition = RootPart.Position
    local targetPosition = currentPosition + (forwardDirection * teleportDistance)
    
    -- Create new CFrame looking in the same direction
    local newCFrame = CFrame.new(targetPosition, targetPosition + forwardDirection)
    
    -- Instant teleport
    RootPart.CFrame = newCFrame
    
    -- Visual feedback
    TeleportButton.Text = "✅ TELEPORTED"
    TeleportButton.BackgroundColor3 = Color3.fromRGB(80, 180, 80)
    
    -- Reset button after 1 second
    task.delay(1, function()
        if TeleportButton then
            TeleportButton.Text = "📲 TELEPORT"
            TeleportButton.BackgroundColor3 = Color3.fromRGB(60, 160, 60)
        end
    end)
end

-- Button click event
TeleportButton.MouseButton1Click:Connect(function()
    InstantTeleport()
end)

-- Close button
CloseButton.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

-- Character respawn handling
Player.CharacterAdded:Connect(function(newChar)
    Character = newChar
    RootPart = newChar:WaitForChild("HumanoidRootPart")
end)

warn("Mobile Teleport Script Loaded! Tap the green button to teleport.")
