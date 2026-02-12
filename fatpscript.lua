local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CoreGui = game:GetService("CoreGui")

local player = Players.LocalPlayer

-- === 設定変数 ===
local tossMultiplier = 1.0
local antiGrabEnabled = true -- 初期状態はON

-- === UI作成 ===
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "ModMenuV2"
screenGui.Parent = CoreGui

local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 250, 0, 250) -- 少し縦を長く
mainFrame.Position = UDim2.new(0.05, 0, 0.4, 0)
mainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
mainFrame.Active = true
mainFrame.Draggable = true
mainFrame.Parent = screenGui

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 30)
title.Text = "Mod Menu (Anti-Grab + Power)"
title.TextColor3 = Color3.new(1, 1, 1)
title.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
title.Parent = mainFrame

-- === アンチダッシュ/掴み無効トグルボタン ===
local toggleBtn = Instance.new("TextButton")
toggleBtn.Size = UDim2.new(0.9, 0, 0, 35)
toggleBtn.Position = UDim2.new(0.05, 0, 0.15, 0)
toggleBtn.Text = "Anti-Grab: ON"
toggleBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
toggleBtn.TextColor3 = Color3.new(1, 1, 1)
toggleBtn.Parent = mainFrame

-- パワー表示ラベル
local pwrLabel = Instance.new("TextLabel")
pwrLabel.Size = UDim2.new(1, 0, 0, 30)
pwrLabel.Position = UDim2.new(0, 0, 0.4, 0)
pwrLabel.Text = "Throw Power: x1.0"
pwrLabel.TextColor3 = Color3.new(0, 1, 0)
pwrLabel.BackgroundTransparency = 1
pwrLabel.Parent = mainFrame

-- パワーアップ/ダウンボタン
local upBtn = Instance.new("TextButton")
upBtn.Size = UDim2.new(0.4, 0, 0, 35)
upBtn.Position = UDim2.new(0.05, 0, 0.6, 0)
upBtn.Text = "Power +"
upBtn.Parent = mainFrame

local downBtn = Instance.new("TextButton")
downBtn.Size = UDim2.new(0.4, 0, 0, 35)
downBtn.Position = UDim2.new(0.55, 0, 0.6, 0)
downBtn.Text = "Power -"
downBtn.Parent = mainFrame

-- === ロジック: ON/OFF切り替え ===
toggleBtn.MouseButton1Click:Connect(function()
    antiGrabEnabled = not antiGrabEnabled
    if antiGrabEnabled then
        toggleBtn.Text = "Anti-Grab: ON"
        toggleBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
    else
        toggleBtn.Text = "Anti-Grab: OFF"
        toggleBtn.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
    end
end)

upBtn.MouseButton1Click:Connect(function()
    tossMultiplier = math.min(tossMultiplier + 0.5, 10.0)
    pwrLabel.Text = "Throw Power: x" .. tostring(tossMultiplier)
end)

downBtn.MouseButton1Click:Connect(function()
    tossMultiplier = math.max(tossMultiplier - 0.5, 1.0)
    pwrLabel.Text = "Throw Power: x" .. tostring(tossMultiplier)
end)

-- === 投げパワー強化ロジック ===
RunService.Heartbeat:Connect(function()
    local char = player.Character
    if char and tossMultiplier > 1.0 then
        for _, part in pairs(workspace:GetDescendants()) do
            -- pcallでNetworkOwnership取得時のエラーを回避
            local success, owner = pcall(function() return part:GetNetworkOwner() end)
            if success and owner == player and part:IsA("BasePart") then
                if part.AssemblyLinearVelocity.Magnitude > 5 then
                    part.AssemblyLinearVelocity = part.AssemblyLinearVelocity * tossMultiplier
                end
            end
        end
    end
end)

-- === アンチ掴み / ラグドール無効化ロジック ===
RunService.Heartbeat:Connect(function()
    if not antiGrabEnabled then return end -- OFFなら何もしない

    local char = player.Character
    if char and char:FindFirstChild("Humanoid") then
        local hum = char.Humanoid
        
        -- ラグドール状態を即座に復帰
        if hum:GetState() == Enum.HumanoidStateType.Ragdoll or hum.PlatformStanding then
            hum:ChangeState(Enum.HumanoidStateType.GettingUp)
            hum.PlatformStanding = false
        end
        
        -- 外部から付けられた拘束具(Weld/Constraint)を削除
        for _, obj in pairs(char:GetDescendants()) do
            if (obj:IsA("Constraint") or obj:IsA("Weld")) and not obj:IsA("Motor6D") then
                obj:Destroy()
            end
        end
    end
end)

-- リモートイベントへの連打 (ONの時のみ実行)
task.spawn(function()
    while task.wait(0.1) do
        if antiGrabEnabled then
            pcall(function()
                ReplicatedStorage.GrabEvents.EndGrabEarly:FireServer()
                ReplicatedStorage.CharacterEvents.Struggle:FireServer()
            end)
        end
    end
end)

print("Mod Menu: Anti-Grab Toggle Added!")
