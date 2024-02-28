QBCore = exports['qb-core']:GetCoreObject()
isLoggedIn = false
local onDuty = false
PlayerJob = {}


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
CreateThread(function()
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
            header = 'Cook food',
            icon = 'fas fa-code',
            isMenuHeader = true, -- Set to true to make a nonclickable title
        },
        {
            header = 'Cook spaghetti',
            txt = 'Cook spaghetti for pesto pasta',
            icon = 'fas fa-code-merge',
            params = {
                isServer = false,
                event = 'pizzajob:client:cookPasta',
            }
        },  
        {
            header = 'Roast bread',
            txt = 'Roast the bread, used for bruschetta',
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
            header = 'Cook food',
            icon = 'fas fa-code',
            isMenuHeader = true, -- Set to true to make a nonclickable title
        },
        {
            header = 'Make Pesto Pasta',
            txt = 'Pesto, Cooked Spaghetti',
            icon = 'fas fa-code-merge',
            params = {
                isServer = false,
                event = 'pizzajob:client:makePestoPasta',
            }
        },  
        {
            header = 'Make Bruschetta',
            txt = 'Toasted Bread, Salad',
            icon = 'fas fa-code-pull-request',
            -- disabled = false, -- optional, non-clickable and grey scale
            -- hidden = true, -- optional, hides the button completely
            params = {
                 isServer = false, -- optional, specify event type
                event = 'pizzajob:client:cookBrus',
            }
        },
        {
            header = 'Make Pizza',
            txt = 'Pizza Dough, Tomatosauce, Peperoni',
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
    QBCore.Functions.Progressbar('cookPasta', 'Cooking pasta', 1000, false, true, { -- Name | Label | Time | useWhileDead | canCancel
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
        QBCore.Functions.Progressbar('cookBread', 'Toasting Bread', 1000, false, true, { -- Name | Label | Time | useWhileDead | canCancel
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
        QBCore.Functions.Progressbar('cookBrus1', 'Putting on the salad', 1000, false, true, { -- Name | Label | Time | useWhileDead | canCancel
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
    QBCore.Functions.Progressbar('cookPizza', 'Putting on peperoni', 10000, false, true, { -- Name | Label | Time | useWhileDead | canCancel
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
        QBCore.Functions.Progressbar('makePestoPasta', 'Cooking Pesto Pasta', 1000, false, true, { -- Name | Label | Time | useWhileDead | canCancel
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
            QBCore.Functions.Progressbar('makePizzaPrep', 'Puts on ornaments', 1000, false, true, { -- Name | Label | Time | useWhileDead | canCancel
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
    QBCore.Functions.Notify('Something went wrong', 'error', 5500)
end)

RegisterNetEvent('pizzajob:client:execute1', function(data) -- Preppa Mat
    ExecuteCommand('1')
end)

RegisterNetEvent('pizzajob:client:execute2', function(data) -- Tillaga Mat
    ExecuteCommand('2')
end)
