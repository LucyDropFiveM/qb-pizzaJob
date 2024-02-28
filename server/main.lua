QBCore = exports['qb-core']:GetCoreObject()








-- Preppa mat Events


RegisterNetEvent('pizzajob:server:cookPasta', function(data)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src) 

    Player.Functions.RemoveItem("spaghetti", 1)
                     TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items["spaghetti"], "remove")
        Wait(10)
     Player.Functions.AddItem("cookedpasta", 1)
     TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items["cookedpasta"], "add")
end)

RegisterNetEvent('pizzajob:server:cookBread', function(data)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src) 

    Player.Functions.RemoveItem("breadslice", 1)
    TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items["breadslice"], "remove")
        Wait(10)
     Player.Functions.AddItem("rbread", 1)
     TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items["rbread"], "add")
end)


-- Tillaga mat

RegisterNetEvent('pizzajob:server:makeBrus', function(data)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src) 

    Player.Functions.RemoveItem("rbread", 1)
    TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items["rbread"], "remove")
    Player.Functions.RemoveItem("sallad", 1)
    TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items["sallad"], "remove")
    Wait(10)
     Player.Functions.AddItem("bruschetta", 1)
     TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items["bruschetta"], "add")
end)

RegisterNetEvent('pizzajob:server:makePestoPasta', function(data)
        local src = source
    local Player = QBCore.Functions.GetPlayer(src) 

    Player.Functions.RemoveItem("pesto", 1)
    TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items["pesto"], "remove")
    Player.Functions.RemoveItem("spaghetti", 1)
    TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items["spaghetti"], "remove")
        Wait(10)
     Player.Functions.AddItem("pestopasta", 1)
     TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items["pestopasta"], "add")
end)


RegisterNetEvent('pizzajob:server:makePizza', function(data)
        local src = source
    local Player = QBCore.Functions.GetPlayer(src) 

    Player.Functions.RemoveItem("pizzadough", 1)
    TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items["pizzadough"], "remove")
    Player.Functions.RemoveItem("tomatsos", 1)
    TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items["tomatsos"], "remove")
        Wait(10)
     Player.Functions.AddItem("pizza", 1)
     TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items["pizza"], "add")
end)


RegisterServerEvent("pizzajob:server:billPlayer")
AddEventHandler("pizzajob:server:billPlayer", function(playerId, amount)
        local biller = QBCore.Functions.GetPlayer(source)
        local billed = QBCore.Functions.GetPlayer(tonumber(playerId))
        local amount = tonumber(amount)
        if biller.PlayerData.job.name == 'pizzajob' then
            if billed ~= nil then
                if biller.PlayerData.citizenid ~= billed.PlayerData.citizenid then
                    if amount and amount > 0 then
                        MySQL.Async.insert('INSERT INTO phone_invoices (citizenid, amount, society, sender) VALUES (:citizenid, :amount, :society, :sender)', {
                            ['citizenid'] = billed.PlayerData.citizenid,
                            ['amount'] = amount,
                            ['society'] = biller.PlayerData.job.name,
                            ['sender'] = biller.PlayerData.charinfo.firstname
                        })
                        TriggerClientEvent('qb-phone:RefreshPhone', billed.PlayerData.source)
                        TriggerClientEvent('QBCore:Notify', source, 'Bill sent!', 'success')
                        TriggerClientEvent('QBCore:Notify', billed.PlayerData.source, 'New bill')
                    else
                        TriggerClientEvent('QBCore:Notify', source, 'Number has to be above 0', 'error')
                    end
                else
                    TriggerClientEvent('QBCore:Notify', source, 'You can/t bill youself..', 'error')
                end
            else
                TriggerClientEvent('QBCore:Notify', source, 'Player not online', 'error')
            end
        else
            TriggerClientEvent('QBCore:Notify', source, 'No access', 'error')
        end
end)
