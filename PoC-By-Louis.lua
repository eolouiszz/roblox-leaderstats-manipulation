--[[
    PoC: Local Leaderstats Manipulation

    Demonstra que valores presentes na pasta `leaderstats` podem ser
    modificados localmente pelo cliente.

    Importante:
    Este PoC demonstra apenas manipulação client-side. Alterar um
    `Value` local não significa que o servidor aceitou ou salvou
    a alteração.
]]

local player = game.Players.LocalPlayer

-- Obtém a pasta de estatísticas associada ao jogador local.
local leaderstats = player:FindFirstChild("leaderstats")

if not leaderstats then
    print("[-] leaderstats não encontrada no LocalPlayer.")
    return
end

print("[PoC] Testando manipulação local de leaderstats...")

pcall(function()
    -- Localiza as estatísticas que serão testadas.
    local wins = leaderstats:FindFirstChild("Wins")
    local laps = leaderstats:FindFirstChild("Laps")

    -- Modifica apenas a representação local do número de vitórias.
    if wins then
        wins.Value = 999999
        print("[+] Wins alteradas localmente para 999999.")
    end

    -- Modifica apenas a representação local do número de voltas.
    if laps then
        laps.Value = 9
        print("[+] Laps alteradas localmente para 9.")
    end
end)