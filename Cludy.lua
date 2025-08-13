loadstring(game:HttpGet("file:///C:/Users/angel/Desktop/CludyShop/Cludy.lua"))()

-- Crear el menú
local screenGui = Instance.new("ScreenGui")
screenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 200, 0, 150)
mainFrame.Position = UDim2.new(0.5, -100, 0.5, -75)
mainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
mainFrame.BorderSizePixel = 1
mainFrame.BorderColor3 = Color3.fromRGB(50, 50, 50)
mainFrame.Visible = false
mainFrame.Parent = screenGui

local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(1, 0, 0, 30)
titleLabel.Position = UDim2.new(0, 0, 0, 0)
titleLabel.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
titleLabel.Text = "Cludy"
titleLabel.TextSize = 20
titleLabel.Font = Enum.Font.SourceSansBold
titleLabel.Parent = mainFrame

-- Speedboost
local speedLabel = Instance.new("TextLabel")
speedLabel.Size = UDim2.new(1, 0, 0, 30)
speedLabel.Position = UDim2.new(0, 0, 0, 35)
speedLabel.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
speedLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
speedLabel.Text = "Speed Boost: 16"
speedLabel.TextSize = 18
speedLabel.Font = Enum.Font.SourceSans
speedLabel.Parent = mainFrame

local speedSlider = Instance.new("TextButton")
speedSlider.Size = UDim2.new(0.8, 0, 0, 30)
speedSlider.Position = UDim2.new(0.1, 0, 0, 70)
speedSlider.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
speedSlider.BorderSizePixel = 1
speedSlider.BorderColor3 = Color3.fromRGB(75, 75, 75)
speedSlider.Text = ""
speedSlider.Parent = mainFrame

local speedValue = 16
local function updateSpeedLabel()
    speedLabel.Text = "Speed Boost: " .. tostring(speedValue)
end

speedSlider.MouseButton1Down:Connect(function()
    speedValue = speedValue + 1
    updateSpeedLabel()
end)

-- Volar
local flyButton = Instance.new("TextButton")
flyButton.Size = UDim2.new(0.8, 0, 0, 30)
flyButton.Position = UDim2.new(0.1, 0, 0, 110)
flyButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
flyButton.BorderSizePixel = 1
flyButton.BorderColor3 = Color3.fromRGB(75, 75, 75)
flyButton.Text = "Enable Fly"
flyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
flyButton.TextSize = 18
flyButton.Font = Enum.Font.SourceSans
flyButton.Parent = mainFrame

local flying = false
flyButton.MouseButton1Down:Connect(function()
    flying = not flying
    if flying then
        flyButton.Text = "Disable Fly"
    else
        flyButton.Text = "Enable Fly"
    end
end)

-- Tecla para abrir/cerrar el menú
local toggleKey = Enum.KeyCode.LeftControl
local userInputService = game:GetService("UserInputService")

userInputService.InputBegan:Connect(function(input, gameProcessed)
    if not gameProcessed and input.KeyCode == toggleKey then
        mainFrame.Visible = not mainFrame.Visible
    end
end)

-- Opción para cambiar la tecla de toggle
local toggleKeyLabel = Instance.new("TextLabel")
toggleKeyLabel.Size = UDim2.new(1, 0, 0, 30)
toggleKeyLabel.Position = UDim2.new(0, 0, 0, 115)
toggleKeyLabel.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
toggleKeyLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
toggleKeyLabel.Text = "Toggle Key: LeftControl"
toggleKeyLabel.TextSize = 18
toggleKeyLabel.Font = Enum.Font.SourceSans
toggleKeyLabel.Parent = mainFrame

local toggleKeyButton = Instance.new("TextButton")
toggleKeyButton.Size = UDim2.new(0.8, 0, 0, 30)
toggleKeyButton.Position = UDim2.new(0.1, 0, 0, 150)
toggleKeyButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
toggleKeyButton.BorderSizePixel = 1
toggleKeyButton.BorderColor3 = Color3.fromRGB(75, 75, 75)
toggleKeyButton.Text = "Change Toggle Key"
toggleKeyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
toggleKeyButton.TextSize = 18
toggleKeyButton.Font = Enum.Font.SourceSans
toggleKeyButton.Parent = mainFrame

toggleKeyButton.MouseButton1Down:Connect(function()
    userInputService.InputBegan:Connect(function(input, gameProcessed)
        if not gameProcessed then
            toggleKey = input.KeyCode
            toggleKeyLabel.Text = "Toggle Key: " .. tostring(toggleKey)
        end
    end)
end)

-- Aplicar speedboost y vuelo
game:GetService("RunService").Stepped:Connect(function()
    local player = game.Players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()
    local humanoid = character:FindFirstChildOfClass("Humanoid")

    if humanoid then
        humanoid.WalkSpeed = speedValue  -- Aplicar speedboost

        if flying then
            local humanoidRootPart = character:FindFirstChildOfClass("HumanoidRootPart")
            if humanoidRootPart then
                local bodyVelocity = Instance.new("BodyVelocity")
                bodyVelocity.Velocity = Vector3.new(0, 50, 0)  -- Ajusta este valor para cambiar la altura de vuelo
                bodyVelocity.MaxForce = Vector3.new(4000, 4000, 4000)
                bodyVelocity.Parent = humanoidRootPart
            end
        end
    end
end)