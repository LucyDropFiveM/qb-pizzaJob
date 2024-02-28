	
CreateThread(function()
        exports['qb-target']:AddBoxZone("pizzajobduty", vector3(-1345.55, -1060.86, 3.87), 1, 1.2, {
            name = "pizzajobduty",
            heading = 32,
            debugPoly = true,
            minZ=1.0,
            maxZ=5.0,
        }, {
            options = {
                {  
                event = "pizzajob:client:DutyB",
                icon = "far fa-clipboard",
                label = "Clock In/Out",
                job = Config.Job,
                },
            },
            distance = 1.5
        })

    



    
    exports['qb-target']:AddBoxZone("resturanttray1", vector3(-1345.07, -1065.24, 8.31), 1.05, 1.0, {
        name = "resturanttray1",
        heading = 35.0,
        debugPoly = Config.DevMode,
        minZ=6.8,
        maxZ=9.3,
    }, {
        options = {
            {
            event = "pizzajob:client:Tray1",
            icon = "far fa-clipboard",
            label = "Tray",
            },
        },
        distance = 1.5
    })


            exports['qb-target']:AddBoxZone("pizzajobregister1", vector3(-1346.07, -1065.80, 8.31), 0.5, 0.4, {
            name="pizzajobregister1",
            debugPoly=Config.DevMode,
            heading=125,
            minZ=6.2,
            maxZ=8.2,
        }, {
                options = {
                    {
                        event = "pizzajob:client:bill",
                        parms = "1",
                        icon = "fas fa-credit-card",
                        label = "Fakturera Kund",
                        job = "pizzajob",
                    },
                },
                distance = 1.5
            })




            exports['qb-target']:AddBoxZone("prepFood1", vector3(-1339.99, -1061.94, 7.39), 1.0, 1.0, {
            name="prepFood1",
            debugPoly=Config.DevMode,
            heading=125,
            minZ=6.2,
            maxZ=8.2,
        }, {
                options = {
                    {
                        event = "pizzajob:client:execute1",
                        icon = "fas fa-credit-card",
                        label = "Prep food",
                        job = "pizzajob",
                    },
                },
                distance = 1.5
            })


            exports['qb-target']:AddBoxZone("cookFood1", vector3(-1338.64, -1061.13, 7.39), 1.0, 1.0, {
            name="cookFood1",
            debugPoly=Config.DevMode,
            heading=125,
            minZ=6.2,
            maxZ=8.2,
        }, {
                options = {
                    {
                        event = "pizzajob:client:execute2",

                        icon = "fas fa-credit-card",
                        label = "Cook",
                        job = "pizzajob",
                    },
                },
                distance = 1.5
            })



end)


RegisterNetEvent("pizzajob:client:bill")
AddEventHandler("pizzajob:client:bill", function()
    local bill = exports['qb-input']:ShowInput({
        header = "Make Receipt",
		submitText = "Bill",
        inputs = {
            {
                text = "Server ID(#)",
				name = "serverid", 
                type = "text", 
                isRequired = true 
            },
            {
                text = "Bill amount", 
                name = "bill", 
                type = "number", 
                isRequired = false 
            }
			
        }
    })
    if bill ~= nil then
        if bill.citizenid == nil or bill.billprice == nil then 
            return 
        end
        TriggerServerEvent("pizzajob:client:billPlayer", bill.citizenid, bill.billprice)
    end
end)
