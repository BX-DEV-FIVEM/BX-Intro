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



local usedPlayers = {}

local function checkIfUsed(id, cb)
    local _src = id
    local xPlayer = ESX.GetPlayerFromId(_src)
    local identifier = xPlayer.identifier

    -- Vérifier dans le cache local
    for _, player in ipairs(usedPlayers) do
        if player.id == _src then
            print("[INFO] Player already in cache, has seen the intro")
            if cb then
                return cb(true)
            else
                return true
            end
        end
    end

    -- Vérifier dans la base de données
    MySQL.Async.fetchAll("SELECT intro_statut FROM BX_Intro WHERE player_id = @identifier", {
        ['@identifier'] = identifier
    }, function(result)
        if result and #result > 0 and result[1].intro_statut then
            table.insert(usedPlayers, {id = _src})
            if cb then
                return cb(true)
            else
                return true
            end
        else
            if cb then
                return cb(false)
            else
                return false
            end
        end
    end)
end

local function updateUser(id, cb)
    local _src = id
    local xPlayer = ESX.GetPlayerFromId(_src)
    local identifier = xPlayer.identifier

    table.insert(usedPlayers, {id = _src})

    MySQL.Async.execute("INSERT INTO BX_Intro (player_id, intro_statut) VALUES (@identifier, true) ON DUPLICATE KEY UPDATE intro_statut = true", {
        ['@identifier'] = identifier
    }, function(row)
        if cb then
            return cb(row > 0)
        else
            return row > 0
        end
    end)
end

RegisterServerEvent('bx:checkintro')
AddEventHandler('bx:checkintro', function()
    local _src = source
    checkIfUsed(_src, function(hasSeenIntro)
        if not hasSeenIntro then
            updateUser(_src, function(success)
                if success then
                    TriggerClientEvent('bx:startintro', _src)
                else
                    print("[ERROR] Failed to update intro status for player " .. _src)
                end
            end)
        else
           -- print("[INFO] Player " .. _src .. " has already seen the intro")
        end
    end)
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
