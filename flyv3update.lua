local main = Instance.new("ScreenGui")

local Frame = Instance.new("Frame")

local up = Instance.new("TextButton")

local down = Instance.new("TextButton")

local onof = Instance.new("TextButton")

local TextLabel = Instance.new("TextLabel")

local plus = Instance.new("TextButton")

local speed = Instance.new("TextLabel")

local mine = Instance.new("TextButton")

local closebutton = Instance.new("TextButton")

local mini = Instance.new("TextButton")

local mini2 = Instance.new("TextButton")

-- GUI Setup

main.Name = "main"

main.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

main.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

main.ResetOnSpawn = false

Frame.Parent = main

Frame.Position = UDim2.new(0.100320168, 0, 0.379746825, 0)

Frame.Size = UDim2.new(0, 190, 0, 57)

Frame.Active = true

Frame.Draggable = true

-- 各ボタンの設定（色は虹色スクリプトで制御するため初期値のみ）

up.Name = "up"

up.Parent = Frame

up.Size = UDim2.new(0, 44, 0, 28)

up.Font = Enum.Font.SourceSans

up.Text = "UP"

up.TextColor3 = Color3.fromRGB(0, 0, 0)

up.TextSize = 14.000

down.Name = "down"

down.Parent = Frame

down.Position = UDim2.new(0, 0, 0.491228074, 0)

down.Size = UDim2.new(0, 44, 0, 28)

down.Font = Enum.Font.SourceSans

down.Text = "DOWN"

down.TextColor3 = Color3.fromRGB(0, 0, 0)

down.TextSize = 14.000

onof.Name = "onof"

onof.Parent = Frame

onof.Position = UDim2.new(0.702823281, 0, 0.491228074, 0)

onof.Size = UDim2.new(0, 56, 0, 28)

onof.Font = Enum.Font.SourceSans

onof.Text = "fly"

onof.TextColor3 = Color3.fromRGB(0, 0, 0)

onof.TextSize = 14.000

TextLabel.Parent = Frame

TextLabel.Position = UDim2.new(0.469327301, 0, 0, 0)

TextLabel.Size = UDim2.new(0, 100, 0, 28)

TextLabel.Font = Enum.Font.SourceSans

TextLabel.Text = "FLY GUI V3"

TextLabel.TextColor3 = Color3.fromRGB(0, 0, 0)

TextLabel.TextScaled = true

TextLabel.TextSize = 14.000

TextLabel.TextWrapped = true

plus.Name = "plus"

plus.Parent = Frame

plus.Position = UDim2.new(0.231578946, 0, 0, 0)

plus.Size = UDim2.new(0, 45, 0, 28)

plus.Font = Enum.Font.SourceSans

plus.Text = "+"

plus.TextColor3 = Color3.fromRGB(0, 0, 0)

plus.TextScaled = true

plus.TextSize = 14.000

plus.TextWrapped = true

speed.Name = "speed"

speed.Parent = Frame

speed.Position = UDim2.new(0.468421042, 0, 0.491228074, 0)

speed.Size = UDim2.new(0, 44, 0, 28)

speed.Font = Enum.Font.SourceSans

speed.Text = "1"

speed.TextColor3 = Color3.fromRGB(0, 0, 0)

speed.TextScaled = true

speed.TextSize = 14.000

speed.TextWrapped = true

mine.Name = "mine"

mine.Parent = Frame

mine.Position = UDim2.new(0.231578946, 0, 0.491228074, 0)

mine.Size = UDim2.new(0, 45, 0, 29)

mine.Font = Enum.Font.SourceSans

mine.Text = "-"

mine.TextColor3 = Color3.fromRGB(0, 0, 0)

mine.TextScaled = true

mine.TextSize = 14.000

mine.TextWrapped = true

closebutton.Name = "Close"

closebutton.Parent = Frame

closebutton.Font = "SourceSans"

closebutton.Size = UDim2.new(0, 45, 0, 28)

closebutton.Text = "X"

closebutton.TextSize = 30

closebutton.Position =  UDim2.new(0, 0, -1, 27)

mini.Name = "minimize"

mini.Parent = Frame

mini.Font = "SourceSans"

mini.Size = UDim2.new(0, 45, 0, 28)

mini.Text = "-"

mini.TextSize = 40

mini.Position = UDim2.new(0, 44, -1, 27)

mini2.Name = "minimize2"

mini2.Parent = Frame

mini2.Font = "SourceSans"

mini2.Size = UDim2.new(0, 45, 0, 28)

mini2.Text = "+"

mini2.TextSize = 40

mini2.Position = UDim2.new(0, 44, -1, 57)

mini2.Visible = false

----------------------------------------------------------------------

-- 🌈 虹色統一アニメーション

----------------------------------------------------------------------

local rainbowElements = {Frame, up, down, onof, TextLabel, plus, speed, mine, closebutton, mini, mini2}

task.spawn(function()

	local hue = 0	while task.wait() do

		local color = Color3.fromHSV(hue, 1, 1)

		for _, item in pairs(rainbowElements) do

			if item:IsA("GuiObject") then

				item.BackgroundColor3 = color

			end

		end

		hue = hue + 0.01

		if hue >= 1 then hue = 0 end

	end

end)

----------------------------------------------------------------------

-- Fly Logic

local speeds = 1

local speaker = game:GetService("Players").LocalPlayer

local nowe = false

game:GetService("StarterGui"):SetCore("SendNotification", { 

	Title = "FLY GUI V3";

	Text = "BY XNEO (Rainbow Edition)";

	Icon = "rbxthumb://type=Asset&id=5107182114&w=150&h=150"})

onof.MouseButton1Down:connect(function()

	if nowe == true then

		nowe = false

		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Climbing,true)

		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown,true)

		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Flying,true)

		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Freefall,true)

		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.GettingUp,true)

		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Jumping,true)

		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Landed,true)

		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Physics,true)

		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.PlatformStanding,true)

		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Ragdoll,true)

		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Running,true)

		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.RunningNoPhysics,true)

		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated,true)

		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.StrafingNoPhysics,true)

		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Swimming,true)

		speaker.Character.Humanoid:ChangeState(Enum.HumanoidStateType.RunningNoPhysics)

	else 

		nowe = true

		for i = 1, speeds do

			task.spawn(function()

				local hb = game:GetService("RunService").Heartbeat	

				tpwalking = true

				local chr = game.Players.LocalPlayer.Character

				local hum = chr and chr:FindFirstChildWhichIsA("Humanoid")

				while tpwalking and hb:Wait() and chr and hum and hum.Parent do

					if hum.MoveDirection.Magnitude > 0 then

						chr:TranslateBy(hum.MoveDirection)

					end

				end

			end)

		end

		game.Players.LocalPlayer.Character.Animate.Disabled = true

		local Char = game.Players.LocalPlayer.Character

		local Hum = Char:FindFirstChildOfClass("Humanoid") or Char:FindFirstChildOfClass("AnimationController")

		for i,v in next, Hum:GetPlayingAnimationTracks() do

			v:AdjustSpeed(0)

		end

		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Climbing,false)

		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown,false)

		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Flying,false)

		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Freefall,false)

		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.GettingUp,false)

		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Jumping,false)

		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Landed,false)

		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Physics,false)

		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.PlatformStanding,false)

		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Ragdoll,false)

		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Running,false)

		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.RunningNoPhysics,false)

		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated,false)

		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.StrafingNoPhysics,false)

		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Swimming,false)

		speaker.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Swimming)

	end

	local plr = game.Players.LocalPlayer

	local isR6 = plr.Character:FindFirstChildOfClass("Humanoid").RigType == Enum.HumanoidRigType.R6

	local torso = isR6 and plr.Character.Torso or plr.Character.UpperTorso

	

	local bg = Instance.new("BodyGyro", torso)

	bg.P = 9e4

	bg.maxTorque = Vector3.new(9e9, 9e9, 9e9)

	bg.cframe = torso.CFrame

	local bv = Instance.new("BodyVelocity", torso)

	bv.velocity = Vector3.new(0,0.1,0)

	bv.maxForce = Vector3.new(9e9, 9e9, 9e9)

	

	if nowe == true then plr.Character.Humanoid.PlatformStand = true end

	

	while nowe == true or game:GetService("Players").LocalPlayer.Character.Humanoid.Health == 0 do

		game:GetService("RunService").RenderStepped:Wait()

		bv.velocity = (game.Workspace.CurrentCamera.CoordinateFrame.lookVector * 0.1) -- シンプルなホバリング

		bg.cframe = game.Workspace.CurrentCamera.CoordinateFrame

	end

	

	bg:Destroy()

	bv:Destroy()

	plr.Character.Humanoid.PlatformStand = false

	game.Players.LocalPlayer.Character.Animate.Disabled = false

	tpwalking = false

end)

-- 上昇・下降

local tis

up.MouseButton1Down:connect(function()

	tis = true

	while tis do

		wait()

		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0,1,0)

	end

end)

up.MouseLeave:connect(function() tis = false end)

up.MouseButton1Up:connect(function() tis = false end)

local dis

down.MouseButton1Down:connect(function()

	dis = true

	while dis do

		wait()

		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0,-1,0)

	end

end)

down.MouseLeave:connect(function() dis = false end)

down.MouseButton1Up:connect(function() dis = false end)

-- スピード調整

plus.MouseButton1Down:connect(function()

	speeds = speeds + 1

	speed.Text = speeds

end)

mine.MouseButton1Down:connect(function()

	if speeds > 1 then

		speeds = speeds - 1

		speed.Text = speeds

	end

end)

-- 閉じる・最小化

closebutton.MouseButton1Click:Connect(function() main:Destroy() end)

mini.MouseButton1Click:Connect(function()

	for _,v in pairs({up,down,onof,plus,speed,mine,mini}) do v.Visible = false end

	mini2.Visible = true

	Frame.BackgroundTransparency = 1

end)

mini2.MouseButton1Click:Connect(function()

	for _,v in pairs({up,down,onof,plus,speed,mine,mini}) do v.Visible = true end

	mini2.Visible = false

	Frame.BackgroundTransparency = 0

end)
