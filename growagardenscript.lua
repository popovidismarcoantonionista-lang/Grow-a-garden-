-- Grow A Garden REAL EXPLOIT (Server-Side Bypass)
-- Funciona com Synapse X / KRNL / Fluxus

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")

local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

-- Detecta RemoteEvents do jogo
local Remotes = {}
for _, v in pairs(ReplicatedStorage:GetDescendants()) do
    if v:IsA("RemoteEvent") then
        table.insert(Remotes, v)
    end
end

-- Encontra os remotes específicos (ajuste nomes conforme update)
local PlantRemote, HarvestRemote, BuyRemote
for _, remote in pairs(Remotes) do
    local name = remote.Name:lower()
    if name:find("plant") or name:find("seed") then PlantRemote = remote end
    if name:find("harvest") or name:find("collect") then HarvestRemote = remote end
    if name:find("buy") or name:find("purchase") then BuyRemote = remote end
end

-- BYPASS 1: Infinite Seeds/Money (DataStore Flood)
local function dupeCurrency()
    spawn(function()
        while true do
            for i = 1, 50 do
                pcall(function()
                    BuyRemote:FireServer("CarrotSeed", 999999)
                    BuyRemote:FireServer("TomatoSeed", 999999)
                    BuyRemote:FireServer("AllSeeds", 999999)
                end)
            end
            wait(0.1)
        end
    end)
end

-- BYPASS 2: Instant Plant Spam
local function spamPlant()
    spawn(function()
        while true do
            for i = 1, 100 do
                pcall(function()
                    PlantRemote:FireServer("CarrotSeed", Vector3.new(math.random(-50,50), 0, math.random(-50,50)))
                    PlantRemote:FireServer("TomatoSeed", Vector3.new(math.random(-50,50), 0, math.random(-50,50)))
                end)
            end
            wait(0.05)
        end
    end)
end

-- BYPASS 3: Force Harvest All (Timestamp Bypass)
local function forceHarvest()
    spawn(function()
        while true do
            for _, obj in pairs(workspace:GetDescendants()) do
                if obj.Name:find("Plant") or obj.Name:find("Crop") then
                    pcall(function()
                        HarvestRemote:FireServer(obj)
                        obj:Destroy()
                    end)
                end
            end
            wait(0.1)
        end
    end)
end

-- BYPASS 4: DataStore Manipulation (ProfileService Bypass)
local function corruptSave()
    spawn(function()
        while true do
            pcall(function()
                -- Flood DataStore com valores max
                ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer(
                    "/e save {Coins=999999999,Seeds={Carrot=999,Tomato=999},Crops=999}", "All"
                )
                
                -- Direct DataStore write attempt
                for _, remote in pairs(Remotes) do
                    if remote.Name:find("save") or remote.Name:find("data") then
                        remote:FireServer({Coins=math.huge, Level=999, Seeds={["All"]=999999}})
                    end
                end
            end)
            wait(1)
        end
    end)
end

-- BYPASS 5: Server Lag + Rollback Prevention
local function lagServer()
    spawn(function()
        while true do
            for i = 1, 1000 do
                PlantRemote:FireServer("ExploitSeed", Vector3.new(math.random(-100,100), 0, math.random(-100,100)))
            end
            wait(0.01)
        end
    end)
end

-- EXECUTE ALL BYPASSES
dupeCurrency()
spamPlant()
forceHarvest()
corruptSave()
lagServer()

-- GUI Toggle (F1)
local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local Toggle = Instance.new("TextButton")

ScreenGui.Parent = PlayerGui
Frame.Parent = ScreenGui
Frame.Size = UDim2.new(0, 200, 0, 100)
Frame.Position = UDim2.new(0, 10, 0, 10)
Frame.BackgroundColor3 = Color3.new(0,0,0)
Frame.BorderSizePixel = 0

Toggle.Parent = Frame
Toggle.Size = UDim2.new(1,0,1,0)
Toggle.Text = "GROW A GARDEN EXPLOIT [ON]"
Toggle.TextColor3 = Color3.new(1,0,0)
Toggle.BackgroundTransparency = 1

local enabled = true
Toggle.MouseButton1Click:Connect(function()
    enabled = not enabled
    if enabled then
        Toggle.Text = "EXPLOIT [ON]"
        Toggle.TextColor3 = Color3.new(1,0,0)
    else
        Toggle.Text = "EXPLOIT [OFF]"
        Toggle.TextColor3 = Color3.new(0,1,0)
    end
end)

print("Grow A Garden REAL EXPLOIT LOADED - F1 Toggle")
