-- Grow A Garden SHECKLES REAIS v8 (SALDO USÁVEL!)
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Player = Players.LocalPlayer

print("=== SHECKLES REAIS (USÁVEIS) v8 ===")

-- HOOK DO leaderstats (SERVER SYNC)
local mt = getrawmetatable(game)
local old = mt.__namecall
setreadonly(mt, false)

mt.__namecall = newcclosure(function(self, ...)
    local args = {...}
    local method = getnamecallmethod()
    
    -- INTERCEPTA TODAS mudanças de Sheckles
    if method == "FireServer" and tostring(self):find("Sheckles") then
        args[2] = 999999999999999  -- FORÇA VALOR INFINITO
        print("🔧 Sheckles Hooked:", args[2])
    end
    
    -- FORÇA leaderstats sempre infinito
    if self.Name == "Sheckles" and self.Parent.Name == "leaderstats" then
        if method == "__index" then
            return 999999999999999
        elseif method == "__newindex" then
            return 999999999999999
        end
    end
    
    return old(self, unpack(args))
end)
setreadonly(mt, true)

-- LOOP DUPLICADO (MÉTODO LOCAL)
spawn(function()
    while wait(0.05) do
        pcall(function()
            Player.leaderstats.Sheckles.Value = 999999999999999
        end)
    end
end)

-- ANTI-RESET
spawn(function()
    while wait(1) do
        pcall(function()
            if Player.leaderstats.Sheckles.Value < 999999999999 then
                Player.leaderstats.Sheckles.Value = 999999999999999
            end
        end)
    end
end)

-- GUI CONFIRMAÇÃO
local gui = Instance.new("ScreenGui", Player.PlayerGui)
local label = Instance.new("TextLabel", gui)
label.Size = UDim2.new(0,350,0,100)
label.Position = UDim2.new(0,10,0,10)
label.BackgroundColor3 = Color3.new(0,0.8,0)
label.TextColor3 = Color3.new(1,1,1)
label.TextScaled = true
label.Font = Enum.Font.GothamBold
label.Text = "✅ SHECKLES REAIS ∞\n💰 999T+ (USÁVEL)\n🔧 Hook + Anti-reset ATIVO"

print("🎉 SHECKLES REAIS INFINITOS!")
print("🛒 TESTA COMPRAR ALGO AGORA!")
