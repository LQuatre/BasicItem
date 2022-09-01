ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterUsableItem('idcard', function(source)
    local _source = source
    TriggerClientEvent("IDCARD:USE", _source)
end)

ESX.RegisterUsableItem('dmvcard', function(source)
    local _source = source
    TriggerClientEvent("DMVCARD:USE", _source)
end)

ESX.RegisterUsableItem('licensecard', function(source)
    local _source = source
    TriggerClientEvent("WCARD:USE", _source)
end)

ESX.RegisterUsableItem("jobcard", function(source)
	local _source    = source
    local xPlayer    = ESX.GetPlayerFromId(_source)
	local identifier = ESX.GetPlayerFromId(_source).identifier
    local name       = xPlayer.getName()

	MySQL.Async.fetchAll('SELECT firstname, lastname, dateofbirth, sex, height FROM users WHERE identifier = @identifier', 
    {['@identifier'] = identifier},
	function (user)
        TriggerClientEvent("JOBCARD:USE", _source, user, firstname, lastname)
	end)
end)

RegisterNetEvent('JOBCARD:MSG')
AddEventHandler('JOBCARD:MSG', function(closestPlayer, msg, name, name2, DataPlayer)
    TriggerClientEvent('esx:showNotification', closestPlayer, (msg):format(name, name2, DataPlayer.job, DataPlayer.job_grade))
end)