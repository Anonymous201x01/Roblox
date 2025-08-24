-- Funny Animation Script (Auto Give Tool)
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Player = Players.LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()

-- Create the funny tool
local function createFunnyTool()
    local tool = Instance.new("Tool")
    tool.Name = "SecretItem"
    tool.ToolTip = "Hmm... what does this do?"
    tool.RequiresHandle = false
    
    -- Customize the tool appearance
    local part = Instance.new("Part")
    part.Size = Vector3.new(0.5, 0.5, 2)
    part.BrickColor = BrickColor.new("Bright red")
    part.Material = Enum.Material.Neon
    part.Parent = tool
    
    tool.Parent = Player.Backpack
    
    return tool
end

-- Crazy animation function
local function startFunnyAnimation(tool)
    tool.Activated:Connect(function()
        local humanoid = Character:FindFirstChild("Humanoid")
        if not humanoid then return end
        
        -- Get the character's arms
        local rightArm = Character:FindFirstChild("RightHand") or Character:FindFirstChild("Right Arm")
        local leftArm = Character:FindFirstChild("LeftHand") or Character:FindFirstChild("Left Arm")
        
        if rightArm and leftArm then
            -- Save original positions
            local originalRightPos = rightArm.Position
            local originalLeftPos = leftArm.Position
            
            -- Create crazy animation loop
            local stopAnimation = false
            
            -- Function to make arms go crazy
            local function crazyArms()
                while tool.Parent == Character and not stopAnimation do
                    -- Get character's lower body position
                    local humanoidRootPart = Character:FindFirstChild("HumanoidRootPart")
                    local lowerBodyPosition = humanoidRootPart and humanoidRootPart.Position - Vector3.new(0, 2, 0)
                    
                    if lowerBodyPosition then
                        -- Make arms rapidly move around lower body area
                        rightArm.CFrame = CFrame.new(lowerBodyPosition + Vector3.new(
                            math.random(-0.5, 0.5),
                            math.random(-0.3, 0.3),
                            math.random(-0.5, 0.5)
                        ))
                        
                        leftArm.CFrame = CFrame.new(lowerBodyPosition + Vector3.new(
                            math.random(-0.5, 0.5),
                            math.random(-0.3, 0.3),
                            math.random(-0.5, 0.5)
                        ))
                    end
                    
                    wait(0.05) -- Very fast movement
                end
            end
            
            -- Start the animation
            coroutine.wrap(crazyArms)()
            
            -- Reset when tool is unequipped
            tool.Unequipped:Connect(function()
                stopAnimation = true
                
                -- Return arms to original positions
                rightArm.CFrame = CFrame.new(originalRightPos)
                leftArm.CFrame = CFrame.new(originalLeftPos)
            end)
        end
    end)
end

-- Give tool to player automatically
local function giveToolToPlayer()
    -- Wait for backpack to exist
    if not Player:FindFirstChild("Backpack") then
        Player:WaitForChild("Backpack")
    end
    
    -- Create and setup the tool
    local tool = createFunnyTool()
    startFunnyAnimation(tool)
    
    -- Auto-equip the tool
    tool.Parent = Player.Backpack
    tool:WaitForChild("Parent")
    
    -- Try to equip after a short delay
    wait(1)
    if tool.Parent == Player.Backpack then
        tool.Parent = Character
    end
end

-- Run when character exists
if Character then
    giveToolToPlayer()
end

-- Also run when new character spawns
Player.CharacterAdded:Connect(function(newChar)
    Character = newChar
    wait(2) -- Wait for character to fully load
    giveToolToPlayer()
end)

warn("Funny item has been added to your backpack! Equip it to see the effect.")