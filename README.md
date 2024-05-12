![1](https://github.com/BX-DEV-FIVEM/BX-INTRO/assets/140925178/1be062d9-5130-4d0d-b305-ab8824190505)

![2](https://github.com/BX-DEV-FIVEM/BX-INTRO/assets/140925178/d7f4ad2e-742e-49e5-8520-e8a315dde7e2)


***
**Introducing BX-Intro, an advanced FiveM script that enriches the initial server entry experience with personalized cinematic intros, customizable welcome music, NPC interactions, and tailored starter packs. This script provides an immersive and dynamic start for new players on your server.**

***

**Features**

* **🎬 Cinematic Intro**: Launch your server experience with a stunning cinematic sequence, trigger via Interactive NPC or Event.
* **🎶 Customizable Welcome Music**: Enhance the cinematic experience with selectable welcome music via YouTube links, adjustable right from the config.
* **📦 Configurable Starter Packs**: Equip new players with starter items such as money, food, or any other essentials to help them begin their journey.
* **🚖 Advanced Taxi System**: Offer players a choice between direct transport with an AI-controlled taxi or teleportation to specific coordinates.
* **📢 Multiple Notification Systems**: Support for various notification systems like ESX, OKOK, or OX.
* **🔄 Auto Updates**: Automatic Updates.
* **♻️ Compatibility with Older Versions of ESX**: Support for older versions of ESX for better flexibility.
* **🟢 Maximum Optimization**: Zero minimal impact on performance (0.00 ms).

***

***🚀 UPDATE 🚀*** 

* **☑️ ADD SQL CHECK**: Check if player have already do the intro ( one use per player ).
* **🧑‍🤝‍🧑 Femal Skin fix** : Fix the character's look (male or female) on the plane.
* **🕶️ Invisibility** : During the taxi animation, the player is in 'ghost mode' for an interference-free experience


***

**🚨**

* **⚠️Don't forget to add "TriggerEvent('bx:StartLaScene')" in your custom script if Config.NpcOn = false**
* **⚠️ADD SQL FILE**

**🚨**
***
**Dependencies**

* **ESX**
* **xSound** 


***

**Configuration**

<details>
<summary><strong>Config.lua</strong></summary>

```lua
Config = {}

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










```

</details>


***
**Live Preview**

[YOUTUBE](https://www.youtube.com/watch?v=E-sW5ZYng54)


***

**BX-DOCUMENTATION**

[DOCUMENTATION](https://bx-devs.gitbook.io/doc)

***

For any questions or support, feel free to join us !

[![Discord](https://github.com/BX-DEV-FIVEM/BX-Carjob/assets/140925178/6b508333-aa27-44ff-9b3c-9030b00c1f28)](https://discord.gg/GhAcTjNcu8)


