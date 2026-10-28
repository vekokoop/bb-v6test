-- BlockSpin Pro Hub - Ultimate Edition V6 (Bulletproof Pawn & Shop Filter)
if not game:IsLoaded() then
    game.Loaded:Wait()
end

local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local LocalPlayer = Players.LocalPlayer
local Camera = Workspace.CurrentCamera

local GUI_Parent = gethui and gethui() or CoreGui

local queue_func = queue_on_teleport or (syn and syn.queue_on_teleport) or (fluxus and fluxus.queue_on_teleport)
if queue_func then
    queue_func([[
        loadstring(game:HttpGet("https://raw.githubusercontent.com/vekokoop/bb-v6c/refs/heads/main/script.lua"))()
    ]])
end

if GUI_Parent:FindFirstChild("BlockSpinSilentESP") then
    GUI_Parent.BlockSpinSilentESP:Destroy()
end

local SilentFOV_Radius = 100
local AimbotFOV_Radius = 100

local silentFovCircle = Drawing.new("Circle")
silentFovCircle.Visible = false
silentFovCircle.Radius = SilentFOV_Radius
silentFovCircle.Filled = false
silentFovCircle.Color = Color3.fromRGB(255, 69, 0)
silentFovCircle.Thickness = 1.5
silentFovCircle.Transparency = 0.7

local aimbotFovCircle = Drawing.new("Circle")
aimbotFovCircle.Visible = false
aimbotFovCircle.Radius = AimbotFOV_Radius
aimbotFovCircle.Filled = false
aimbotFovCircle.Color = Color3.fromRGB(0, 191, 255)
aimbotFovCircle.Thickness = 1.5
aimbotFovCircle.Transparency = 0.7

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "BlockSpinSilentESP"
ScreenGui.Parent = GUI_Parent
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.ResetOnSpawn = false

local FloatingIcon = Instance.new("TextButton")
FloatingIcon.Name = "FloatingIcon"
FloatingIcon.Parent = ScreenGui
FloatingIcon.BackgroundColor3 = Color3.fromRGB(15, 15, 22)
FloatingIcon.Position = UDim2.new(0, 35, 0, 150)
FloatingIcon.Size = UDim2.new(0, 54, 0, 54)
FloatingIcon.Font = Enum.Font.SourceSansBold
FloatingIcon.Text = "🎯"
FloatingIcon.TextColor3 = Color3.fromRGB(255, 69, 0)
FloatingIcon.TextSize = 26

local IconCorner = Instance.new("UICorner")
IconCorner.CornerRadius = UDim.new(1, 0)
IconCorner.Parent = FloatingIcon

local IconStroke = Instance.new("UIStroke")
IconStroke.Color = Color3.fromRGB(255, 69, 0)
IconStroke.Thickness = 2.5
IconStroke.Parent = FloatingIcon

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(18, 18, 25)
MainFrame.Position = UDim2.new(0.5, -170, 0.5, -200)
MainFrame.Size = UDim2.new(0, 340, 0, 450)
MainFrame.Visible = false

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 16)
MainCorner.Parent = MainFrame

local MainStroke = Instance.new("UIStroke")
MainStroke.Color = Color3.fromRGB(255, 69, 0)
MainStroke.Thickness = 2
MainStroke.Parent = MainFrame

local TopBar = Instance.new("Frame")
TopBar.Name = "TopBar"
TopBar.Parent = MainFrame
TopBar.BackgroundColor3 = Color3.fromRGB(24, 24, 35)
TopBar.Size = UDim2.new(1, 0, 0, 48)

local TopCorner = Instance.new("UICorner")
TopCorner.CornerRadius = UDim.new(0, 16)
TopCorner.Parent = TopBar

local Title = Instance.new("TextLabel")
Title.Parent = TopBar
Title.BackgroundTransparency = 1
Title.Position = UDim2.new(0, 18, 0, 0)
Title.Size = UDim2.new(0.7, 0, 1, 0)
Title.Font = Enum.Font.SourceSansBold
Title.Text = "BLOCKSPIN | Pro Hub V6"
Title.TextColor3 = Color3.fromRGB(255, 69, 0)
Title.TextSize = 15
Title.TextXAlignment = Enum.TextXAlignment.Left

local CloseXBtn = Instance.new("TextButton")
CloseXBtn.Parent = TopBar
CloseXBtn.BackgroundColor3 = Color3.fromRGB(220, 50, 50)
CloseXBtn.Position = UDim2.new(1, -38, 0.5, -13)
CloseXBtn.Size = UDim2.new(0, 26, 0, 26)
CloseXBtn.Font = Enum.Font.SourceSansBold
CloseXBtn.Text = "X"
CloseXBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseXBtn.TextSize = 13
CloseXBtn.AutoButtonColor = false

local XCorner = Instance.new("UICorner")
XCorner.CornerRadius = UDim.new(1, 0)
XCorner.Parent = CloseXBtn

local Container = Instance.new("ScrollingFrame")
Container.Parent = MainFrame
Container.BackgroundTransparency = 1
Container.Position = UDim2.new(0, 0, 0, 55)
Container.Size = UDim2.new(1, 0, 1, -65)
Container.CanvasSize = UDim2.new(0, 0, 0, 0)
Container.ScrollBarThickness = 4

local UIList = Instance.new("UIListLayout")
UIList.Parent = Container
UIList.HorizontalAlignment = Enum.HorizontalAlignment.Center
UIList.SortOrder = Enum.SortOrder.LayoutOrder
UIList.Padding = UDim.new(0, 10)

local UIPad = Instance.new("UIPadding")
UIPad.Parent = Container
UIPad.PaddingTop = UDim.new(0, 5)

local function createFeatureToggle(name, desc)
    local btn = Instance.new("TextButton")
    btn.Parent = Container
    btn.BackgroundColor3 = Color3.fromRGB(26, 26, 36)
    btn.Size = UDim2.new(0.9, 0, 0, 50)
    btn.Font = Enum.Font.SourceSansBold
    btn.Text = ""
    btn.AutoButtonColor = false

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 12)
    corner.Parent = btn

    local stroke = Instance.new("UIStroke")
    stroke.Color = Color3.fromRGB(50, 50, 70)
    stroke.Thickness = 1.2
    stroke.Parent = btn

    local nameLabel = Instance.new("TextLabel")
    nameLabel.Parent = btn
    nameLabel.BackgroundTransparency = 1
    nameLabel.Position = UDim2.new(0, 16, 0, 7)
    nameLabel.Size = UDim2.new(0.7, 0, 0, 18)
    nameLabel.Font = Enum.Font.SourceSansBold
    nameLabel.Text = name
    nameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    nameLabel.TextSize = 14
    nameLabel.TextXAlignment = Enum.TextXAlignment.Left

    local statusLabel = Instance.new("TextLabel")
    statusLabel.Parent = btn
    statusLabel.BackgroundTransparency = 1
    statusLabel.Position = UDim2.new(0, 16, 0, 25)
    statusLabel.Size = UDim2.new(0.7, 0, 0, 16)
    statusLabel.Font = Enum.Font.SourceSans
    statusLabel.Text = "Status: [ OFF ]"
    statusLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
    statusLabel.TextSize = 12
    statusLabel.TextXAlignment = Enum.TextXAlignment.Left

    return btn, statusLabel, stroke
end

local function createFovControl(labelText, initialVal, onMinus, onPlus)
    local frame = Instance.new("Frame")
    frame.Parent = Container
    frame.BackgroundColor3 = Color3.fromRGB(22, 22, 30)
    frame.Size = UDim2.new(0.9, 0, 0, 40)

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 10)
    corner.Parent = frame

    local stroke = Instance.new("UIStroke")
    stroke.Color = Color3.fromRGB(40, 40, 55)
    stroke.Thickness = 1
    stroke.Parent = frame

    local label = Instance.new("TextLabel")
    label.Parent = frame
    label.BackgroundTransparency = 1
    label.Position = UDim2.new(0, 14, 0, 0)
    label.Size = UDim2.new(0.5, 0, 1, 0)
    label.Font = Enum.Font.SourceSansBold
    label.Text = labelText .. ": " .. initialVal
    label.TextColor3 = Color3.fromRGB(200, 200, 200)
    label.TextSize = 13
    label.TextXAlignment = Enum.TextXAlignment.Left

    local minusBtn = Instance.new("TextButton")
    minusBtn.Parent = frame
    minusBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 48)
    minusBtn.Position = UDim2.new(1, -74, 0.5, -13)
    minusBtn.Size = UDim2.new(0, 26, 0, 26)
    minusBtn.Font = Enum.Font.SourceSansBold
    minusBtn.Text = "-"
    minusBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    minusBtn.TextSize = 16
    local minusCorner = Instance.new("UICorner"); minusCorner.CornerRadius = UDim.new(0, 6); minusCorner.Parent = minusBtn

    local plusBtn = Instance.new("TextButton")
    plusBtn.Parent = frame
    plusBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 48)
    plusBtn.Position = UDim2.new(1, -40, 0.5, -13)
    plusBtn.Size = UDim2.new(0, 26, 0, 26)
    plusBtn.Font = Enum.Font.SourceSansBold
    plusBtn.Text = "+"
    plusBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    plusBtn.TextSize = 16
    local plusCorner = Instance.new("UICorner"); plusCorner.CornerRadius = UDim.new(0, 6); plusCorner.Parent = plusBtn

    minusBtn.Activated:Connect(function()
        local newVal = onMinus()
        label.Text = labelText .. ": " .. newVal
    end)
    plusBtn.Activated:Connect(function()
        local newVal = onPlus()
        label.Text = labelText .. ": " .. newVal
    end)
    return frame
end

local SilentAimBtn, SilentStatus, SilentStroke = createFeatureToggle("Silent Aim", "تصويب صامت")
createFovControl("Silent FOV", SilentFOV_Radius, 
    function() if SilentFOV_Radius > 30 then SilentFOV_Radius = SilentFOV_Radius - 15 end silentFovCircle.Radius = SilentFOV_Radius return SilentFOV_Radius end,
    function() if SilentFOV_Radius < 300 then SilentFOV_Radius = SilentFOV_Radius + 15 end silentFovCircle.Radius = SilentFOV_Radius return SilentFOV_Radius end
)

local AimbotBtn, AimbotStatus, AimbotStroke = createFeatureToggle("Aimbot", "أيم بوت بقفل ثابت داخل الدائرة")
createFovControl("Aimbot FOV", AimbotFOV_Radius,
    function() if AimbotFOV_Radius > 30 then AimbotFOV_Radius = AimbotFOV_Radius - 15 end aimbotFovCircle.Radius = AimbotFOV_Radius return AimbotFOV_Radius end,
    function() if AimbotFOV_Radius < 300 then AimbotFOV_Radius = AimbotFOV_Radius + 15 end aimbotFovCircle.Radius = AimbotFOV_Radius return AimbotFOV_Radius end
)

local EspBtn, EspStatus, EspStroke = createFeatureToggle("Players ESP", "تلوين أجسام اللاعبين فقط")
local AutoLootBtn, AutoLootStatus, AutoLootStroke = createFeatureToggle("Auto Loot", "التقاط الغنائم باللمس الواقعي")

UIList:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    Container.CanvasSize = UDim2.new(0, 0, 0, UIList.AbsoluteContentSize.Y + 20)
end)

local function toggleMenu() MainFrame.Visible = not MainFrame.Visible end
FloatingIcon.Activated:Connect(toggleMenu)
CloseXBtn.Activated:Connect(toggleMenu)

local function setupFeatureLogic(button, statusLabel, stroke, callback)
    local state = false
    button.Activated:Connect(function()
        state = not state
        if state then
            statusLabel.Text = "Status: [ ACTIVE ]"
            statusLabel.TextColor3 = Color3.fromRGB(255, 69, 0)
            stroke.Color = Color3.fromRGB(255, 69, 0)
            task.spawn(function() callback(true) end)
        else
            statusLabel.Text = "Status: [ OFF ]"
            statusLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
            stroke.Color = Color3.fromRGB(50, 50, 70)
            callback(false)
        end
    end)
end

local silentEnabled = false
local aimbotEnabled = false
local autoLootEnabled = false
local currentLockedTarget = nil
local cachedSilentTarget = nil

local function getClosestSilentTarget()
    local closest = nil
    local shortest = silentFovCircle.Radius
    local mouse = UserInputService:GetMouseLocation()
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("Humanoid") and p.Character.Humanoid.Health > 0 then
            local part = math.random(1, 10) <= 3 and p.Character:FindFirstChild("Head") or p.Character:FindFirstChild("HumanoidRootPart")
            if part then
                local pos, onScreen = Camera:WorldToViewportPoint(part.Position)
                if onScreen then
                    local dist = (Vector2.new(pos.X, pos.Y) - mouse).Magnitude
                    if dist < shortest then shortest = dist; closest = part end
                end
            end
        end
    end
    return closest
end

local function getClosestAimbotTarget()
    local camCenter = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
    if currentLockedTarget and currentLockedTarget.Parent and currentLockedTarget.Parent:FindFirstChild("Humanoid") and currentLockedTarget.Parent.Humanoid.Health > 0 then
        local pos, onScreen = Camera:WorldToViewportPoint(currentLockedTarget.Position)
        if onScreen and (Vector2.new(pos.X, pos.Y) - camCenter).Magnitude <= aimbotFovCircle.Radius * 1.3 then
            return currentLockedTarget
        end
    end
    local closest = nil
    local shortest = aimbotFovCircle.Radius
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("Humanoid") and p.Character.Humanoid.Health > 0 then
            local part = p.Character:FindFirstChild("HumanoidRootPart")
            if part then
                local pos, onScreen = Camera:WorldToViewportPoint(part.Position)
                if onScreen then
                    local dist = (Vector2.new(pos.X, pos.Y) - camCenter).Magnitude
                    if dist < shortest then shortest = dist; closest = part end
                end
            end
        end
    end
    currentLockedTarget = closest
    return currentLockedTarget
end

local oldNamecall
oldNamecall = hookmetamethod(game, "__namecall", function(self, ...)
    local method = getnamecallmethod()
    if silentEnabled and not checkcaller() and (method == "Raycast" or method == "FindPartOnRay") and self == Workspace then
        if cachedSilentTarget and cachedSilentTarget.Parent then
            local args = {...}
            pcall(function()
                if method == "Raycast" and typeof(args[1]) == "Vector3" and typeof(args[2]) == "Vector3" then
                    args[2] = (cachedSilentTarget.Position - args[1]).Unit * args[2].Magnitude
                elseif method == "FindPartOnRay" and typeof(args[1]) == "Ray" then
                    args[1] = Ray.new(args[1].Origin, (cachedSilentTarget.Position - args[1].Origin).Unit * args[1].Direction.Magnitude)
                end
            end)
            return oldNamecall(self, unpack(args))
        end
    end
    return oldNamecall(self, ...)
end)

RunService.RenderStepped:Connect(function()
    local camCenter = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
    silentFovCircle.Position = camCenter
    aimbotFovCircle.Position = camCenter

    if silentEnabled then cachedSilentTarget = getClosestSilentTarget() else cachedSilentTarget = nil end
    if aimbotEnabled then
        pcall(function()
            local targetPart = getClosestAimbotTarget()
            if targetPart then Camera.CFrame = Camera.CFrame:Lerp(CFrame.new(Camera.CFrame.Position, targetPart.Position), 0.35) else currentLockedTarget = nil end
        end)
    end
end)

-- 🌟 حماية "مدرع" (Bulletproof Filter) لاستبعاد أي مناطق بيع، متاجر، أو تفاعلات خاصة 🌟
local activeDrops = {}
local collectedParts = {}

Workspace.DescendantAdded:Connect(function(obj)
    if obj:IsA("BasePart") then
        task.delay(0.1, function()
            if obj and obj.Parent and obj:FindFirstChild("TouchInterest") then
                activeDrops[obj] = true
            end
        end)
    end
end)

Workspace.DescendantRemoving:Connect(function(obj)
    if activeDrops[obj] then
        activeDrops[obj] = nil
        collectedParts[obj] = nil
    end
end)

task.spawn(function()
    for _, obj in pairs(Workspace:GetDescendants()) do
        if obj:IsA("BasePart") and obj:FindFirstChild("TouchInterest") then
            activeDrops[obj] = true
        end
    end
end)

local function collectLoot()
    local char = LocalPlayer.Character
    if not char then return end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end

    for obj, _ in pairs(activeDrops) do
        if obj and obj.Parent and obj:FindFirstChild("TouchInterest") then
            local pName = obj.Parent.Name:lower()
            local oName = obj.Name:lower()
            
            -- فلتر "مدرع" وشامل لأي كلمات قد تسبب تعارض مع البيع أو المتاجر أو الـ NPCs
            if not (pName:find("shop") or pName:find("pawn") or pName:find("sell") or pName:find("market") or pName:find("npc") or pName:find("trade") or pName:find("register") or
                    oName:find("shop") or oName:find("pawn") or oName:find("sell") or oName:find("market") or oName:find("npc") or oName:find("trade") or oName:find("register")) then
                
                local distance = (hrp.Position - obj.Position).Magnitude
                
                if distance <= 8 and not collectedParts[obj] then
                    collectedParts[obj] = true
                    
                    pcall(function()
                        firetouchinterest(hrp, obj, 0)
                        task.wait()
                        firetouchinterest(hrp, obj, 1)
                    end)
                    
                    task.delay(2, function()
                        collectedParts[obj] = nil
                    end)
                end
            end
        else
            activeDrops[obj] = nil
        end
    end
end

task.spawn(function()
    while task.wait(0.4) do
        if autoLootEnabled then pcall(collectLoot) end
    end
end)

setupFeatureLogic(SilentAimBtn, SilentStatus, SilentStroke, function(enabled) silentEnabled = enabled; silentFovCircle.Visible = enabled end)
setupFeatureLogic(AimbotBtn, AimbotStatus, AimbotStroke, function(enabled) aimbotEnabled = enabled; aimbotFovCircle.Visible = enabled; if not enabled then currentLockedTarget = nil end end)
setupFeatureLogic(AutoLootBtn, AutoLootStatus, AutoLootStroke, function(enabled) autoLootEnabled = enabled end)

local espEnabled = false
local activeHighlights = {}
local function applyHighlight(char)
    if char and not char:FindFirstChild("BlockSpinHighlight") then
        local hl = Instance.new("Highlight")
        hl.Name = "BlockSpinHighlight"
        hl.Adornee = char
        hl.FillColor = Color3.fromRGB(255, 69, 0)
        hl.OutlineColor = Color3.fromRGB(255, 255, 255)
        hl.FillTransparency = 0.4
        hl.Parent = char
        table.insert(activeHighlights, hl)
    end
end
setupFeatureLogic(EspBtn, EspStatus, EspStroke, function(enabled)
    espEnabled = enabled
    if enabled then
        for _, p in ipairs(Players:GetPlayers()) do if p ~= LocalPlayer and p.Character then applyHighlight(p.Character) end end
    else
        for _, hl in ipairs(activeHighlights) do if hl then hl:Destroy() end end
        activeHighlights = {}
    end
end)
for _, p in ipairs(Players:GetPlayers()) do p.CharacterAdded:Connect(function(char) if espEnabled then task.wait(0.6); applyHighlight(char) end end) end
Players.PlayerAdded:Connect(function(p) p.CharacterAdded:Connect(function(char) if espEnabled then task.wait(0.6); applyHighlight(char) end end) end)

local dragging, dragStart, startPos
FloatingIcon.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then dragging = true; dragStart = input.Position; startPos = FloatingIcon.Position end
end)
UserInputService.InputChanged:Connect(function(input)
    if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - dragStart
        FloatingIcon.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)
UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then dragging = false end
end)

print("BlockSpin Pro Hub V6 - Bulletproof Edition Loaded Successfully!")
