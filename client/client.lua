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


local currentDestination = 1
local IsMissionStarted = false






function SpawnNPC()
    local npcConfig = Config.NPC
    RequestModel(GetHashKey(npcConfig.Model))
    while not HasModelLoaded(GetHashKey(npcConfig.Model)) do
        Wait(1)
    end
    local npc = CreatePed(npcConfig.PedType, GetHashKey(npcConfig.Model), npcConfig.x, npcConfig.y, npcConfig.z, npcConfig.h, false, true)
    SetPedCanBeTargetted(npc, false)
    SetPedAsEnemy(npc, false)
    SetBlockingOfNonTemporaryEvents(npc, true)
    FreezeEntityPosition(npc, true)
    local animDict = 'anim@amb@casino@brawl@reacts@standing@'
    local animName = 'm_standing_01_gawk_loop_06'
    RequestAnimDict(animDict)
    while not HasAnimDictLoaded(animDict) do
        Wait(1)
    end
    TaskPlayAnim(npc, animDict, animName, 8.0, -8.0, -1, 1, 0, false, false, false)
end


if Config.NpcOn then

    SpawnNPC()

end

local shown = false
local inDistance = false

if Config.NpcOn then
    Citizen.CreateThread(function()
        while true do
            local playerCoords = GetEntityCoords(PlayerPedId())
            local npcCoords = vector3(Config.NPC.x, Config.NPC.y, Config.NPC.z)
            local dist = #(playerCoords - npcCoords)

            if dist < 5 then
                if not shown then
                    if Config.ShowNotify == 'ox' then
                        lib.showTextUI(Strings['start'])
                    elseif Config.ShowNotify == 'default' then
                        DisplayHelpText(Strings['start'])
                    elseif Config.ShowNotify == 'okok' then
                        exports['okokTextUI']:Open(Strings['start'], 'darkblue', 'right')
                    elseif Config.ShowNotify == 'esx' then
                        ESX.TextUI(Strings['start'], "info")
                    end
                    shown = true
                end

                if IsControlJustReleased(0, 51) then
                    CkeckIntroStart()
                end

                Citizen.Wait(0)
            else
                if shown then
                    if Config.ShowNotify == 'ox' then
                        lib.hideTextUI()
                    elseif Config.ShowNotify == 'okok' then
                        exports['okokTextUI']:Close()
                    elseif Config.ShowNotify == 'esx' then
                        ESX.HideUI()
                    end
                    shown = false
                end
                Citizen.Wait(500) 
            end
        end
    end)
end



function DisplayHelpText(text)
    SetTextComponentFormat("STRING")
    AddTextComponentString(text)
    DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end


function CkeckIntroStart()
   if Config.DevMode then
    TriggerEvent('bx:startintro')
   else
    TriggerServerEvent('bx:checkintro')
   end
end

RegisterNetEvent('bx:startintro')
AddEventHandler('bx:startintro', function()
DoScreenFadeOut(250)
TriggerEvent('bx:StartLaScene')
 Wait(2500)
 TriggerServerEvent('bx:setPlayerBucket', GetPlayerServerId(PlayerId()), 1)
 teleportPlayer(Config.WaitDuringCinematic.x, Config.WaitDuringCinematic.y, Config.WaitDuringCinematic.z)
 DoScreenFadeIn(250)

end)




function GiveStarterPack()
    if Config.StartPack then
        TriggerServerEvent('bx_giveStarterPack')
    end
end

function DeleteTaxi(vehicle, driver)
	if DoesEntityExist(vehicle) then
		if IsPedInVehicle(PlayerPedId(), vehicle, false) then
			TaskLeaveVehicle(PlayerPedId(), vehicle, 0)
			Wait(2000)			
		end
		local blip = GetBlipFromEntity(vehicle)
		if DoesBlipExist(blip) then
			RemoveBlip(blip)
		end
		DeleteEntity(driver)
		DeleteEntity(vehicle)
	end
	if not DoesEntityExist(vehicle) and DoesEntityExist(driver) then
		DeleteEntity(driver)
	end
end


function DisplayHelpText(str)
	SetTextComponentFormat("STRING")
	AddTextComponentString(str)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end


function InitialSetup()
	SetManualShutdownLoadingScreenNui(true)
	ToggleSound(muteSound)
	if not IsPlayerSwitchInProgress() then
		SwitchOutPlayer(PlayerPedId(), 0, 1)
	end
end



function ToggleSound(state)
	if state then
		StartAudioScene("MP_LEADERBOARD_SCENE");
	else
		StopAudioScene("MP_LEADERBOARD_SCENE");
	end
end


xSound = exports.xsound

RegisterNetEvent('MusiqueBienvenue')
AddEventHandler('MusiqueBienvenue', function()
    local pos = GetEntityCoords(PlayerPedId())
    local volume = Config.MusiqueBienvenueVolume  
    local url = Config.MusiqueBienvenueURL 
    xSound:PlayUrl("name", url, volume)

end)






local taxiVeh
local isTaxi = false
local Active = false







local sub_b0b5 = {
    [0] = "MP_Plane_Passenger_1",
    [1] = "MP_Plane_Passenger_2",
    [2] = "MP_Plane_Passenger_3",
    [3] = "MP_Plane_Passenger_4",
    [4] = "MP_Plane_Passenger_5",
    [5] = "MP_Plane_Passenger_6",
    [6] = "MP_Plane_Passenger_7"
}

function sub_b747(ped, a_1)
    if a_1 == 0 then
        SetPedComponentVariation(ped, 0, 21, 0, 0)
        SetPedComponentVariation(ped, 1, 0, 0, 0)
        SetPedComponentVariation(ped, 2, 9, 0, 0)
        SetPedComponentVariation(ped, 3, 1, 0, 0)
        SetPedComponentVariation(ped, 4, 9, 0, 0)
        SetPedComponentVariation(ped, 5, 0, 0, 0)
        SetPedComponentVariation(ped, 6, 4, 8, 0)
        SetPedComponentVariation(ped, 7, 0, 0, 0)
        SetPedComponentVariation(ped, 8, 15, 0, 0)
        SetPedComponentVariation(ped, 9, 0, 0, 0)
        SetPedComponentVariation(ped, 10, 0, 0, 0)
        SetPedComponentVariation(ped, 11, 10, 0, 0)
        ClearPedProp(ped, 0)
        ClearPedProp(ped, 1)
        ClearPedProp(ped, 2)
        ClearPedProp(ped, 3)
        ClearPedProp(ped, 4)
        ClearPedProp(ped, 5)
        ClearPedProp(ped, 6)
        ClearPedProp(ped, 7)
        ClearPedProp(ped, 8)
    elseif a_1 == 1 then
        SetPedComponentVariation(ped, 0, 13, 0, 0)
        SetPedComponentVariation(ped, 1, 0, 0, 0)
        SetPedComponentVariation(ped, 2, 5, 4, 0)
        SetPedComponentVariation(ped, 3, 1, 0, 0)
        SetPedComponentVariation(ped, 4, 10, 0, 0)
        SetPedComponentVariation(ped, 5, 0, 0, 0)
        SetPedComponentVariation(ped, 6, 10, 0, 0)
        SetPedComponentVariation(ped, 7, 11, 2, 0)
        SetPedComponentVariation(ped, 8, 13, 6, 0)
        SetPedComponentVariation(ped, 9, 0, 0, 0)
        SetPedComponentVariation(ped, 10, 0, 0, 0)
        SetPedComponentVariation(ped, 11, 10, 0, 0)
        ClearPedProp(ped, 0)
        ClearPedProp(ped, 1)
        ClearPedProp(ped, 2)
        ClearPedProp(ped, 3)
        ClearPedProp(ped, 4)
        ClearPedProp(ped, 5)
        ClearPedProp(ped, 6)
        ClearPedProp(ped, 7)
        ClearPedProp(ped, 8)
    elseif a_1 == 2 then
        SetPedComponentVariation(ped, 0, 15, 0, 0)
        SetPedComponentVariation(ped, 1, 0, 0, 0)
        SetPedComponentVariation(ped, 2, 1, 4, 0)
        SetPedComponentVariation(ped, 3, 1, 0, 0)
        SetPedComponentVariation(ped, 4, 0, 1, 0)
        SetPedComponentVariation(ped, 5, 0, 0, 0)
        SetPedComponentVariation(ped, 6, 1, 7, 0)
        SetPedComponentVariation(ped, 7, 0, 0, 0)
        SetPedComponentVariation(ped, 8, 2, 9, 0)
        SetPedComponentVariation(ped, 9, 0, 0, 0)
        SetPedComponentVariation(ped, 10, 0, 0, 0)
        SetPedComponentVariation(ped, 11, 6, 0, 0)
        ClearPedProp(ped, 0)
        ClearPedProp(ped, 1)
        ClearPedProp(ped, 2)
        ClearPedProp(ped, 3)
        ClearPedProp(ped, 4)
        ClearPedProp(ped, 5)
        ClearPedProp(ped, 6)
        ClearPedProp(ped, 7)
        ClearPedProp(ped, 8)
    elseif a_1 == 3 then
        SetPedComponentVariation(ped, 0, 14, 0, 0)
        SetPedComponentVariation(ped, 1, 0, 0, 0)
        SetPedComponentVariation(ped, 2, 5, 3, 0)
        SetPedComponentVariation(ped, 3, 3, 0, 0)
        SetPedComponentVariation(ped, 4, 1, 6, 0)
        SetPedComponentVariation(ped, 5, 0, 0, 0)
        SetPedComponentVariation(ped, 6, 11, 5, 0)
        SetPedComponentVariation(ped, 7, 0, 0, 0)
        SetPedComponentVariation(ped, 8, 2, 0, 0)
        SetPedComponentVariation(ped, 9, 0, 0, 0)
        SetPedComponentVariation(ped, 10, 0, 0, 0)
        SetPedComponentVariation(ped, 11, 3, 12, 0)
        ClearPedProp(ped, 0)
        ClearPedProp(ped, 1)
        ClearPedProp(ped, 2)
        ClearPedProp(ped, 3)
        ClearPedProp(ped, 4)
        ClearPedProp(ped, 5)
        ClearPedProp(ped, 6)
        ClearPedProp(ped, 7)
        ClearPedProp(ped, 8)
    elseif a_1 == 4 then
        SetPedComponentVariation(ped, 0, 18, 0, 0)
        SetPedComponentVariation(ped, 1, 0, 0, 0)
        SetPedComponentVariation(ped, 2, 15, 3, 0)
        SetPedComponentVariation(ped, 3, 15, 0, 0)
        SetPedComponentVariation(ped, 4, 2, 5, 0)
        SetPedComponentVariation(ped, 5, 0, 0, 0)
        SetPedComponentVariation(ped, 6, 4, 6, 0)
        SetPedComponentVariation(ped, 7, 4, 0, 0)
        SetPedComponentVariation(ped, 8, 3, 0, 0)
        SetPedComponentVariation(ped, 9, 0, 0, 0)
        SetPedComponentVariation(ped, 10, 0, 0, 0)
        SetPedComponentVariation(ped, 11, 4, 0, 0)
        ClearPedProp(ped, 0)
        ClearPedProp(ped, 1)
        ClearPedProp(ped, 2)
        ClearPedProp(ped, 3)
        ClearPedProp(ped, 4)
        ClearPedProp(ped, 5)
        ClearPedProp(ped, 6)
        ClearPedProp(ped, 7)
        ClearPedProp(ped, 8)
    elseif a_1 == 5 then
        SetPedComponentVariation(ped, 0, 27, 0, 0)
        SetPedComponentVariation(ped, 1, 0, 0, 0)
        SetPedComponentVariation(ped, 2, 7, 3, 0)
        SetPedComponentVariation(ped, 3, 11, 0, 0)
        SetPedComponentVariation(ped, 4, 4, 8, 0)
        SetPedComponentVariation(ped, 5, 0, 0, 0)
        SetPedComponentVariation(ped, 6, 13, 14, 0)
        SetPedComponentVariation(ped, 7, 5, 3, 0)
        SetPedComponentVariation(ped, 8, 3, 0, 0)
        SetPedComponentVariation(ped, 9, 0, 0, 0)
        SetPedComponentVariation(ped, 10, 0, 0, 0)
        SetPedComponentVariation(ped, 11, 2, 7, 0)
        ClearPedProp(ped, 0)
        ClearPedProp(ped, 1)
        ClearPedProp(ped, 2)
        ClearPedProp(ped, 3)
        ClearPedProp(ped, 4)
        ClearPedProp(ped, 5)
        ClearPedProp(ped, 6)
        ClearPedProp(ped, 7)
        ClearPedProp(ped, 8)
    elseif a_1 == 6 then
        SetPedComponentVariation(ped, 0, 16, 0, 0)
        SetPedComponentVariation(ped, 1, 0, 0, 0)
        SetPedComponentVariation(ped, 2, 15, 1, 0)
        SetPedComponentVariation(ped, 3, 3, 0, 0)
        SetPedComponentVariation(ped, 4, 5, 6, 0)
        SetPedComponentVariation(ped, 5, 0, 0, 0)
        SetPedComponentVariation(ped, 6, 2, 8, 0)
        SetPedComponentVariation(ped, 7, 0, 0, 0)
        SetPedComponentVariation(ped, 8, 2, 0, 0)
        SetPedComponentVariation(ped, 9, 0, 0, 0)
        SetPedComponentVariation(ped, 10, 0, 0, 0)
        SetPedComponentVariation(ped, 11, 3, 7, 0)
        ClearPedProp(ped, 0)
        ClearPedProp(ped, 1)
        ClearPedProp(ped, 2)
        ClearPedProp(ped, 3)
        ClearPedProp(ped, 4)
        ClearPedProp(ped, 5)
        ClearPedProp(ped, 6)
        ClearPedProp(ped, 7)
        ClearPedProp(ped, 8)
    end
end



RegisterNetEvent('bx:StartLaScene', function()
    TriggerEvent('MusiqueBienvenue')
    local plyrId = PlayerPedId() 
    if IsMale(plyrId) then
		RequestCutsceneWithPlaybackList("MP_INTRO_CONCAT", 31, 8)
	else	
		RequestCutsceneWithPlaybackList("MP_INTRO_CONCAT", 103, 8)
	end
    while not HasCutsceneLoaded() do Wait(10) end 
	if IsMale(plyrId) then
		RegisterEntityForCutscene(0, 'MP_Male_Character', 3, GetEntityModel(PlayerPedId()), 0)
		RegisterEntityForCutscene(PlayerPedId(), 'MP_Male_Character', 0, 0, 0)
		SetCutsceneEntityStreamingFlags('MP_Male_Character', 0, 1) 
		local female = RegisterEntityForCutscene(0,"MP_Female_Character",3,0,64) 
		NetworkSetEntityInvisibleToNetwork(female, true)
	else
		RegisterEntityForCutscene(0, 'MP_Female_Character', 3, GetEntityModel(PlayerPedId()), 0)
		RegisterEntityForCutscene(PlayerPedId(), 'MP_Female_Character', 0, 0, 0)
		SetCutsceneEntityStreamingFlags('MP_Female_Character', 0, 1) 
		local male = RegisterEntityForCutscene(0,"MP_Male_Character",3,0,64) 
		NetworkSetEntityInvisibleToNetwork(male, true)
	end
	local ped = {}
	for v_3=0, 6, 1 do
		if v_3 == 1 or v_3 == 2 or v_3 == 4 or v_3 == 6 then
			ped[v_3] = CreatePed(26, `mp_f_freemode_01`, -1117.77783203125, -1557.6248779296875, 3.3819, 0.0, 0, 0)
		else
			ped[v_3] = CreatePed(26, `mp_m_freemode_01`, -1117.77783203125, -1557.6248779296875, 3.3819, 0.0, 0, 0)
		end
        if not IsEntityDead(ped[v_3]) then
			sub_b747(ped[v_3], v_3)
            FinalizeHeadBlend(ped[v_3])
            RegisterEntityForCutscene(ped[v_3], sub_b0b5[v_3], 0, 0, 64)
        end
    end
	
	NewLoadSceneStartSphere(-1212.79, -1673.52, 7, 1000, 0) 
    SetWeatherTypeNow("EXTRASUNNY")
    StartCutscene(4)
        

    Wait(34520) 
    for v_3=0, 6, 1 do
        DeleteEntity(ped[v_3])
    end
    PrepareMusicEvent("AC_STOP")
    TriggerMusicEvent("AC_STOP")
    StopCutsceneImmediately()
    DoScreenFadeOut(250)
    ClearPedWetness(plyrId)
    if Config.useTaxi then
        DoScreenFadeIn(300)
        CreateTaxi(Config.TaxiSpawn)
    else
        xSound:Destroy("name")
        DoScreenFadeIn(300)
        GiveStarterPack()
        SetEntityCoords(plyrId, Config.SpawnPedLoc)
    end
end) 


function IsMale(ped)
	if IsPedModel(ped, 'mp_m_freemode_01') then
		return true
	else
		return false
	end
end



function CreateTaxiPed(vehicle)
	local model = GetHashKey("a_m_y_stlat_01")
	if DoesEntityExist(vehicle) then
		if IsModelValid(model) then
			RequestModel(model)
			while not HasModelLoaded(model) do
				Wait(1)
			end
			taxiPed = CreatePedInsideVehicle(vehicle, 26, model, -1, true, false)
			SetAmbientVoiceName(ped, "A_M_M_EASTSA_02_LATINO_FULL_01")	
			SetBlockingOfNonTemporaryEvents(ped, true)
			SetEntityAsMissionEntity(ped, true, true)
			SetModelAsNoLongerNeeded(model)
		end
	end
end



function CreateTaxi(x, y, z)
	local taxiModel = Config.Taxi
	if IsModelValid(taxiModel) then
		if IsThisModelACar(taxiModel) then
			RequestModel(taxiModel)
			while not HasModelLoaded(taxiModel) do
				Wait(1)
			end
			if not DoesEntityExist(taxiVeh) then
                PlaySoundFrontend(-1, "Text_Arrive_Tone", "Phone_SoundSet_Default", 1)
                taxiVeh = CreateVehicle(taxiModel, x, y, z, Config.TaxiSpawn.w, true, false)
                SetVehicleNumberPlateText(taxiVeh, Config.TaxiPlate)
                SetEntityAsMissionEntity(taxiVeh, true, true)
                SetVehicleEngineOn(taxiVeh, true, true, false)
                SetVehicleOnGroundProperly(taxiVeh)
                CreateTaxiPed(taxiVeh)
                local blip = AddBlipForEntity(taxiVeh)
                SetBlipSprite(blip, 198)
                SetBlipFlashes(blip, true)
                SetBlipFlashTimer(blip, 5000)
                SetModelAsNoLongerNeeded(taxiModel)
                SetHornEnabled(taxiVeh, true)
                StartVehicleHorn(taxiVeh, 1000, GetHashKey("NORMAL"), false)
                SetPedIntoVehicle(PlayerPedId(), taxiVeh, 0)
                if IsPedInVehicle(PlayerPedId(), taxiVeh, 1) then
                    DoScreenFadeIn(250)
                    TriggerServerEvent('bx:setEntityBucket', taxiPed, 1)
                    SetVehicleDoorsLocked(taxiVeh, 4)
                    SetVehicleRadioEnabled(taxiVeh, false)
                    TaskVehicleDriveToCoord(taxiPed, taxiVeh, Config.TaxiDestination.x, Config.TaxiDestination.y, Config.TaxiDestination.z, Config.TaxiSpeed, 0, GetEntityModel(taxiVeh), Config.TaxiDrivingStyle, 2.0)
                    SetPedKeepTask(taxiPed, true)
                    Active = true
                    print(Active)
                    Wait(10000)
                    isTaxi = true
                end
			end
		end
	end	
end



Citizen.CreateThread(function()
    local sleep = 200
    while true do
        if Active then
            local player = PlayerPedId()
            local vehicle = GetVehiclePedIsIn(player, false)
            local dist = #(GetEntityCoords(player) - vector3(Config.TaxiDestination.x, Config.TaxiDestination.y, Config.TaxiDestination.z))

            if dist <= 15 then
                ClearPedTasks(player) 
                TaskVehiclePark(taxiPed, vehicle, Config.TaxiDestination.x, Config.TaxiDestination.y, Config.TaxiDestination.z, Config.TaxiHeading, 0, 20.0, true)
                Wait(10000)
                xSound:Destroy("name")
                GiveStarterPack()
                TaskLeaveVehicle(player, vehicle, 0)
                while IsPedInVehicle(player, vehicle, false) do
                    Wait(100)
                end
                Wait(2000)
               TaskVehicleDriveToCoord(taxiPed, vehicle, Config.NewDestination.x, Config.NewDestination.y, Config.NewDestination.z, Config.NewDestination.w, 0, GetEntityModel(vehicle), 1074528293, 10.0)
               Wait(15000)
                DeleteTaxi(vehicle, taxiPed)
                TriggerServerEvent('bx:restorePlayerBucket', GetPlayerServerId(PlayerId()))
                Active = false
                isTaxi = false
            end
            if isTaxi then
                if Config.PlayerCanSkip then
                    sleep = 3
                    DisplayHelpText('~INPUT_FRONTEND_RRIGHT~ '.. Strings['presstoskip']) 
                    if IsControlJustPressed(1, 194) then
                        DoScreenFadeOut(2500)
                        Wait(3000)
                        SetEntityCoords(vehicle, vector3(Config.SkipToNearestLoc.x, Config.SkipToNearestLoc.y, Config.SkipToNearestLoc.z))
                        SetEntityHeading(vehicle, Config.SkipToNearestLoc.w)
                        DoScreenFadeIn(250)
                        isTaxi = false
                        sleep = 200
                    end
                end
            end
        end
        Wait(sleep)
    end
end)



function teleportPlayer(x, y, z)
    local playerPed = PlayerPedId()
    if playerPed then
        SetEntityCoords(playerPed, x, y, z, false, false, false, true)
    end
end

