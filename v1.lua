local OrionLib =  loadstring(game:HttpGet("https://raw.githubusercontent.com/jadpy/suki/refs/heads/main/orion"))()
local Window = OrionLib:MakeWindow({Name = "🐦‍⬛Yoizaki🐦‍⬛", HidePremium = true, SaveConfig = false})

-- [[ 設定セクション ]]
local CorrectKey = "Yoizaki" -- 認証キー
local KeyInput = ""
local Attempts = 0
local MaxAttempts = 3
local IsLoaded = false

-- [[ メイン機能（認証後にここが表示される） ]]
function LoadMainScript()
    if IsLoaded then return end
    IsLoaded = true

    local Tab1 = Window:MakeTab({Name = "Script", Icon = "rbxassetid://4483362458"})
    local Tab2 = Window:MakeTab({Name = "tp", Icon = "rbxassetid://4483362458"})

Tab2:AddButton({
    Name = "Kingへtp",
    Callback = function()
        local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()

if character and character:FindFirstChild("HumanoidRootPart") then
    character.HumanoidRootPart.CFrame = CFrame.new(4, 1401, -44)
end
    end    
})


Tab2:AddButton({
    Name = "荒らし",
    Callback = function()
        local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()

if character and character:FindFirstChild("HumanoidRootPart") then
    character.HumanoidRootPart.CFrame = CFrame.new(5, 1400, -12)
end
    end    
})

Tab2:AddButton({
    Name = "地上",
    Callback = function()
        local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()

if character and character:FindFirstChild("HumanoidRootPart") then
    character.HumanoidRootPart.CFrame = CFrame.new(102, 573, -2)
end
    end    
})


Tab1:AddButton({
    Name = "座標",
    Callback = function()
        loadstring(game:HttpGet("https://pastebin.com/raw/2RkwMiLp"))()
    end    
})

Tab1:AddButton({
    Name = "煽るよう",
    Callback = function()
        loadstring(game:HttpGet("https://pastebin.com/raw/09025Qs5"))()
    end    
})
end
-- [[ キー認証タブ（最初に出るやつ） ]]
local KeyTab = Window:MakeTab({Name = "Key🔑", Icon = "rbxassetid://4483362458"})

KeyTab:AddTextbox({
    Name = "KeyはYoizakiです。",
    Default = "",
    TextDisappear = true,
    Callback = function(Value)
        KeyInput = Value
    end
})

KeyTab:AddButton({
    Name = "🔓 認証する",
    Callback = function()
        if KeyInput == CorrectKey then
            OrionLib:MakeNotification({
                Name = "Access Granted",
                Content = "🩷Yoizaki hub🩷",
                Time = infinite -- 無限表示
            })
            LoadMainScript() -- メイン機能をロード
        else
            Attempts = Attempts + 1
            local Left = MaxAttempts - Attempts
            
            if Attempts >= MaxAttempts then
                game.Players.LocalPlayer:Kick("\n【Galaxy Hub】\n認証に3回失敗したため、安全のために追放されました。")
            else
                OrionLib:MakeNotification({
                    Name = "Wrong Key",
                    Content = "キーが違います。残り: " .. tostring(Left) .. "回",
                    Time = 3
                })
            end
        end
    end
})

OrionLib:Init()
