if Config.UseOldEsx then
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
else
    ESX = exports["es_extended"]:getSharedObject()
end


RegisterServerEvent('bx_giveStarterPack')
AddEventHandler('bx_giveStarterPack', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    if xPlayer then
        for _, item in pairs(Config.StarterPackItems) do
            if item.item == "money" then
                xPlayer.addMoney(item.amount)
            else
                xPlayer.addInventoryItem(item.item, item.amount)
            end
        end
    end
end)



RegisterServerEvent('bx:checkintro')
AddEventHandler('bx:checkintro', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    if xPlayer then
        local identifier = xPlayer.identifier
        MySQL.Async.fetchScalar('SELECT intro_statut FROM users WHERE identifier = @identifier', {
            ['@identifier'] = identifier
        }, function(starterPackGiven)
            starterPackGiven = tonumber(starterPackGiven)

            if starterPackGiven == 0 then
                MySQL.Async.execute('UPDATE users SET intro_statut = 1 WHERE identifier = @identifier', {
                    ['@identifier'] = identifier
                })
                TriggerClientEvent('bx:startintro', _source)
            else

            end
        end)
    end
end)


RegisterNetEvent('bx:setPlayerBucket')
AddEventHandler('bx:setPlayerBucket', function(source, bucketId)
    SetPlayerRoutingBucket(source, bucketId)
    
end)

RegisterNetEvent('bx:restorePlayerBucket')
AddEventHandler('bx:restorePlayerBucket', function(source)
    SetPlayerRoutingBucket(source, 0)
end)


RegisterNetEvent('bx:setEntityBucket')
AddEventHandler('bx:setEntityBucket', function(entityId, bucketId)
    SetEntityRoutingBucket(entity, 1)
end)

AddEventHandler('playerDropped', function(reason)
    local src = source
    SetPlayerRoutingBucket(src, 0)
end)
