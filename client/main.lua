QBCore = exports['qb-core']:GetCoreObject()
isLoggedIn = false
local onDuty = false
PlayerJob = {}

function DrawText3Ds(x, y, z, text)
	SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x,y,z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    DrawRect(0.0, 0.0+0.0125, 0.017+ factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end


RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    QBCore.Functions.GetPlayerData(function(PlayerData)
        if PlayerData.job.onduty then
            if PlayerData.job.name == Config.Job then
                TriggerServerEvent("QBCore:ToggleDuty")
            end
        end
    end)
end)

RegisterNetEvent('QBCore:Client:OnJobUpdate', function(JobInfo)
    PlayerJob = JobInfo
    onDuty = PlayerJob.onduty
end)

RegisterNetEvent('QBCore:Client:SetDuty', function(duty)
	onDuty = duty
end)

Citizen.CreateThread(function()
    Drusilla = AddBlipForCoord(-1197.32, -897.655, 13.995)
    SetBlipSprite (Drusilla, 106)
    SetBlipDisplay(Drusilla, 4)
    SetBlipScale  (Drusilla, 0.5)
    SetBlipAsShortRange(Drusilla, true)
    SetBlipColour(Drusilla, 75)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentSubstringPlayerName("Drusilla")
    EndTextCommandSetBlipName(Drusilla)
end) 

RegisterNetEvent("pizzajob:client:DutyB", function()
    TriggerServerEvent("QBCore:ToggleDuty")
end)


RegisterNetEvent("pizzajob:client:Tray1", function()
    TriggerEvent("inventory:client:SetCurrentStash", "resturanttray1")
    TriggerServerEvent("inventory:server:OpenInventory", "stash", "resturanttray1", {
        maxweight = 10000,
        slots = 6,
    })
end)

RegisterNetEvent("pizzajob:client:storage", function()
    TriggerEvent("inventory:client:SetCurrentStash", "resturantstorage")
    TriggerServerEvent("inventory:server:OpenInventory", "stash", "resturantstorage", {
        maxweight = 250000,
        slots = 40,
    })
end)


RegisterCommand('1', function()
exports['qb-menu']:openMenu({
        {
            header = 'Tillaga Mat',
            icon = 'fas fa-code',
            isMenuHeader = true, -- Set to true to make a nonclickable title
        },
        {
            header = 'Koka Spaghetti',
            txt = 'Koka spaghetti till Pesto Pasta',
            icon = 'fas fa-code-merge',
            params = {
                isServer = false,
                event = 'pizzajob:client:cookPasta',
            }
        },  
        {
            header = 'Rosta Bröd',
            txt = 'Rosta bröd till bruschetta',
            icon = 'fas fa-code-pull-request',
            -- disabled = false, -- optional, non-clickable and grey scale
            -- hidden = true, -- optional, hides the button completely
            params = {
                 isServer = false, -- optional, specify event type
                event = 'pizzajob:client:cookBread',
            }
        },
    })
end)



RegisterCommand('2', function()
exports['qb-menu']:openMenu({
        {
            header = 'Tillaga Mat',
            icon = 'fas fa-code',
            isMenuHeader = true, -- Set to true to make a nonclickable title
        },
        {
            header = 'Tillaga Pesto Pasta',
            txt = 'Pesto, Kokad Spaghetti',
            icon = 'fas fa-code-merge',
            params = {
                isServer = false,
                event = 'pizzajob:client:makePestoPasta',
            }
        },  
        {
            header = 'Tillaga Bruschetta',
            txt = 'Rostat Bröd, Sallad',
            icon = 'fas fa-code-pull-request',
            -- disabled = false, -- optional, non-clickable and grey scale
            -- hidden = true, -- optional, hides the button completely
            params = {
                 isServer = false, -- optional, specify event type
                event = 'pizzajob:client:cookBrus',
            }
        },
        {
            header = 'Tillaga Pizza',
            txt = 'Pizza Deg, Tomatsås, Fefferoni',
            icon = 'fas fa-code-pull-request',
            -- disabled = false, -- optional, non-clickable and grey scale
            -- hidden = true, -- optional, hides the button completely
            params = {
                 isServer = false, -- optional, specify event type
                event = 'pizzajob:client:cookPizza',  
        }
    },
    })
end)

RegisterNetEvent('pizzajob:client:cookPasta', function(data)
    QBCore.Functions.Progressbar('cookPasta', 'Kokar Pastan', 1000, false, true, { -- Name | Label | Time | useWhileDead | canCancel
    disableMovement = true,
    disableCarMovement = true,
    disableMouse = false,
    disableCombat = true,
}, {
    animDict = 'anim@gangops@facility@servers@',
    anim = 'hotwire',
    flags = 16,
}, {}, {}, function() -- Play When Done
    TriggerServerEvent('pizzajob:server:cookPasta')
end, function() -- Play When Cancel
    TriggerEvent('pizzajob:client:failedTask')
end)

end)


RegisterNetEvent('pizzajob:client:cookBread', function(data)
        QBCore.Functions.Progressbar('cookBread', 'Rostar Bröden', 1000, false, true, { -- Name | Label | Time | useWhileDead | canCancel
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = 'anim@gangops@facility@servers@',
        anim = 'hotwire',
        flags = 16,
    }, {}, {}, function() -- Play When Done
        TriggerServerEvent('pizzajob:server:cookBread')
    end, function() -- Play When Cancel
        TriggerEvent('pizzajob:client:failedTask')
    end)

end)

RegisterNetEvent('pizzajob:client:cookBrus', function(data)
        QBCore.Functions.Progressbar('cookBrus1', 'Lägger På Salladen...', 1000, false, true, { -- Name | Label | Time | useWhileDead | canCancel
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = 'anim@gangops@facility@servers@',
        anim = 'hotwire',
        flags = 16,
    }, {}, {}, function() -- Play When Done
        TriggerServerEvent('pizzajob:server:makeBrus')
    end, function() -- Play When Cancel
        TriggerEvent('pizzajob:client:failedTask')
    end)

end)


RegisterNetEvent('pizzajob:client:cookPizza', function(data)
    QBCore.Functions.Progressbar('cookPizza', 'Lägger på Fefferoni och Tomatsås...', 10000, false, true, { -- Name | Label | Time | useWhileDead | canCancel
    disableMovement = true,
    disableCarMovement = true,
    disableMouse = false,
    disableCombat = true,
}, {
    animDict = 'anim@gangops@facility@servers@',
    anim = 'hotwire',
    flags = 16,
}, {}, {}, function() -- Play When Done
    TriggerServerEvent('pizzajob:server:makePizza')
end, function() -- Play When Cancel
    TriggerEvent('pizzajob:client:failedTask')
end)

end)

RegisterNetEvent('pizzajob:client:makePestoPasta', function(data)
        QBCore.Functions.Progressbar('makePestoPasta', 'Lagar Pesto Pasta', 1000, false, true, { -- Name | Label | Time | useWhileDead | canCancel
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = 'anim@gangops@facility@servers@',
        anim = 'hotwire',
        flags = 16,
    }, {}, {}, function() -- Play When Done
        TriggerServerEvent('pizzajob:server:makePestoPasta')
    end, function() -- Play When Cancel
        TriggerEvent('pizzajob:client:failedTask')
    end)

end)

RegisterNetEvent('pizzajob:client:makePizzaPrep', function(data)
            QBCore.Functions.Progressbar('makePizzaPrep', 'Lägger på alla pålägg', 1000, false, true, { -- Name | Label | Time | useWhileDead | canCancel
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = 'anim@gangops@facility@servers@',
        anim = 'hotwire',
        flags = 16,
    }, {}, {}, function() -- Play When Done
        TriggerServerEvent('pizzajob:server:makePestoPasta')
    end, function() -- Play When Cancel
        TriggerEvent('pizzajob:client:failedTask')
        end)

end)

RegisterNetEvent('pizzajob:client:failedTask', function(data)
    QBCore.Functions.Notify('Något gick fel', 'error', 5500)
end)

RegisterNetEvent('pizzajob:client:execute1', function(data) -- Preppa Mat
    ExecuteCommand('1')
end)

RegisterNetEvent('pizzajob:client:execute2', function(data) -- Tillaga Mat
    ExecuteCommand('2')
end)