ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

    while ESX.GetPlayerData().job == nil do
        Citizen.Wait(10)
    end

    ESX.PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent("IDCARD:USE")
AddEventHandler("IDCARD:USE", function()
    closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()				
    if closestDistance ~= -1 and closestDistance <= 2.0 then
        ESX.ShowNotification((_LConfig.playerReceiveCard):format(GetPlayerName(closestPlayer)))
        TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(closestPlayer))
    else
        ESX.ShowNotification(_LConfig.nobodyFound)
        TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(PlayerId()))
    end
    Citizen.Wait(1)
end)

RegisterNetEvent("DMVCARD:USE")
AddEventHandler("DMVCARD:USE", function()
    closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()				
    if closestDistance ~= -1 and closestDistance <= 2.0 then
        ESX.ShowNotification((playerReceiveCard):format(GetPlayerName(closestPlayer)))
        TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(closestPlayer), 'driver')
    else
        ESX.ShowNotification(_LConfig.nobodyFound)
        TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(PlayerId()), 'driver')
        -- TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(PlayerId()), 'weapon')
    end
    Citizen.Wait(1)
end)

RegisterNetEvent("WCARD:USE")
AddEventHandler("WCARD:USE", function()
    closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()							
    if closestDistance ~= -1 and closestDistance <= 2.0 then
        ESX.ShowNotification((playerReceiveCard):format(GetPlayerName(closestPlayer)))
        TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(closestPlayer), 'weapon')
    else
        ESX.ShowNotification(_LConfig.nobodyFound)
        TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(PlayerId()), 'weapon')
    end
    Citizen.Wait(1)
end)

RegisterNetEvent("JOBCARD:USE")
AddEventHandler("JOBCARD:USE", function(user)
    closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end

    ESX.PlayerData = ESX.GetPlayerData()

    local userData = user[1]
    local name     = userData.firstname
    local name2    = userData.lastname
    
    if closestDistance ~= -1 and closestDistance <= 2.0 then
        ESX.ShowNotification(("[~b~Inventaire~s~]~n~ %s a bien reçu votre carte."):format(GetPlayerName(closestPlayer)))
        for job,info in pairs(_LConfig.jobs) do
            if ESX.PlayerData.job.name == job then
                local msg = info.message
                local DataPlayer = ESX.PlayerData
                TriggerServerEvent('JOBCARD:MSG', GetPlayerServerId(closestPlayer), msg, name, name2, DataPlayer)
                return
            end
        end
        local msg = _LConfig.defaultJobMessage
        local DataPlayer = ESX.PlayerData
        TriggerServerEvent('JOBCARD:MSG', GetPlayerServerId(closestPlayer), msg, name, name2, DataPlayer)
    else
        ESX.ShowNotification(_LConfig.nobodyFound)
        for job,info in pairs(_LConfig.jobs) do
            if ESX.PlayerData.job.name == job then
                ESX.ShowNotification((info.message):format(name, name2, ESX.PlayerData.job.label, ESX.PlayerData.job.grade_label))
                return
            end
        end
        ESX.ShowNotification((_LConfig.defaultJobMessage):format(name, name2, ESX.PlayerData.job.label, ESX.PlayerData.job.grade_label)) -- 
    end
    Citizen.Wait(1)
end)

