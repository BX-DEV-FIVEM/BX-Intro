Config = {}

Config.DevMode = false -- if true bypass sql check

----- Setting ----- 

Config.StartPack = true

Config.StarterPackItems = { -- if Config.StartPack = true
    {item = "money", amount = 50},
    {item = "bread", amount = 1}
}

Config.WaitDuringCinematic = vector3(-1625.0665, -3160.8740, 13.9959) -- Tp player during plane cinematic

Config.CheckUpdate = true

----- NPC Setting ----- 


Config.NpcOn = true -- if start with interaction with NPC / false you have to trigger  TriggerEvent('bx:StartLaScene') for start

Config.NPC = { -- if Config.NpcOn = true
    PedType = 26,
    Model = 'cs_movpremmale',  -- NPC model
    x = -1122.051 ,y = -2791.3450, z = 15.5906, h = 239.8188   -- Pos NPC  
}




----- Notify Setting ----- 


Config.ShowNotify = 'ox' -- default ( DisplayHelpText ) / esx ( ESX.TextUI ) / okok (OKOK.TextUi) / ox ( Ox.Lib ) -- don't forget to uncomment  '@ox_lib/init.lua', in manifest


----- Taxi Setting ----- 


Config.useTaxi = true          --Use AI Taxi or Not?

Config.SpawnPedLoc = vector3(-1044.91, -2750.2, 21.36)    --If not using AI Taxi then set player spawn location 

Config.Taxi = `nightshade`                                     --Taxi Model

Config.TaxiPlate = 'BX-DEV'                              --Taxi Number Plate

Config.TaxiSpawn = vector4(-1058.48, -2713.28, 20.17, 240.05)       --Taxi First Spawn Location   

Config.TaxiDestination = vector3(-521.7092, -266.4742, 35.3202)         --Taxi Destination Lcoation   

Config.TaxiSpeed = 25.0

Config.TaxiDrivingStyle = 524863

Config.TaxiHeading = 110.7019 -- heading for Parking destination 

Config.PlayerCanSkip = true -- player can skip to SkipToNearestLoc

Config.SkipToNearestLoc = vector4(-472.1253, -251.7663, 35.9601, 107.3558)       -- Taxi Skip Nearest Location to destination must be next to Config.TaxiDestination

Config.NewDestination = vector4(-1044.0, -2749.0, 37.47, 21.00) -- Coordinates where the NPC leaves with the car




----- Music Setting ----- 

Config.MusiqueBienvenueURL = "https://www.youtube.com/watch?v=M4QSMqvuWMg" -- Must be a YouTube link 
Config.MusiqueBienvenueVolume = 0.5 -- Volume



----- Translation ----- 



Strings = { --- translation
    ['start'] = '[E] - Start the adventure',
    ['presstoskip'] = 'To Skip',
}






