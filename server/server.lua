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
