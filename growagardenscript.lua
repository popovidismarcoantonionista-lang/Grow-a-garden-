-- Grow A Garden SHECKLES REAIS v9 (ENCONTRA REMOTE REAL)
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Player = Players.LocalPlayer

print("=== DEBUG REMOTES SHECKLES v9 ===")

-- ENCONTRA TODOS OS REMOTES POSSÍVEIS
spawn(function()
    wait(2)
    for _, remote in pairs(ReplicatedStorage:GetDescendants()) do
        if remote:IsA("RemoteEvent") or remote:IsA("RemoteFunction") then
            print("🔍 REMOTE:", remote:GetFullName())
            
            -- TESTA FIRE EM TODOS
            pcall(function()
                remote:FireServer("Sheckles", 999999999999999)
                remote:FireServer("AddSheckles", 999999999999999)
                remote:FireServer("UpdateCurrency", "Sheckles", 999999999999999)
            end)
        end
    end
end)

-- LOOP LOCAL FORÇADO
spawn(function()
    while wait(0.1) do
        pcall(function()
            Player.leaderstats.Sheckles.Value = 999999999999999
        end)
    end
end)

-- PROCURA EM TODOS OS LUGARES POSSÍVEIS
spawn(function()
    while wait(2) do
        for _, obj in pairs(game:GetDescendants()) do
            if obj.Name:lower():find("sheckle") or obj.Name:lower():find("money") or obj.Name:lower():find("coin") then
                print("💰 ENCONTRADO:", obj:GetFullName(), obj.Value or obj.Text or "N/A")
                if obj:IsA("IntValue") or obj:IsA("NumberValue") then
                    obj.Value = 999999999999999
                end
            end
        end
    end
end)

print("🔍 EXECUTE E MANDA:")
print("1. TODOS os REMOTES que apareceram")
print("2. Se algum 'ENCONTRADO' mudou o valor")
print("3. TESTA COMPRAR enquanto roda!")
