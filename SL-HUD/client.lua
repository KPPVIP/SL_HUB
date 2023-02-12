local localplayer
local isActive = false
local playerCash
local bankMoney
local blackMoney
local ESX = nil
local loaded = false
local playerJob
local playerJobRank
local streetName
local area
local keybindsEnabled = false
local keys = {
    ["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
    ["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
    ["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 20, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
    ["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
    ["LEFTSHIFT"] = 21, ["Z"] = 246, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
    ["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
    ["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
    ["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,

    --Numpad
    ["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}
local zoneNames = { ['AIRP'] = "Los Santos International Airport", ['ALAMO'] = "Alamo Sea", ['ALTA'] = "Alta", ['ARMYB'] = "Fort Zancudo", ['BANHAMC'] = "Banham Canyon Dr", ['BANNING'] = "Banning", ['BEACH'] = "Vespucci Beach", ['BHAMCA'] = "Banham Canyon", ['BRADP'] = "Braddock Pass", ['BRADT'] = "Braddock Tunnel", ['BURTON'] = "Burton", ['CALAFB'] = "Calafia Bridge", ['CANNY'] = "Raton Canyon", ['CCREAK'] = "Cassidy Creek", ['CHAMH'] = "Chamberlain Hills", ['CHIL'] = "Vinewood Hills", ['CHU'] = "Chumash", ['CMSW'] = "Chiliad Mountain State Wilderness", ['CYPRE'] = "Cypress Flats", ['DAVIS'] = "Davis", ['DELBE'] = "Del Perro Beach", ['DELPE'] = "Del Perro", ['DELSOL'] = "La Puerta", ['DESRT'] = "Grand Senora Desert", ['DOWNT'] = "Downtown", ['DTVINE'] = "Downtown Vinewood", ['EAST_V'] = "East Vinewood", ['EBURO'] = "El Burro Heights", ['ELGORL'] = "El Gordo Lighthouse", ['ELYSIAN'] = "Elysian Island", ['GALFISH'] = "Galilee", ['GOLF'] = "GWC and Golfing Society", ['GRAPES'] = "Grapeseed", ['GREATC'] = "Great Chaparral", ['HARMO'] = "Harmony", ['HAWICK'] = "Hawick", ['HORS'] = "Vinewood Racetrack", ['HUMLAB'] = "Humane Labs and Research", ['JAIL'] = "Bolingbroke Penitentiary", ['KOREAT'] = "Little Seoul", ['LACT'] = "Land Act Reservoir", ['LAGO'] = "Lago Zancudo", ['LDAM'] = "Land Act Dam", ['LEGSQU'] = "Legion Square", ['LMESA'] = "La Mesa", ['LOSPUER'] = "La Puerta", ['MIRR'] = "Mirror Park", ['MORN'] = "Morningwood", ['MOVIE'] = "Richards Majestic", ['MTCHIL'] = "Mount Chiliad", ['MTGORDO'] = "Mount Gordo", ['MTJOSE'] = "Mount Josiah", ['MURRI'] = "Murrieta Heights", ['NCHU'] = "North Chumash", ['NOOSE'] = "N.O.O.S.E", ['OCEANA'] = "Pacific Ocean", ['PALCOV'] = "Paleto Cove", ['PALETO'] = "Paleto Bay", ['PALFOR'] = "Paleto Forest", ['PALHIGH'] = "Palomino Highlands", ['PALMPOW'] = "Palmer-Taylor Power Station", ['PBLUFF'] = "Pacific Bluffs", ['PBOX'] = "Pillbox Hill", ['PROCOB'] = "Procopio Beach", ['RANCHO'] = "Rancho", ['RGLEN'] = "Richman Glen", ['RICHM'] = "Richman", ['ROCKF'] = "Rockford Hills", ['RTRAK'] = "Redwood Lights Track", ['SANAND'] = "San Andreas", ['SANCHIA'] = "San Chianski Mountain Range", ['SANDY'] = "Sandy Shores", ['SKID'] = "Mission Row", ['SLAB'] = "Stab City", ['STAD'] = "Maze Bank Arena", ['STRAW'] = "Strawberry", ['TATAMO'] = "Tataviam Mountains", ['TERMINA'] = "Terminal", ['TEXTI'] = "Textile City", ['TONGVAH'] = "Tongva Hills", ['TONGVAV'] = "Tongva Valley", ['VCANA'] = "Vespucci Canals", ['VESP'] = "Vespucci", ['VINE'] = "Vinewood", ['WINDF'] = "Ron Alternates Wind Farm", ['WVINE'] = "West Vinewood", ['ZANCUDO'] = "Zancudo River", ['ZP_ORT'] = "Port of South Los Santos", ['ZQ_UAR'] = "Davis Quartz", ['OBSERV'] = "Observatorium" }
Citizen.CreateThread(function()
    while not ESX do
        TriggerEvent("esx:getSharedObject", function(obj) 
            ESX = obj 
        end)
    Citizen.Wait(1000)
    end
end)

RegisterNetEvent("esx:playerLoaded")
    AddEventHandler("esx:playerLoaded", function()
        loaded = true
        localplayer = PlayerPedId()
end)

Citizen.CreateThread(function()
    if Config.debug then
        loaded = true
    end
end)

Citizen.CreateThread(function()
    while true do
        if Config.enableInfoHUD and loaded then
            ESX.TriggerServerCallback("SL-HUD:getPlayerPing", function(ping)
                Ping = ping
            end)
            ESX.TriggerServerCallback("SL-HUD:getPlayers", function(players)
                Players = players
            end)
            ESX.TriggerServerCallback("SL-HUD:getPlayerJob", function(jobName, jobRankName)
                playerJob = jobName
                playerJobRank = jobRankName
            end)
            infoData(true, Players, GetPlayerServerId(PlayerId()), Ping, playerJob, playerJobRank)
        end
        Citizen.Wait(Config.infoHUDRefresh)
    end
end)

Citizen.CreateThread(function()
    while true do
        if Config.enableMoneyHUD and loaded then
            local playerData = ESX.GetPlayerData()
            ESX.TriggerServerCallback("SL-HUD:getPlayerBankMoney", function(bankMoney)
                playerBankMoney = bankMoney
            end)
            for i=1, #playerData.accounts, 1 do
                if playerData.accounts[i].name == "money" then
                    playerCash = playerData.accounts[i].money
                    break
                end
            end
            for i=1, #playerData.accounts, 1 do
                if playerData.accounts[i].name == "black_money" then
                    blackMoney = playerData.accounts[i].money
                    break
                end
            end
            moneyData(true, playerCash, playerBankMoney, blackMoney)
        end
        Citizen.Wait(Config.moneyHUDRefresh)
    end
end)

Citizen.CreateThread(function()
    while true do
        if Config.enableBasicNeedsHUD and loaded then
            TriggerEvent("esx_status:getStatus", "hunger", function(status)
                if status then playerHunger = math.floor(status.val / 10000) end
            end)
            TriggerEvent("esx_status:getStatus", "thirst", function(status)
                if status then playerThirst = math.floor(status.val / 10000) end
            end)
            basicData(true, playerHunger, playerThirst)
        end
        Citizen.Wait(Config.basicNeedsHUDRefresh)
    end
end)
Citizen.CreateThread(function()
    while true do
        if Config.enableOptionalNeedsHUD and loaded then
            local playerHealth = GetEntityHealth(PlayerPedId())
            local playerArmor = GetPedArmour(PlayerPedId())
            optionalData(true, playerHealth, playerArmor)
        end
        Citizen.Wait(Config.optionalNeedsHUDRefresh)
    end
end)
Citizen.CreateThread(function()
    while true do
        if Config.enableStaminaOxygenHUD and loaded then
            if GetPlayerSprintStaminaRemaining(PlayerId()) > 0 then
                staminaData(true, GetPlayerSprintStaminaRemaining(PlayerId()))
            else
                staminaData(false)
            end
            if GetPlayerUnderwaterTimeRemaining(PlayerId()) < 10 then
                oxygenData(true, GetPlayerUnderwaterTimeRemaining(PlayerId()))
            else
                oxygenData(false)
            end
        end
        Citizen.Wait(Config.staminaOxygenHUDRefresh)
    end
end)
Citizen.CreateThread(function()
    while true do
        if Config.enableStreetNameHUD and loaded then
            local coords = GetEntityCoords(PlayerPedId())
            streetName = GetStreetNameFromHashKey(GetStreetNameAtCoord(coords.x, coords.y, coords.z, Citizen.ResultAsInteger()), Citizen.ResultAsInteger())
            area = zoneNames[GetNameOfZone(coords.x, coords.y, coords.z)]
            location(true, streetName, area)
        end
        Citizen.Wait(Config.streetNameHUDRefresh)
    end
end)
Citizen.CreateThread(function()
    while true do
        if loaded and not keybindsEnabled then
            keyBinds(true)
        end
        Citizen.Wait(500)
    end
end)
-----------------------------------------------------------
--NUI msgs

function infoData(bool, players, id, ping, jobName, JobRankName)
    if bool == true then
        SendNUIMessage({
            script = "SL-HUD",
            func = "infoData",
            enabled = bool,
            players = players,
            id = id,
            ping = ping,
            jobName = jobName,
            jobRank = JobRankName
        })
    else
        SendNUIMessage({
            script = "SL-HUD",
            func = "infoData",
            enabled = bool,
        })
    end
end

function basicData(bool, hunger, thirst)
    if bool == true then
        SendNUIMessage({
            script = "SL-HUD",
            func = "basicNeeds",
            enabled = bool,
            hunger = hunger,
            thirst = thirst,
        })
    else
        SendNUIMessage({
            script = "SL-HUD",
            func = "basicNeeds",
            enabled = bool,
        })
    end
end

function staminaData(bool, stamina)
    if bool == true then
        SendNUIMessage({
            script = "SL-HUD",
            func = "stamina",
            enabled = bool,
            stamina = stamina,
        })
    else
        SendNUIMessage({
            script = "SL-HUD",
            func = "stamina",
            enabled = bool,
        })
    end
end

function oxygenData(bool, oxygen)
    if bool == true then
        SendNUIMessage({
            script = "SL-HUD",
            func = "oxygen",
            enabled = bool,
            oxygen = oxygen,
        })
    else
        SendNUIMessage({
            script = "SL-HUD",
            func = "oxygen",
            enabled = bool,
        })
    end
end

function optionalData(bool, health, armor)
    if bool == true then
        SendNUIMessage({
            script = "SL-HUD",
            func = "optionalNeeds",
            enabled = bool,
            health = health,
            armor = armor,
        })
    else
        SendNUIMessage({
            script = "SL-HUD",
            func = "optionalNeeds",
            enabled = bool,
        })
    end
end

function moneyData(bool, cash, bankMoney ,blackMoney)
    if bool == true then
        SendNUIMessage({
            script = "SL-HUD",
            func = "moneyData",
            enabled = bool,
            cash = cash,
            bankMoney = bankMoney,
            blackMoney = blackMoney,
        })
    else
        SendNUIMessage({
            script = "SL-HUD",
            func = "moneyData",
            enabled = bool,
        })
    end
end

function location(bool, streetName, regionName)
    if bool == true then
        SendNUIMessage({
            script = "SL-HUD",
            func = "location",
            streetName = streetName,
            regionName = regionName,
            enabled = bool,
        })
    else
        SendNUIMessage({
            script = "SL-HUD",
            func = "location",
            enabled = bool,
        })
    end
end

function keyBinds(bool)
    if bool == true then
        keybindsEnabled = true
        SendNUIMessage({
            script = "SL-HUD",
            func = "keyBindings",
            enabled = bool,
        })
    else
        SendNUIMessage({
            script = "SL-HUD",
            func = "keyBindings",
            enabled = bool,
        })
    end
end
-----------------------------------------------------------
RegisterNUICallback("getConfig", function()
    for i, conf in pairs(Config.keyBinds) do
        SendNUIMessage({
            script = "SL-KEYBINDS",
            func = "createElements",
            icon = conf.icon,
            keyBind = conf.keyBind,
            marginLeft = conf.marginLeft,
            color = "rgb(" .. Config.accentColor.r .. " " .. Config.accentColor.g .. " " .. Config.accentColor.b .. ")",
            fontSize = conf.fontSize,
            iconSize = conf.iconSize,
        })
    end
    SendNUIMessage({
        script = "SL-HUD",
        func = "confVars",
        r = Config.accentColor.r,
        g = Config.accentColor.g,
        b = Config.accentColor.b,
        currency = Config.currency,
        basicIndicators = Config.enableBasicIndicators,
        serverName1 = Config.serverName1,
        serverName2 = Config.serverName2,
        maxNotifyCount = Config.maxNotificationCount,
        notificationMarginTop = Config.notiMarginTop,
        notificationTop = Config.notificationFromTop,
        keyBindAnimation = Config.enableAnimation,
        hideKeys = Config.hideBinds,
        hideStats = Config.hideStatsBars,
        hideTopRight = Config.hideTopRightInfo,
        hideStreetInfo = Config.hideStreetInfoHUD,
        overrideAnnouncement = Config.overrideAnnouncement,
    })
    TriggerEvent("SL-HUD:outOfSaveZone")
    if not loaded then
        SendNUIMessage({
            script = "SL-HUD",
            func = "hide",
            enabled = false,
        })
        isActive = false
    end
    if not Config.enableMoneyHUD or not loaded then
        moneyData(false)
    else
        moneyData(true)
    end

    if not Config.enableOptionalNeedsHUD or not loaded then
        optionalData(false)
    else
        optionalData(true)
    end

    if not Config.enableBasicNeedsHUD or not loaded then
        basicData(false)
    else
        basicData(true)
    end

    if not Config.enableInfoHUD or not loaded then
        infoData(false)
    else
        infoData(true)
    end

    if not Config.enableStaminaOxygenHUDRefresh or not loaded then
        staminaData(false)
        oxygenData(false)
    else
        staminaData(true)
        oxygenData(true)
    end

    if not Config.enableKeyBinds or not loaded then
        keyBinds(false)
    else
        keyBinds(true)
    end

    if not Config.enableStreetNameHUD or not loaded then
        location(false)
    else
        location(true)
    end
end)

Citizen.CreateThread(function()
    while true do
        if IsPauseMenuActive() or IsPlayerDead(PlayerId()) then
            if isActive then
                isActive = false
                SendNUIMessage({
                    script = "SL-HUD",
                    func = "hide",
                    enabled = false,
                })
            end
        else
            if not isActive and loaded then
                isActive = true
                SendNUIMessage({
                    script = "SL-HUD",
                    func = "hide",
                    enabled = true,
                })
            end
        end
        Citizen.Wait(500)
    end
end)
if Config.enableCommansForPlayers then
    RegisterCommand(Config.keybindToggleCommand, function()
        if Config.enableKeyBinds then
            Config.enableKeyBinds = false
            keyBinds(false)
        else
            Config.enableKeyBinds = true
            keyBinds(true)
        end
    end)
    RegisterCommand(Config.infoHUDToggleCommand, function()
        if Config.enableInfoHUD then
            Config.enableInfoHUD = false
            infoData(false)
        else
            Config.enableInfoHUD = true
            infoData(true)
        end
    end)
    RegisterCommand(Config.moneyHUDToggleCommand, function()
        if Config.enableMoneyHUD then
            Config.enableMoneyHUD = false
            moneyData(false)
        else
            Config.enableMoneyHUD = true
            moneyData(true)
        end
    end)
    RegisterCommand(Config.basicNeedsHUDToggleCommand, function()
        if Config.enableBasicNeedsHUD then
            Config.enableBasicNeedsHUD = false
            basicData(false)
        else
            Config.enableBasicNeedsHUD = true
            basicData(true)
        end
    end)
    RegisterCommand(Config.optionalNeedsHUDToggleCommand, function()
        if Config.enableOptionalNeedsHUD then
            Config.enableOptionalNeedsHUD = false
            optionalData(false)
        else
            Config.enableOptionalNeedsHUD = true
            optionalData(true)
        end
    end)
    RegisterCommand(Config.staminaOxygenHUDToggleCommand, function()
        if Config.enableStaminaOxygenHUD then
            Config.enableStaminaOxygenHUD = false
            staminaData(false)
            oxygenData(false)
        else
            Config.enableStaminaOxygenHUD = true
            staminaData(true)
            oxygenData(true)
        end
    end)
    RegisterCommand(Config.streetNameHUDToggleCommand, function()
        if Config.enableStreetNameHUD then
            Config.enableStreetNameHUD = false
            location(false)
        else
            Config.enableStreetNameHUD = true
            location(true)
        end
    end)
    TriggerEvent("chat:addSuggestion", "/" .. Config.keybindToggleCommand, "Toggles the Keybinds on the left side")
    TriggerEvent("chat:addSuggestion", "/" .. Config.infoHUDToggleCommand, "Toggles the Server Infos in the Top right(Ping, ID etc.)")
    TriggerEvent("chat:addSuggestion", "/" .. Config.moneyHUDToggleCommand, "Toggles the Money Infos in the Top right")
    TriggerEvent("chat:addSuggestion", "/" .. Config.basicNeedsHUDToggleCommand, "Toggles the Food and Water bar in the right center")
    TriggerEvent("chat:addSuggestion", "/" .. Config.optionalNeedsHUDToggleCommand, "Toggles the Health and Armor bar in the right center")
    TriggerEvent("chat:addSuggestion", "/" .. Config.staminaOxygenHUDToggleCommand, "Toggles the Stamina Bar when running and the Oxygen Bar when diving")
    TriggerEvent("chat:addSuggestion", "/" .. Config.streetNameHUDToggleCommand, "Toggles the Streetname Indicator in the bottom left")
end
TriggerEvent("chat:addSuggestion", "/announce", Config.announceCommandSuggestion)
RegisterCommand("announce", function(rawCommand, args)
    local message = table.concat(args, " ", 3)
    TriggerEvent("SL-HUD:registerAnnounce", args[1], args[2], message)
end)

RegisterNetEvent("SL-HUD:registerAnnounce")
AddEventHandler("SL-HUD:registerAnnounce", function(Time, Title, Message)
    ESX.TriggerServerCallback("SL-HUD:getGroup", function(playerGroup)
        for i, group in pairs(Config.announcementGroups) do
            if group == playerGroup then
                TriggerServerEvent("SL-HUD:registerServerAnnounce", Time, Title, Message)
                break
            else
                TriggerEvent("SL-HUD:sendNotification", 4000, "rgb(255, 37, 55)", Config.noPermissionTitle, Config.noPermissionMessage)
            end
        end
    end)
end)

RegisterNetEvent("SL-HUD:announce")
AddEventHandler("SL-HUD:announce", function(Time, Title, Message)
    SendNUIMessage({
        script = "SL-HUD",
        func = "announcement",
        time = Time,
        color = "rgb(" .. Config.accentColor.r .. "," .. Config.accentColor.g .. "," .. Config.accentColor.b .. ")",
        title = Title,
        message = Message
    })
end)

RegisterNetEvent("SL-HUD:inSaveZone")
AddEventHandler("SL-HUD:inSaveZone", function()
    SendNUIMessage({
        script = "SL-HUD",
        func = "saveZone",
        enabled = true
    })
end)

RegisterNetEvent("SL-HUD:outOfSaveZone")
AddEventHandler("SL-HUD:outOfSaveZone", function()
    SendNUIMessage({
        script = "SL-HUD",
        func = "saveZone",
        enabled = false
    })
end)

RegisterNetEvent("SL-HUD:sendNotification")
AddEventHandler("SL-HUD:sendNotification", function(time, color, title, message)
    SendNUIMessage({
        script = "SL-HUD",
        func = "notification",
        time = time,
        color = color,
        title = title,
        message = message,
    })
end)

for i, class in pairs(Config.restrictedAreas) do
    TriggerEvent("chat:addSuggestion", "/" .. Config.addRestrictionCommandSuggestion, "Syntax(Command Radius eg. 150)Creates a restricted zone at your current Position")
    TriggerEvent("chat:addSuggestion", "/" .. Config.removeRestrictionCommandSuggestion, "Removes the restricted Zone")
    RegisterCommand(class.addRestrictionCommand, function(rawCommand, args)
        if playerJob == class.jobName then
            for i, jobRank in pairs(class.jobRank) do
                if jobRank == playerJobRank then
                    if class.blipSettings.blipRadius == "" and class.blipSettings.blip == "" then
                        createBlip(class, args[1])
                    else
                        TriggerEvent("SL-HUD:sendNotification", 4000, "rgb(255, 37, 55)", Config.noPermissionTitle, Config.ZoneAlreadyRestricted)
                    end
                    break
                end
                if i == #class.jobRank and class.blipSettings.blipRadius == "" and class.blipSettings.blip == "" then
                    TriggerEvent("SL-HUD:sendNotification", 4000, "rgb(255, 37, 55)", Config.noPermissionTitle, Config.noPermissionMessage)
                end
            end
        else
            TriggerEvent("SL-HUD:sendNotification", 4000, "rgb(255, 37, 55)", Config.noPermissionTitle, Config.noPermissionMessage)
        end
    end, false)
end
for i, class in pairs(Config.restrictedAreas) do
    RegisterCommand(class.removeRestrictionCommand, function(rawCommand)
        if playerJob == class.jobName then
            for i, jobRank in pairs(class.jobRank) do
                if jobRank == playerJobRank then
                    removeBlip(class)
                    break
                end
                if i == #class.jobRank and class.blipSettings.blipRadius == "" and class.blipSettings.blip == "" then
                    TriggerEvent("SL-HUD:sendNotification", 4000, "rgb(255, 37, 55)", Config.noPermissionTitle, Config.noPermissionMessage)
                end
            end
        else
            TriggerEvent("SL-HUD:sendNotification", 4000, "rgb(255, 37, 55)", Config.noPermissionTitle, Config.noPermissionMessage)
        end
    end, false)
end
function createBlip(settings, radius)
    local message = settings.activeannounceMessage
    for word in message.gmatch("/streetName/", "%a+") do
        message = message:gsub("%/streetName/", streetName)
    end
    for word in message.gmatch("/areaName/", "%a+") do 
        message = message:gsub("%/areaName/", area)
    end
    for word in message.gmatch("/radius/", "%a+") do 
        message = message:gsub("%/radius/", radius)
    end
    TriggerEvent("SL-HUD:announce", settings.activeannouceTime, settings.activeannounceTitle, message)
    local coords = GetEntityCoords(PlayerPedId())
    local blipSettings = settings.blipSettings
    blipSettings.radius = radius
    blipSettings.blip = AddBlipForCoord(coords.x, coords.y, coords.z)
    blipSettings.blipRadius = AddBlipForRadius(coords.x, coords.y, coords.z, tonumber(radius .. ".0"))

	SetBlipColour(blipSettings.blipRadius, blipSettings.color)
	SetBlipAlpha (blipSettings.blipRadius, 80)
	SetBlipSprite (blipSettings.blip, blipSettings.sprite)
	SetBlipScale  (blipSettings.blip, blipSettings.scale)
	SetBlipColour (blipSettings.blip, blipSettings.color)
	SetBlipAsShortRange(blipSettings.blip, true)

	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString(blipSettings.name)
	EndTextCommandSetBlipName(blipSettings.blip)
end

function removeBlip(settings, blipRadius, blip)
    local message = settings.inactiveannounceMessage
    for word in message.gmatch("/streetName/", "%a+") do
        message = message:gsub("%/streetName/", streetName)
    end
    for word in message.gmatch("/areaName/", "%a+") do 
        message = message:gsub("%/areaName/", area)
    end
    for word in message.gmatch("/radius/", "%a+") do 
        message = message:gsub("%/radius/", settings.blipSettings.radius)
    end
    TriggerEvent("SL-HUD:announce", settings.inactiveannouceTime, settings.inactiveannounceTitle, message)
    RemoveBlip(settings.blipSettings.blipRadius)
    RemoveBlip(settings.blipSettings.blip)
    settings.blipSettings.blipRadius = ""
    settings.blipSettings.blip = ""
end