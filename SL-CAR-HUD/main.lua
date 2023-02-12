local loaded = false
local isInVehicle = false
local currentSpeed = 0
local currentVehicle
local localplayer
local excluded = false
local unitMultiplier = 0
local count = 0
local cruiseControlActive = false
local setSpeed = false
local cruiseSpeed = 0
local seatBelt = false
local oldBodyHealth = nil
local timer = 0
local clock = 0
local oldclock = 0
local disabled = false
local time = 0
local lastSpeed = 0
local lastVelocity = vector3(0, 0, 0)
local cruisePressed = false
local beltPressed = false
local cruiseStop = false
local beltStop = false
local classestonumber = {
    ["Compacts"] = 0, ["Sedans"] = 1, ["SUVs"] = 2, ["Coupes"] = 3, ["Muscle"] = 4, ["SportsClassics"] = 5, ["Sports"] = 6, ["Super"] = 7, ["Motorcycles"] = 8, ["Off-road"] = 9, ["Industrial"] = 10, ["Utility"] = 11, ["Vans"] = 12, ["Cycles"] = 13, ["Boats"] = 14, ["Helicopters"] = 15, ["Planes"] = 16, ["Service"] = 17, ["Emergency"] = 18, ["Military"] = 19, ["Commercial"] = 20, ["Trains"] = 21,
}
local Keys = {
    ["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
    ["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
    ["TAB"] = 37, ["Q"] = 44, ["SPACEBAR"] = 55, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 20, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
    ["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
    ["LEFTSHIFT"] = 21, ["Z"] = 246, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
    ["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
    ["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
    ["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
    ["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}
AddEventHandler("onResourceStart", function(resourceName)
    if (GetCurrentResourceName() ~= resourceName) then
      return
    end
    print("SUCCESSFULLY STARTED SL CAR HUD! IF ANY ERRORS OCCUR RELOAD THE SCRIPT OR JOIN OUR DISCORD AT https://discord.gg/4EeprRpUEV FOR HELP")
end)
 Citizen.CreateThread(function()
     while true do
             if loaded then
                 if not isInVehicle then
                     if IsPedInAnyVehicle(PlayerPedId()) and GetIsVehicleEngineRunning(GetVehiclePedIsUsing(PlayerPedId())) and not IsPauseMenuActive() then
                         isInVehicle = true
                         currentVehicle = GetVehiclePedIsUsing(PlayerPedId())
                         localplayer = PlayerPedId()
                         SendNUIMessage ({
                             script = "car_hud",
                             enabled = "true"
                         })
                     end
                 end
                 if isInVehicle then
                     if not IsPedInAnyVehicle(PlayerPedId()) or not GetIsVehicleEngineRunning(GetVehiclePedIsUsing(PlayerPedId())) then
                         isInVehicle = false
                         count = 0
                         excluded = false
                         SendNUIMessage ({script = "car_hud", enabled = "false"})
                     end
                     if excluded then
                        SendNUIMessage ({script = "car_hud", enabled = "false"})
                    end
                end
                if IsPlayerDead(PlayerId()) then
                    isInVehicle = false
                    count = 0
                    excluded = false
                    SendNUIMessage ({script = "car_hud", enabled = "false"})
                end
            end
        Citizen.Wait(300)
    end
end)
Citizen.CreateThread(function()
    while true do
        if isInVehicle then
            if not excluded then
                local speed
                currentSpeed = GetEntitySpeed(currentVehicle)
                SendNUIMessage ({
                script = "car_hud",
                func = "data",
                rpm = GetVehicleCurrentRpm(currentVehicle) * (350/1),
                speed = math.floor(currentSpeed * unitMultiplier),
                engine = GetIsVehicleEngineRunning(currentVehicle)
                })
            end
            Citizen.Wait(80)
        else
            Citizen.Wait(500)
        end
    end
end)
Citizen.CreateThread(function()
    while true do
        if isInVehicle then
            if not excluded then
                SendNUIMessage ({
                script = "car_hud",
                func = "fuellevel",
                fuellevel = GetVehicleFuelLevel(currentVehicle) * (212/100)
                })
            end
        else
            if Config.bindOutline then
                cruisePressed = false
                beltPressed = false
                SendNUIMessage ({
                    script = "car_hud",
                    func = "seatbelt-glow",
                    enabled = false
                })
                SendNUIMessage ({
                    script = "car_hud",
                    func = "cruise-glow",
                    enabled = false
                })
            end
        end
        Citizen.Wait(500)
    end
end)
Citizen.CreateThread(function()
    while true do
            if count < 1 then
                if isInVehicle and count < 1 then
                    count = count + 1
                    for i = 1, #Config.excludedClasses, 1 do
                        class = classestonumber[Config.excludedClasses[i]]
                        if GetVehicleClass(GetVehiclePedIsUsing(PlayerPedId())) == class then
                            excluded = true
                            break
                        else
                            excluded = false
                        end
                    end
                    for i = 1, #Config.excludedModels, 1 do
                        local model = Config.excludedModels[i]
                        if model == nil or model == "" then
                            break
                        end
                        if model == GetDisplayNameFromVehicleModel(GetEntityModel(GetVehiclePedIsUsing(PlayerPedId()))) then
                            excluded = true
                            break
                        else
                            excluded = false
                        end
                    end
                    for i = 1, #Config.hideRpmOnModels, 1 do
                        local model = Config.hideRpmOnModels[i]
                        if model == nil or model == "" then
                            break
                        end
                        if model == GetDisplayNameFromVehicleModel(GetEntityModel(GetVehiclePedIsUsing(PlayerPedId()))) then
                            SendNUIMessage({
                                script = "fuel_hud",
                                func = "hideRpm",
                                enabled = true
                            })
                            break
                        else
                            SendNUIMessage({
                                script = "fuel_hud",
                                func = "hideRpm",
                                enabled = false
                            })
                        end
                    end
                end
            end
        Citizen.Wait(100)
    end
end)
Citizen.CreateThread(function()
    while Config.bindOutline do
        if isInVehicle then
            if not cruisePressed then
                if IsControlPressed(0, Keys[Config.cruiseControlBind]) then
                    cruisePressed = true
                    SendNUIMessage ({
                        script = "car_hud",
                        func = "cruise-glow",
                        enabled = true
                    })
                end
            end
            if not beltPressed then
                if IsControlPressed(0, Keys[Config.seatBeltBind]) then
                    beltPressed = true
                    SendNUIMessage ({
                        script = "car_hud",
                        func = "seatbelt-glow",
                        enabled = true
                    })
                end
            end
            Citizen.Wait(10)
        else
            Citizen.Wait(500)
        end
    end
end)
Citizen.CreateThread(function()
    while Config.enableCruiseControl do
        if isInVehicle then
            for i = 1, #Config.cruiseControlCancelBinds, 1 do
                if IsControlPressed(1, Keys[Config.cruiseControlCancelBinds[i]]) then
                    pressed = true
                    if cruiseControlActive then
                        timer = timer + 1
                        if timer > Config.timeTillCancel then
                            resetCruiseSpeed()
                            --TriggerEvent('esx:showNotification', Config.CruiseControlInActiveMessage)
                            TriggerEvent("SL-HUD:sendNotification", 4000, "rgb(124, 237, 255)", Config.messageTitle, Config.CruiseControlInActiveMessage)
                            timer = 0
                        end
                    end
                end
                if IsControlJustReleased(1, Keys[Config.cruiseControlCancelBinds[i]]) then
                    timer = 0
                    pressed = false
                end
            end
            if IsControlJustReleased(1, Keys[Config.cruiseControlBind]) then
                if not cruiseControlActive and not disabled and not pressed then
                        setCruiseSpeed()
                        --TriggerEvent('esx:showNotification', Config.CruiseControlActiveMessage .. " " .. math.floor(cruiseSpeed * unitMultiplier) .. " " .. Config.unit)
                        TriggerEvent("SL-HUD:sendNotification", 4000, "rgb(124, 237, 255)", Config.messageTitle, Config.CruiseControlActiveMessage .. " " .. math.floor(cruiseSpeed * unitMultiplier) .. " " .. Config.unit)
                else
                    if cruiseControlActive then
                        resetCruiseSpeed()
                        --TriggerEvent('esx:showNotification', Config.CruiseControlInActiveMessage)
                        TriggerEvent("SL-HUD:sendNotification", 4000, "rgb(124, 237, 255)", Config.messageTitle, Config.CruiseControlInActiveMessage)
                    end
                end
                if Config.bindOutline then
                    cruisePressed = false
                    SendNUIMessage ({
                        script = "car_hud",
                        func = "cruise-glow",
                        enabled = false
                    })
                end
            end
            Citizen.Wait(8)
        else
            Citizen.Wait(500)
        end
    end
end)
Citizen.CreateThread(function()
    while Config.enableSeatBelt do
        if isInVehicle then
            if IsControlJustReleased(1, Keys[Config.seatBeltBind]) then
                if seatBelt == false then
                    seatBelt = true
                    --TriggerEvent('esx:showNotification', Config.seatBeltActiveMessage)
                    TriggerEvent("SL-HUD:sendNotification", 4000, "rgb(124, 237, 255)", Config.messageTitle, Config.seatBeltActiveMessage)
                else
                    seatBelt = false
                    --TriggerEvent('esx:showNotification', Config.seatBeltInActiveMessage)
                    TriggerEvent("SL-HUD:sendNotification", 4000, "rgb(124, 237, 255)", Config.messageTitle, Config.seatBeltInActiveMessage)
                end
                if Config.bindOutline then
                    beltPressed = false
                    SendNUIMessage ({
                        script = "car_hud",
                        func = "seatbelt-glow",
                        enabled = false
                    })
                end
            end
            Citizen.Wait(8)
        else
            Citizen.Wait(500)
        end
    end
end)
Citizen.CreateThread(function()
    while Config.enableSeatBelt do
        if isInVehicle then
            if not seatBelt then
                lastSpeed = GetEntitySpeed(currentVehicle)
                lastVelocity = GetEntityVelocity(currentVehicle)
                Citizen.Wait(50)
                if currentSpeed * unitMultiplier > Config.seatBeltCrashMinSpeed and (lastSpeed - GetEntitySpeed(currentVehicle)) > (GetEntitySpeed(currentVehicle)* Config.seatBeltCrashTolerance) then
                    SetEntityCoords(localplayer, GetEntityCoords(localplayer).x + Fwv(localplayer).x, GetEntityCoords(localplayer).y + Fwv(localplayer).y, GetEntityCoords(localplayer).z - .47, true, true, true)
                    SetEntityVelocity(localplayer, lastVelocity.x, lastVelocity.y, lastVelocity.z)
                    SetPedToRagdoll(localplayer, 1e3, 1e3, 0, false, false, false)
                end
                Citizen.Wait(50)
            else
                Citizen.Wait(100)
            end
        else
            seatBelt = false
            Citizen.Wait(1000)
        end
    end
end)
Citizen.CreateThread(function()
    while true do
        if seatBelt then
            DisableControlAction(0, 75, true)
            DisableControlAction(27, 75, true)
        end
        Citizen.Wait(10)
    end
end)
Citizen.CreateThread(function()
    while true do
        if isInVehicle then
            if seatBelt then
                SendNUIMessage({
                    script = "car_hud",
                    func = "seatbelt",
                    active = true
                })
            end
            if not seatBelt then
                SendNUIMessage({
                    script = "car_hud",
                    func = "seatbelt",
                    active = false
                })
            end
        end
        Citizen.Wait(500)
    end
end)
Citizen.CreateThread(function()
    while true do
        if isInVehicle then
            if currentSpeed * unitMultiplier < Config.cruiseControlMinSpeed then
                disabled = true
            else
                disabled = false
            end
            Citizen.Wait(100)
        else
            Citizen.Wait(1000)
        end
    end
end)
Citizen.CreateThread(function()
    while true do
        if cruiseControlActive then
            if GetVehicleBodyHealth(GetVehiclePedIsUsing(PlayerPedId())) ~= oldBodyHealth then
                resetCruiseSpeed()
                --TriggerEvent('esx:showNotification', Config.CruiseControlInActiveMessage)
                TriggerEvent("SL-HUD:sendNotification", 4000, "rgb(124, 237, 255)", Config.messageTitle, Config.CruiseControlInActiveMessage)
            end
        end
        Citizen.Wait(100)
    end
end)
RegisterNUICallback("getConfig", function()
    loaded = true
    if Config.customMultiplier == 0 then
        if Config.unit == "Km/h" then
            unitMultiplier = 3.6
        else if Config.unit == "Mp/h" then
            unitMultiplier = 2.236936
        end
    end
    else
        unitMultiplier = Config.customMultiplier
    end

    SendNUIMessage({
        script = "car_hud",
        func = "configVars",
        r = Config.accentColor.r,
        g = Config.accentColor.g,
        b = Config.accentColor.b,
        unit = Config.unit,
        centerSpeed = Config.centerSpeed,
        cruiseBind = Config.cruiseControlBind,
        beltBind = Config.seatBeltBind,
        showKeyBinds = Config.showKeyBinds,
        cruiseControl = Config.enableCruiseControl,
        seatBelt = Config.enableSeatBelt,
    })
end)

Citizen.CreateThread(function()
    while true do
        if setSpeed then
            if currentSpeed < cruiseSpeed then
                if IsVehicleOnAllWheels(currentVehicle) then
                    SetVehicleForwardSpeed(currentVehicle, cruiseSpeed)
                end
            end
        end
        Citizen.Wait(50)
    end
end)

function setCruiseSpeed()
    cruiseSpeed = currentSpeed
    cruiseControlActive = true
    setSpeed = true
    oldBodyHealth = GetVehicleBodyHealth(currentVehicle)
    SendNUIMessage({
        script = "car_hud",
        func = "cruiseControl",
        enabled = true
    })
end

function resetCruiseSpeed()
    cruiseSpeed = 0
    SetEntityMaxSpeed(currentVehicle, GetVehicleHandlingFloat(currentVehicle, "CHandlingData","fInitialDriveMaxFlatVel"))
    cruiseControlActive = false
    setSpeed = false
    SendNUIMessage({
        script = "car_hud",
        func = "cruiseControl",
        enabled = false
    })
end

function Fwv(entity)
    local hr = GetEntityHeading(entity) + 90.0
    if hr < 0.0 then hr = 360.0 + hr end
    hr = hr * 0.0174533
    return { x = math.cos(hr) * 2.0, y = math.sin(hr) * 2.0 }
  end