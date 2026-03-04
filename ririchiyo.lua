local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

-- 1. 親となるPlayerGuiを取得（ここがUIの表示場所）
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

-- 2. ScreenGuiを作成し、親をPlayerGuiに設定
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "HitboxGuiSystem"
ScreenGui.ResetOnSpawn = false -- リスポーンしても消えない設定
ScreenGui.Parent = PlayerGui

-- 3. メインフレームの作成
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 200, 0, 120)
MainFrame.Position = UDim2.new(0.5, -100, 0.2, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
MainFrame.BorderSizePixel = 2
MainFrame.Active = true
MainFrame.Draggable = true -- マウスで動かせる
MainFrame.Parent = ScreenGui

-- 4. タイトル
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 30)
Title.Text = "HITBOX CHANGER"
Title.TextColor3 = Color3.new(1, 1, 1)
Title.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Title.Parent = MainFrame

-- 5. ON/OFFボタン
local ToggleBtn = Instance.new("TextButton")
ToggleBtn.Size = UDim2.new(0, 180, 0, 35)
ToggleBtn.Position = UDim2.new(0, 10, 0, 40)
ToggleBtn.Text = "OFF"
ToggleBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
ToggleBtn.TextColor3 = Color3.new(1, 1, 1)
ToggleBtn.Parent = MainFrame

-- 6. サイズ入力ボックス
local SizeInput = Instance.new("TextBox")
SizeInput.Size = UDim2.new(0, 180, 0, 30)
SizeInput.Position = UDim2.new(0, 10, 0, 80)
SizeInput.Text = "10"
SizeInput.PlaceholderText = "Hitbox Size"
SizeInput.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
SizeInput.Parent = MainFrame

----------------------------------------------------
-- 動作ロジック
----------------------------------------------------
local isEnabled = false

local function applyHitbox()
    local sizeVal = tonumber(SizeInput.Text) or 2
    
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character then
            local hrp = player.Character:FindFirstChild("HumanoidRootPart")
            if hrp then
                if isEnabled then
                    hrp.Size = Vector3.new(sizeVal, sizeVal, sizeVal)
                    hrp.Transparency = 0.6
                    hrp.BrickColor = BrickColor.new("Bright blue")
                    hrp.Material = Enum.Material.Neon
                    hrp.CanCollide = false
                else
                    -- 元に戻す
                    hrp.Size = Vector3.new(2, 2, 1)
                    hrp.Transparency = 1
                    hrp.CanCollide = true
                end
            end
        end
    end
end

-- ボタンクリックイベント
ToggleBtn.MouseButton1Click:Connect(function()
    isEnabled = not isEnabled
    if isEnabled then
        ToggleBtn.Text = "ON"
        ToggleBtn.BackgroundColor3 = Color3.fromRGB(50, 200, 50)
    else
        ToggleBtn.Text = "OFF"
        ToggleBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
        applyHitbox() -- サイズをリセット
    end
end)

-- ループで常に実行（新しいプレイヤーやリスポーンに対応）
RunService.RenderStepped:Connect(function()
    if isEnabled then
        applyHitbox()
    end
end)
