
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local gui = Instance.new("ScreenGui")
gui.Name = "DongkakPanel"
gui.ResetOnSpawn = false
gui.Parent = playerGui

local blue = Color3.fromRGB(15, 65, 145)
local neon = Color3.fromRGB(40, 145, 255)
local white = Color3.fromRGB(240, 248, 255)

-- Main panel
local panel = Instance.new("Frame")
panel.Size = UDim2.fromOffset(280, 330)
panel.Position = UDim2.new(0.5, -140, 0.5, -165)
panel.BackgroundColor3 = Color3.fromRGB(7, 13, 29)
panel.BorderSizePixel = 0
panel.Parent = gui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 12)
corner.Parent = panel

local stroke = Instance.new("UIStroke")
stroke.Color = neon
stroke.Thickness = 2
stroke.Parent = panel

-- Header
local header = Instance.new("TextLabel")
header.Size = UDim2.new(1, -45, 0, 48)
header.Position = UDim2.fromOffset(12, 4)
header.BackgroundTransparency = 1
header.Text = "DONGKAK"
header.TextColor3 = neon
header.TextSize = 25
header.Font = Enum.Font.GothamBlack
header.Parent = panel

local subtitle = Instance.new("TextLabel")
subtitle.Size = UDim2.new(1, 0, 0, 20)
subtitle.Position = UDim2.fromOffset(0, 44)
subtitle.BackgroundTransparency = 1
subtitle.Text = "GAMING CONTROL PANEL"
subtitle.TextColor3 = white
subtitle.TextSize = 10
subtitle.Font = Enum.Font.GothamBold
subtitle.Parent = panel

-- Minimize button
local minimize = Instance.new("TextButton")
minimize.Size = UDim2.fromOffset(35, 32)
minimize.Position = UDim2.new(1, -40, 0, 8)
minimize.Text = "—"
minimize.TextSize = 22
minimize.TextColor3 = white
minimize.BackgroundColor3 = blue
minimize.Parent = panel

local miniCorner = Instance.new("UICorner")
miniCorner.CornerRadius = UDim.new(0, 8)
miniCorner.Parent = minimize

-- Floating show button
local show = Instance.new("TextButton")
show.Size = UDim2.fromOffset(60, 60)
show.Position = UDim2.new(0, 15, 0.5, -30)
show.Text = "☠"
show.TextSize = 30
show.TextColor3 = neon
show.BackgroundColor3 = Color3.fromRGB(7, 13, 29)
show.Visible = false
show.Parent = gui

local showCorner = Instance.new("UICorner")
showCorner.CornerRadius = UDim.new(1, 0)
showCorner.Parent = show

local showStroke = Instance.new("UIStroke")
showStroke.Color = neon
showStroke.Thickness = 2
showStroke.Parent = show

minimize.Activated:Connect(function()
    panel.Visible = false
    show.Visible = true
end)

show.Activated:Connect(function()
    show.Visible = false
    panel.Visible = true
end)

-- Feature toggle buttons
local states = {
    Aimbot = false,
    SilentAim = false,
    ESP = false,
    DummySupport = true,
}

local function createToggle(name, y)
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(1, -24, 0, 42)
    button.Position = UDim2.fromOffset(12, y)
    button.BackgroundColor3 = blue
    button.TextColor3 = white
    button.TextSize = 14
    button.Font = Enum.Font.GothamBold
    button.Parent = panel

    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, 8)
    c.Parent = button

    local function refresh()
        button.Text = name .. ": " ..
            (states[name] and "ON" or "OFF")
        button.BackgroundColor3 =
            states[name] and Color3.fromRGB(0, 115, 90)
            or blue
    end

    refresh()

    button.Activated:Connect(function()
        states[name] = not states[name]
        refresh()

        -- State flags for your own game's systems
        _G[name .. "Enabled"] = states[name]
        print(name, states[name] and "ON" or "OFF")
    end)
end

createToggle("Aimbot", 78)
createToggle("SilentAim", 128)
createToggle("ESP", 178)
createToggle("DummySupport", 228)

_G.AimbotEnabled = states.Aimbot
_G.SilentAimEnabled = states.SilentAim
_G.ESPEnabled = states.ESP
_G.TargetDummy = states.DummySupport

print("DONGKAK GUI loaded")
