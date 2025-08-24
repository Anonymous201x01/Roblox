-- Advanced NoClip Script with Stealth Techniques
-- GUI Version with Adaptive Bypass Methods

local Player = game:GetService("Players").LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")
local RootPart = Character:WaitForChild("HumanoidRootPart")

-- Stealth settings
local StealthMode = {
    Enabled = true,
    MaxSpeed = 25, -- Maximum movement speed to avoid detection
    SmoothTransitions = true,
    AntiTeleportBack = true,
    FakeCollision = false -- Simulate collision in certain cases
}

-- Adaptive bypass methods
local BypassMethods = {
    "CFrameSmooth",
    "VelocityControl", 
    "HybridApproach",
    "StealthWalk"
}

local CurrentMethod = "HybridApproach"
local NoClipEnabled = false

-- Create stealth GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "StealthMovement"
ScreenGui.Parent = game:GetService("CoreGui")
ScreenGui.ResetOnSpawn = false

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 320, 0, 250)
MainFrame.Position = UDim2.new(0.5, -160, 0.5, -125)
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 35)
Title.Position = UDim2.new(0, 0, 0, 0)
Title.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
Title.TextColor3 = Color3.fromRGB(200, 200, 255)
Title.Text = "Stealth Movement Control"
Title.Font = Enum.Font.GothamBold
Title.Parent = MainFrame

local ToggleButton = Instance.new("TextButton")
ToggleButton.Size = UDim2.new(0.85, 0, 0, 45)
ToggleButton.Position = UDim2.new(0.075, 0, 0.18, 0)
ToggleButton.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
ToggleButton.TextColor3 = Color3.fromRGB(200, 200, 255)
ToggleButton.Text = "Enable Stealth Walk (N)"
ToggleButton.Font = Enum.Font.Gotham
ToggleButton.Parent = MainFrame

local StatusLabel = Instance.new("TextLabel")
StatusLabel.Size = UDim2.new(0.85, 0, 0, 30)
StatusLabel.Position = UDim2.new(0.075, 0, 0.42, 0)
StatusLabel.BackgroundTransparency = 1
StatusLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
StatusLabel.Text = "Status: Disabled"
StatusLabel.Font = Enum.Font.Gotham
StatusLabel.Parent = MainFrame

local MethodLabel = Instance.new("TextLabel")
MethodLabel.Size = UDim2.new(0.85, 0, 0, 30)
MethodLabel.Position = UDim2.new(0.075, 0, 0.58, 0)
MethodLabel.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
MethodLabel.TextColor3 = Color3.fromRGB(200, 200, 255)
MethodLabel.Text = "Method: HybridApproach"
MethodLabel.Font = Enum.Font.Gotham
MethodLabel.Parent = MainFrame

local SpeedLabel = Instance.new("TextLabel")
SpeedLabel.Size = UDim2.new(0.85, 0, 0, 25)
SpeedLabel.Position = UDim2.new(0.075, 0, 0.75, 0)
SpeedLabel.BackgroundTransparency = 1
SpeedLabel.TextColor3 = Color3.fromRGB(150, 150, 200)
SpeedLabel.Text = "Max Speed: " .. StealthMode.MaxSpeed
SpeedLabel.Font = Enum.Font.Gotham
SpeedLabel.TextSize = 12
SpeedLabel.Parent = MainFrame

local CloseButton = Instance.new("TextButton")
CloseButton.Size = UDim2.new(0, 25, 0, 25)
CloseButton.Position = UDim2.new(1, -25, 0, 0)
CloseButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.Text = "X"
CloseButton.Font = Enum.Font.GothamBold
CloseButton.Parent = MainFrame

-- Advanced stealth techniques
local function ApplyStealthTechniques()
    if not NoClipEnabled or not Character or not RootPart then return end
    
    local lastValidPosition = RootPart.CFrame
    local lastUpdate = tick()
    local movementBuffer = {}
    
    while NoClipEnabled and Character and RootPart and Character:IsDescendantOf(workspace) do
        local currentTime = tick()
        local deltaTime = currentTime - lastUpdate
        
        -- Method-specific implementations
        if CurrentMethod == "CFrameSmooth" then
            -- Smooth CFrame adjustment with velocity control
            local currentCFrame = RootPart.CFrame
            RootPart.Velocity = Vector3.new(0, 0, 0)
            RootPart.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
            
            -- Simulate natural movement patterns
            if StealthMode.SmoothTransitions then
                task.wait(0.01)
                if RootPart and RootPart:IsDescendantOf(workspace) then
                    RootPart.CFrame = currentCFrame
                end
            end
            
        elseif CurrentMethod == "VelocityControl" then
            -- Controlled velocity approach
            RootPart.Velocity = Vector3.new(0, 0, 0)
            RootPart.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
            
            -- Occasionally allow small velocity for realism
            if math.random(1, 20) == 1 then
                RootPart.Velocity = Vector3.new(
                    math.random(-2, 2),
                    math.random(-1, 1),
                    math.random(-2, 2)
                )
            end
            
        elseif CurrentMethod == "HybridApproach" then
            -- Combination of methods
            local currentCFrame = RootPart.CFrame
            
            -- Control physics properties
            RootPart.Velocity = Vector3.new(0, 0, 0)
            RootPart.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
            RootPart.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
            
            -- Smooth position maintenance
            if StealthMode.SmoothTransitions then
                task.wait(0.015)
                if RootPart and RootPart:IsDescendantOf(workspace) then
                    RootPart.CFrame = currentCFrame
                end
            end
            
        elseif CurrentMethod == "StealthWalk" then
            -- Most stealthy approach with randomized patterns
            RootPart.Velocity = Vector3.new(0, 0, 0)
            
            -- Simulate occasional micro-movements
            if math.random(1, 15) == 1 then
                RootPart.CFrame = RootPart.CFrame + Vector3.new(
                    math.random(-0.1, 0.1),
                    0,
                    math.random(-0.1, 0.1)
                )
            end
        end
        
        -- Disable collision for all parts (local effect only)
        for _, part in pairs(Character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = false
                part.Massless = true -- Reduce physics impact
            end
        end
        
        -- Speed limiting to avoid detection
        if StealthMode.MaxSpeed > 0 and RootPart.Velocity.Magnitude > StealthMode.MaxSpeed then
            RootPart.Velocity = RootPart.Velocity.Unit * StealthMode.MaxSpeed
        end
        
        -- Anti-teleport back technique
        if StealthMode.AntiTeleportBack then
            lastValidPosition = RootPart.CFrame
            table.insert(movementBuffer, {time = currentTime, position = lastValidPosition})
            
            -- Keep only recent movements
            while #movementBuffer > 0 and currentTime - movementBuffer[1].time > 2 do
                table.remove(movementBuffer, 1)
            end
        end
        
        lastUpdate = currentTime
        game:GetService("RunService").Stepped:Wait()
    end
end

-- Toggle function
local function ToggleStealthWalk()
    NoClipEnabled = not NoClipEnabled
    
    if NoClipEnabled then
        ToggleButton.Text = "Disable Stealth Walk (N)"
        ToggleButton.BackgroundColor3 = Color3.fromRGB(70, 150, 70)
        StatusLabel.Text = "Status: Active"
        StatusLabel.TextColor3 = Color3.fromRGB(100, 255, 100)
        
        -- Start stealth thread
        coroutine.wrap(ApplyStealthTechniques)()
    else
        ToggleButton.Text = "Enable Stealth Walk (N)"
        ToggleButton.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
        StatusLabel.Text = "Status: Disabled"
        StatusLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
        
        -- Restore physics properties
        if Character then
            for _, part in pairs(Character:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = true
                    part.Massless = false
                end
            end
        end
    end
end

-- GUI Events
ToggleButton.MouseButton1Click:Connect(ToggleStealthWalk)

CloseButton.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
    NoClipEnabled = false
end)

-- Method cycling
MethodLabel.MouseButton1Click:Connect(function()
    local currentIndex = table.find(BypassMethods, CurrentMethod) or 1
    local nextIndex = currentIndex % #BypassMethods + 1
    CurrentMethod = BypassMethods[nextIndex]
    MethodLabel.Text = "Method: " .. CurrentMethod
end)

-- Speed adjustment
SpeedLabel.MouseButton1Click:Connect(function()
    StealthMode.MaxSpeed = StealthMode.MaxSpeed + 5
    if StealthMode.MaxSpeed > 50 then
        StealthMode.MaxSpeed = 15
    end
    SpeedLabel.Text = "Max Speed: " .. StealthMode.MaxSpeed
end)

-- Keyboard control
local UIS = game:GetService("UserInputService")
UIS.InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.N and not UIS:GetFocusedTextBox() then
        ToggleStealthWalk()
    end
end)

-- Character respawn handling
Player.CharacterAdded:Connect(function(newChar)
    Character = newChar
    Humanoid = newChar:WaitForChild("Humanoid")
    RootPart = newChar:WaitForChild("HumanoidRootPart")
    
    if NoClipEnabled then
        task.wait(1) -- Wait for character to fully load
        coroutine.wrap(ApplyStealthTechniques)()
    end
end)

-- Auto-cleanup if character is removed
Character.AncestryChanged:Connect(function()
    if not Character:IsDescendantOf(workspace) then
        NoClipEnabled = false
    end
end)

warn("Stealth Movement System Loaded! Press N to toggle.")
warn("Click on Method to cycle through different stealth approaches")
warn("Click on Speed to adjust maximum movement speed")
